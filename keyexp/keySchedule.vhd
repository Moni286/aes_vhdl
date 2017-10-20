----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:11:52 10/08/2017 
-- Design Name: 
-- Module Name:    keySchedule - Behavioral 
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

entity keySchedule is Port (
	clk : IN  STD_LOGIC;
	clr : IN  STD_LOGIC;
	d   : IN  STD_LOGIC_VECTOR (127 downto 0);
	q   : OUT STD_LOGIC_VECTOR (127 downto 0);
	w	 : OUT STD_LOGIC;
	rnd : OUT STD_LOGIC_VECTOR (3 downto 0));
end keySchedule;

architecture Behavioral of keySchedule is
	COMPONENT lrotate IS PORT ( 
		win  : IN  STD_LOGIC_VECTOR (31 downto 0);
		wout : OUT STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT lrotate;

	COMPONENT sbox4B IS PORT (
		clk  : IN  STD_LOGIC;
		win  : IN  STD_LOGIC_VECTOR (31 downto 0);
		wout : OUT STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT sbox4B;
	
	COMPONENT rcon IS PORT (
		clk : IN  STD_LOGIC;
		i   : IN  STD_LOGIC_VECTOR (3 downto 0);
		win : IN  STD_LOGIC_VECTOR (31 downto 0);
		wout: OUT STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT rcon;

	COMPONENT reg128 IS PORT ( 
		clk : IN  STD_LOGIC;
		en :  IN  STD_LOGIC;
		clr : IN  STD_LOGIC;
		d :   IN  STD_LOGIC_VECTOR (127 downto 0);
		q :   OUT STD_LOGIC_VECTOR (127 downto 0));
	END COMPONENT reg128;

	COMPONENT roundCounter IS PORT ( 
		en    : IN  STD_LOGIC;
		clk   : IN  STD_LOGIC;
		reset : IN  STD_LOGIC;
		q     : OUT STD_LOGIC_VECTOR (3 downto 0));
	END COMPONENT roundCounter;	

	COMPONENT keyMux IS PORT ( 
		sel : in  STD_LOGIC_VECTOR (3 downto 0);
		d0 : in  STD_LOGIC_VECTOR (127 downto 0);
		d1 : in  STD_LOGIC_VECTOR (127 downto 0);
		q : out  STD_LOGIC_VECTOR (127 downto 0));
	END COMPONENT keyMux;
	
	SIGNAL rotatedWord     : STD_LOGIC_VECTOR (31 downto 0);
	SIGNAL substitutedWord : STD_LOGIC_VECTOR (31 downto 0);
	SIGNAL rconnedWord     : STD_LOGIC_VECTOR (31 downto 0);
	SIGNAL nextKeyW0 : STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
	SIGNAL nextKeyW1 : STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
	SIGNAL nextKeyW2 : STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
	SIGNAL nextKeyW3 : STD_LOGIC_VECTOR (31 downto 0) := X"00000000";
	SIGNAL roundNumber : STD_LOGIC_VECTOR (3 downto 0) := X"0";
	SIGNAL regIn : STD_LOGIC_VECTOR (127 downto 0) := X"00000000000000000000000000000000";
	SIGNAL nextKey : STD_LOGIC_VECTOR (127 downto 0) := X"00000000000000000000000000000000";
	SIGNAL key : STD_LOGIC_VECTOR(127 downto 0) := X"00000000000000000000000000000000";
	SIGNAL en : STD_LOGIC := '0';
	
begin

	rotateWord: lrotate port map (key(31 downto 0), rotatedWord);
	substituteWord:  sbox4B  port map (clk, rotatedWord, substitutedWord);
	roundCounter0 :  roundCounter port map (en, clk, clr, roundNumber);
	rconiXORbyte:    rcon    port map (clk, roundNumber, substitutedWord, rconnedWord);
	
	
	nextKeyW0 <= rconnedWord xor key(127 downto 96);
	nextKeyW1 <= nextKeyW0   xor key(95  downto 64);
	nextKeyW2 <= nextKeyW1   xor key(63  downto 32);
	nextKeyW3 <= nextKeyW2   xor key(31  downto  0);
	regIn <= nextKeyW0 & nextKeyW1 & nextKeyW2 & nextKeyW3;
	
	keyMux0 : keyMux port map(roundNumber, d, regIn, nextKey);
	reg0 : reg128 port map (clk, '1', clr, nextKey, key);
	
	PROCESS(clk, clr)
	BEGIN
		if rising_edge(clk) then
			q <= key;
			if roundNumber < X"C" and roundNumber /= "0000" then
				w <= '1';
			else
				w <= '0';
			end if;
			
			if roundNumber >= X"B" then
				en <= '0';
			end if;
			rnd <= STD_LOGIC_VECTOR(unsigned(roundNumber) - "0001");
		end if;
		
		if clr = '1' then
			en <= '1';
		end if;
	END PROCESS;
end Behavioral;




