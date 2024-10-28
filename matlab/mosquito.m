clear;
close all;
clc;
fclose('all');

%%
% Define the folder path
folderPath = '.\mosq_data';
% folderPath = '.\Wingbeats\Ae. aegypti\D_16_12_12_19_46_13';
% folderPath = '.\Wingbeats\Ae. albopictus\D_17_01_02_18_26_35';
% folderPath = '.\Wingbeats\An. arabiensis\D_17_01_30_15_21_19';
% folderPath = '.\Wingbeats\An. gambiae\Anopheles gambiae_ 5d-7d\D_17_01_16_18_41_36';
% folderPath = '.\Wingbeats\C. pipiens\D_16_12_05_16_12_45';
% folderPath = '.\Wingbeats\C. quinquefasciatus\D_16_12_19_11_06_09';

wavFiles = dir(fullfile(folderPath, '*.wav'));

audioData = cell(1, length(wavFiles));
samplingRates = cell(1, length(wavFiles));

for k = 1:length(wavFiles)
    fileName = fullfile(folderPath, wavFiles(k).name);
    [data, fs] = audioread(fileName);

    audioData{k} = data;
    samplingRates{k} = fs;
    
%     disp(['Read ', wavFiles(k).name, ', Duration: ', num2str(length(data)/fs), ' seconds']);
end

%%
% figure;
% plot((1:length(Audio)) / SamplingRate, Audio);
% title('Audio Data from the First File');
% xlabel('Time (seconds)');
% ylabel('Amplitude');
% grid on;

%%
use_fft = 1;
use_bsf = 0;

if use_fft
    idx_l=128;
    windowLength = 10;
    num_th = 10;
    SNDR_threshold = 9;
    osr = 6;
    alpha = 3;
    fst = 437.5;
    fend = 687.5;
end

if use_bsf
    idx_l=256;
    windowLength = 15;
    num_th = 15;
    SNDR_threshold = 0;
    fst = 450;
    fend = 550;
    fbw = 700;
end

%%
is_mosq = reshape([], 1, 0);

for k = 1:length(wavFiles)
    Audio = audioData{k};
    Audio = round(Audio/max(abs(Audio))*2^15);
    SNDR = reshape([], 1, 0);
    for idx_loop = 1:floor(5000/idx_l)
        idx_st = 1 + (idx_loop-1)*idx_l;
        Audio_hp = Audio(idx_st+1:idx_st+idx_l) - Audio(idx_st:idx_st+idx_l-1);
        if use_fft
            SNDR = [SNDR, mosq_FFT(fs, Audio_hp, alpha, osr, fst, fend)];
        end
        % if use_bsf
        %    SNDR = [SNDR, mosq_BSF(fs, Audio_hp, fst, fend, fbw)];
        % end
    end
  
    % Initialize logical array for storing result
    result = 0;
    
    % Enumerate each window
    for i = 1:(length(SNDR) - windowLength + 1)
        currentWindow = SNDR(i:i + windowLength - 1);
        
        % If all elements in the current window > SNDR
        if sum(currentWindow > SNDR_threshold) >= num_th
            result = 1;
            break;
        end
    end
    is_mosq = [is_mosq, result];
%     figure;
%     plot(SNDR);
%     title('SNDR over Time');
%     xlabel('Segment Index');
%     ylabel('SNDR Value');
%     grid on;
end

% plotting
figure;
plot(is_mosq);
title('Mosquito Detected (true)');
xlabel('File Index');
ylabel('ans');
grid on;

tp = sum(is_mosq);
fn = length(wavFiles)-sum(is_mosq);

%%
% Define the folder path
folderPath2 = '.\comp_group';

wavFiles2 = dir(fullfile(folderPath2, '*.wav'));

% Make cells to store data & sampling rate
audioData2 = cell(1, length(wavFiles2));
samplingRates2 = cell(1, length(wavFiles2));

for k = 1:length(wavFiles2)
    fileName = fullfile(folderPath2, wavFiles2(k).name);
    [data, fs] = audioread(fileName);
    audioData2{k} = data;
    samplingRates2{k} = fs;
    
%     disp(['Read ', wavFiles(k).name, ', Duration: ', num2str(length(data)/fs), ' seconds']);
end

%%
is_mosq2 = reshape([], 1, 0);

for k = 1:length(wavFiles2)
    Audio = audioData2{k};
    Audio = round(Audio/max(abs(Audio))*2^15);    
    SNDR = reshape([], 1, 0);
    for idx_loop = 1:floor(5000/idx_l)
        idx_st = 1 + (idx_loop-1)*idx_l;
        Audio_hp = Audio(idx_st+1:idx_st+idx_l) - Audio(idx_st:idx_st+idx_l-1);
        if use_fft
            SNDR = [SNDR, mosq_FFT(fs, Audio_hp, alpha, osr, fst, fend)];
        end
        % if use_bsf
        %    SNDR = [SNDR, mosq_BSF(fs, Audio_hp, fst, fend, fbw)];
        % end
    end
  
    % Initialize logical array for storing result
    result = 0;
    
    % Enumerate each window
    for i = 1:(length(SNDR) - windowLength + 1)
        currentWindow = SNDR(i:i + windowLength - 1);
        
        % If all elements in the current window > SNDR
        if sum(currentWindow > SNDR_threshold) >= num_th
            result = 1;
            break;
        end
    end
    is_mosq2 = [is_mosq2, result];
%     figure;
%     plot(SNDR);
%     title('SNDR over Time');
%     xlabel('Segment Index');
%     ylabel('SNDR Value');
%     grid on;
end

% Plot the is_mosq check ans
figure;
plot(is_mosq2);
title('Mosquito Detected (false)');
xlabel('File Index');
ylabel('ans');
grid on;

fp = sum(is_mosq2);
tn = length(wavFiles2)-sum(is_mosq2);

%%
confusionMatrix = [tp, fn; fp, tn];
% confusionMatrix = [94, 505; 6, 375];

figure;
imagesc(confusionMatrix);
colormap('winter');  
colorbar;

% Text annotations
textStrings = num2str(confusionMatrix(:));   % Mat values -> strings
textStrings = strtrim(cellstr(textStrings)); % Remove leading & trailing whitespaces
[x, y] = meshgrid(1:2);  % x and y coordinates for the strings

hStrings = text(x(:), y(:), textStrings(:), 'HorizontalAlignment', 'center');

% Add labels
set(gca, 'XTick', 1:2, 'XTickLabel', {'Positive', 'Negative'}, 'YTick', 1:2, 'YTickLabel', {'Positive', 'Negative'});
xlabel('Predicted Class');
ylabel('Actual Class');
title('Confusion Matrix');

% Better apperance 
axis equal;





