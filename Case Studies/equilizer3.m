function y = equilizer(xv, xvfs, g1, g2, g3, g4, g5)

fc1 = 60;
tao1 = 1/(2*pi*fc1);
fs =xvfs;

% Low pass
x1 = filter((1/fs)/tao1, [1, (1/fs)/tao1-1], xv);

fc2 = 680;
tao1 = 1/(2*pi*fc1);
tao2 = 1/(2*pi*fc2);
fs =xvfs;

% Low pass
x2 = filter((1/fs)/tao2, [1, (1/fs)/tao2-1], xv);

% High pass
x2 = filter([1, -1], [(1+(1/fs)/tao2), -1], x2);

fc3 = 3320;
tao3 = 1/(2*pi*fc3);
fs =xvfs;

% Low pass
x3 = filter((1/fs)/tao3, [1, (1/fs)/tao3-1], xv);

% High pass
x3 = filter([1, -1], [(1+(1/fs)/tao3), -1], x3);

fc4 = 12680;
tao4 = 1/(2*pi*fc4);
fs =xvfs;

% Low pass
x4 = filter((1/fs)/tao4, [1, (1/fs)/tao4-1], xv);

% High pass
x4 = filter([1, -1], [(1+(1/fs)/tao3), -1], x4);

% High pass
x5 = filter([1, -1], [(1+(1/fs)/tao4), -1], xv);

y = mean(abs(xv))*(g1*x1/mean(abs(x1)) + g2*x2/mean(max(x2)) + g3*x3/mean(max(x3)) + g4*x4/mean(max(x4)) + g5*x5/mean(max(x5)));

end