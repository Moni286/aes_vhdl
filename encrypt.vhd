----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:06:50 10/21/2017 
-- Design Name: 
-- Module Name:    encrypt - Behavioral 
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

entity encrypt is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           roundNumber : in  STD_LOGIC_VECTOR (3 downto 0);
           roundKey : in  STD_LOGIC_VECTOR (127 downto 0);
           plaintext : in  STD_LOGIC_VECTOR (127 downto 0);
           ciphertext : out  STD_LOGIC_VECTOR (127 downto 0));
end encrypt;

architecture Behavioral of encrypt is
	
	COMPONENT reg16B PORT ( 
		clk : in  STD_LOGIC;
		clr : in  STD_LOGIC;
		d : in  STD_LOGIC_VECTOR (127 downto 0);
		q : out  STD_LOGIC_VECTOR (127 downto 0));
	END COMPONENT reg16B;
	
	COMPONENT sbox16B PORT ( 
		clk : in  STD_LOGIC;
		d : in  STD_LOGIC_VECTOR (127 downto 0);
		q : out  STD_LOGIC_VECTOR (127 downto 0));
	END COMPONENT sbox16B;

	COMPONENT shiftRows PORT ( 
		d : in  STD_LOGIC_VECTOR (127 downto 0);
		q : out  STD_LOGIC_VECTOR (127 downto 0));
	END COMPONENT shiftRows;
	
	COMPONENT mixColumns PORT (
		clk : in STD_LOGIC;
		d : in  STD_LOGIC_VECTOR (127 downto 0);
		q : out STD_LOGIC_VECTOR (127 downto 0));
	END COMPONENT mixColumns;
	
	signal from_mux : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_addRoundKey : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_reg1 : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_reg2 : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_reg3 : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_subBytes : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_shiftRows : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_mixColumns : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
begin



-- roundMux: mux16B3x1 port map(roundNumber, plaintext, from_mixColumns, from_shiftRows, from_mux);
with roundNumber select from_mux <=
	plaintext when "0001",
	from_reg3 when others;

shiftRowsLayer : shiftRows port map(from_mux, from_shiftRows);
storedState1 : reg16B port map(clk, clr, from_shiftRows, from_reg1);

subBytesLayer : sbox16B port map(clk, from_reg1, from_subBytes);
storedState2 : reg16B port map(clk, clr, from_subBytes, from_reg2);

mixColumnsLayer: mixColumns port map(clk, from_reg2, from_mixColumns);
from_addRoundKey <= from_mixColumns xor roundKey;
storedState3 : reg16B port map(clk, clr, from_addRoundKey, from_reg3);
ciphertext <= from_reg3;


end Behavioral;

