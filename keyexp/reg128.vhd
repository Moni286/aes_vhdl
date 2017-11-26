----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:22:42 10/13/2017 
-- Design Name: 
-- Module Name:    reg128 - Behavioral 
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

entity reg128 is
    Port ( clk : in  STD_LOGIC;
           en  : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           d   : in  STD_LOGIC_VECTOR (127 downto 0);
           q   : out  STD_LOGIC_VECTOR (127 downto 0));
end reg128;

architecture Behavioral of reg128 is

begin

	process(clk, clr)
	begin
		if clr = '1' then
			q <= X"00000000000000000000000000000000";
		elsif rising_edge(clk) then
			if en = '1' then
				q <= d;
			end if;
		end if;
	end process;
end Behavioral;

