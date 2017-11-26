----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:01:50 10/08/2017 
-- Design Name: 
-- Module Name:    aes_full - Behavioral 
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

entity aes_full is
    Port ( pt : in  STD_LOGIC_VECTOR (127 downto 0);
           rkey : in  STD_LOGIC_VECTOR (127 downto 0);
           en : in  STD_LOGIC;
			  clk : in STD_LOGIC;
           ct : out  STD_LOGIC_VECTOR (127 downto 0);
			  round : out STD_LOGIC_VECTOR(3 downto 0));
end aes_full;

architecture Behavioral of aes_full is

COMPONENT aes_round is
    Port ( state : in  STD_LOGIC_VECTOR (127 downto 0);
           rkey : in  STD_LOGIC_VECTOR (127 downto 0);
			  clk : in STD_LOGIC;
			  en : in STD_LOGIC;
           nextState : out  STD_LOGIC_VECTOR (127 downto 0);
			  enable_next : out STD_LOGIC);
END COMPONENT aes_round;

COMPONENT sub_bytes is
    Port (
			b 	: in  STD_LOGIC_VECTOR (127 downto 0);
			sb : out STD_LOGIC_VECTOR (127 downto 0);
			clk : in STD_LOGIC
		);
END COMPONENT sub_bytes;

signal cnt : STD_LOGIC := '0';

signal state0 : STD_LOGIC_VECTOR(127 downto 0);
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
signal state11 : STD_LOGIC_VECTOR(127 downto 0);
signal after_shiftrows : STD_LOGIC_VECTOR(127 downto 0);

signal en1 : STD_LOGIC := '1';
signal en2 : STD_LOGIC := '0';
signal en3 : STD_LOGIC := '0';
signal en4 : STD_LOGIC := '0';
signal en5 : STD_LOGIC := '0';
signal en6 : STD_LOGIC := '0';
signal en7 : STD_LOGIC := '0';
signal en8 : STD_LOGIC := '0';
signal en9 : STD_LOGIC := '0';
signal en10 : STD_LOGIC := '0';

begin
	
	round1 : aes_round port map(
		state => state0,
		rkey => rkey,
		clk => clk,
		en => cnt,
		nextState => state1,
		enable_next => en1
	);
	
	round2 : aes_round port map(
		state => state1,
		rkey => rkey,
		clk => clk,
		en => en1,
		nextState => state2,
		enable_next => en2
	);
	
	round3 : aes_round port map(
		state => state2,
		rkey => rkey,
		clk => clk,
		en => en2,
		nextState => state3,
		enable_next => en3
	);
	
	round4 : aes_round port map(
		state => state3,
		rkey => rkey,
		clk => clk,
		en => en3,
		nextState => state4,
		enable_next => en4
	);
	
	round5 : aes_round port map(
		state => state4,
		rkey => rkey,
		clk => clk,
		en => en4,
		nextState => state5,
		enable_next => en5
	);
	
	round6 : aes_round port map(
		state => state5,
		rkey => rkey,
		clk => clk,
		en => en5,
		nextState => state6,
		enable_next => en6
	);
	
	round7 : aes_round port map(
		state => state6,
		rkey => rkey,
		clk => clk,
		en => en6,
		nextState => state7,
		enable_next => en7
	);
	
	round8 : aes_round port map(
		state => state7,
		rkey => rkey,
		clk => clk,
		en => en7,
		nextState => state8,
		enable_next => en8
	);
	
	round9 : aes_round port map(
		state => state8,
		rkey => rkey,
		clk => clk,
		en => en8,
		nextState => state9,
		enable_next => en9
	);
	
	sbox : sub_bytes port map(
		b => state9,
		sb => state10,
		clk => clk
	);
	
	after_shiftrows <= state10(127 downto 120) & state10(87 downto 80) & state10(47 downto 40) & state10(7 downto 0) &
						state10(95 downto 88) & state10(55 downto 48) & state10(15 downto 8) & state10(103 downto 96) &
						state10(63 downto 56) & state10(23 downto 16) & state10(111 downto 104) & state10(71 downto 64) &
						state10(31 downto 24) & state10(119 downto 112) & state10(79 downto 72) & state10(39 downto 32);
	
	state11 <= after_shiftrows xor rkey;
	
	PROCESS(clk, cnt, en, en9)
	BEGIN
		if rising_edge(clk) and cnt = '0' and en = '1' then
			state0 <= pt xor rkey;
			cnt <= '1';
		end if;
		
		if rising_edge(clk) and en9 = '1' then
			ct <= state11;
			en10 <= '1';
		end if;
		
		if cnt = '0' then
			round <= "0000";
		elsif cnt = '1' and en1 = '0' then
			round <= "0001";
		elsif en1 = '1' and en2 = '0' then
			round <= "0010";
		elsif en2 = '1' and en3 = '0' then
			round <= "0011";
		elsif en3 = '1' and en4 = '0' then
			round <= "0100";
		elsif en4 = '1' and en5 = '0' then
			round <= "0101";
		elsif en5 = '1' and en6 = '0' then
			round <= "0110";
		elsif en6 = '1' and en7 = '0' then
			round <= "0111";
		elsif en7 = '1' and en8 = '0' then
			round <= "1000";
		elsif en8 = '1' and en9 = '0' then
			round <= "1001";
		elsif en9 = '1' and en10 = '0' then
			round <= "1010";
		end if;
	END PROCESS;

end Behavioral;





