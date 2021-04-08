close all
clear all
format long
i = 0;
j = i;
ficheiro = "../doc/data.txt";
fg = fopen(ficheiro,"r");
A = 1:11;
str_null = '';
while (j<100)
   j = 1+j;
  fd = fgets(fg);
  if fd == -1
    break
  end
  idx = strfind(fd,'=');
  a = str2num(fd(idx+1:end));
  if(isempty(a))
  else 
    i = i+1;
    A(i) =  a; 
  end
  end
fclose(fg);

fid = fopen('circuit_data_1.cir',"w");
fprintf(fid,".OP \n");
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

fed = fopen('circuit_data_2.cir',"w");
fprintf(fed,".OP \n");
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
fprintf(fed,"Vs 1 0 %f \n",A(8));
fprintf(fed,"C 7 5 %fu \n",A(9));
fprintf(fed,".END \n");
fclose(fed);

fid = fopen('circuit_data_3.cir',"w");
fprintf(fid,".OP \n");
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

fid = fopen('circuit_data_4.cir',"w");
fprintf(fid,".OP \n");
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
