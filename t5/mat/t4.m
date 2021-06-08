
close all
clear all
format long

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Added Material bellow                        %
%                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R1 = 1000;
R2 = 1000;
R31 = 100000;
R32 = 100000;
R33 = 100000;
R3 = R31+1/(1/R32 + 1/R33);
R4 = 1000;

C1 = 0.22*10^(-6);
% two 0.22 uFaraday condensors in series
C2 = 0.11*10^(-6);

f = logspace(1,8,10000);
T = ones(1,length(f));
T_db = ones(1,length(f));
T_phase = ones(1,length(f));

%cálculo da resposta da frequência
for y = 1:length(f)
	T(y) = (1+R3/R4)*(1/(1+R2*C2*f(y)*2*pi()*i))*(R1*C1*2*pi()*f(y)*i)/(1+R1*C1*2*pi()*f(y)*i);
	T_db(y) = 20*log10(abs(T(y)));
	T_phase(y) = arg(T(y))*180/pi();
endfor

%valor téorico ideializado do gain e das impendencias de saída e de entrada do circuito para 1 KHz

Input_Imp_teo = (1/(2*pi*1000*C1*i) + R1);
Output_Imp_teo = R2/(1 + 1000*C2*R2*2*pi*i);
Gain_teo = abs((1+R3/R4)*(1/(1+R2*C2*1000*2*pi*i))*((R1*C1*2*pi*1000*i)/(1+R1*C1*2*pi*1000*i)));
Gain_teo_db = 20*log10(Gain_teo);

%%%

%Load = 8; % Ohm

%% functions to output results of Operating Point to Latex


doc_const = fopen("octave_Constants_used_t_4.tex","w");
fprintf(doc_const,"Amplificador Operacional 741 &  \\\\  \\hline \n");
fprintf(doc_const,"R1 & %f KOhm\\\\  \\hline \n", R1/1000);
fprintf(doc_const,"R2 & %f KOhm\\\\  \\hline \n", R2/1000);
fprintf(doc_const,"R31 & %f KOhm\\\\  \\hline \n", R31/1000);
fprintf(doc_const,"R32 & %f KOhm\\\\  \\hline \n", R32/1000);
fprintf(doc_const,"R33 & %f KOhm\\\\  \\hline \n", R33/1000);
fprintf(doc_const,"R4 & %f KOhm\\\\  \\hline \n", R4/1000);
fprintf(doc_const,"C1 & %f nF\\\\  \\hline \n", C1*1000000000);
fprintf(doc_const,"C2 & %f nF\\\\  \\hline \n", C2*1000000000);
fclose(doc_const);

doc_const_1 = fopen("octave_OP_t_4.tex","w");
fprintf(doc_const_1,"&  K\\\\  \\hline \n");
#{
fprintf(doc_const_1,"V eq & %f K\\\\  \\hline \n", VEQ);
fprintf(doc_const_1,"I B & %f m\\\\  \\hline \n", IB1*1000);
fprintf(doc_const_1,"I c 1 & %f m\\\\  \\hline \n", IC1*1000);
fprintf(doc_const_1,"I e 1 & %f m\\\\  \\hline \n", IE1*1000);
fprintf(doc_const_1,"V E & %f \\\\  \\hline \n", VE1);
fprintf(doc_const_1,"V Output 1 & %f \\\\  \\hline \n", VO1);
fprintf(doc_const_1,"VCE & %f \\\\  \\hline \n", VCE);
fprintf(doc_const_1,"V Input 2 & %f \\\\  \\hline \n", VI2);
fprintf(doc_const_1,"I c 2 & %f m\\\\  \\hline \n", IC2*1000);
fprintf(doc_const_1,"I e 2 & %f m\\\\  \\hline \n", IE2*1000);
fprintf(doc_const_1,"V Output & %f \\\\  \\hline \n", VO2);
#}
fclose(doc_const_1);

max_gain = max(T_db);

barrier = max_gain - 3;
cut_off_frequency = 0;
upper_freq = 0;
tic = 0;
for variable = 1:length(f)

  if (T_db(variable) >= barrier) && (tic == 0)
  	cut_off_frequency = f(variable);
  	tic = 1;
  endif

  if (T_db(variable) <= barrier) && (tic == 1)
  	upper_freq = f(variable);  
  	tic = 0;
  endif
endfor

bandwidth_freq = upper_freq - cut_off_frequency;
Center_freq_teo = sqrt(upper_freq*cut_off_frequency);
deviation_center_freq = abs(Center_freq_teo - 1000);
gain_deviation_teo = abs(Gain_teo - 100);
custo = 13323.29209 + 303.66;
merito = 1/(custo*(deviation_center_freq + gain_deviation_teo + 0.000001));



doc_const_2 = fopen("octave_results_t_4.tex","w");
%%%
fprintf(doc_const_2,"Theorical Input Impedance & %f  %f i KOhm\\\\  \\hline \n", real(Input_Imp_teo)/1000, imag(Input_Imp_teo)/1000);
fprintf(doc_const_2,"Theorical Output Impedance & %f  %f i KOhm\\\\  \\hline \n", real(Output_Imp_teo)/1000, imag(Output_Imp_teo)/1000);
fprintf(doc_const_2,"Voltage Gain at central freq & %f V\\\\  \\hline \n", Gain_teo);
fprintf(doc_const_2,"Voltage Gain at central freq in decibels & %f V\\\\  \\hline \n", Gain_teo_db);
%%%
fprintf(doc_const_2,"Center of freq & %f Hz\\\\  \\hline \n", Center_freq_teo);
fprintf(doc_const_2,"Deviation of center of freq & %f Hz\\\\  \\hline \n", deviation_center_freq);
fprintf(doc_const_2,"Cust & %f \\\\  \\hline \n", custo);
fprintf(doc_const_2,"Cut-off frequency & %f Hz\\\\  \\hline \n", cut_off_frequency);
fprintf(doc_const_2,"Bandwidth & %f \\\\  \\hline \n", bandwidth_freq);
fprintf(doc_const_2,"Cust & %f M.U.\\\\  \\hline \n", custo);
fprintf(doc_const_2,"Merit & %f E-6\\\\  \\hline \n", merito*10^(6));
fclose(doc_const_2);



% gráfico da magnitude de V_out(f)/V_in(f)

F_gain = figure();
 semilogx(f, T_db, "k");
 hold on;
 grid on;
 title("Frequecy response of the Magnitude of the tension gain");
 xlabel ("frequency [Hz]");
 ylabel ("Decibels [D]");
 legend("Magnitude of V_out(f)/V_in(f)");
 saveas(F_gain, "magnitude_response_gain.eps");
close(F_gain);

% gráfico da fase de V_out(f)/V_in(f)

F_gain_phase = figure();
 semilogx(f, T_phase, "k");
 hold on;
 grid on;
 title("Frequecy response of the phase of the tension gain");
 xlabel ("frequency [Hz]");
 ylabel ("Degrees");
 legend("phase of V_out(f)/V_in(f)");
 saveas(F_gain_phase, "phase_response_gain.eps");
close(F_gain_phase);

