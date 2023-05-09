`timescale 1ns / 1ps 
module lab3_2(
			input[4:0] smartCode,
			input CLK, 
			input lab, //0:Digital, 1:Mera
			input [1:0] mode, //00:exit, 01:enter, 1x: idle 
			output reg [5:0] numOfStuInMera,
			output reg [5:0] numOfStuInDigital,
			output reg restrictionWarnMera,//1:show warning, 0:do not show warning
			output reg isFullMera, //1:full, 0:not full
			output reg isEmptyMera, //1: empty, 0:not empty
			output reg unlockMera,	//1:door is open, 0:closed
			output reg restrictionWarnDigital,//1:show warning, 0:do not show warning
			output reg isFullDigital, //1:full, 0:not full
			output reg isEmptyDigital, //1: empty, 0:not empty
			output reg unlockDigital //1:door is open, 0:closed
	);
	 
	// You may declare your variables below	
	
	integer i;
	integer ones;
	
	initial begin
			numOfStuInMera=0;
			numOfStuInDigital=0;
			restrictionWarnMera=0;
			isFullMera=0;
			isEmptyMera=1'b1;
			unlockMera=0;		
			restrictionWarnDigital=0;
			isFullDigital=0;
			isEmptyDigital=1'b1;
			unlockDigital=0;
	end
	//Modify the lines below to implement your design
	//always @(posedge CLK) 
	//...
	always @(posedge CLK)
	begin 
		unlockMera=0;
		unlockDigital=0;
		i=0;
		ones=0;
		restrictionWarnDigital=0;
		restrictionWarnMera=0;
		
		
		if(mode==2'b01) //entry mode
		begin
			for (i=0;i<5;i=i+1) begin //smartCode even or odd counter
				if (smartCode[i]==1'b1)
				begin
					ones=ones+1;
				end
			end
			
			if (lab==1'b0)// enter digital
			begin
				if (numOfStuInDigital<15) // student can enter without checking smartcode
				begin 
					unlockDigital=1;
					isEmptyDigital=0;
					numOfStuInDigital=numOfStuInDigital+1;
				end
				
				else //CHECK SMARTCODE
				begin
					if (ones %2==0) //cannot enter Digital
					begin
						if(numOfStuInDigital==30)
						begin
							isFullDigital=1;
						end
						else
						begin
							restrictionWarnDigital=1;
						end
					end
					
					else //student can enter to digital
					begin
						if (numOfStuInDigital<30) //has capacity
						begin
							unlockDigital=1;
							numOfStuInDigital=numOfStuInDigital+1;
							if (numOfStuInDigital==30) //capacity has full?
							begin
								isFullDigital=1;
							end
						end
						
						else //no capacity
						begin
							isFullDigital=1;
						end
					end
				end
			end
			
			else // enter mera
			begin 
				if (numOfStuInMera<15) //can enter Mera
				begin
					unlockMera=1;
					isEmptyMera=0;
					numOfStuInMera=numOfStuInMera+1;
				end
				
				else //check for smartcode
				begin
					if (ones%2!=0) //cannot enter Mera
					begin
						if(numOfStuInMera==30)
						begin
							isFullMera=1;
						end
						
						else // has capacity yet cannot enter
						begin
							restrictionWarnMera=1;
						end
					end
					
					else//can enter mera
					begin
						if(numOfStuInMera<30) //has capacity and can enter
						begin
							unlockMera=1;
							numOfStuInMera=numOfStuInMera+1;
							if (numOfStuInMera==30)
							begin
								isFullMera=1;
							end
						end
						
						else //hasno capacity
						begin
							isFullMera=1;
						end
					end
					
				end		
			end
		end
		
		else if (mode==2'b00) //exit mode
		begin
			if (lab ==0) //exit from Digital
			begin
				if (numOfStuInDigital!=0)
				begin
					unlockDigital=1; //door has opened 
					numOfStuInDigital=numOfStuInDigital-1;
					if (numOfStuInDigital==1'b0) //digital is empty now//
					begin
						isEmptyDigital=1'b1;
					end
				end
			end
			
			else //exit from Mera
			begin
				if (numOfStuInMera!=0)
				begin
					unlockMera=1'b1;
					numOfStuInMera=numOfStuInMera-1;
					if (numOfStuInMera==0)
					begin
						isEmptyMera=1'b1;
					end
				end
			end
		end
		
		else //idle mode
		begin
			restrictionWarnMera=0;
			restrictionWarnDigital=0;
			unlockMera=0;
			unlockDigital=0;
		end
	end
endmodule



