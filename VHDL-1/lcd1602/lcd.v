/*******************************************************************
**���ǵ�FPGA������
**��վ��www.OurFPGA.com
**�Ա���OurFPGA.taobao.com
**����: OurFPGA@gmail.com
**��ӭ���ҵ�½��վ������FPGA�����Ӽ������ۣ�����������Ƶ�̳̼�����
*****************�ļ���Ϣ********************************************
**�������ڣ�   2011.06.01
**�汾�ţ�     version 1.0
**����������   ��ʵ������LCD1602��ʾӢ��
��ʾ��HELLO WORLD!��
ע�⣺1602��12864����һ��20�������������������Լ�ʱ���������ұߵ�һ����Ϊ1�������ߵĿ�Ϊ20.��PCB��Ҳ�а�ɫ�ַ�����
������1602Һ��ʱ����ȷ��Һ���ı���1��������1��Ӧ��ͨ�������£���ȷ�Ĳ��õ�1602Һ����¶�ڿ�����PCB�����ġ�

�粻��������ʾ���Ȳ���û�в��������������Ե����������Աߵ�RW�ɵ�����(����)�����ұ���ת��


********************************************************************/


/*
/*******************************************************************
**Our FPGA development network
**Website: www.OurFPGA.com
Taobao: OurFPGA.taobao.com
**Email: OurFPGA@gmail.com
**Welcome to the website, participate in FPGA and electronic technology discussions, download free video tutorials and materials
File Information****




*/

module lcd(clk, rs, rw, en,dat);  
input clk;  
 output [7:0] dat; 
 output  rs,rw,en; 
 //tri en; 
 reg e; 
 reg [7:0] dat; 
 reg rs;   
 reg  [15:0] counter; 
 reg [4:0] current,next; 
 reg clkr; 
 reg [1:0] cnt; 
 parameter  set0=4'h0; 
 parameter  set1=4'h1; 
 parameter  set2=4'h2; 
 parameter  set3=4'h3; 
 parameter  dat0=4'h4; 
 parameter  dat1=4'h5; 
 parameter  dat2=4'h6; 
 parameter  dat3=4'h7; 
 parameter  dat4=4'h8; 
 parameter  dat5=4'h9; 

 parameter  dat6=4'hA; 
 parameter  dat7=4'hB; 
 parameter  dat8=4'hC; 
 parameter  dat9=4'hD; 
 parameter  dat10=4'hE; 
 parameter  dat11=5'h10; 
 parameter  nul=4'hF; 
always @(posedge clk)      
 begin 
  counter=counter+1; 
  if(counter==16'h000f)  
  clkr=~clkr; 
end 
always @(posedge clkr) 
begin 
 current=next; 
  case(current) 
    set0:   begin  rs<=0; dat<=8'h30; next<=set1; end 
    set1:   begin  rs<=0; dat<=8'h0c; next<=set2; end 
    set2:   begin  rs<=0; dat<=8'h6; next<=set3; end 
    set3:   begin  rs<=0; dat<=8'h1; next<=dat0; end 
    dat0:   begin  rs<=1; dat<="H"; next<=dat1; end 
    dat1:   begin  rs<=1; dat<="E"; next<=dat2; end 
    dat2:   begin  rs<=1; dat<="L"; next<=dat3; end 
    dat3:   begin  rs<=1; dat<="L"; next<=dat4; end 
    dat4:   begin  rs<=1; dat<="O"; next<=dat5; end 
    dat5:   begin  rs<=1; dat<=" "; next<=dat6; end 

    dat6:   begin  rs<=1; dat<="W"; next<=dat7; end 
    dat7:   begin  rs<=1; dat<="O"; next<=dat8; end 
    dat8:   begin  rs<=1; dat<="R"; next<=dat9; end 
    dat9:   begin  rs<=1; dat<="L"; next<=dat10; end 
    dat10:   begin  rs<=1; dat<="D"; next<=dat11; end 
    dat11:   begin  rs<=1; dat<="!"; next<=nul; end 
     nul:   begin rs<=0;  dat<=8'h00;                    //��һ�� Ȼ�� ��Һ����E �� ���� 
              if(cnt!=2'h2)  
                  begin  
                       e<=0;next<=set0;cnt<=cnt+1;  
                  end  
                   else  
                     begin next<=nul; e<=1; 
                    end    
              end 
   default:   next=set0; 
    endcase 
 end 
assign en=clkr|e; 
assign rw=0; 
endmodule  