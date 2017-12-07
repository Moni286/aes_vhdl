----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:35:22 12/06/2017 
-- Design Name: 
-- Module Name:    encAllRounds - Behavioral 
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

entity encAllRounds is
    Port ( plaintext : in  STD_LOGIC_VECTOR (127 downto 0);
           roundkeys : in  STD_LOGIC_VECTOR (1407 downto 0);
           clk : in  STD_LOGIC;
			  clr : in STD_LOGIC;
           ciphertext : out  STD_LOGIC_VECTOR (127 downto 0));
end encAllRounds;

architecture Behavioral of encAllRounds is

COMPONENT encrypt is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           roundKey : in  STD_LOGIC_VECTOR (127 downto 0);
           plaintext : in  STD_LOGIC_VECTOR (127 downto 0);
           ciphertext : out  STD_LOGIC_VECTOR (127 downto 0));
end COMPONENT encrypt;

COMPONENT finalRound is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           rkey : in  STD_LOGIC_VECTOR (127 downto 0);
           state : in  STD_LOGIC_VECTOR (127 downto 0);
           ciphertext : out  STD_LOGIC_VECTOR (127 downto 0));
end COMPONENT finalRound;

signal state1 : STD_LOGIC_VECTOR(127 downto 0);
signal state2 : STD_LOGIC_VECTOR(127 downto 0);
signal state3 : STD_LOGIC_VECTOR(127 downto 0);
signal state4 : STD_LOGIC_VECTOR(127 downto 0);
signal state5 : STD_LOGIC_VECTOR(127 downto 0);
signal state6 : STD_LOGIC_VECTOR(127 downto 0);
signal state7 : STD_LOGIC_VECTOR(127 downto 0);
signal state8 : STD_LOGIC_VECTOR(127 downto 0);
signal state9 : STD_LOGIC_VECTOR(127 downto 0);
signal state10 : STD_LOGIC_VECTOR(127 downto 0);

begin

	PROCESS(clk)
	BEGIN
		if rising_edge(clk) then
			if clr = '0' then
				state1 <= roundkeys(127 downto 0) xor plaintext;
			end if;
		end if;
	END PROCESS;
	round1 : encrypt PORT MAP(clk, clr, roundkeys(255 downto 128), state1, state2);
	round2 : encrypt PORT MAP(clk, clr, roundkeys(383 downto 256), state2, state3);
	round3 : encrypt PORT MAP(clk, clr, roundkeys(511 downto 384), state3, state4);
	round4 : encrypt PORT MAP(clk, clr, roundkeys(639 downto 512), state4, state5);
	round5 : encrypt PORT MAP(clk, clr, roundkeys(767 downto 640), state5, state6);
	round6 : encrypt PORT MAP(clk, clr, roundkeys(895 downto 768), state6, state7);
	round7 : encrypt PORT MAP(clk, clr, roundkeys(1023 downto 896), state7, state8);
	round8 : encrypt PORT MAP(clk, clr, roundkeys(1151 downto 1024), state8, state9);
	round9 : encrypt PORT MAP(clk, clr, roundkeys(1279 downto 1152), state9, state10);
	round10 : finalRound PORT MAP(clk, clr, roundkeys(1407 downto 1280), state10, ciphertext); --  should be final round

end Behavioral;









