function out = NGEQ3filterAudio(in,targetGains)
% Filter audio using the Neurally Controlled Graphic Equalizer
% out = NGEQfilterAudio3(in,b,a,G0)
%
% in = input audio signal
% out = filtered audio signal
% targetGains: vector (31x1) consisting the user-set gains [-12dB 12dB]
%
%
% Written by Jussi Rämö, August 24, 2019

%% Calculate the optimized filter gains
filterGains = NGEQ3(targetGains);

%% Design the individual EQ filters
[b,a,G0] = GEQfilters3(filterGains);

%% Filter audio
% Init output
out = G0.*in;
% Filter with 31 EQ filters
for m = 1:31
	out = filter(b(m,:),a(m,:),out);
end

