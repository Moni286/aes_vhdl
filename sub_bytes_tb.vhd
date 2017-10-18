--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:26:16 09/30/2017
-- Design Name:   
-- Module Name:   C:/Users/HP/Desktop/University/Academics/Capstone/aes_test/sub_bytes_tb.vhd
-- Project Name:  aes_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sub_bytes
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
 
ENTITY sub_bytes_tb IS
END sub_bytes_tb;
 
ARCHITECTURE behavior OF sub_bytes_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sub_bytes
    PORT(
         b : IN  std_logic_vector(31 downto 0);
         sb : OUT  std_logic_vector(31 downto 0);
			clk : IN std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal b : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal sb : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	signal clk : std_logic;
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sub_bytes PORT MAP (
          b => b,
          sb => sb,
			 clk => clk
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
		b <= x"01" & x"00" & x"00" & x"00";
      -- wait for <clock>_period*10;
		wait for 100 ns;
		b <= x"7c" & x"00" & x"00" & x"00";
      -- insert stimulus here 
		wait for 100 ns;
		b <= x"de" & x"00" & x"00" & x"00";
      wait;
   end process;

END;
