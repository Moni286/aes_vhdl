----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:21:39 10/03/2017 
-- Design Name: 
-- Module Name:    key_expansion - Behavioral 
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

entity key_expansion is
    Port ( key : in  STD_LOGIC_VECTOR (127 downto 0);
           clk : in  STD_LOGIC;
           ri : in  STD_LOGIC_VECTOR(3 downto 0);
           set : in  STD_LOGIC;
           rkey : out  STD_LOGIC_VECTOR (127 downto 0));
end key_expansion;

architecture Behavioral of key_expansion is

	type t_sBox is array (0 to 255)
        of STD_LOGIC_VECTOR(7 downto 0);
  constant sBox : t_sBox := 
	 (
		 x"63", x"7C", x"77", x"7B", x"F2", x"6B", x"6F", x"C5", x"30", x"01", x"67", x"2B", x"FE", x"D7", x"AB", x"76",
		 x"CA", x"82", x"C9", x"7D", x"FA", x"59", x"47", x"F0", x"AD", x"D4", x"A2", x"AF", x"9C", x"A4", x"72", x"C0",
		 x"B7", x"FD", x"93", x"26", x"36", x"3F", x"F7", x"CC", x"34", x"A5", x"E5", x"F1", x"71", x"D8", x"31", x"15",
		 x"04", x"C7", x"23", x"C3", x"18", x"96", x"05", x"9A", x"07", x"12", x"80", x"E2", x"EB", x"27", x"B2", x"75",
		 x"09", x"83", x"2C", x"1A", x"1B", x"6E", x"5A", x"A0", x"52", x"3B", x"D6", x"B3", x"29", x"E3", x"2F", x"84",
		 x"53", x"D1", x"00", x"ED", x"20", x"FC", x"B1", x"5B", x"6A", x"CB", x"BE", x"39", x"4A", x"4C", x"58", x"CF",
		 x"D0", x"EF", x"AA", x"FB", x"43", x"4D", x"33", x"85", x"45", x"F9", x"02", x"7F", x"50", x"3C", x"9F", x"A8",
		 x"51", x"A3", x"40", x"8F", x"92", x"9D", x"38", x"F5", x"BC", x"B6", x"DA", x"21", x"10", x"FF", x"F3", x"D2",
		 x"CD", x"0C", x"13", x"EC", x"5F", x"97", x"44", x"17", x"C4", x"A7", x"7E", x"3D", x"64", x"5D", x"19", x"73",
		 x"60", x"81", x"4F", x"DC", x"22", x"2A", x"90", x"88", x"46", x"EE", x"B8", x"14", x"DE", x"5E", x"0B", x"DB",
		 x"E0", x"32", x"3A", x"0A", x"49", x"06", x"24", x"5C", x"C2", x"D3", x"AC", x"62", x"91", x"95", x"E4", x"79",
		 x"E7", x"C8", x"37", x"6D", x"8D", x"D5", x"4E", x"A9", x"6C", x"56", x"F4", x"EA", x"65", x"7A", x"AE", x"08",
		 x"BA", x"78", x"25", x"2E", x"1C", x"A6", x"B4", x"C6", x"E8", x"DD", x"74", x"1F", x"4B", x"BD", x"8B", x"8A",
		 x"70", x"3E", x"B5", x"66", x"48", x"03", x"F6", x"0E", x"61", x"35", x"57", x"B9", x"86", x"C1", x"1D", x"9E",
		 x"E1", x"F8", x"98", x"11", x"69", x"D9", x"8E", x"94", x"9B", x"1E", x"87", x"E9", x"CE", x"55", x"28", x"DF",
		 x"8C", x"A1", x"89", x"0D", x"BF", x"E6", x"42", x"68", x"41", x"99", x"2D", x"0F", x"B0", x"54", x"BB", x"16"
	 );
	 
