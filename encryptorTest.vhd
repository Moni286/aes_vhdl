--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:53:26 12/06/2017
-- Design Name:   
-- Module Name:   C:/Users/HP/Desktop/University/Academics/Capstone/aes - Copy/encryptorTest.vhd
-- Project Name:  aes
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: toplevel
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
 
ENTITY encryptorTest IS
END encryptorTest;
 
ARCHITECTURE behavior OF encryptorTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT toplevel
    PORT(
         clk : IN  std_logic;
         clr : IN  std_logic;
         originalKey : IN  std_logic_vector(127 downto 0);
         plaintext : IN  std_logic_vector(127 downto 0);
         ciphertext : OUT  std_logic_vector(127 downto 0);
         done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal clr : std_logic := '0';
   signal originalKey : std_logic_vector(127 downto 0) := (others => '0');
   signal plaintext : std_logic_vector(127 downto 0) := (others => '0');

 	--Outputs
   signal ciphertext : std_logic_vector(127 downto 0);
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: toplevel PORT MAP (
          clk => clk,
          clr => clr,
          originalKey => originalKey,
          plaintext => plaintext,
          ciphertext => ciphertext,
          done => done
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
		originalKey <= x"000102030405060708090a0b0c0d0e0f";
		clr <= '0';
		wait for clk_period*12;
		plaintext <= x"00112233445566778899aabbccddeeaa";
      wait for clk_period*1;
		plaintext <= x"00112233445566778899aabbccddee11";
		wait for clk_period*1;
		plaintext <= x"00112233445566778899aabbccddeeff";
      -- insert stimulus here 

      wait;
   end process;

END;
