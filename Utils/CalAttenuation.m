function attenuationSeq = CalAttenuation(position, soundType, freqSeq, intensitySeq, varargin)
    %% Calculate attenuation sequence according to frequency and intensity sequences
    narginchk(4, 5);

    if ~isempty(varargin)
        intensityFile = varargin{1}; % Use the preloaded intensity file if it exists
    else
        intensityFile = LoadIntensityFile(position, soundType);
    end

    if strcmp(soundType, 'noise')
        attenuationSeq = intensityFile - intensitySeq;
    else
        attenuationSeq = interp1(intensityFile.frequency, intensityFile.intensity, freqSeq, 'linear') - intensitySeq;
    end

    return;

end
