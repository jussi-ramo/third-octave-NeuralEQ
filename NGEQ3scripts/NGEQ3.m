function filterGains = NGEQ(targetGains)
% NGEQ filter gain calculation
% filterGains = NGEQ(targetGains)
%
% targetGains: vector (31x1) consisting the user-set gains [-12dB 12dB]
% filterGains: optimized output gains in dB
%
% Written by Jussi Rämö, August 24, 2019.

%% Check input vector size. Should be 31 x 1
[row,col] = size(targetGains);
if row == 31 && col == 1
	targetGains = targetGains;
elseif row == 1 && col == 31;
	targetGains = targetGains';
else
	error('targetGains vector has the wrong size! Should be 31 x 1 column vector.')
end

%% Initialize outputs and variables
g = zeros(31,1);			% Scaled input gains [-1 1]
o1 = zeros(62,1);			% Output of the 1st hidden layer
o2 = zeros(31,1);			% Output of the 1st hidden layer
go = zeros(31,1);			% Scaled output gains [-1 1]
filterGains = zeros(31,1);	% Output gains in dB

%% Load neural net parameters needed in Eqs. (11)-(15)
load NGEQ3_parameters.mat 

%% Filter gain calculation
g = 2.*(targetGains - xmin)./(xmax-xmin) - 1;	% Eq. (11)
o1 = tanh(W1*g + theta1);						% Eq. (12)
o2 = tanh(W2*o1 + theta2);						% Eq. (13)
go = W3*o2 + theta3;							% Eq. (14)
filterGains = (tmax-tmin).*(go + 1)/2 + tmin;	% Eq. (15)
