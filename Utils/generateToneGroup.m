loopN = 10;
freqSeq = []; attSeq = [];
freq = [500; 1000; 2000; 4000];
intensity = [60; 60; 60 ;60];
att = CalAttenuation('positionA', 'pureTone', freq, intensity);
for nSecLoop = 1 : loopN
freqSeqReg = reshape([ones(1,30)*freq(1) ; ones(1,30)*freq(2); ones(1,30)*freq(3); ones(1,30)*freq(4)], [], 1);
attSeqReg = reshape([ones(1,30)*att(1); ones(1,30)*att(2); ones(1,30)*att(3); ones(1,30)*att(4)], [], 1);
randIdx = randperm(120);
freqSeqIrreg = freqSeqReg(randIdx);
attSeqIrreg = attSeqReg(randIdx);
freqSeq = [freqSeq; freqSeqReg; freqSeqIrreg];
attSeq = [attSeq; attSeqReg; attSeqIrreg];
end
path = 'D:\Monkey\matlab\parameters';
params.freqSeq = freqSeq;
params.attSeq = attSeq;
generateParamsFiles(path,params)