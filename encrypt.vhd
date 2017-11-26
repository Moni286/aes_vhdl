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

	COMPONENT mux16B3x1 PORT( 
		sel: in  STD_LOGIC_VECTOR (  3 downto 0);
		d0 : in  STD_LOGIC_VECTOR (127 downto 0);
		d1 : in  STD_LOGIC_VECTOR (127 downto 0);
		dA : in  STD_LOGIC_VECTOR (127 downto 0);
		q : out  STD_LOGIC_VECTOR (127 downto 0));
	END COMPONENT mux16B3x1;
	
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
	signal from_register : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_subBytes : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_shiftRows : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_mixColumns : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
begin

roundMux: mux16B3x1 port map(roundNumber, plaintext, from_mixColumns, from_shiftRows, from_mux);
from_addRoundKey <= from_mux xor roundKey;
storedState : reg16B port map(clk, clr, from_addRoundKey, from_register);
subBytesLayer : sbox16B port map(clk, from_register, from_subBytes);
shiftRowsLayer : shiftRows port map(from_subBytes, from_shiftRows);
mixColumnsLayer: mixColumns port map(clk, from_shiftRows, from_mixColumns);

PROCESS(clk)
BEGIN
	if rising_edge(clk) then
	if roundNumber = "1011" then
		ciphertext <= from_register;
	end if;
	end if;
	
END PROCESS;
end Behavioral;

