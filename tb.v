module ieee_addition_tb;

  reg [31:0] a, b;
  wire [31:0] result;

  // Instantiate the ieee754_addition module
  ieee_addition uut (
    .a(a),
    .b(b),
    .result(result)
  );
reg clk = 0;
  always #5 clk = ~clk;
  initial begin
    // Case 1: Same negaitive sign
    a = 32'b11000000100100000000000000000000; // -4.5
    b = 32'b11000000100100000000000000000000; // -4.5 result=c1100000
    #10;
    $display("Result for Case 1: %h + %h = %h", a, b, result);

    // Case 2: different signs
    a = 32'b11000001000100000000000000000000; // -9
    b = 32'b01000000101000000000000000000000; // 5 result=c0800000
    #10;
    $display("Result for Case 2: %h + %h = %h", a, b, result);

    // Case 3: Different signs
    a = 32'b00111111100000000000000000000000; // 1
    b = 32'b11000001011100000000000000000000; // -15 result c1600000
    #10;
    $display("Result for Case 3: %h + %h = %h", a, b, result);

    // Case 4: Different signs
    a = 32'b01000000101111001100110011001101; // 5.9
    b = 32'b11000000000011001100110011001101; // -2.2 result 406ccccd
    #10;
    $display("Result for Case 4: %h + %h = %h", a, b, result);
  
    // Case 5: Same negative signs
    a = 32'b11000000101000000000000000000000; // -5
    b = 32'b01000000001110011001100110011010; // -2.9 result c0066666
    #10;
    $display("Result for Case 5: %h + %h = %h", a, b, result);

    // Case 7: Different signs
    a = 32'b11000001001010100110011001100110; // -10.65
    b = 32'b01000000001110011001100110011010; // 2.9  result c0f80000
    #10;
    $display("Result for Case 7: %h + %h = %h", a, b, result);

   // Case 7: Same negative signs
    a = 32'b11000001001010100110011001100110; // -10.65
    b = 32'b11000000111110000000000000000000; // -7.75  result c1933333
    #10;
    $display("Result for Case 7: %h + %h = %h", a, b, result);

    // Case 8: same number but different sign
    a = 32'b11000001001010100110011001100110; // -10.65
    b = 32'b01000001001010100110011001100110; // +10.65 result 00000000
    #10;
    $display("Result for Case 8: %h + %h = %h", a, b, result);

   // Case 9: Different signs
    a = 32'b11000010100101000000000000000000; // -74
    b = 32'b01000010101101100000000000000000; // 91 result 41880000
    #10;
    $display("Result for Case 9: %h + %h = %h", a, b, result);


   // Case 10: Same Positive signs
    a = 32'b01000001011111001100110011001101; // 15.8
    b = 32'b01000000111111001100110011001101; // 7.9 result 41bd999a
    #10;
    $display("Result for Case 10: %h + %h = %h", a, b, result);

   // Case 11: Same Positive signs
    a = 32'b01000001000111000010100011110110; // 9.76
    b = 32'b01000000101110101000111101011100; // 91 result 417970a4
    #10;
    $display("Result for Case 11: %h + %h = %h", a, b, result);

    // Case 12: num + 0
    a = 32'b01000000101111001100110011001101; // 5.9
    b = 32'b00000000000000000000000000000000; // 0 result 40bccccd
    #10;
    $display("Result for Case 12: %h + %h = %h", a, b, result);

    // Case 13: num + 0
    a = 32'b00000000000000000000000000000000; // 0 
    b = 32'b01000000101111001100110011001101; // 5.9 result 40bccccd
    #10;
    $display("Result for Case 13: %h + %h = %h", a, b, result);



    $stop;
  end
endmodule

