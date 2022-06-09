function intensityFile = LoadIntensityFile(position, soundType)
    %% Parse intensity file
    switch position
        case 'positionA' % right

            switch soundType
                case 'pureTone'
                    fileAll = xlsread('Documents/Intensity Files/20191105-speaker4.xlsx', 1, 'A2:E27');
                case 'complexTone'
                    fileAll = xlsread('Documents/Intensity Files/20200105.xlsx', 1, 'A2:E20');
                case 'complexToneSmall'
                    fileAll = xlsread('Documents/Intensity Files/speaker0oFloor4Right.xlsx', 1, 'A2:E20');
                case 'noise'
                    intensityFile = xlsread('Documents/Intensity Files/20191105-speaker4.xlsx', 1, 'C28');
                    
                    return;
            end

        case 'positionB' %left

            switch soundType
                case 'pureTone'
                    fileAll = xlsread('Documents/Intensity Files/tone_calibration_left.xlsx', 1, 'A2:E27');
                case 'complexTone'
                    fileAll = xlsread('Documents/Intensity Files/fuza_calibration_left.xlsx', 1, 'A2:E20');
                case 'complexToneSmall'
                    fileAll = xlsread('Documents/Intensity Files/speaker0oFloor4Right.xlsx', 1, 'A2:E20');
                case 'noise'
                    intensityFile = xlsread('Documents/Intensity Files/tone_calibration_left.xlsx', 1, 'C28');
                    return;
            end

        case 'positionMulti'
            intensityFile = [];
            return;
    end

    intensityFile.frequency = fileAll(:, 1);
    intensityFile.intensity = fileAll(:, 3); % Intensity at monkey ear without attenuation
    return;
end
