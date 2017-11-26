----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:26:27 10/29/2017 
-- Design Name: 
-- Module Name:    control - Behavioral 
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

entity control is
	Port (
		clk : IN STD_LOGIC;
		byte_recvd: IN STD_LOGIC;
		rx_byte : IN STD_LOGIC_VECTOR(7 downto 0);
		enc_done : IN STD_LOGIC;
		send_done : IN STD_LOGIC;
		tx_active : IN STD_LOGIC;
		key_w : OUT STD_LOGIC;
		pt_w : OUT STD_LOGIC;
		index : OUT STD_LOGIC_VECTOR (3 downto 0);
		enc_reset : OUT STD_LOGIC;
		ct_w : OUT STD_LOGIC;
		o_state : OUT STD_LOGIC_VECTOR(2 downto 0);
		send : OUT STD_LOGIC
	);
end control;

architecture Behavioral of control is

signal state : STD_LOGIC_VECTOR(2 downto 0) := "000";
signal s_index : STD_LOGIC_VECTOR (4 downto 0) := "00000";
signal pt_full : STD_LOGIC := '0';
signal key_full : STD_LOGIC := '0';

-- state 000 => idle
-- state 001 => writing plaintext
-- state 010 => writing key
-- state 011 => encrypting
-- state 100 => writing ciphertext
-- state 101 => sending ciphertext
-- state 110 => reset

begin
	o_state <= state;
	index <= s_index(3 downto 0);
	
	PROCESS(clk, state)
	BEGIN
		if rising_edge(clk) then
			case state is
				when "000" => -- idle state
					if byte_recvd = '1' and rx_byte = x"01" then -- plaintext signal received
						state <= "001";
						pt_w <= '1';
						key_w <= '0';
						ct_w <= '0';
						s_index <= "00000";
						enc_reset <= '1';
						send <= '0';
					elsif byte_recvd = '1' and rx_byte = x"02" then -- key signal received
						state <= "010";
						pt_w <= '0';
						key_w <= '1';
						ct_w <= '0';
						s_index <= "00000";
						enc_reset <= '1';
						send <= '0';
					elsif byte_recvd = '1' and rx_byte = x"03" then -- reset signal received
						state <= "110";
						pt_w <= '0';
						key_w <= '0';
						ct_w <= '0';
						pt_full <= '0';
						key_full <= '0';
						s_index <= "00000";
						enc_reset <= '1';
						send <= '0';
					end if;
					
					if pt_full = '1' and key_full = '1' then
						state <= "011";
						pt_w <= '0';
						key_w <= '0';
						ct_w <= '0';
						s_index <= "00000";
						enc_reset <= '0';
						send <= '0';
					end if;
				when "001" => -- pt write state
					if s_index = "10000" then
						state <= "000";
						pt_w <= '0';
						key_w <= '0';
						ct_w <= '0';
						s_index <= "00000";
						enc_reset <= '1';
						pt_full <= '1';
						send <= '0';
					else 
						if byte_recvd = '1' then
							s_index <= STD_LOGIC_VECTOR(unsigned(s_index) + 1);
							if s_index = "01111" then
								pt_w <= '0';
							end if;
						end if;
					end if;
				when "010" => -- key write state
					if s_index = "10000" then
						state <= "000";
						pt_w <= '0';
						key_w <= '0';
						ct_w <= '0';
						s_index <= "00000";
						enc_reset <= '1';
						key_full <= '1';
						send <= '0';
					else 
						if byte_recvd = '1' then
							s_index <= STD_LOGIC_VECTOR(unsigned(s_index) + 1);
							if s_index = "01111" then
								key_w <= '0';
							end if;
						end if;
					end if;
				when "011" => -- encrypting state 
					if enc_done = '1' then
						state <= "100";
						ct_w <= '1';
						pt_w <= '0';
						key_w <= '0';
						s_index <= "00000";
						enc_reset <= '0';
						send <= '0';
					end if;
				when "100" => -- ciphertext write state
					state <= "101";
					ct_w <= '0';
					pt_w <= '0';
					key_w <= '0';
					send <= '0';
					s_index <= "00000";
					enc_reset <= '1';
				when "101" => -- ciphertext send state
					if s_index = "10000" then
						state <= "000";
						ct_w <= '0';
						pt_w <= '0';
						key_w <= '0';
						send <= '0';
						s_index <= "00000";
						enc_reset <= '1';
						-- key_full <= '0';
						pt_full <= '0';
					else
						send <= '1';
						if send_done = '1' and tx_active = '0' then
							s_index <= STD_LOGIC_VECTOR(unsigned(s_index) + 1);
						elsif s_index = "00000" then
							s_index <= STD_LOGIC_VECTOR(unsigned(s_index) + 1);
						end if;
					end if;
				when "110" =>
					state <= "000";
					ct_w <= '0';
					pt_w <= '0';
					key_w <= '0';
					send <= '0';
					s_index <= "00000";
					enc_reset <= '1';
				when others =>
					state <= "000";
					ct_w <= '0';
					pt_w <= '0';
					key_w <= '0';
					send <= '0';
					s_index <= "00000";
					enc_reset <= '1';
			end case;
		end if;
		
