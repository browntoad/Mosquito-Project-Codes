function [SNDR] = mosq_FFT(fs,Daq, alpha, osr, fst, fend)
    sampling_points = length(Daq);
    ts = 1/fs;
    
    spec = fft(Daq)/(sampling_points/2);                  
    specdb=20*log10(abs(spec(1:sampling_points/2+1)));    % Convert FFT output mag -> dB

%     fi_ind = fi/(fs/sampling_points);
    [a, fi_ind]= maxk(specdb(1:round(sampling_points/2/osr)+1),1);
    fi_ind = fi_ind - 1;

    include_dc = 0;
    if fi_ind <= (alpha-1)/2
        fi_ind = (alpha-1)/2;
        include_dc = 1;
    end

    fi = fi_ind * fs / sampling_points;

    % Find SNDR
    signal= 20*log10(norm(spec(fi_ind+1-((alpha-1)/2):fi_ind+1+((alpha-1)/2))));  % Signal amp
    Psignal = norm(spec(fi_ind+1-((alpha-1)/2):fi_ind+1+((alpha-1)/2)))^2;        % Signal power
    Pnoise = norm(spec(1:round(sampling_points/2/osr)+1))^2-Psignal;   % Noise power
    
    if include_dc == 1
        Pnoise = norm(spec(1:round(sampling_points/2/osr)+1))^2-Psignal;
    end

    SNDR = 10*log10(Psignal/Pnoise); % Apply formula
    if (fi < fst) | (fi > fend)
        SNDR = -inf;   % Cant even qualify as a mosquito sound
    end

end

