
close all
clear all

%gain stage

VT=25e-3;
BFN=178.7;
VAFN=69.7;
RE1=100;
RC1=1000;
RB1=80000;
RB2=20000;
VBEON=0.7;
VCC=12;
RS=100;

RB=1/(1/RB1+1/RB2);
VEQ=RB2/(RB1+RB2)*VCC;
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1);
IC1=BFN*IB1;
IE1=(1+BFN)*IB1;
VE1=RE1*IE1;
VO1=VCC-RC1*IC1;
VCE=VO1-VE1;


gm1=IC1/VT;
rpi1=BFN/gm1;
ro1=VAFN/IC1;

RSB=RB*RS/(RB+RS);

AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2);
AVI_DB = 20*log10(abs(AV1));
AV1simple = RB/(RB+RS) * gm1*RC1/(1+gm1*RE1);
AVIsimple_DB = 20*log10(abs(AV1simple));

RE1=0;
AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2);
AVI_DB = 20*log10(abs(AV1));
AV1simple =  - RSB/RS * gm1*RC1/(1+gm1*RE1);
AVIsimple_DB = 20*log10(abs(AV1simple));

RE1=100;
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)));
ZX = ro1*((RSB+rpi1)*RE1/(RSB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RSB)+1/RE1+gm1*rpi1/(rpi1+RSB)));
ZX = ro1*(   1/RE1+1/(rpi1+RSB)+1/ro1+gm1*rpi1/(rpi1+RSB)  )/(   1/RE1+1/(rpi1+RSB) ) ;
ZO1 = 1/(1/ZX+1/RC1);

RE1=0;
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)));
ZO1 = 1/(1/ro1+1/RC1);

%ouput stage
BFP = 227.3;
VAFP = 37.2;
RE2 = 100;
VEBON = 0.7;
VI2 = VO1;
IE2 = (VCC-VEBON-VI2)/RE2;
IC2 = BFP/(BFP+1)*IE2;
VO2 = VCC - RE2*IE2;

gm2 = IC2/VT;
go2 = IC2/VAFP;
gpi2 = gm2/BFP;
ge2 = 1/RE2;

AV2 = gm2/(gm2+gpi2+go2+ge2);
% added
AV2_DB = 20*log10(abs(AV2)); %% vai dar um valor próximo de 0
%
ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2);
ZO2 = 1/(gm2+gpi2+go2+ge2);


%total
gB = 1/(1/gpi2+ZO1);
AV = (gB+gm2/gpi2*gB)/(gB+ge2+go2+gm2/gpi2*gB)*AV1;
AV_DB = 20*log10(abs(AV));
ZI=ZI1;
ZO=1/(go2+gm2/gpi2*gB+ge2+gB);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                   Added Material bellow                        %
%                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RE1 = 100;
C_I = 1*10^(-3); % F
C_E = 1*10^(-3); % F
C_O = 1*10^(-6); % F
% BJT NPN
C_mu_1 = 4.388*10^(-12); % F Cjc
C_pi_1 = 1.61*10^(-11); % F Cje
%BJT PNP
C_mu_2 = 1.113*10^(-11); % F
C_pi_2 = 1.4*10^(-11); % F
%
Load = 8; % Ohm

%% functions to output results of Operating Point to Latex

% Constants_used
doc_const = fopen("octave_Constants_used_t_4.tex","w");
fprintf(doc_const,"VT & %f \\\\  \\hline \n", VT);
fprintf(doc_const,"BFN & %f \\\\  \\hline \n", BFN);
fprintf(doc_const,"VAFN & %f \\\\  \\hline \n", VAFN);
fprintf(doc_const,"RE1 & %f K\\\\  \\hline \n", RE1/1000);
fprintf(doc_const,"RC1 & %f K\\\\  \\hline \n", RC1/1000);
fprintf(doc_const,"RB1 & %f K\\\\  \\hline \n", RB1/1000);
fprintf(doc_const,"RB2 & %f K\\\\  \\hline \n", RB2/1000);
fprintf(doc_const,"VBEON & %f \\\\  \\hline \n", VBEON);
fprintf(doc_const,"VCC & %f \\\\  \\hline \n", VCC);
fprintf(doc_const,"RS & %f K\\\\  \\hline \n", RS/1000);
fprintf(doc_const,"BFP & %f K\\\\  \\hline \n", BFP);
fprintf(doc_const,"VAFP & %f \\\\  \\hline \n", VAFP);
fprintf(doc_const,"RE2 & %f K\\\\  \\hline \n", RE2/1000);
fprintf(doc_const,"VEBON & %f \\\\  \\hline \n", VEBON);
fprintf(doc_const,"C I & %f u\\\\  \\hline \n", C_I*10^(6));
fprintf(doc_const,"C E & %f u\\\\  \\hline \n", C_E*10^(6));
fprintf(doc_const,"C O & %f u\\\\  \\hline \n", C_O*10^(6));
fclose(doc_const);

% OP results
doc_const_1 = fopen("octave_OP_t_4.tex","w");
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
fclose(doc_const_1);

%%function to graph a aproximation of the frequency response v_o(f)/v_i(f)

%function to calculate the vector V_out(f)/V_in(f)

f = logspace(1,8,100);
vs = (i)*10e-3;

