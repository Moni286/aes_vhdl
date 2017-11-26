--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:36:35 10/12/2017
-- Design Name:   
-- Module Name:   C:/Users/HP/Desktop/University/Academics/Capstone/aes_test/main_tb.vhd
-- Project Name:  aes_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: main
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
 
ENTITY main_tb IS
END main_tb;
 
ARCHITECTURE behavior OF main_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         ptblock : IN  std_logic_vector(127 downto 0);
         clk : IN  std_logic;
         ciphertext : OUT  std_logic_vector(127 downto 0);
         en : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ptblock : std_logic_vector(127 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal en : std_logic := '0';

 	--Outputs
   signal ciphertext : std_logic_vector(127 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          ptblock => ptblock,
          clk => clk,
          ciphertext => ciphertext,
          en => en
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
      wait for 10 ns;	
		en <= '1';
		ptblock <= x"00000000000000000000000000000000";
      wait for clk_period*50;
		en <= '1';
		ptblock <= x"00000000000000000000000000000000";
      wait;
   end process;

END;
