function [b,a,G0] = GEQfilters3(filterGains)
% Graphic EQ filter design for the Third-Octave Graphic Equalizer
% [b,a] = GEQfilters3(filterGains)
%
% filterGains: Optimized EQ filter gains from NGEQ3.m
%
% Written by Jussi Rämö, August 24, 2019

%% Octave center frequencies and bandwidths
fs  = 44100;  				% Sample rate
fc = [19.69,24.80,31.25,39.37,49.61,62.50,78.75,99.21,125.0,157.5,198.4, ...
    250.0,315.0,396.9,500.0,630.0,793.7,1000,1260,1587,2000,2520,3175,4000, ...
    5040,6350,8000,10080,12700,16000,20160]; % Log center frequencies for filters
wc = 2*pi*fc/fs;  			% Command gain frequencies in radians
c = 0.4; 					% Gain factor at bandwidth (parameter c)
B = 2*pi/fs*[9.178 11.56 14.57 18.36 23.13 29.14 36.71 46.25 58.28 73.43 ...
    92.51 116.6 146.9 185.0 233.1 293.7 370.0 466.2 587.4 740.1 932.4 ...
    1175 1480 1865 2350 2846 3502 4253 5038 5689 5570]; % EQ filter bandwidths

% Filter gains
g = filterGains;			% Optimized filter gains in dB
G = 10.^(g/20);   			% Convert gains to linear gain factors
gB = c*g;      				% Gain at bandwidth edges  Eq. (4)
GB = 10.^(gB/20); 			% Convert to linear gain factor

b = zeros(31,3);  			% Initialize 3 numerator coefficients for each 31 filters
a = zeros(31,3);  			% Initialize 3 denominator coefficients for each 31 filters

% Filter design using NGEQ3 optimized gains with pareq2.m
for m = 1:31,
    [b0(m), b(m,:), a(m,:)] = pareq2(G(m), GB(m), wc(m), B(m)); % Design filters
end

G0 = prod(b0);				% Eq. (7)


