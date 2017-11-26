--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:28:59 10/15/2017
-- Design Name:   
-- Module Name:   E:/aes128/keyScheduleTest.vhd
-- Project Name:  aes128
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: keySchedule
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY keyScheduleTest IS
END keyScheduleTest;
 
ARCHITECTURE behavior OF keyScheduleTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keySchedule
    PORT(
         clk : IN  std_logic;
         clr : IN  std_logic;
         d : IN  std_logic_vector(127 downto 0);
         q : OUT  std_logic_vector(127 downto 0);
			w : OUT STD_LOGIC;
			rnd : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal clr : std_logic := '0';
   signal d : std_logic_vector(127 downto 0) := (others => '0');

 	--Outputs
   signal q : std_logic_vector(127 downto 0);
	signal w : STD_LOGIC := '0';
	signal rnd : STD_LOGIC_VECTOR(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keySchedule PORT MAP (
          clk => clk,
          clr => clr,
          d => d,
          q => q,
			 w => w,
			 rnd => rnd
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		clr <= '1';
		
		wait for clk_period;
		clr <= '0';
		d <= X"5468617473206d79204b756e67204675";

		wait for clk_period * 20;
		clr <= '1';
		
		wait for clk_period;
		clr <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
