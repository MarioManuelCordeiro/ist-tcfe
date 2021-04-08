
close all
clear all

pkg load symbolic

format long

m = 0;
o = m;
fg = fopen('data.txt',"r");
A = 1:11;
str_null = '';
while (o<100)
   o = 1+o;
  fd = fgets(fg);
  if fd == -1
    break
  end
  idx = strfind(fd,'=');
  a = str2num(fd(idx+1:end));
  if(isempty(a))
  else 
    m = m+1;
    A(m) =  a; 
  end
  end
A;

doc_const = fopen("octave_constants_t_2.tex","w");
fprintf(doc_const,"R(1) & %f \\\\  \\hline \n", A(1));
fprintf(doc_const,"R(2) & %f \\\\  \\hline \n", A(2));
fprintf(doc_const,"R(3) & %f \\\\  \\hline \n", A(3));
fprintf(doc_const,"R(4) & %f \\\\  \\hline \n", A(4));
fprintf(doc_const,"R(5) & %f \\\\  \\hline \n", A(5));
fprintf(doc_const,"R(6) & %f \\\\  \\hline \n", A(6));
fprintf(doc_const,"R(7) & %f \\\\  \\hline \n", A(7));
fprintf(doc_const,"C & %f \\\\  \\hline", A(9));
fprintf(doc_const,"Vs & %f \\\\  \\hline", A(8));
fprintf(doc_const,"Kb & %f \\\\  \\hline", A(10));
fprintf(doc_const,"Kd & %f \\\\  \\hline", A(11));
fclose(doc_const);

%% Numerical calculations

% Input of data about the circuit
R1 = A(1)*1000;
R2 = A(2)*1000;
R3 = A(3)*1000;
R4 = A(4)*1000;
R5 = A(5)*1000;
R6 = A(6)*1000;
R7 = A(7)*1000;
Vs = A(8);
Kb = A(10)/1000;
Kc = A(11)*1000;
C = A(9)*power(10,-6);

%%vector of the solutions of the method of Nodes
V_solucoes_1 = ones(7,1);
V_solucoes_2 = ones(7,1);
V_solucoes_3 = ones(7,1);

%% Resolution of the system of equations of the Method of Nodes
%1º alínea - certificado

Matriz_nodos_1 = [ 1 0 0 0 0 0 0
          -1/R1 (1/R1+1/R2+1/R3) -1/R2 -1/R3 0 0 0
           0 (-1/R2-Kb) 1/R2 Kb 0 0 0
           0 Kb 0 (-1/R5-Kb) 1/R5 0 0
           0 0 0 0 0 (1/R6+1/R7) -1/R7
           0 0 0 1 0 Kc/R6 -1 
           0 -1/R3 0 (1/R3+1/R4+1/R5) -1/R5 1/R6 0];
           
Column_constants_Nodes_1 = [Vs 0 0 0 0 0 0]';

V_solucoes_1 = Matriz_nodos_1\Column_constants_Nodes_1;

%Voltages
doc_voltage = fopen("octave_theorical_voltage_values_in_negative_time.tex","w");
fprintf(doc_voltage,"V(1) & %f \\\\  \\hline \n", V_solucoes_1(1));
fprintf(doc_voltage,"V(2) & %f \\\\  \\hline \n", V_solucoes_1(2));
fprintf(doc_voltage,"V(3) & %f \\\\  \\hline \n", V_solucoes_1(3));
fprintf(doc_voltage,"V(4) & %f \\\\  \\hline \n", 0);
fprintf(doc_voltage,"V(5) & %f \\\\  \\hline \n", V_solucoes_1(4));
fprintf(doc_voltage,"V(6) & %f \\\\  \\hline \n", V_solucoes_1(5));
fprintf(doc_voltage,"V(7) & %f \\\\  \\hline \n", V_solucoes_1(6));
fprintf(doc_voltage,"V(8) & %f \\\\  \\hline", V_solucoes_1(7));
fclose(doc_voltage);

%Currents
doc_current = fopen("octave_theorical_current_values_in_negative_time.tex","w");
fprintf(doc_current,"@G1[i] & %f \\\\ \\hline \n",Kb*(V_solucoes_1(2)-V_solucoes_1(4))*1000);
fprintf(doc_current,"@C[current] & %f \\\\ \\hline \n",0);
fprintf(doc_current,"@R1[i] & %f \\\\ \\hline \n",(V_solucoes_1(2)-V_solucoes_1(1))/R1*1000);
fprintf(doc_current,"@R2[i] & %f \\\\ \\hline \n",(V_solucoes_1(3)-V_solucoes_1(2))/R2*1000);
fprintf(doc_current,"@R3[i] & %f \\\\ \\hline \n",(V_solucoes_1(2)-V_solucoes_1(4))/R3*1000);
fprintf(doc_current,"@R4[i] & %f \\\\ \\hline \n",(V_solucoes_1(4))/R4*1000);
fprintf(doc_current,"@R5[i] & %f \\\\ \\hline \n",(V_solucoes_1(4)-V_solucoes_1(5))/R5*1000);
fprintf(doc_current,"@R6[i] & %f \\\\ \\hline \n",(-V_solucoes_1(6))/R6*1000);
fprintf(doc_current,"@R7[i] & %f \\\\ \\hline",(V_solucoes_1(6)-V_solucoes_1(7))/R7*1000);
fclose(doc_current);

