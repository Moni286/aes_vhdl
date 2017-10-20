----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:37:12 10/18/2017 
-- Design Name: 
-- Module Name:    key_RAM - Behavioral 
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

entity key_RAM is
    Port ( addr : in  STD_LOGIC_VECTOR (3 downto 0);
			  clk : in STD_LOGIC;
           read_write : in  STD_LOGIC;
           keyIn : in  STD_LOGIC_VECTOR (127 downto 0);
           keyOut : out  STD_LOGIC_VECTOR (127 downto 0);
           enable : in  STD_LOGIC);
end key_RAM;

architecture Behavioral of key_RAM is

	type ram_array is array(11 to 0) of STD_LOGIC_VECTOR(127 downto 0);
	signal RamArray: ram_array;
	
begin

	process(clk)
	begin
	if rising_edge(clk) and read_write = '0' then
			RamArray(to_integer(unsigned(addr))) <= keyIn;
	end if;
	
	if read_write = '1' then
		keyOut <= RamArray(to_integer(unsigned(addr)));
	end if;

	end process;



end Behavioral;

