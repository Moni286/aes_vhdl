----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:55:24 12/06/2017 
-- Design Name: 
-- Module Name:    fullKeySched - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fullKeySched is
    Port ( originalKey : in  STD_LOGIC_VECTOR (127 downto 0);
           clk : in  STD_LOGIC;
			  clr : in STD_LOGIC;
           rk1 : out  STD_LOGIC_VECTOR (127 downto 0);
           rk2 : out  STD_LOGIC_VECTOR (127 downto 0);
           rk3 : out  STD_LOGIC_VECTOR (127 downto 0);
           rk4 : out  STD_LOGIC_VECTOR (127 downto 0);
           rk5 : out  STD_LOGIC_VECTOR (127 downto 0);
           rk6 : out  STD_LOGIC_VECTOR (127 downto 0);
           rk7 : out  STD_LOGIC_VECTOR (127 downto 0);
           rk8 : out  STD_LOGIC_VECTOR (127 downto 0);
           rk9 : out  STD_LOGIC_VECTOR (127 downto 0);
           rk10 : out  STD_LOGIC_VECTOR (127 downto 0));
end fullKeySched;

architecture Behavioral of fullKeySched is

COMPONENT keySchedule is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           roundNumber : in  STD_LOGIC_VECTOR (3 downto 0);
           originalKey : in  STD_LOGIC_VECTOR (127 downto 0);
           roundKey : out  STD_LOGIC_VECTOR (127 downto 0));
end COMPONENT keySchedule;

signal rk1_s : STD_LOGIC_VECTOR(127 downto 0);
signal rk2_s : STD_LOGIC_VECTOR(127 downto 0);
signal rk3_s : STD_LOGIC_VECTOR(127 downto 0);
signal rk4_s : STD_LOGIC_VECTOR(127 downto 0);
signal rk5_s : STD_LOGIC_VECTOR(127 downto 0);
signal rk6_s : STD_LOGIC_VECTOR(127 downto 0);
signal rk7_s : STD_LOGIC_VECTOR(127 downto 0);
signal rk8_s : STD_LOGIC_VECTOR(127 downto 0);
signal rk9_s : STD_LOGIC_VECTOR(127 downto 0);
signal rk10_s : STD_LOGIC_VECTOR(127 downto 0);

begin

	keyRound1 : keySchedule PORT MAP(clk, clr, x"1", originalKey, rk1_s);
	rk1 <= rk1_s;
	
	keyRound2 : keySchedule PORT MAP(clk, clr, x"2", rk1_s, rk2_s);
	rk2 <= rk2_s;
	
	keyRound3 : keySchedule PORT MAP(clk, clr, x"3", rk2_s, rk3_s);
	rk3 <= rk3_s;
	
	keyRound4 : keySchedule PORT MAP(clk, clr, x"4", rk3_s, rk4_s);
	rk4 <= rk4_s;
	
	keyRound5 : keySchedule PORT MAP(clk, clr, x"5", rk4_s, rk5_s);
	rk5 <= rk5_s;
	
	keyRound6 : keySchedule PORT MAP(clk, clr, x"6", rk5_s, rk6_s);
	rk6 <= rk6_s;
	
	keyRound7 : keySchedule PORT MAP(clk, clr, x"7", rk6_s, rk7_s);
	rk7 <= rk7_s;
	
	keyRound8 : keySchedule PORT MAP(clk, clr, x"8", rk7_s, rk8_s);
	rk8 <= rk8_s;
	
	keyRound9 : keySchedule PORT MAP(clk, clr, x"9", rk8_s, rk9_s);
	rk9 <= rk9_s;
	
	keyRound19 : keySchedule PORT MAP(clk, clr, x"a", rk9_s, rk10_s);
	rk10 <= rk10_s;

end Behavioral;













