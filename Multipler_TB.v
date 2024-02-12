`timescale 1ns/1ns

module testbench;
  reg [31:0] a, b;
  wire [31:0] result;
  
  ieee754_multiplier uut (
    .a(a),
    .b(b),
    .result(result)
  );
  initial begin
    $monitor("Time=%0t a=%h b=%h result=%h", $time, a, b, result);

    // Test Case 1: +0 * +0 r=00000000
    a = 32'h00000000;
    b = 32'h00000000;
    #10;

    // Test Case 2: +inf * +0 r=nan
    a = 32'h7f800000;
    b = 32'h00000000; 
    #10;

    // Test Case 3: NAN * num r= 7f800001
    a = 32'h7fffffff; 
    b = 32'h3f800001; 
    #10;

    // Test Case 4: 1.0 * 2.0 r=40000000
    a = 32'h3f800000; 
    b = 32'h40000000; 
    #10;

    // Test Case 5: -inf * + 1.0 r=ff800000
    a = 32'hff800000; 
    b = 32'h3f800000; 
    #10;

    // Test Case 6: +0 * +0 r=00000000
    a = 32'h00000000;
    b = 32'h00000000;
    #10;

    // Test Case 7: +inf * 1.0 r=7f800000
    a = 32'h7f800000; 
    b = 32'h3f800000; 
    #10;
    
    // Test Case 8: 2.5 * 2.5 r=0x40c80000
    a = 32'h40200000;
    b = 32'h40200000;
    #10
    
    // Test Case 9: -0 * -0 r=00000000;
    a = 32'h80000000;
    b = 32'h80000000;
    #10;
    
     // Test Case 10: -0 * +0  r=80000000
    a = 32'h80000000;
    b = 32'h00000000;
    #10;
    
     // Test Case 11: +inf * inf r=7f800000
    a = 32'h7f800000; 
    b = 32'h7f800000; 
    #10;
    
     // Test Case 12: 3.14 * 2.25 r=0x40e2147b
    a = 32'h4048f5c3; 
    b = 32'h40100000; 
    #10;
    // Test Case 15: 5.25 * 3.75 r=0x419d8000 ==19.6875
    a = 32'h40a80000; 
    b = 32'h40700000; 
    #10;
   
  // Test Case 16: 5.2* -2.5 r=0xc14fffff -13 
     a=32'h40a66666;
     b=32'hc0200000;
     #10;

  // Test Case 17: -2.75* 1.25 r=0xc05c0000 -3.4375
     a=32'hc0300000;
     b=32'h3fa00000;
     #10;
 
 // Test Case 18: -2.75* -1.25 r=0x405c0000 == 3.4375
     a=32'hc0300000;
     b=32'hbfa00000;
     #10;
    
    // Test Case 12: -inf * -0 r=7fffffff
    a=32'hff800000;
    b=32'h80000000;
    #10;
    
    // Test Case 13: nan * nan r=7fffffff
    a=32'h7fffffff;
    b=32'h7fffffff;
    #10
    
    // Test Case 14: +inf * nan r=7fffffff
    a = 32'h7f800000; 
    b = 32'h7fffffff; 
    #10;

    

    $stop;
  end

endmodule


