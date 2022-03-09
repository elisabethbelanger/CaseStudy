%% Audio Equilizer Function
% The function takes in inputs for the gain factors and input signal with
% its sampling freqency. Input is passed through 3 bandpass filters made
% from low- and high-pass RC circuits and a single low pass at the highest
% frequencies and a single high-pass at lowest frequencies.
%
% * Inputs:
% 
% # xv: N x 1 vector of audio signal
% # xvfs: integer corresponding to sampling frequency of the audio
% # xv: N x 1 vector of audio signal
% # xvfs: integer corresponding to sampling frequency of the audio
% # g1 - g5: integer values of the desired gain for each of the 5 filters
%
% * Output: y: N x 1 vector of the filtered signal
% 

function y = equilizer(xv, xvfs, g1, g2, g3, g4, g5)

fc1 = 120;
tao1 = 1/(2*pi*fc1);
fs =xvfs;

% Low pass - 120 hz 
x1 = filter((1/fs)/tao1, [(1/fs)/tao1+1, -1], xv);

% BP1 120 -> 680
fc1_1=60*2;
fc1_2 = 680*2;
tao1_1 = 1/(2*pi*fc1_1);
tao1_2 = 1/(2*pi*fc1_2);
fs =xvfs;

% Low pass
x2 = filter((1/fs)/tao1_2, [(1/fs)/tao1_2+1, -1], xv);

% High pass
x2 = filter([1, -1], [(1+(1/fs)/tao1_1), -1], x2);

% BP2 680 -> 3320

fc2_1=680*1.3;
fc2_2 = 3320*1.5;
tao2_1 = 1/(2*pi*fc2_1);
tao2_2 = 1/(2*pi*fc2_2);
fs =xvfs;

% Low pass
x3 = filter((1/fs)/tao2_2, [(1/fs)/tao2_2+1, -1], xv);

% High pass
x3 = filter([1, -1], [(1+(1/fs)/tao2_1), -1], x3);


% BP3 3320 -> 12680

fc3_1=3320*1.52;
fc3_2 = 12680;
tao3_1 = 1/(2*pi*fc3_1);
tao3_2 = 1/(2*pi*fc3_2);

fs =xvfs;

% Low pass
x4 = filter((1/fs)/tao3_2, [1+(1/fs)/tao3_2, -1], xv);
% High pass
x4 = filter([1, -1], [(1+(1/fs)/tao3_1), -1], x4);

% High pass - 12680+
tao4 = 12680;

x5 = filter([1, -1], [(1+(1/fs)/tao4), -1], xv);

y = max(abs(xv))*(g1*x1/max(abs(x1)) + g2*x2/max(abs(x2)) + g3*x3/max(abs(x3)) + g4*x4/max(abs(x4)) + g5*x5/max(abs(x5)));

end