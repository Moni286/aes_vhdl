----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:38:34 10/21/2017 
-- Design Name: 
-- Module Name:    mixColumns - Behavioral 
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

entity mixColumns is
    Port ( d : in  STD_LOGIC_VECTOR (127 downto 0);
           q : out  STD_LOGIC_VECTOR (127 downto 0));
end mixColumns;

architecture Behavioral of mixColumns is
	COMPONENT mixColumns4B PORT (
		d : in  STD_LOGIC_VECTOR (31 downto 0);
		q : out STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT mixColumns4B;
begin

mixColumns4B0: mixColumns4B port map (d(127 downto 96), q(127 downto 96));
mixColumns4B1: mixColumns4B port map (d( 95 downto 64), q( 95 downto 64));
mixColumns4B2: mixColumns4B port map (d( 63 downto 32), q( 63 downto 32));
mixColumns4B3: mixColumns4B port map (d( 31 downto  0), q( 31 downto  0));

end Behavioral;

