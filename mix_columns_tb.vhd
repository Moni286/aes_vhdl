--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:28:51 10/07/2017
-- Design Name:   
-- Module Name:   C:/Users/HP/Desktop/University/Academics/Capstone/aes_test/mix_columns_tb.vhd
-- Project Name:  aes_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mix_columns
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
 
ENTITY mix_columns_tb IS
END mix_columns_tb;
 
ARCHITECTURE behavior OF mix_columns_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mix_columns
    PORT(
         inBytes : IN  std_logic_vector(127 downto 0);
         outBytes : OUT  std_logic_vector(127 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal inBytes : std_logic_vector(127 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal outBytes : std_logic_vector(127 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mix_columns PORT MAP (
          inBytes => inBytes,
          outBytes => outBytes,
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
		inBytes <= x"6353e08c0960e104cd70b751bacad0e7";
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
