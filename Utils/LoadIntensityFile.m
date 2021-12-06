function intensityFile = LoadIntensityFile(position, soundType)
    %% Parse intensity file
    switch position
        case 'positionA'

            switch soundType
                case 'pureTone'
                    fileAll = xlsread('/Documents/Intensity Files/20191105-speaker4.xlsx', 1, 'A2:E27');
                case 'complexTone'
                    fileAll = [];
                case 'noise'
                    intensityFile = xlsread('/Documents/Intensity Files/20191105-speaker4.xlsx', 1, 'C28');
                    return;
            end

        case 'positionB'

            switch soundType
                case 'pureTone'
                    fileAll = [];
                case 'complexTone'
                    fileAll = [];
                case 'noise'
                    intensityFile = [];
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