%2º alínea - certificado

Matriz_nodos_2 = [(1/R1+1/R2+1/R3) -1/R2 -1/R3 0 0 0 0;
                -Kb-1/R2 1/R2 Kb 0 0 0 0                                  
                -1/R3 0 (1/R3+1/R4+1/R5) -1/R5 -1/R7 1/R7 -1                                   
                Kb 0 (-Kb-1/R5) 1/R5 0 0 1
                0 0 0 0 (1/R6+1/R7) -1/R7 0 
                0 0 0 1 0 -1 0                                   
                0 0 1 0 Kc/R6 -1 0];
           
Column_constants_Nodes_2 = [0 0 0 0 0 (V_solucoes_1(5)-V_solucoes_1(7)) 0]';

V_solucoes_2 = Matriz_nodos_2\Column_constants_Nodes_2;

Rx = (V_solucoes_1(5)-V_solucoes_1(7))/abs(V_solucoes_2(7));
Constante_tempo = C*Rx;

%Voltages
doc_voltage = fopen("octave_theorical_voltage_values_in_zero_time.tex","w");
fprintf(doc_voltage,"V(1) & %f \\\\  \\hline \n", 0);
fprintf(doc_voltage,"V(2) & %f \\\\  \\hline \n", V_solucoes_2(1));
fprintf(doc_voltage,"V(3) & %f \\\\  \\hline \n", V_solucoes_2(2));
fprintf(doc_voltage,"V(4) & %f \\\\  \\hline \n", 0);
fprintf(doc_voltage,"V(5) & %f \\\\  \\hline \n", V_solucoes_2(3));
fprintf(doc_voltage,"V(6) & %f \\\\  \\hline \n", V_solucoes_2(4));
fprintf(doc_voltage,"V(7) & %f \\\\  \\hline \n", V_solucoes_2(5));
fprintf(doc_voltage,"V(8) & %f \\\\  \\hline", V_solucoes_2(6));
fclose(doc_voltage);

%Currents
doc_current = fopen("octave_theorical_current_values_in_zero_time.tex","w");
fprintf(doc_current,"@G1[i] & %f \\\\ \\hline \n",Kb*(V_solucoes_2(1)-V_solucoes_2(3))*1000);
fprintf(doc_current,"@C[current] & %f \\\\ \\hline \n",V_solucoes_2(7));
fprintf(doc_current,"@R1[i] & %f \\\\ \\hline \n",(V_solucoes_2(1))/R1*1000);
fprintf(doc_current,"@R2[i] & %f \\\\ \\hline \n",(V_solucoes_2(2)-V_solucoes_2(1))/R2*1000);
fprintf(doc_current,"@R3[i] & %f \\\\ \\hline \n",(V_solucoes_2(1)-V_solucoes_2(3))/R3*1000);
fprintf(doc_current,"@R4[i] & %f \\\\ \\hline \n",(V_solucoes_2(3))/R4*1000);
fprintf(doc_current,"@R5[i] & %f \\\\ \\hline \n",(V_solucoes_2(4)-V_solucoes_2(5))/R5*1000);
fprintf(doc_current,"@R6[i] & %f \\\\ \\hline \n",(-V_solucoes_2(5))/R6*1000);
fprintf(doc_current,"@R7[i] & %f \\\\ \\hline",(V_solucoes_2(5)-V_solucoes_2(6))/R7*1000);
fclose(doc_current);

% alínea 3 - certificado
 
 %eixo do tempo de 0 a 20 ms
 t = 0:1e-6:20e-3; %s
 v6_n = V_solucoes_2(4)*exp(-t/Constante_tempo);
 
 %%% gráfico da resposta natural [0;20] ms
 %%falta título
 H_natural = figure();
 plot (t*1000, v6_n, "g");

 xlabel ("t[ms]");
 ylabel ("v6_n [V]");
 print (H_natural, "natural.eps", "-depsc");

 %%%%%% 

%alínea 4 - Fazer a matriz pra calcular com o método nodal da solução forçada

w = 2*pi*1000; % frequência angular

Matriz_nodos_3 = [1 0 0 0 0 0 0
                  -1/R1 (1/R1+1/R2+1/R3) -1/R2 -1/R3 0 0 0
                  0 (-1/R2-Kb) 1/R2 Kb 0 0 0
                  0 -1/R3 0 (1/R3+1/R4+1/R5) (-i*w*C-1/R5) -1/R7 (i*w*C+1/R7)
                  0 Kb 0 (-Kb-1/R5) (1/R5+i*w*C) 0 (-i*w*C)
                  0 0 0 0 0 (1/R6+1/R7) -1/R7
                  0 0 0 1 0 Kc/R6 -1];

