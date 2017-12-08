--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:06:56 12/08/2017
-- Design Name:   
-- Module Name:   C:/Users/HP/Desktop/University/Academics/Capstone/aes/fullEncrypter_test.vhd
-- Project Name:  aes
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fullEncrypter
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
 
ENTITY fullEncrypter_test IS
END fullEncrypter_test;
 
ARCHITECTURE behavior OF fullEncrypter_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fullEncrypter
    PORT(
         plaintext : IN  std_logic_vector(127 downto 0);
         clk : IN  std_logic;
         clr : IN  std_logic;
         roundKey : IN  std_logic_vector(127 downto 0);
         roundNumber : IN  std_logic_vector(3 downto 0);
         ciphertext : OUT  std_logic_vector(127 downto 0);
         fast_clk : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal plaintext : std_logic_vector(127 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal clr : std_logic := '0';
   signal roundKey : std_logic_vector(127 downto 0) := (others => '0');
   signal roundNumber : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ciphertext : std_logic_vector(127 downto 0);
   signal fast_clk : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
   constant fast_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fullEncrypter PORT MAP (
          plaintext => plaintext,
          clk => clk,
          clr => clr,
          roundKey => roundKey,
          roundNumber => roundNumber,
          ciphertext => ciphertext,
          fast_clk => fast_clk
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

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
