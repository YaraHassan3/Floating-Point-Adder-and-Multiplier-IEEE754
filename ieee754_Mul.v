module ieee754_multiplier(
  input [31:0] a,
  input [31:0] b,
  output reg [31:0] result
);
  reg [7:0] exp_a, exp_b, exp_result;
  reg [47:0] frac_result; 
  reg sign_a, sign_b, sign_result; 

  always @(*) begin
    sign_a = a[31];
    exp_a = a[30:23];
    sign_b = b[31];
    exp_b = b[30:23]; 
    sign_result = sign_a ^ sign_b;
    result[31] = sign_result;
    exp_result = exp_a + exp_b - 127; 
    frac_result = {1'b1, a[22:0]} *{1'b1, b[22:0]};
     //$display ("fracttttttt %b", frac_result[47]);
    // Check for special cases
    if ((exp_a == 8'hFF && a[22:0] == 23'h000000 && exp_b == 8'h00) || 
        (exp_b == 8'hFF && b[22:0] == 23'h000000 && exp_a == 8'h00)) begin
      result = 32'h7fffffff;
 end 
    else if ((exp_a == 8'h00 && a[22:0] == 23'h000000) || (exp_b == 8'h00 && b[22:0] == 23'h000000)) begin
      result = (sign_a ^ sign_b) ? 32'h80000000:32'h00000000 ;
    end 
    else if (exp_a == 8'hFF && a[22:0] == 23'h000000 && exp_b == 8'hFF && b[22:0] == 23'h000000) begin
      result = (sign_a ^ sign_b) ? 32'hff800000 : 32'h7f800000;
    end 
    else if ((exp_a == 8'hFF && a[22:0] > 23'h000000) || (exp_b == 8'hFF && b[22:0] > 23'h000000)) begin
      result = 32'h7fffffff;
    end 
    else if ((exp_a == 8'hFF && a[22:0] == 23'h000000) || (exp_b == 8'hFF && b[22:0] == 23'h000000)) begin
      result = (sign_a ^ sign_b) ? 32'hff800000 : 32'h7f800000;
    end 
    else if (exp_a == 8'h00 && a[22:0] == 23'h000000 && exp_b == 8'h00 && b[22:0] == 23'h000000) begin
      result = (sign_a ^ sign_b) ? 32'h80000000:32'h00000000 ;
     end 
   else 
     begin 
    if (frac_result[47] == 1'b1) begin
      frac_result =  frac_result;
      exp_result = exp_result + 1;
      result[30:23] = exp_result ;
      //result[22:0]= frac_result[46:24];
    end 
     else if (frac_result[47] == 1'b0) begin 
	frac_result =  frac_result<<1;
        exp_result = exp_result;
        result[30:23] = exp_result ;
       // result[22:0]= frac_result[45:23];
    end
     if (frac_result[23] && (frac_result[22:0] != 0)) begin
	result [22:0]= frac_result[46:24] + 1'b1;  end
    else begin 
	result [22:0]= frac_result[46:24];  end
end
end
endmodule