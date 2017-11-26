--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:19:57 10/12/2017
-- Design Name:   
-- Module Name:   C:/Users/HP/Desktop/University/Academics/Capstone/aes_test/aes_full_tb.vhd
-- Project Name:  aes_test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: aes_full
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
 
ENTITY aes_full_tb IS
END aes_full_tb;
 
ARCHITECTURE behavior OF aes_full_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT aes_full
    PORT(
         pt : IN  std_logic_vector(127 downto 0);
         rkey : IN  std_logic_vector(127 downto 0);
         en : IN  std_logic;
         clk : IN  std_logic;
         ct : OUT  std_logic_vector(127 downto 0);
			round : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal pt : std_logic_vector(127 downto 0) := (others => '0');
   signal rkey : std_logic_vector(127 downto 0) := (others => '0');
   signal en : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal ct : std_logic_vector(127 downto 0);
	signal round : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: aes_full PORT MAP (
          pt => pt,
          rkey => rkey,
          en => en,
          clk => clk,
          ct => ct,
			 round => round
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
		en <= '1';
		pt <= x"00112233445566778899aabbccddeeff";
		rkey <= x"000102030405060708090a0b0c0d0e0f";
		
      wait for clk_period*1;
		rkey <= x"d6aa74fdd2af72fadaa678f1d6ab76fe";
		
		wait for clk_period*3;
		rkey <= x"b692cf0b643dbdf1be9bc5006830b3fe";
		
		wait for clk_period*3;
		rkey <= x"b6ff744ed2c2c9bf6c590cbf0469bf41";
		
		wait for clk_period*3;
		rkey <= x"47f7f7bc95353e03f96c32bcfd058dfd";
		
		wait for clk_period*3;
		rkey <= x"3caaa3e8a99f9deb50f3af57adf622aa";
		
		wait for clk_period*3;
		rkey <= x"5e390f7df7a69296a7553dc10aa31f6b";
		
		wait for clk_period*3;
		rkey <= x"14f9701ae35fe28c440adf4d4ea9c026";
		
		wait for clk_period*3;
		rkey <= x"47438735a41c65b9e016baf4aebf7ad2";
		
		wait for clk_period*3;
		rkey <= x"549932d1f08557681093ed9cbe2c974e";
		
		wait for clk_period*3;
		rkey <= x"13111d7fe3944a17f307a78b4d2b30c5";
		
      wait;
		
   end process;

END;



