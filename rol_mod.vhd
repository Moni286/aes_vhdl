----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:51:55 09/30/2017 
-- Design Name: 
-- Module Name:    rol_mod - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rol_mod is
    Port ( r : in  STD_LOGIC_VECTOR (1 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           rb : out  STD_LOGIC_VECTOR (31 downto 0));
end rol_mod;

architecture Behavioral of rol_mod is

begin

	process(r, b)
	begin
		case (r) is
			when "00" =>
				rb <= b;
			when "01" =>
				rb <= b(23 downto 0) & b(31 downto 24);
			when "10" =>
				rb <= b(15 downto 0) & b(31 downto 16);
			when "11" =>
				rb <= b(7 downto 0) & b(31 downto 8);
			when others =>
				rb <= b;
		end case;
	end process;

end Behavioral;

