----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:51:04 10/08/2017 
-- Design Name: 
-- Module Name:    lrotate - Behavioral 
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

entity lrotate is
    Port ( win  : in   STD_LOGIC_VECTOR (31 downto 0);
           wout : out  STD_LOGIC_VECTOR (31 downto 0));
end lrotate;

architecture Behavioral of lrotate is

begin

wout(31 downto 24) <= win(23 downto 16);
wout(23 downto 16) <= win(15 downto 08);
wout(15 downto 08) <= win(07 downto 00);
wout(07 downto 00) <= win(31 downto 24);

end Behavioral;