--	type t_sBox is array (0 to 255)
--			  of STD_LOGIC_VECTOR(7 downto 0);
	constant rcon: t_sBox := 
	  (
		 x"8d", x"01", x"02", x"04", x"08", x"10", x"20", x"40", x"80", x"1b", x"36", x"6c", x"d8", x"ab", x"4d", x"9a", 
		 x"2f", x"5e", x"bc", x"63", x"c6", x"97", x"35", x"6a", x"d4", x"b3", x"7d", x"fa", x"ef", x"c5", x"91", x"39", 
		 x"72", x"e4", x"d3", x"bd", x"61", x"c2", x"9f", x"25", x"4a", x"94", x"33", x"66", x"cc", x"83", x"1d", x"3a", 
		 x"74", x"e8", x"cb", x"8d", x"01", x"02", x"04", x"08", x"10", x"20", x"40", x"80", x"1b", x"36", x"6c", x"d8", 
		 x"ab", x"4d", x"9a", x"2f", x"5e", x"bc", x"63", x"c6", x"97", x"35", x"6a", x"d4", x"b3", x"7d", x"fa", x"ef", 
		 x"c5", x"91", x"39", x"72", x"e4", x"d3", x"bd", x"61", x"c2", x"9f", x"25", x"4a", x"94", x"33", x"66", x"cc", 
		 x"83", x"1d", x"3a", x"74", x"e8", x"cb", x"8d", x"01", x"02", x"04", x"08", x"10", x"20", x"40", x"80", x"1b", 
		 x"36", x"6c", x"d8", x"ab", x"4d", x"9a", x"2f", x"5e", x"bc", x"63", x"c6", x"97", x"35", x"6a", x"d4", x"b3", 
		 x"7d", x"fa", x"ef", x"c5", x"91", x"39", x"72", x"e4", x"d3", x"bd", x"61", x"c2", x"9f", x"25", x"4a", x"94", 
		 x"33", x"66", x"cc", x"83", x"1d", x"3a", x"74", x"e8", x"cb", x"8d", x"01", x"02", x"04", x"08", x"10", x"20", 
		 x"40", x"80", x"1b", x"36", x"6c", x"d8", x"ab", x"4d", x"9a", x"2f", x"5e", x"bc", x"63", x"c6", x"97", x"35", 
		 x"6a", x"d4", x"b3", x"7d", x"fa", x"ef", x"c5", x"91", x"39", x"72", x"e4", x"d3", x"bd", x"61", x"c2", x"9f", 
		 x"25", x"4a", x"94", x"33", x"66", x"cc", x"83", x"1d", x"3a", x"74", x"e8", x"cb", x"8d", x"01", x"02", x"04", 
		 x"08", x"10", x"20", x"40", x"80", x"1b", x"36", x"6c", x"d8", x"ab", x"4d", x"9a", x"2f", x"5e", x"bc", x"63", 
		 x"c6", x"97", x"35", x"6a", x"d4", x"b3", x"7d", x"fa", x"ef", x"c5", x"91", x"39", x"72", x"e4", x"d3", x"bd", 
		 x"61", x"c2", x"9f", x"25", x"4a", x"94", x"33", x"66", x"cc", x"83", x"1d", x"3a", x"74", x"e8", x"cb", x"8d"
	);
	
--	type t_roundKeys is array (0 to 175)
--        of 
	signal roundKeys : STD_LOGIC_VECTOR(1408 downto 0);
	signal state : STD_LOGIC := '0';
	
	signal k0 : STD_LOGIC_VECTOR(31 downto 0);
	signal k1 : STD_LOGIC_VECTOR(31 downto 0);
	signal k2 : STD_LOGIC_VECTOR(31 downto 0);
	signal k3 : STD_LOGIC_VECTOR(31 downto 0);
	
	signal krcon : STD_LOGIC_VECTOR(31 downto 0);   -- k3 before subsitution
	signal krcon_s : STD_LOGIC_VECTOR(31 downto 0); -- k3 after subsitution
	
