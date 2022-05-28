
tic
t1=t_test;
pause(1)
stop(t1)

    function t1=t_test(varargin)
        if nargin == 0  % 直接命令行输�? t_test 表示：创建一个定时器对象，开始定�?
            delete(timerfind)   % 删除现有的定时器，重新创建一个定时器
            t1= timer('TimerFcn',@t_TimerFcn,'Period',0.02,'ExecutionMode','fixedRate');
            start(t1);
        end
    end
    
    
        function t_TimerFcn(hObject,eventdata)
        toc
        tic
    end
    
