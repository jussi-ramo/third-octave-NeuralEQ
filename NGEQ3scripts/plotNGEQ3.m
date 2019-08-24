% Plots the magnitude response of the Third-Octave Neural Graphic EQ
%
% Serves as an example how to utilize the function included in the NGEQ3 package
% plotNGEQ3(targetGains)
%
% targetGains: vector (31x1) consisting the user-set gains [-12dB 12dB]
%
% Written by Jussi Rämö, August 24, 2019

%% User-set target gains - CHANGE THESE TO EXPERIMENT w/ NGEQ
targetGains = [12 -12 12 -12 12 -12 12 -12 12 -12 12 -12 12 -12 12 -12 12 -12 12 -12 12 -12 12 -12 12 -12 12 -12 12 -12 12]';	% Zig Zag gains
% targetGains = randi([-12 12],31,1); 					% Random gains


fs = 44100;					% Sample rate
fc = [19.69,24.80,31.25,39.37,49.61,62.50,78.75,99.21,125.0,157.5,198.4, ...
    250.0,315.0,396.9,500.0,630.0,793.7,1000,1260,1587,2000,2520,3175,4000, ...
    5040,6350,8000,10080,12700,16000,20160]; % Log center frequencies for filters

%% Calculate the optimized filter gains
filterGains = NGEQ3(targetGains);

%% Design the individual EQ filters
[b,a,G0] = GEQfilters3(filterGains);

%% Filter an impulse
in = [1; zeros(fs-1,1)]; % Create an impulse
out = G0.*in;			 % Multiply by G0
% Filter with 10 EQ filters
for m = 1:31
	out = filter(b(m,:),a(m,:),out);
end

%% Calculate spectrum and plot
len = length(out);
spectr = abs(fft(out));
spectr = 20*log10(spectr(1:len/2));
dfreq = fs/len;
splen = length(spectr);
frq = linspace(0,dfreq*(splen-1),splen);

fig = figure;
semilogx(frq,spectr,'k','LineWidth',2);
hold on;
plot(fc,targetGains,'ko','MarkerSize',10)
plot(fc,filterGains,'kx','MarkerSize',10)
plot([18 fs/2],[12 12],'--k')
plot([18 fs/2],[-12 -12],'--k')
hold off;
xlim([18 fs/2]);
grid on;
set(gca,'XTick',[100 1000 10000 20000]);
set(gca,'XTickLabel',{'100','1k','10k','20k'},'Fontname','Times','Fontsize',18)
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
ylim([-30 30])
legend('NGEQ response','Target gains','Filter gains','location','northeastoutside')
fig.Position(3) = 800;