begin

	process(key, clk, ri, set)
	BEGIN
	
		if rising_edge(clk) then
			if set = '1' then
				roundKeys(127 downto 0) <= key;
			else
				if state = '0' then
					
					state <= '1';
					
					case ri is
						when "0000" => -- i = 0
							krcon_s(7 downto 0) <= sBox(to_integer(unsigned(roundKeys(111 downto 104))));
							krcon_s(15 downto 8) <= sBox(to_integer(unsigned(roundKeys(119 downto 112))));
							krcon_s(23 downto 16) <= sBox(to_integer(unsigned(roundKeys(127 downto 120))));
							krcon_s(31 downto 24) <= sBox(to_integer(unsigned(roundKeys(103 downto 96))))
								XOR rcon(to_integer(unsigned(ri)));
								
						when "0001" => -- i = 1
							krcon_s(7 downto 0) <= sBox(to_integer(unsigned(roundKeys(128 + 111 downto 128 + 104))));
							krcon_s(15 downto 8) <= sBox(to_integer(unsigned(roundKeys(128 + 119 downto 128 + 112))));
							krcon_s(23 downto 16) <= sBox(to_integer(unsigned(roundKeys(128 + 127 downto 128 + 120))));
							krcon_s(31 downto 24) <= sBox(to_integer(unsigned(roundKeys(128 + 103 downto 128 + 96))))
								XOR rcon(to_integer(unsigned(ri)));
								
						when "0010" => -- i = 2
							krcon_s(7 downto 0) <= sBox(to_integer(unsigned(roundKeys(256 + 111 downto 256 + 104))));
							krcon_s(15 downto 8) <= sBox(to_integer(unsigned(roundKeys(256 + 119 downto 256 + 112))));
							krcon_s(23 downto 16) <= sBox(to_integer(unsigned(roundKeys(256 + 127 downto 256 + 120))));
							krcon_s(31 downto 24) <= sBox(to_integer(unsigned(roundKeys(256 + 103 downto 256 + 96))))
								XOR rcon(to_integer(unsigned(ri)));
								
						when "0011" => -- i = 3
							krcon_s(7 downto 0) <= sBox(to_integer(unsigned(roundKeys(384 + 111 downto 384 + 104))));
							krcon_s(15 downto 8) <= sBox(to_integer(unsigned(roundKeys(384 + 119 downto 384 + 112))));
							krcon_s(23 downto 16) <= sBox(to_integer(unsigned(roundKeys(384 + 127 downto 384 + 120))));
							krcon_s(31 downto 24) <= sBox(to_integer(unsigned(roundKeys(384 + 103 downto 384 + 96))))
								XOR rcon(to_integer(unsigned(ri)));
								
						when "0100" => -- i = 4
							krcon_s(7 downto 0) <= sBox(to_integer(unsigned(roundKeys(512 + 111 downto 512 + 104))));
							krcon_s(15 downto 8) <= sBox(to_integer(unsigned(roundKeys(512 + 119 downto 512 + 112))));
							krcon_s(23 downto 16) <= sBox(to_integer(unsigned(roundKeys(512 + 127 downto 512 + 120))));
							krcon_s(31 downto 24) <= sBox(to_integer(unsigned(roundKeys(512 + 103 downto 512 + 96))))
								XOR rcon(to_integer(unsigned(ri)));
								
						when "0101" => -- i = 5
							krcon_s(7 downto 0) <= sBox(to_integer(unsigned(roundKeys(640 + 111 downto 640 + 104))));
							krcon_s(15 downto 8) <= sBox(to_integer(unsigned(roundKeys(640 + 119 downto 640 + 112))));
							krcon_s(23 downto 16) <= sBox(to_integer(unsigned(roundKeys(640 + 127 downto 640 + 120))));
							krcon_s(31 downto 24) <= sBox(to_integer(unsigned(roundKeys(640 + 103 downto 640 + 96))))
								XOR rcon(to_integer(unsigned(ri)));
								
						when "0110" => -- i = 6
							krcon_s(7 downto 0) <= sBox(to_integer(unsigned(roundKeys(768 + 111 downto 768 + 104))));
							krcon_s(15 downto 8) <= sBox(to_integer(unsigned(roundKeys(768 + 119 downto 768 + 112))));
							krcon_s(23 downto 16) <= sBox(to_integer(unsigned(roundKeys(768 + 127 downto 768 + 120))));
							krcon_s(31 downto 24) <= sBox(to_integer(unsigned(roundKeys(768 + 103 downto 768 + 96))))
								XOR rcon(to_integer(unsigned(ri)));
								
						when "0111" => -- i = 7
							krcon_s(7 downto 0) <= sBox(to_integer(unsigned(roundKeys(768 + 111 downto 768 + 104))));
							krcon_s(15 downto 8) <= sBox(to_integer(unsigned(roundKeys(768 + 119 downto 768 + 112))));
							krcon_s(23 downto 16) <= sBox(to_integer(unsigned(roundKeys(768 + 127 downto 768 + 120))));
							krcon_s(31 downto 24) <= sBox(to_integer(unsigned(roundKeys(768 + 103 downto 768 + 96))))
								XOR rcon(to_integer(unsigned(ri)));
								
						when "1000" => -- i = 8
							krcon_s(7 downto 0) <= sBox(to_integer(unsigned(roundKeys(896 + 111 downto 896 + 104))));
							krcon_s(15 downto 8) <= sBox(to_integer(unsigned(roundKeys(896 + 119 downto 896 + 112))));
							krcon_s(23 downto 16) <= sBox(to_integer(unsigned(roundKeys(896 + 127 downto 896 + 120))));
							krcon_s(31 downto 24) <= sBox(to_integer(unsigned(roundKeys(896 + 103 downto 896 + 96))))
								XOR rcon(to_integer(unsigned(ri)));
								
						when "1001" => -- i = 9
							krcon_s(7 downto 0) <= sBox(to_integer(unsigned(roundKeys(1024 + 111 downto 1024 + 104))));
							krcon_s(15 downto 8) <= sBox(to_integer(unsigned(roundKeys(1024 + 119 downto 1024 + 112))));
							krcon_s(23 downto 16) <= sBox(to_integer(unsigned(roundKeys(1024 + 127 downto 1024 + 120))));
							krcon_s(31 downto 24) <= sBox(to_integer(unsigned(roundKeys(1024 + 103 downto 1024 + 96))))
								XOR rcon(to_integer(unsigned(ri)));
					end case;
					
				else
					state <= '0';
					
					k0 <= roundKeys((31 + (to_integer(unsigned(ri)) * 128)) downto (to_integer(unsigned(ri)) * 128)) XOR krcon_s;
					k1 <= k0 XOR roundKeys((63 + (to_integer(unsigned(ri)) * 128)) downto (32 + (to_integer(unsigned(ri)) * 128)));
					k2 <= k1 XOR roundKeys((95 + (to_integer(unsigned(ri)) * 128)) downto (64 + (to_integer(unsigned(ri)) * 128)));
					k3 <= k2 XOR roundKeys((127 + (to_integer(unsigned(ri)) * 128)) downto (96 + (to_integer(unsigned(ri)) * 128)));
					
					roundKeys((255 + (to_integer(unsigned(ri)) * 128)) downto(128 + (to_integer(unsigned(ri)) * 128))) <= k3 & k2 & k1 & k0;
					rKey <= roundKeys((127 + (to_integer(unsigned(ri)) * 128)) downto (to_integer(unsigned(ri)) * 128));
				end if;
			end if;
		end if;
		
	END PROCESS;

end Behavioral;