% definir impendencias de várias Componentes
Z_c_i = 1./(i*C_I*2*pi*f);
Z_c_e = 1./(i*C_E*2*pi*f);
Z_c_o = 1./(i*C_O*2*pi*f);
Z_c_pi_1 = 1./(i*C_pi_1*2*pi*f);
Z_c_mu_1 = 1./(i*C_mu_1*2*pi*f);
Z_c_pi_2 = 1./(i*C_pi_2*2*pi*f);
Z_c_mu_2 = 1./(i*C_mu_2*2*pi*f);
z_1 = ones(1, length(f));
z_2 = ones(1, length(f));
z_3 = ones(1, length(f));
z_4 = ones(1, length(f));
z_5 = ones(1, length(f));
z_6 = ones(1, length(f));
z_7 = ones(1, length(f));
for h = 1:length(f)
z_1(h) = RE1*Z_c_e(h)/(RE1 + Z_c_e(h));   %vector
z_2(h) = 1/(1/RE2 + 1/(Load + Z_c_o(h))); %vector
z_3(h) = RS + Z_c_i(h);            %vector
z_4(h) = Z_c_pi_1(h)*rpi1/(rpi1 +Z_c_pi_1(h));%vector
z_6(h) = (Z_c_pi_2(h)/gpi2)/(1/gpi2 +Z_c_pi_2(h));  %vector
endfor

z_5 = Z_c_mu_1;                %vetor
z_7 = Z_c_mu_2;                %vetor
%

Vector_of_gains = ones(length(f),1);

for k = 1:length(f) 

V_solutions = ones(4, 1);

Vector_column = [vs/z_3(k) 0 0 0]';

Matrix_of_Nodes = [(1/z_3(k) + 1/RB + 1/z_5(k) + 1/z_4(k)) (-1/z_5(k)) (-1/z_4(k)) 0;
                   (gm1 - 1/z_5(k)) (1/z_5(k) + 1/ro1 + 1/z_6(k) + 1/z_7(k) + 1/RC1) (-gm1 -1/ro1) (-1/z_6(k));
                   (-gm1 -1/z_4(k)) (-1/ro1) (1/z_1(k) + 1/z_4(k) + 1/ro1 +gm1) (0);
                   0 (-1/z_6(k)-gm2) 0 (1/z_6(k) + gm2 +gpi2 + 1/z_2(k) )];

V_solutions = Matrix_of_Nodes\Vector_column;
Vector_of_gains(k) = 20*log10(abs((Load/(Load+Z_c_o(k)))*V_solutions(4)/V_solutions(1)));

endfor

max_gain = max(Vector_of_gains);
barrier = max_gain - 3;
cut_off_frequency = 0;
upper_bound = 0;
tic = 0;
for variable = 1:length(f)

if Vector_of_gains(variable) >= barrier
  cut_off_frequency = f(variable);
  tic = 1;
endif

if (Vector_of_gains(variable) < barrier) && (tic == 1)
  upper_bound = f(variable);  
  tic = 0;
  endif
endfor

bandwidth_freq = upper_bound - cut_off_frequency;
upper_bound

doc_const_2 = fopen("octave_results_t_4.tex","w");
% first stage
fprintf(doc_const_2,"Input Impedance of first stage & %f \\\\  \\hline \n", ZI1);
fprintf(doc_const_2,"Gain of first stage & %f \\\\  \\hline \n", AV1);
fprintf(doc_const_2,"Gain of first stage in decibels & %f decibels \\\\  \\hline \n", AVI_DB);
fprintf(doc_const_2,"Output Impedance of first stage & %f \\\\  \\hline \n", ZO1);
% second stage
fprintf(doc_const_2,"Input Impedance of second stage & %f \\\\  \\hline \n", ZI2);
fprintf(doc_const_2,"Gain of second stage & %f \\\\  \\hline \n", AV2);
fprintf(doc_const_2,"Gain of second stage in decibels & %f decibels \\\\  \\hline \n", AV2_DB);
fprintf(doc_const_2,"Output Impedance of second stage & %f \\\\  \\hline \n", ZO2);
%%% não pedem no enunciado pelas impendencias totais, mas meto aqui 
%%% só no caso de se querer meter no Latex
fprintf(doc_const_2,"total Input Impedance & %f \\\\  \\hline \n", ZI);
fprintf(doc_const_2,"total Output Impedance & %f \\\\  \\hline \n", ZO);
fprintf(doc_const_2,"total Voltage Gain & %f \\\\  \\hline \n", AV);
fprintf(doc_const_2,"total Voltage Gain in decibels & %f \\\\  \\hline \n", AV_DB);
%%%
fprintf(doc_const_2,"Cut-off frequency & %f \\\\  \\hline \n", cut_off_frequency);
fprintf(doc_const_2,"Bandwidth & %f \\\\  \\hline \n", bandwidth_freq);
fprintf(doc_const_2,"Cust & %f \\\\  \\hline \n", 2102.2);
fprintf(doc_const_2,"Merit & %f \\\\  \\hline \n", (bandwidth_freq*abs(AV))/(2101.2*cut_off_frequency));
fclose(doc_const_2);



% gráfico do gráfico V_out(f)/V_in(f)

F_gain = figure();
 semilogx(f, Vector_of_gains, "k");
 hold on;
 grid on;
 title("Frequecy response of the Magnitude of the tension gain");
 xlabel ("frequency [Hz]");
 ylabel ("Decibels [D]");
 legend("V_out(f)/V_in(f)");
 saveas(F_gain, "magnitude_response_gain.eps");
close(F_gain);
