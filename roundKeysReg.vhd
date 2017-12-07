----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:16:28 12/06/2017 
-- Design Name: 
-- Module Name:    roundKeysReg - Behavioral 
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

entity roundKeysReg is
    Port ( clk : in  STD_LOGIC;
           w : in  STD_LOGIC;
			  index : in STD_LOGIC_VECTOR (3 downto 0);
           rkey : in  STD_LOGIC_VECTOR (127 downto 0);
           allKeys : out  STD_LOGIC_VECTOR (1407 downto 0));
end roundKeysReg;

architecture Behavioral of roundKeysReg is

type key_array is array (0 to 15)
        of STD_LOGIC_VECTOR(127 downto 0);

signal roundKeys : key_array;

begin

	allKeys(127 downto 0) <= roundKeys(0);
	allKeys(255 downto 128) <= roundKeys(1);
	allKeys(383 downto 256) <= roundKeys(2);
	allKeys(511 downto 384) <= roundKeys(3);
	allKeys(639 downto 512) <= roundKeys(4);
	allKeys(767 downto 640) <= roundKeys(5);
	allKeys(895 downto 768) <= roundKeys(6);
	allKeys(1023 downto 896) <= roundKeys(7);
	allKeys(1151 downto 1024) <= roundKeys(8);
	allKeys(1279 downto 1152) <= roundKeys(9);
	allKeys(1407 downto 1280) <= roundKeys(10);
	
	PROCESS(clk)
	BEGIN
		if rising_edge(clk) then
			if w = '1' then
				roundKeys(to_integer(unsigned(index))) <= rkey;
			end if;
		end if;
	END PROCESS;

end Behavioral;








