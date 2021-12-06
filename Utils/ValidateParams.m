function [passOrNot, errorMsg] = ValidateParams(params)
    errorMsg = [];

    %% Main GUI
    % Prob length not matched
    if length(params.stdNumArray) ~= length(params.stdNumProb)
        errorMsg = [errorMsg; ' '; {'- Main GUI: Length of std number array and prob NOT MATCHED'}];
    end

    % Prob sum ~= 1
    if abs(sum(params.stdNumProb) - 1) > sqrt(eps)
        errorMsg = [errorMsg; ' '; {'- Main GUI: Sum of std number prob ~= 1'}];
    end

    if abs(sum(params.freqDiffProb) - 1) > sqrt(eps)
        errorMsg = [errorMsg; ' '; {'- Main GUI: Sum of freqDiffProb ~= 1'}];
    end

    if abs(sum(params.intensityDiffProb) - 1) > sqrt(eps)
        errorMsg = [errorMsg; ' '; {'- Main GUI: Sum of intensityDiffProb ~= 1'}];
    end

    if abs(sum(params.durationDiffProb) - 1) > sqrt(eps)
        errorMsg = [errorMsg; ' '; {'- Main GUI: Sum of durationDiffProb ~= 1'}];
    end

    %% Children GUI
    % Use try...catch...end for every single protocol params validation
    try
        % Protocol Name: Cue Integration
        if abs(params.freqTrialRatio + params.intensityTrialRatio + params.doubleTrialRatio -100) > sqrt(eps)
            errorMsg = [errorMsg; ' '; {'- Cue Integtation Setting: Sum of ratio ~= 100%'}];
        end

    end

    %% Return validation result and error messages
    if isempty(errorMsg)
        passOrNot = true;
    else
        passOrNot = false;
        errorMsg = [{'Validation FAILED! Error messages: '}; errorMsg];
    end

    return;
end
