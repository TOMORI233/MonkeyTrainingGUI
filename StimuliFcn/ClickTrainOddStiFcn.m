function ClickTrainOddStiFcn(device)
%% Variables initialization
DTO = get(device, 'UserData');
DTO.vars.attSeq = [];
DTO.vars.cueType = [];
DTO.vars.freqSeq = [];
DTO.vars.intensityFile = LoadIntensityFile(DTO.params.stiPosition, DTO.params.soundType);
DTO.vars.intensitySeq = [];
DTO.vars.ISI = DTO.params.ISI_average;
DTO.vars.lastStiOnsetTime = 0;
DTO.vars.pushInTrialFlag = false;
DTO.vars.pushAfterDelayFlag = true;
DTO.vars.pushTime = 0;
DTO.vars.stdNum = 0;
DTO.vars.stiCount = 0;
DTO.vars.sweepCount = 0;
DTO.vars.tCount = 0;
DTO.vars.time2LastSound = 0;
DTO.vars.trialStartFlag = false;
DTO.vars.oddballType = [];
DTO.vars.firstOnset2LastOnset = 0;
DTO.vars.time2LastSound = 0; % for choice win based on tic-toc
%% Initialize TDT constant params
% DTO.obj.write('waterDelay', waterDelayTimeDev);
% Constant parameters
paramsNames = fieldnames(DTO.params);

for index = 1:size(paramsNames, 1)
    eval([paramsNames{index}, '=DTO.params.', paramsNames{index}, ';']);
end

%% Save DTO to device userdata and enable serialport callback
set(device, 'UserData', DTO);
if offsetChoiceWinFlag
    DTO.callbackFcn = @OffsetChoiceWinlSerialFcn;
end
configureCallback(device, 'byte', 1, DTO.callbackFcn);

shengqiang=xlsread('G:\MonkeyTrainingGUI\Documents\Intensity Files\speaker0oclickTrain.xlsx', 1, 'A2:E40'); %¥ø“Ù
att0=[shengqiang(:,1) shengqiang(:,4)];%%
run('clickTrainAttIdx2.m')

%% Generate oddball sequence
params.freq1 = [];
params.freq2 = [];
params.Dur = [];
params.att = [];
params.num = [];
params.ISI = [];
params.order = [];
oddballTypeAll = [];
soundNum = [];

% read Variables
varsNames = fieldnames(DTO.vars);

for index = 1:size(varsNames, 1)
    eval([varsNames{index}, '=DTO.vars.', varsNames{index}, ';']);
end

% TODO: random ISI
ISI = ISI_average;
ISIInTrial = ISI;

ISIAll = []; orderAll = []; repAll = []; numsAll = []; numAllall = []; ratioAll = []; WAll = []; ISIInTrialAll = []; attAll = [];
for trialN = 1:sweepCountMax*2
    type = randsrc(1,1,[seqType ; typeProb]);
    % std number
    stdNum = randsrc(1, 1, [stdNumArray'; stdNumProb']);

    % click train odd seq type
    switch type
        case 1 % SSA basic
            orderSSA = [1 1; 1 2; 1 3; 1 4; 1 5; 6 6; 6 10];
            orders = [1 2 3 4 5 6 7];
            orderProb=ones(1,7)/7;
            orderIdx = randsrc(1,1,[orders; orderProb]);
            stdOrder = orderSSA(orderIdx,1);
            curOrder = orderSSA(orderIdx,2);
            stdAtt = attIdx(stdOrder);
            curAtt = attIdx(curOrder);
            
            order = [ones(stdNum,1)*stdOrder;curOrder];
            att = [ones(stdNum,1)*stdAtt;curAtt];
            ISICur = ISIInTrial;
        case 2 % SSA Working memory
            orderSSA = [1 1; 1 3; 6 6; 6 8; 11 11; 11 12; 15 15; 15 16; 19 19; 19 20];
            orders = [1 2 3 4 5 6 7 8 9 10];
