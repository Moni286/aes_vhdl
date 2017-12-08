----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:53:04 12/06/2017 
-- Design Name: 
-- Module Name:    finalRound - Behavioral 
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

entity finalRound is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           rkey : in  STD_LOGIC_VECTOR (127 downto 0);
           state : in  STD_LOGIC_VECTOR (127 downto 0);
           ciphertext : out  STD_LOGIC_VECTOR (127 downto 0));
end finalRound;

architecture Behavioral of finalRound is

	COMPONENT reg16B PORT ( 
		clk : in  STD_LOGIC;
		clr : in  STD_LOGIC;
		d : in  STD_LOGIC_VECTOR (127 downto 0);
		q : out  STD_LOGIC_VECTOR (127 downto 0));
	END COMPONENT reg16B;
	
	COMPONENT sbox16B PORT ( 
		clk : in STD_LOGIC;
		d : in  STD_LOGIC_VECTOR (127 downto 0);
		q : out  STD_LOGIC_VECTOR (127 downto 0));
	END COMPONENT sbox16B;

	COMPONENT shiftRows PORT ( 
		d : in  STD_LOGIC_VECTOR (127 downto 0);
		q : out  STD_LOGIC_VECTOR (127 downto 0));
	END COMPONENT shiftRows;
	
	signal from_mux : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_addRoundKey : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_register : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_subBytes : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_shiftRows : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
	signal from_mixColumns : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');

begin

	subBytesLayer : sbox16B port map(clk, state, from_subBytes);
	shiftRowsLayer : shiftRows port map(from_subBytes, from_shiftRows);
	from_addRoundKey <= from_shiftRows xor rkey;
	storedState : reg16B port map(clk, clr, from_addRoundKey, from_register);
	ciphertext <= from_register;

end Behavioral;

