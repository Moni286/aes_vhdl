--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:02:23 10/08/2017
-- Design Name:   
-- Module Name:   E:/aes128/lrotateTest.vhd
-- Project Name:  aes128
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lrotate
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
 
ENTITY lrotateTest IS
END lrotateTest;
 
ARCHITECTURE behavior OF lrotateTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lrotate
    PORT(
         win : IN  std_logic_vector(31 downto 0);
         wout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal win : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal wout : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lrotate PORT MAP (
          win => win,
          wout => wout
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
		win <= X"12345678";
		
		wait for 100 ns;
		win <= X"87654321";
		
		wait for 100 ns;
		win <= X"67204675";

--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
