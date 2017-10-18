----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:32:15 10/08/2017 
-- Design Name: 
-- Module Name:    aes_round - Behavioral 
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

entity aes_round is
    Port ( state : in  STD_LOGIC_VECTOR (127 downto 0);
           rkey : in  STD_LOGIC_VECTOR (127 downto 0);
			  clk : in STD_LOGIC;
			  en : in STD_LOGIC;
           nextState : out  STD_LOGIC_VECTOR (127 downto 0);
			  enable_next : out STD_LOGIC);
end aes_round;

architecture Behavioral of aes_round is
	
	-- components
	
	COMPONENT mix_columns is
    Port (
			inBytes : in  STD_LOGIC_VECTOR (127 downto 0);
			outBytes : out STD_LOGIC_VECTOR (127 downto 0);
			clk : in STD_LOGIC
		);
	END COMPONENT mix_columns;
	
	COMPONENT sub_bytes is
    Port (
			b 	: in  STD_LOGIC_VECTOR (127 downto 0);
			sb : out STD_LOGIC_VECTOR (127 downto 0);
			clk : in STD_LOGIC
		);
	 
	end COMPONENT sub_bytes;
	
	signal round_state : STD_LOGIC_VECTOR(127 downto 0);
	signal round_key : STD_LOGIC_VECTOR(127 downto 0);
	signal after_sbox : STD_LOGIC_VECTOR(127 downto 0);
	signal after_shiftrows : STD_LOGIC_VECTOR(127 downto 0);
	signal after_mixcolumns : STD_LOGIC_VECTOR(127 downto 0);
	
	signal cnt : STD_LOGIC_VECTOR(2 downto 0) := "000";
	
begin
	sbox : sub_bytes port map(
		b => state,
		sb => after_sbox,
		clk => clk
	);
	
--	after_shiftrows <= after_sbox(95 downto 88) & after_sbox(55 downto 48) & after_sbox(15 downto 8) & after_sbox(103 downto 96) &
--					after_sbox(63 downto 56) & after_sbox(23 downto 16) & after_sbox(111 downto 104) & after_sbox(71 downto 64) &
--					after_sbox(31 downto 24) & after_sbox(119 downto 112) & after_sbox(79 downto 72) & after_sbox(39 downto 32) &
--					after_sbox(127 downto 120) & after_sbox(87 downto 80) & after_sbox(47 downto 40) & after_sbox(7 downto 0);
 
--	after_shiftrows <= after_sbox(7 downto 0) & after_sbox(47 downto 40) & after_sbox(87 downto 80) & after_sbox(127 downto 120) &
--					after_sbox(39 downto 32) & after_sbox(79 downto 72) & after_sbox(119 downto 112) & after_sbox(31 downto 24) &
--					after_sbox(71 downto 64) & after_sbox(111 downto 104) & after_sbox(23 downto 16) & after_sbox(63 downto 56) &
--					after_sbox(103 downto 96) & after_sbox(15 downto 8) & after_sbox(55 downto 48) & after_sbox(95 downto 88);
	
	after_shiftrows <= after_sbox(127 downto 120) & after_sbox(87 downto 80) & after_sbox(47 downto 40) & after_sbox(7 downto 0) &
						after_sbox(95 downto 88) & after_sbox(55 downto 48) & after_sbox(15 downto 8) & after_sbox(103 downto 96) &
						after_sbox(63 downto 56) & after_sbox(23 downto 16) & after_sbox(111 downto 104) & after_sbox(71 downto 64) &
						after_sbox(31 downto 24) & after_sbox(119 downto 112) & after_sbox(79 downto 72) & after_sbox(39 downto 32);
	
	mixcolumns : mix_columns port map(
		inBytes => after_shiftrows,
		outBytes => after_mixcolumns,
		clk => clk
	);
	
	PROCESS(clk, en)
	BEGIN
		if rising_edge(clk) and en = '1' then
		
			if cnt < "010" then
				cnt <= STD_LOGIC_VECTOR(unsigned(cnt) + 1);
				enable_next <= '0';
				if cnt = "000" then
--					round_state <= state;
					round_key <= rkey;
				end if;
			else
				if cnt = "010" then
					enable_next <= '1';
					nextState <= after_mixcolumns xor rkey;
					cnt <= STD_LOGIC_VECTOR(unsigned(cnt) + 1);
				end if;
			end if;
		end if;
	END PROCESS;
	
	
	
end Behavioral;

