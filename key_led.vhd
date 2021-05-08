-- Quartus-II 10.1 VHDL Quartus-II 10.1 VHDL Quartus-II 10.1 VHDL Quartus-II 10

-- When pressing the four keys on the board. The nixie tube displays the obtained data.

-- This is derived from the TodayStart example key_led.v, which wasn't reliable
-- for multiple reasons. The comprehensive CASE statement has been replaced by
-- a much smaller number of IFs, and operation has been made synchronous without
-- which the initial state was undefined (this board only has a clock on CLK3,
-- see http://kiedontaa.blogspot.com/2019/12/gameboy-to-vga.html for comments.
--
-- Assume for the purpose of maintenance that there are now two files key_led.v
-- and key_led.vhd, use one or the other as Quartus's top-level entity. MarkMLl

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY key_led IS PORT(CLOCK    : IN  STD_LOGIC;
     key_data : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);                -- 0 indicates button pressed
     LED7D    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";      -- 0 selects digit
     LED7S    : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := "11111111"); -- 0 illuminates segment
END key_led;

-- For a TodayStart board with a Cyclone EP1C3T144C8
-- -------------------------------------------------
--
-- Segment allocation (7 is MS bit of binary literals):
--
--        0
--
--    5      1
--
--        6
--
--    4      2
--
--        3       7
--
-- Pin allocation:
--
-- Pin Name/Usage               : Location  : Dir.   : I/O Standard      : Voltage : I/O Bank  : User Assignment
-- -------------------------------------------------------------------------------------------------------------
-- key_data[3]                  : 60        : input  : 3.3-V LVTTL       :         : 4         : Y              
-- key_data[2]                  : 61        : input  : 3.3-V LVTTL       :         : 4         : Y              
-- key_data[1]                  : 62        : input  : 3.3-V LVTTL       :         : 4         : Y              
-- key_data[0]                  : 67        : input  : 3.3-V LVTTL       :         : 4         : Y              
-- 
-- LED7S[6]                     : 73        : output : 3.3-V LVTTL       :         : 3         : Y              
-- LED7S[0]                     : 74        : output : 3.3-V LVTTL       :         : 3         : Y              
-- LED7S[4]                     : 75        : output : 3.3-V LVTTL       :         : 3         : Y              
-- LED7S[7]                     : 76        : output : 3.3-V LVTTL       :         : 3         : Y              
-- LED7S[1]                     : 77        : output : 3.3-V LVTTL       :         : 3         : Y              
-- LED7S[2]                     : 78        : output : 3.3-V LVTTL       :         : 3         : Y              
-- LED7S[3]                     : 79        : output : 3.3-V LVTTL       :         : 3         : Y              
-- LED7S[5]                     : 82        : output : 3.3-V LVTTL       :         : 3         : Y              
-- 
-- LED7D[0]                     : 83        : output : 3.3-V LVTTL       :         : 3         : Y              
-- LED7D[1]                     : 84        : output : 3.3-V LVTTL       :         : 3         : Y              
-- LED7D[2]                     : 85        : output : 3.3-V LVTTL       :         : 3         : Y              
-- LED7D[3]                     : 91        : output : 3.3-V LVTTL       :         : 3         : Y              
--
-- CLOCK                        : 92        : input  : 3.3-V LVTTL       :         : 3         : Y              
  
ARCHITECTURE key_led_arch OF key_led IS BEGIN

  PROCESS(CLOCK, key_data) IS BEGIN 
    LED7D <= "0000";

-- Using this if statement, if multiple buttons are pressed the rightmost wins.  
  
--    IF rising_edge(CLOCK) THEN
--      IF key_data(3 DOWNTO 3) = "0" THEN
--        LED7S <= "10011001"; -- 4 on segments
--		END IF;  
--      IF key_data(2 DOWNTO 2) = "0" THEN
--        LED7S <= "10110000"; -- 3 on segments
--		END IF;  
--      IF key_data(1 DOWNTO 1) = "0" THEN
--        LED7S <= "10100100"; -- 2 on segments
--		END IF;  
--      IF key_data(0 DOWNTO 0) = "0" THEN
--        LED7S <= "11111001"; -- 1 on segments
--		END IF;  
--    END IF; -- rising_edge()

-- Using this if statement, if multiple buttons are pressed the leftmost wins.  
  
    IF rising_edge(CLOCK) THEN
      IF key_data(3 DOWNTO 3) = "0" THEN
        LED7S <= "10011001"; -- 4 on segments
      ELSE	 
        IF key_data(2 DOWNTO 2) = "0" THEN
          LED7S <= "10110000"; -- 3 on segments
        ELSE	 
          IF key_data(1 DOWNTO 1) = "0" THEN
            LED7S <= "10100100"; -- 2 on segments
          ELSE	 
            IF key_data(0 DOWNTO 0) = "0" THEN
              LED7S <= "11111001"; -- 1 on segments
            END IF;
          END IF;
        END IF;		
      END IF;	
    END IF; -- rising_edge()
	 
  END PROCESS; 
  
END key_led_arch;

