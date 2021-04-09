close all
clear all
format long
o = 0;
m = o;
ficheiro = "../Data.txt";
fg = fopen(ficheiro,"r");
%A = dlmread(ficheiro);
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
fclose(fg);

V = 0;

ficheiro = "diferenca_tensao.txt";
fd = fopen(ficheiro,"r");
r = fgets(fd);
V = str2num(r(1:end));
fclose(fd);

ficheiro_1 = 'circuit_data_1.cir';
fid = fopen(ficheiro_1,"w");
fprintf(fid,".OP \n\n");
fprintf(fid,"R1 1 2 %fK \n",A(1));
fprintf(fid,"R2 3 2 %fK \n",A(2));
fprintf(fid,"R3 2 4 %fK \n",A(3));
fprintf(fid,"R4 4 0 %fK \n",A(4));
fprintf(fid,"R5 4 5 %fK \n",A(5));
fprintf(fid,"R6 0 6 %fK \n",A(6));
fprintf(fid,"R7 8 7 %fK \n",A(7));
fprintf(fid,"Vo 6 8 0 \n");
fprintf(fid,"H1 4 7 Vo %fK \n",A(11));
fprintf(fid,"G1 5 3 2 4 %fm \n",A(10));
fprintf(fid,"Vs 1 0 %f \n",A(8));
fprintf(fid,"C 7 5 %fu \n",A(9));
fprintf(fid,".END \n");
fclose(fid);

ficheiro_2 = 'circuit_data_2.cir';
fed = fopen(ficheiro_2,"w");
fprintf(fed,".OP \n\n");
fprintf(fed,"R1 1 2 %fK \n",A(1));
fprintf(fed,"R2 3 2 %fK \n",A(2));
fprintf(fed,"R3 2 4 %fK \n",A(3));
fprintf(fed,"R4 4 0 %fK \n",A(4));
fprintf(fed,"R5 4 5 %fK \n",A(5));
fprintf(fed,"R6 0 6 %fK \n",A(6));
fprintf(fed,"R7 8 7 %fK \n",A(7));
fprintf(fed,"Vo 6 8 0 \n");
fprintf(fed,"H1 4 7 Vo %fK \n",A(11));
fprintf(fed,"G1 5 3 2 4 %fm \n",A(10));
fprintf(fed,"Vs 1 0 %f \n",0);
fprintf(fed,"Vc 5 7 %f \n",V);
fprintf(fed,".END \n");
fclose(fed);

ficheiro_3 = 'circuit_data_3.cir';
fid = fopen(ficheiro_3,"w");
fprintf(fid,".OP \n\n");
fprintf(fid,"R1 1 2 %fK \n",A(1));
fprintf(fid,"R2 3 2 %fK \n",A(2));
fprintf(fid,"R3 2 4 %fK \n",A(3));
fprintf(fid,"R4 4 0 %fK \n",A(4));
fprintf(fid,"R5 4 5 %fK \n",A(5));
fprintf(fid,"R6 0 6 %fK \n",A(6));
fprintf(fid,"R7 8 7 %fK \n",A(7));
fprintf(fid,"Vo 6 8 0 \n");
fprintf(fid,"H1 4 7 Vo %fK \n",A(11));
fprintf(fid,"G1 5 3 2 4 %fm \n",A(10));
fprintf(fid,"Vs 1 0 %f \n",0);
fprintf(fid,"C 7 5 %fu \n",A(9));
fprintf(fid,".END \n");
fclose(fid);

ficheiro_4 = 'circuit_data_4.cir';
fed = fopen(ficheiro_4,"w");
fprintf(fid,".OP \n\n");
fprintf(fid,"R1 1 2 %fK \n",A(1));
fprintf(fid,"R2 3 2 %fK \n",A(2));
fprintf(fid,"R3 2 4 %fK \n",A(3));
fprintf(fid,"R4 4 0 %fK \n",A(4));
fprintf(fid,"R5 4 5 %fK \n",A(5));
fprintf(fid,"R6 0 6 %fK \n",A(6));
fprintf(fid,"R7 8 7 %fK \n",A(7));
fprintf(fid,"Vo 6 8 0 \n");
fprintf(fid,"H1 4 7 Vo %fK \n",A(11));
fprintf(fid,"G1 5 3 2 4 %fm \n",A(10));
fprintf(fid,"Vs 1 0 sin(0 1 1k) ac 1 \n");
fprintf(fid,"C 7 5 %fu \n",A(9));
fprintf(fid,".END\n");
fclose(fid);
