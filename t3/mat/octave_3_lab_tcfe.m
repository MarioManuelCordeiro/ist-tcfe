close all
clear all

format long

%%% Constants
f = 50;   %Hertz
w = 2*pi*f; % radians per second
A = 230;  %Volts
R_1 = 65; %KOhm
R_2 = 68.28; %KOhm
C = 160; % microFarad

%Diode
n_material = 1;
n_diodes_series = 21;
V_t = 25e-3;
I_s = 1e-14;
V_ON = 12; %valor médio da v_O retirado do NgSpice


time = linspace (0,0.4,4000);

time_1 = linspace(0.2, 0.4, 2000);

V_out_rectifier = zeros(1, length(time));
v_Out = zeros(1, length(time));

%%% Transformador
n = 16;

V_AC = 230*cos(w*time);

Vin = V_AC/n;

%%% Envelope Detector

%effect of the full-bridge rectifier

for x = 1:length(time)
	V_out_rectifier(x) = abs(Vin(x));
endfor
%

t_off = 1/w*atan(1/(R_1*(1e+3)*C*(1e-6)*w));


for k = 1:length(time)

	V_discharge = 230/n*cos(w*t_off)*exp(-(time(k)-t_off)/(R_1*(1e+3)*C*(1e-6)));


	if time(k) < t_off
		V_in_regulater(k) = V_out_rectifier(k);
	elseif  V_discharge >= V_out_rectifier(k)
		V_in_regulater(k) = V_discharge;
	else
		t_off = (1/f)/2 + t_off;
		V_in_regulater(k) = V_out_rectifier(k);
	endif

endfor

%graph of the output of Envelope Detector

	for p = 1:length(time_1)
		Vinregulater(p) = V_in_regulater(p+1999);
	endfor

H_parcial = figure();
 plot (time_1*1000, Vinregulater, "b");
 grid on;
 title("Output Voltage of Envelope Detector");
 xlabel ("time [ms]");
 ylabel ("Voltage [V]");
 legend("V2(t)");
 print (H_parcial, "Output_Envelope_Detector.eps", "-depsc");


%%% Voltage Regulator
	rd = (n_diodes_series*n_material*V_t)/(I_s*exp(V_ON/(n_material*V_t)));
	
	V_in_average = mean(V_in_regulater);
for w = 1:length(time)

	v_out(w) = (rd)/(rd + R_2*(1e+3))*(V_in_regulater(w)-V_in_average);
	
	V_out(w) = v_out(w) + V_ON;
endfor

%graph of the output of Voltage Regulater

	for g = 1:length(time_1)
		Vout(g) = V_out(g+1999);
	endfor


H_total = figure();
 plot (time_1*1000, Vout, "b");
 grid on;
 title("Output Voltage of the AC to DC converter");
 xlabel ("time [ms]");
 ylabel ("Voltage [V]");
 legend("V3(t)");
 print (H_total, "Output_Voltage_Regulater.eps", "-depsc");
 
 deviations_vector = zeros(1, length(Vout));
 
 for y = 1:length(Vout)
 	deviations_vector(y) = Vout(y) - 12;
 endfor
 
 H_total_desvios = figure();
 plot (time_1*1000, deviations_vector, "b");
 grid on;
 title("Output Voltage deviations of the AC to DC converter");
 xlabel ("time [ms]");
 ylabel ("Voltage [V]");
 legend("V3(t)-12");
 print (H_total_desvios, "Output_Voltage_Regulater_deviations.eps", "-depsc");
 

%output of values

%output DC level and Voltage ripple.

doc_results_3 = fopen("octave_theorical_results_3.tex","w");
fprintf(doc_results_3,"DC Level & %f \\\\  \\hline \n", mean(V_out));
fprintf(doc_results_3,"Voltage ripple & %f \\\\  \\hline \n", max(V_out)-min(V_out));
fclose(doc_results_3);

