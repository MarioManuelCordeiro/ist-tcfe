
close all
clear all

%pkg load symbolic

%% Numerical calculations

% Input of data about the circuit
R1 = 1.04309563061*1000;
R2 = 2.01744623407*1000;
R3 = 3.13691375104*1000;
R4 = 4.15429988186*1000;
R5 = 3.07915362723*1000;
R6 = 2.02592738504*1000;
R7 = 1.04226655522*1000;
Va = 5.23936486299;
Id = 1.03899051042/1000;
Kb = 7.31630468385/1000;
Kc = 8.25247516035*1000;


%%vector of the solutions of the method of Nodes
V_solucoes = ones(7,1);
%vector of the solutions of the method of Mesh
I_solucoes = ones(4,1);


%% Resolution of the system of equations of the Method of Nodes
Matriz_nodos = [ 1 0 0 0 0 0 0
          -1/R1 (1/R1+1/R2+1/R3) -1/R2 -1/R3 0 0 0
           0 (-1/R2-Kb) 1/R2 Kb 0 0 0
           0 Kb 0 (-1/R5-Kb) 1/R5 0 0
           0 0 0 0 0 (1/R6+1/R7) -1/R7
           0 0 0 1 0 Kc/R6 -1 
           0 -1/R3 0 (1/R3+1/R4+1/R5) -1/R5 -1/R7 1/R7];
           
Column_constants_Nodes = [Va 0 0 Id 0 0 -Id]';

V_solucoes = Matriz_nodos\Column_constants_Nodes;

%solutions of the voltages
V1 = V_solucoes(1);
V2 = V_solucoes(2);
V3 = V_solucoes(3);
V4 = V_solucoes(4);
V5 = V_solucoes(5);
V6 = V_solucoes(6);
V7 = V_solucoes(7);


%% Resolution of the system of equations of the Method of Mesh
 Matrix_mesh = [ 0 0 0 1
           R4 0 (R4+R6+R7-Kc) 0
          (R1+R3+R4) R3 R4 0
          R3*Kb (R3*Kb-1) 0 0];
Column_constants_Mesh = [Id 0 Va 0]';
 
I_solucoes = Matrix_mesh\Column_constants_Mesh;

%solutions of the corrents
I1 = I_solucoes(1);
I2 = I_solucoes(2);
I3 = I_solucoes(3);
I4 = I_solucoes(4);


%% Alocation of the numerical results to the report

%Voltages
doc_voltage = fopen("octave_theorical_voltage_values.tex","w");
fprintf(doc_voltage,"V(1) & %f \\\\  \\hline \n", V1);
fprintf(doc_voltage,"V(2) & %f \\\\  \\hline \n", V2);
fprintf(doc_voltage,"V(3) & %f \\\\  \\hline \n", V3);
fprintf(doc_voltage,"V(4) & %f \\\\  \\hline \n", V4);
fprintf(doc_voltage,"V(5) & %f \\\\  \\hline \n", V5);
fprintf(doc_voltage,"V(6) & %f \\\\  \\hline \n", V6);
fprintf(doc_voltage,"V(7) & %f \\\\  \\hline \n", V7);
fprintf(doc_voltage,"V(8) & %f \\\\  \\hline", V6);
fclose(doc_voltage);

%Currents
doc_current = fopen("octave_theorical_current_values.tex","w");
fprintf(doc_current,"@I1[i] & %f \\\\ \\hline \n",I1*1000);
fprintf(doc_current,"@I2[i] & %f \\\\ \\hline \n",I2*1000);
fprintf(doc_current,"@I3[i] & %f \\\\ \\hline \n",I3*1000);
fprintf(doc_current,"@I4[i] & %f \\\\ \\hline \n",I4*1000);
fprintf(doc_current,"@G1[i] & %f \\\\ \\hline \n",I2*1000);
fprintf(doc_current,"@Id[current] & %f \\\\ \\hline \n",I4*1000);
fprintf(doc_current,"@R1[i] & %f \\\\ \\hline \n",I1*1000);
fprintf(doc_current,"@R2[i] & %f \\\\ \\hline \n",I2*1000);
fprintf(doc_current,"@R3[i] & %f \\\\ \\hline \n",(I1+I2)*1000);
fprintf(doc_current,"@R4[i] & %f \\\\ \\hline \n",(I1+I3)*1000);
fprintf(doc_current,"@R5[i] & %f \\\\ \\hline \n",(I2-I4)*1000);
fprintf(doc_current,"@R6[i] & %f \\\\ \\hline \n",I3*1000);
fprintf(doc_current,"@R7[i] & %f \\\\ \\hline",I3*1000);
fclose(doc_current);
