----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:37:06 10/20/2017 
-- Design Name: 
-- Module Name:    rcon - Behavioral 
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

entity rcon is
    Port ( roundNumber : in STD_LOGIC_VECTOR(3 downto 0);
           d : in  STD_LOGIC_VECTOR (31 downto 0);
           q : out STD_LOGIC_VECTOR (31 downto 0));
end rcon;

architecture Behavioral of rcon is
	COMPONENT rconi PORT ( 
		d : in  STD_LOGIC_VECTOR (3 downto 0);
		q : out STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT rconi;
	signal rconiValue : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
calculate_rconi: rconi port map (roundNumber, rconiValue);

q(31 downto 24) <= d(31 downto 24) xor rconiValue;
q(23 downto 00) <= d(23 downto 00);

end Behavioral;

