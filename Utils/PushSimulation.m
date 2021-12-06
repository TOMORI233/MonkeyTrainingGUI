% 模拟猴子按键
if ~exist('com2', 'var')
    com2 = serialport('COM2', 115200);
end
write(com2, 1, 'uint8');
pause(0.02);
write(com2, 2, 'uint8');