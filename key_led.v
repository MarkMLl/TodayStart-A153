// Quartus-II 10.1 Verilog Quartus-II 10.1 Verilog Quartus-II 10.1 Verilog Qua

// When pressing the four keys on the board. The nixie tube displays the obtained data.

// This is derived from the TodayStart example key_led.v, which wasn't reliable
// for multiple reasons. The comprehensive CASE statement has been replaced by
// a much smaller number of IFs, and operation has been made synchronous without
// which the initial state was undefined (this board only has a clock on CLK3,
// see http://kiedontaa.blogspot.com/2019/12/gameboy-to-vga.html for comments.
//
// Assume for the purpose of maintenance that there are now two files key_led.v
// and key_led.vhd, use one or the other as Quartus's top-level entity. MarkMLl

module key_led (CLOCK, key_data, LED7D, LED7S);

input CLOCK;
input [3:0] key_data;
output reg [3:0] LED7D;
output reg [7:0] LED7S;

// For a TodayStart board with a Cyclone EP1C3T144C8
// -------------------------------------------------
//
// Segment allocation (7 is MS bit of binary literals):
//
//        0
//
//    5      1
//
//        6
//
//    4      2
//
//        3       7
//
// Pin allocation:
//
// Pin Name/Usage               : Location  : Dir.   : I/O Standard      : Voltage : I/O Bank  : User Assignment
// -------------------------------------------------------------------------------------------------------------
// key_data[3]                  : 60        : input  : 3.3-V LVTTL       :         : 4         : Y              
// key_data[2]                  : 61        : input  : 3.3-V LVTTL       :         : 4         : Y              
// key_data[1]                  : 62        : input  : 3.3-V LVTTL       :         : 4         : Y              
// key_data[0]                  : 67        : input  : 3.3-V LVTTL       :         : 4         : Y              
// 
// LED7S[6]                     : 73        : output : 3.3-V LVTTL       :         : 3         : Y              
// LED7S[0]                     : 74        : output : 3.3-V LVTTL       :         : 3         : Y              
// LED7S[4]                     : 75        : output : 3.3-V LVTTL       :         : 3         : Y              
// LED7S[7]                     : 76        : output : 3.3-V LVTTL       :         : 3         : Y              
// LED7S[1]                     : 77        : output : 3.3-V LVTTL       :         : 3         : Y              
// LED7S[2]                     : 78        : output : 3.3-V LVTTL       :         : 3         : Y              
// LED7S[3]                     : 79        : output : 3.3-V LVTTL       :         : 3         : Y              
// LED7S[5]                     : 82        : output : 3.3-V LVTTL       :         : 3         : Y              
// 
// LED7D[0]                     : 83        : output : 3.3-V LVTTL       :         : 3         : Y              
// LED7D[1]                     : 84        : output : 3.3-V LVTTL       :         : 3         : Y              
// LED7D[2]                     : 85        : output : 3.3-V LVTTL       :         : 3         : Y              
// LED7D[3]                     : 91        : output : 3.3-V LVTTL       :         : 3         : Y              
//
// CLOCK                        : 92        : input  : 3.3-V LVTTL       :         : 3         : Y              

initial
  begin
    LED7D = 4'b0000; // All digits on
    LED7S = 8'b11111111; // All segments off
  end

// Using this always statement, if multiple buttons are pressed the rightmost wins.  
  
/* always @(posedge CLOCK)
  begin
    if (~key_data[3])
	   LED7S = 8'b10011001; // 4 on segments
    if (~key_data[2])
      LED7S = 8'b10110000; // 3 on segments
    if (~key_data[1])
      LED7S = 8'b10100100; // 2 on segments
    if (~key_data[0])
      LED7S = 8'b11111001; // 1 on segments
  end */

// Using this always statement, if multiple buttons are pressed the leftmost wins.  
  
always @(posedge CLOCK)
  if (~key_data[3])
    LED7S = 8'b10011001; // 4 on segments
  else
    if (~key_data[2])
      LED7S = 8'b10110000; // 3 on segments
	 else	
      if (~key_data[1])
        LED7S = 8'b10100100; // 2 on segments
		else  
       if (~key_data[0])
         LED7S = 8'b11111001; // 1 on segments
  
endmodule
