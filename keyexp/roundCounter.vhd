----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:43:17 10/08/2017 
-- Design Name: 
-- Module Name:    roundCounter - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity roundCounter is
    Port ( en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (3 downto 0));
end roundCounter;

architecture Behavioral of roundCounter is
	signal temp: STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin

	process(clk, reset, en)
	begin
		if reset = '1' then
			temp <= "0000";
		elsif(rising_edge(clk)) then
			if en = '1' then
				if temp = "1011" then
					temp <= "0000";
				else 
					temp <= temp + 1;
				end if;
			else
				temp <= "0000";
			end if;
		end if;
	end process;
	q <= temp;
end Behavioral;