%             orderProb=ones(1,10)/10;
            orderProb= repmat([1/20 3/20],1,5);
            orderIdx = randsrc(1,1,[orders; orderProb]);
            stdOrder = orderSSA(orderIdx,1);
            curOrder = orderSSA(orderIdx,2);
            stdAtt = attIdx(stdOrder);
            curAtt = attIdx(curOrder);

            stdFreq = normrnd(4000,1000);
            while stdFreq < 500
                    stdFreq = normrnd(4000,1000);
            end
            devFreq = stdFreq * 1.2;

            order = [ones(stdNum,1)*stdOrder;curOrder];
            att = [ones(stdNum,1)*stdAtt;curAtt];
            ISICur = ISIInTrial;
            %             s1Amp = 3;
            %             s2Amp = s1Amp+s1Amp*0.5*(pul0seOn(order(1,1))/pulseOn(order(1,2))-1);
        case 3 % SSA High order
            orderSSA = [20 25; 25 20;95 100; 100 95; 20 20; 25 25; 95 95; 100 100];
            orders = [1 2 3 4 5 6 7 8];
            orderProb=ones(1,8)/8;
            orderIdx = randsrc(1,1,[orders; orderProb]);
            stdOrder = orderSSA(orderIdx,1);
            curOrder = orderSSA(orderIdx,2);
            stdAtt = attIdx(stdOrder);
            curAtt = attIdx(curOrder);
            order = [ones(stdNum,1)*stdOrder;curOrder];
            att = [ones(stdNum,1)*stdAtt;curAtt];
            ISICur = ISIInTrial;
        case 4 % SSA Short
            orderSSA = [1 6; 6 1; 1 1; 6 6;36 37; 37 36; 36 36; 37 37; 38 39; 39 38; 38 38; 39 39];
            orders = [1 2 3 4 5 6 7 8 9 10 11 12];
            orderProb=[1/8 1/8 1/24 1/24 1/8 1/8 1/24 1/24 1/8 1/8 1/24 1/24 ];
            orderIdx = randsrc(1,1,[orders; orderProb]);
            stdOrder = orderSSA(orderIdx,1);
            curOrder = orderSSA(orderIdx,2);
            order = [ones(stdNum,1)*stdOrder;curOrder];
            ISICur = 500;
        case 5 % SSA Scale
            orderSSA = [1 6; 6 1; 1 1; 6 6;13 14; 14 13; 13 13; 14 14];
            orders = [1 2 3 4 5 6 7 8];
            orderProb=[1/5 1/5 1/20 1/20 1/5 1/5 1/20 1/20 ];
            ISIs = [502 536 502 536 496 496 496 496];
            orderIdx = randsrc(1,1,[orders; orderProb]);
            stdOrder = orderSSA(orderIdx,1);
            curOrder = orderSSA(orderIdx,2);
            order = [ones(stdNum,1)*stdOrder;curOrder];
            ISICur = ISIs(orderIdx);
    end

    % determine oddball trial type
    if curOrder == stdOrder
        oddballType = 'STD';
    else
        oddballType = 'DEV';
    end

    % integrate stim parameters
    params.freq1 = [params.freq1 ; ones(stdNum+1, 1) * stdFreq ];
    params.freq2 = [params.freq2 ; ones(stdNum+1, 1) * devFreq ];
    params.Dur = [params.Dur ; intensitySeq'];
    params.att = [params.att ; att];
    params.num = [params.num ; (1:stdNum+1)'];
    params.ISI = [params.ISI ; ones(stdNum+1,1)*ISI];
    params.order = [params.order ; order];
    oddballTypeAll = [oddballTypeAll ; {oddballType}];
    soundNum = [soundNum ; stdNum+1];

end
params.soundNum = soundNum;
DTO.vars.oddballTypeAll = oddballTypeAll;
DTO.vars.soundNum = soundNum;
DTO.vars.ISIAll = params.ISI;

path = 'D:\Monkey\matlab\parameters';
generateParamsFiles(path,params);

% pause(2);
%% Set TDT device obj
%     DTO.obj = [];
DTO.obj = TDEV();
DTO.obj.DEVICE_NAME = DTO.obj.DEVICE_NAMES{1};
DTO.obj.standby;
pause(2);

%% Set timer
delete(timerfind);
DTO.period = 0.02; % sec
DTO.vars.sessionStart = tic;
mTimer = timer('TimerFcn', {@mTimerFcn, device}, 'Period', DTO.period, 'ExecutionMode', 'fixedRate');
set(device, 'UserData', DTO);
start(mTimer);
DTO.obj.record;
% DTO.obj.preview;
end

%% TimerFcn
function mTimerFcn(~, ~, device)
%% Get constants and variables
DTO = get(device, 'UserData');
period = DTO.period * 1000; % ms
obj = DTO.obj;


paramsNames = fieldnames(DTO.params);

for index = 1:size(paramsNames, 1)
    eval([paramsNames{index}, '=DTO.params.', paramsNames{index}, ';']);
end

% Variables
varsNames = fieldnames(DTO.vars);

for index = 1:size(varsNames, 1)
    eval([varsNames{index}, '=DTO.vars.', varsNames{index}, ';']);
end

%% Idle
if sweepCount > sweepCountMax
    disp('Reach max sweep count');
    obj.idle;
    configureCallback(device, 'off');
    delete(timerfind);
end

%% TODO: Stimulus
% tCount = tCount + 1;
tCount = toc(sessionStart) / DTO.period; % period = 0.02;
time2LastSound = toc*1000 -firstOnset2LastOnset;
% Punish for not starting, for ACTIVE
if tCount >= max([lastStiOnsetTime, pushTime]) + punishDelayTime * 1000 / period
    obj.write('T', 1); % Punishment On
end

% Trial started by monkey
if ~trialStartFlag && pushAfterDelayFlag && tCount >= pushTime + pushToOnsetInterval / period
    sweepCount = sweepCount + 1;

    % time to devonset
    if sweepCount == 1
        obj.write('waterDelay', waterDelayTimeDev);
        idx = 1:soundNum(1)-1;
    else
        idx = (1:soundNum(sweepCount)-1) + sum(soundNum(1 : sweepCount - 1));
    end


    firstOnset2LastOnset = sum(ISIAll(idx));





    % Reset flags
    pushInTrialFlag = false;
    pushAfterDelayFlag = false;
    stiCount = 0;

    % parameters of current trial
    oddballType = oddballTypeAll{sweepCount};
    stdNum = soundNum(sweepCount) - 1;

    % Set flags
    trialStartFlag = true;

    %     disp(['Trial Start - ' num2str(sweepCount)]);
    %     disp([cueType, ' ', oddballType, ' ', num2str(stdNum)]);
end

% trig current trial
%         obj.write('sweep', sweepCount);
if trialStartFlag && tCount >= lastStiOnsetTime + ISI / period && stiCount <= stdNum
    stiCount = stiCount + 1;
    %       disp([soundType, ': ', num2str(stiCount)]);

    %       disp(['stdNum = ' num2str(stdNum)]);
    %       disp(['trialStartFlag' num2str(trialStartFlag)]);
    %       disp(['stiCount = ' num2str(stiCount)]);
    %       disp(['current tCount = ' num2str(tCount)]);
    %       disp(['next sti time = ' num2str( lastStiOnsetTime + ISI / period)]);
    lastStiOnsetTime = tCount;
    obj.write('sweep', sweepCount);
    if stiCount == 1
        switch soundType
            case 'pureTone'

            case 'complexTone'

            case 'noise'

        end

        obj.write('trig', 1);
        obj.write('trig', 0);
        tic
    end
end



% Std trial correct

if trialStartFlag && stiCount == stdNum + 1 && time2LastSound >=   waterDelayTimeStd - waterDelayTimeDev && strcmp(oddballType, 'STD') && ~pushInTrialFlag
    obj.write('W', rewardTimeCorrect);
    if sweepCount > 200
        obj.write('W', rewardTimeCorrect*1.3);
    end
    if sweepCount > 300
        obj.write('W', rewardTimeCorrect*1.6);
    end
    obj.write('water', 1);
    obj.write('water', 0);
    disp('std correct');
    trialStartFlag = false;
end


% Trial auto end
if trialStartFlag && stiCount >= stdNum + 1 && tCount > lastStiOnsetTime  + max( offsetChoiceWinFlag * durationStd + [waterDelayTimeStd choiceWindow(2)]) / period

    %     disp('trial auto end');
    trialStartFlag = false;
end


% passive initiate next trial
if strcmp(activeOrPassive,'passiveBehavior') && ~trialStartFlag &&  tCount > lastStiOnsetTime + delayTime / period
    %      disp('passive trial auto start');
    pushAfterDelayFlag = 1;
    pushTime = tCount - pushToOnsetInterval / period;
end

%% Update DTO for serialport callbacFcn
for index = 1:size(varsNames, 1)
    DTO.vars.(varsNames{index}) = eval(varsNames{index});
end

set(device, 'UserData', DTO); % Save DTO to device userdata
configureCallback(device, 'byte', 1, DTO.callbackFcn); % Enable serialport callback
end
