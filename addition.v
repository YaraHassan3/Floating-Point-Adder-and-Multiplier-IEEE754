module ieee_addition (
  input [31:0] a,        
  input [31:0] b,        
  output reg [31:0] result );

  reg [7:0] exp_a, exp_b, exp_result, exp_diff;
  reg sign_a, sign_b, sign_result,carry;
  reg [23:0] fract_a, fract_b,fract_Mod1,fract_Mod2;
  reg [23:0] fract_result;
  reg [23:0] shift_amount;
  always @(*) 
    begin 
      sign_a  = a[31];    
      sign_b  = b[31];
      fract_a = {1'b1,a[22:0]};  
      fract_b = {1'b1,b[22:0]};
      exp_a   = a[30:23]; 
      exp_b   = b[30:23];
      exp_diff=8'b0;  
      fract_result=25'd0; fract_Mod1=24'd0; fract_Mod2=24'd0;
      carry=1'b0;
      shift_amount=24'b0;
    end 
    
    always @(*)
      begin 
        if (exp_a == 0 && fract_a ==0 ) begin 
            exp_result = exp_b;
            sign_result=sign_b;
	    fract_result=fract_b; end
       else if (exp_b == 0 && fract_b ==0 ) begin 
            exp_result = exp_a;
            sign_result=sign_a;
	    fract_result=fract_a; end

       else if (exp_a > exp_b)
          begin 
            exp_diff = exp_a - exp_b;
            fract_Mod1=fract_a;
            fract_Mod2= fract_b >> exp_diff;
            exp_result = exp_a;
          end
         else if (exp_b > exp_a)
           begin 
            exp_diff = exp_b - exp_a;
            fract_Mod1 = fract_a >> exp_diff;
            fract_Mod2=  fract_b;
            exp_result = exp_b;
          end
        else begin 
          exp_result = exp_a;
	  fract_Mod1 = fract_a;
          fract_Mod2=  fract_b;
        end
        
      if (sign_a == sign_b)
        begin 
        sign_result=sign_a;
        {carry,fract_result}=fract_Mod1+fract_Mod2;
      end 

    else if (sign_a != sign_b)
	begin
	if (fract_Mod1 >fract_Mod2) 
      begin 
        sign_result=sign_a;
        {carry,fract_result}=fract_Mod1 - fract_Mod2;
      end
      else if (fract_Mod2 >fract_Mod1)
      begin 
        sign_result=sign_b;
        {carry,fract_result}=fract_Mod2 - fract_Mod1;
      end
       else 
         begin 
          sign_result = 0;
        fract_result = 25'd0; // result is zero
        exp_result = 8'b0; // exponent is zero
         end 
    end
      
    if (carry) 
      begin 
        fract_result={1'b1,fract_result[23:1]};
        exp_result=exp_result + 1'b1;
      end
    else
      begin 
        while (fract_result[23] == 0 && fract_result[22:0] >0) begin
            fract_result = fract_result << 1;
            shift_amount=shift_amount + 1'b1;
          end
            exp_result = exp_result - shift_amount;
          while (!shift_amount) begin 
            fract_result=fract_result >> shift_amount;
            shift_amount=shift_amount-1'b1;
          end
        end
         
      result = {sign_result, exp_result, fract_result[22:0]};
    end
endmodule