Column_constants_Nodes_3 = [1 0 0 0 0 0 0]';

V_solucoes_3 = Matriz_nodos_3\Column_constants_Nodes_3;

%Voltages
doc_voltage = fopen("octave_theorical_voltage_forced.tex","w");
fprintf(doc_voltage,"V(1) & %f \\\\  \\hline \n", abs(V_solucoes_3(1)));
fprintf(doc_voltage,"V(2) & %f \\\\  \\hline \n", abs(V_solucoes_3(2)));
fprintf(doc_voltage,"V(3) & %f \\\\  \\hline \n", abs(V_solucoes_3(3)));
fprintf(doc_voltage,"V(4) & %f \\\\  \\hline \n", 0);
fprintf(doc_voltage,"V(5) & %f \\\\  \\hline \n", abs(V_solucoes_3(4)));
fprintf(doc_voltage,"V(6) & %f \\\\  \\hline \n",abs(V_solucoes_3(5)));
fprintf(doc_voltage,"V(7) & %f \\\\  \\hline \n", abs(V_solucoes_3(6)));
fprintf(doc_voltage,"V(8) & %f \\\\  \\hline", abs(V_solucoes_3(7)));
fclose(doc_voltage);

magnitude_v6f = abs(V_solucoes_3(5));
phase_v6f = angle(V_solucoes_3(5));

V6_f = magnitude_v6f*sin(w.*t+phase_v6f);
V8_f = abs(V_solucoes_3(7))*sin(w.*t+angle(V_solucoes_3(7)));

%% alínea 5 - confirmado
V6 = V6_f + v6_n;
vc = V6 - V8_f;
V_s = sin(w.*t);

t_neg = -5e-3:1e-6:-1e-6;

tempo = [t_neg t];

y = 1;

for l = -5e-3:1e-6:-1e-6
  V6_neg(y) = V_solucoes_1(5);
  V_s_neg(y) = Vs;
  y = y+1;
end

V_6 = [V6_neg V6];
VS = [V_s_neg V_s];

H_total = figure();
 plot (tempo*1000, V_6, "b", tempo*1000, VS, "g");
 grid on;
 title("Voltage of tension source (Vs(t)) and of the node 6 (V6(t))");
 xlabel ("time [ms]");
 ylabel ("Voltage [V]");
 legend("V6(t)", "Vs(t)");
 print (H_total, "total_solution.eps", "-depsc");


%alínea 6 - confirmado


k = 1;
f = logspace(-1,6);
  for n = 1:size(f)(2)
    Matriz_mesh = [ [R1+R2+R3 R3  R4  0];
                    [R3*Kb (R3*Kb-1) 0 0];
                    [R4 0 (R4+R6+R7-Kc) 0];
                    [0 R5 -Kc (R5+1/(i*C*f(k)*2*pi))];]; 
    B = [1 0 0 0]';
    
    I = Matriz_mesh\B;
    
    V6_total(k) = 20*log10(abs(R4*(I(1)+I(3))-R3*(I(2)+I(4))));
    Vc_total(k) = 20*log10(abs(I(4)/(i*C*pi*2*f(k))));
    V6_ang(k) = 180/pi*arg(R4*(I(1)+I(3))-R3*(I(2)+I(4)));
    Vc_ang(k) = 180/pi*arg(I(4)/(i*C*pi*2*f(k)));
    k = 1+k;
  end;



F_Mag = figure();
 semilogx(f, V6_total, "k");
 hold on;
 semilogx(f, Vc_total, "g");
 grid on;
 title("Frequecy response of the Magnitude of the tension of the capacitor (Vc(t)) and of the node 6 (V6(t))");
 xlabel ("frequency [Hz]");
 ylabel ("Decibels [D]");
 legend("V6(f)", "Vc(f)");
 saveas(F_Mag, "magnitude_response.pdf");
close(F_Mag);
 
F_Ang = figure();
 semilogx(f, V6_ang, "k");
 hold on;
 semilogx(f, Vc_ang, "g");
 grid on;
 title("Frequecy response of the Angle of the tension of the capacitor (Vc(t)) and of the node 6 (V6(t))");
 xlabel ("frequency [Hz]");
 ylabel ("Degrees");
 legend("V6(f)", "Vc(f)");
 saveas(F_Ang, "angle_response.pdf");
 close(F_Ang);

 H_global = figure();
 plot (t*1000, V6, "g", t*1000, vc, "b", t*1000, V_s, "k");
 title("Voltages in the circuit");
 legend("V6(t)","Vc(t)","Vs(t)");
 grid on;
 xlabel ("t[ms]");
 ylabel ("Voltage [V]");
 print (H_global, "global_voltage.eps", "-depsc");
 close(H_global);