--			if byte_recvd = '1' and rx_byte = x"01" and state = "000" then -- plaintext write signal
--				pt_w <= '1';
--				key_w <= '0';
--				enc_reset <= '1';
--				ct_w <= '0';
--				state <= "001";
--			elsif byte_recvd = '1' and rx_byte = x"02" and state = "000" then -- key write signal
--				key_w <= '1';
--				pt_w <= '0';
--				key_reset <= '0';
--				pt_reset <= '0';
--				enc_reset <= '1';
--				ct_w <= '0';
--				state <= "010";
--			elsif state = "001" and pt_full = '1' then -- plaintext write done
--				-- increment by 1 when byte recvd, stop when index = 1111
--				state <= "000";
--				key_w <= '0';
--				pt_w <= '0';
--				key_reset <= '0';
--				pt_reset <= '0';
--				ct_w <= '0';
--				enc_reset <= '1';
--			elsif state = "010" and key_full = '1' then -- key write done
--				state <= "000";
--				key_w <= '0';
--				pt_w <= '0';
--				key_reset <= '0';
--				pt_reset <= '0';
--				ct_w <= '0';
--				enc_reset <= '1';
--			elsif key_full = '1' and pt_full = '1' and state = "000" then -- key write done, pt write done
--				enc_reset <= '0';
--				key_w <= '0';
--				pt_w <= '0';
--				key_reset <= '0';
--				pt_reset <= '0';
--				ct_w <= '0';
--				state <= "011";
--			elsif enc_done = '1' and state = "011" then -- encryption done
--				state <= "100";
--				ct_w <= '1';
--				enc_reset <= '0';
--				key_w <= '0';
--				pt_w <= '0';
--				key_reset <= '0';
--				pt_reset <= '0';
--			elsif state =  "100" then
--				ct_w <= '0';
--				enc_reset <= '0';
--				key_w <= '0';
--				pt_w <= '0';
--				key_reset <= '0';
--				pt_reset <= '0';
--				state <= "101";
--			elsif byte_recvd = '1' and rx_byte = x"03" and (state /= "001" and state /= "010") then
--				state <= "110";
--				key_w <= '0';
--				pt_w <= '0';
--				key_reset <= '1';
--				pt_reset <= '1';
--				ct_w <= '0';
--				enc_reset <= '1';
--			elsif state = "110" then
--				key_w <= '0';
--				pt_w <= '0';
--				key_reset <= '0';
--				pt_reset <= '0';
--				ct_w <= '0';
--				enc_reset <= '1';
--				state <= "000";
--			end if;
	END PROCESS;

end Behavioral;

