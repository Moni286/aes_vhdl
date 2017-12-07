----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:46:22 10/21/2017 
-- Design Name: 
-- Module Name:    x2 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity x2 is
    Port ( d : in  STD_LOGIC_VECTOR (7 downto 0);
           q : out  STD_LOGIC_VECTOR (7 downto 0));
end x2;

architecture Behavioral of x2 is

type t_x2 is array (0 to 255)
        of STD_LOGIC_VECTOR(7 downto 0);
constant x2Values : t_x2 := (
	X"00", X"02", X"04", X"06", X"08", X"0a", X"0c", X"0e", X"10", X"12", X"14", X"16", X"18", X"1a", X"1c", X"1e", 
	X"20", X"22", X"24", X"26", X"28", X"2a", X"2c", X"2e", X"30", X"32", X"34", X"36", X"38", X"3a", X"3c", X"3e", 
	X"40", X"42", X"44", X"46", X"48", X"4a", X"4c", X"4e", X"50", X"52", X"54", X"56", X"58", X"5a", X"5c", X"5e", 
	X"60", X"62", X"64", X"66", X"68", X"6a", X"6c", X"6e", X"70", X"72", X"74", X"76", X"78", X"7a", X"7c", X"7e", 
	X"80", X"82", X"84", X"86", X"88", X"8a", X"8c", X"8e", X"90", X"92", X"94", X"96", X"98", X"9a", X"9c", X"9e", 
	X"a0", X"a2", X"a4", X"a6", X"a8", X"aa", X"ac", X"ae", X"b0", X"b2", X"b4", X"b6", X"b8", X"ba", X"bc", X"be", 
	X"c0", X"c2", X"c4", X"c6", X"c8", X"ca", X"cc", X"ce", X"d0", X"d2", X"d4", X"d6", X"d8", X"da", X"dc", X"de", 
	X"e0", X"e2", X"e4", X"e6", X"e8", X"ea", X"ec", X"ee", X"f0", X"f2", X"f4", X"f6", X"f8", X"fa", X"fc", X"fe", 
	X"1b", X"19", X"1f", X"1d", X"13", X"11", X"17", X"15", X"0b", X"09", X"0f", X"0d", X"03", X"01", X"07", X"05", 
	X"3b", X"39", X"3f", X"3d", X"33", X"31", X"37", X"35", X"2b", X"29", X"2f", X"2d", X"23", X"21", X"27", X"25", 
	X"5b", X"59", X"5f", X"5d", X"53", X"51", X"57", X"55", X"4b", X"49", X"4f", X"4d", X"43", X"41", X"47", X"45", 
	X"7b", X"79", X"7f", X"7d", X"73", X"71", X"77", X"75", X"6b", X"69", X"6f", X"6d", X"63", X"61", X"67", X"65", 
	X"9b", X"99", X"9f", X"9d", X"93", X"91", X"97", X"95", X"8b", X"89", X"8f", X"8d", X"83", X"81", X"87", X"85", 
	X"bb", X"b9", X"bf", X"bd", X"b3", X"b1", X"b7", X"b5", X"ab", X"a9", X"af", X"ad", X"a3", X"a1", X"a7", X"a5", 
	X"db", X"d9", X"df", X"dd", X"d3", X"d1", X"d7", X"d5", X"cb", X"c9", X"cf", X"cd", X"c3", X"c1", X"c7", X"c5", 
	X"fb", X"f9", X"ff", X"fd", X"f3", X"f1", X"f7", X"f5", X"eb", X"e9", X"ef", X"ed", X"e3", X"e1", X"e7", X"e5"	);
	
begin

	q <= x2Values(to_integer(unsigned(d)));

end Behavioral;

