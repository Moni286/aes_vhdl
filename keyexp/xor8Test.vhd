--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   05:16:12 10/08/2017
-- Design Name:   
-- Module Name:   E:/aes128/xor8Test.vhd
-- Project Name:  aes128
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: xor8
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
 
ENTITY xor8Test IS
END xor8Test;
 
ARCHITECTURE behavior OF xor8Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT xor8
    PORT(
         d0 : IN  std_logic_vector(7 downto 0);
         d1 : IN  std_logic_vector(7 downto 0);
         q : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal d0 : std_logic_vector(7 downto 0) := (others => '0');
   signal d1 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal q : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: xor8 PORT MAP (
          d0 => d0,
          d1 => d1,
          q => q
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

--      wait for <clock>_period*10;

      -- insert stimulus here 
		d0 <= X"AE";
		d1 <= X"EA";
      wait;
   end process;

END;
