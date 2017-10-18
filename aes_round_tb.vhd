--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:36:31 10/08/2017
-- Design Name:   
-- Module Name:   C:/Users/HP/Desktop/University/Academics/Capstone/aes_test/aes_round_tb.vhd
-- Project Name:  aes_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: aes_round
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
 
ENTITY aes_round_tb IS
END aes_round_tb;
 
ARCHITECTURE behavior OF aes_round_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT aes_round
    PORT(
         state : IN  std_logic_vector(127 downto 0);
         rkey : IN  std_logic_vector(127 downto 0);
         clk : IN  std_logic;
         en : IN  std_logic;
         nextState : OUT  std_logic_vector(127 downto 0);
         enable_next : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal state : std_logic_vector(127 downto 0) := (others => '0');
   signal rkey : std_logic_vector(127 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal en : std_logic := '0';

 	--Outputs
   signal nextState : std_logic_vector(127 downto 0);
   signal enable_next : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: aes_round PORT MAP (
          state => state,
          rkey => rkey,
          clk => clk,
          en => en,
          nextState => nextState,
          enable_next => enable_next
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
		en <= '0';
      wait for clk_period*10;
		
		
		rkey <= x"d6aa74fdd2af72fadaa678f1d6ab76fe";
		state <= x"00102030405060708090a0b0c0d0e0f0";
      -- insert stimulus here 
		
		wait for clk_period*10;
		
		en <= '1';
		
		wait for clk_period*6;
		rkey <= 	x"d6aa74fddff72fadaa678f1d6ab76fef";
		state <= x"aa1020304050a0708090a0b0c0d0edf0";
		
      wait;
   end process;

END;
