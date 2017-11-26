----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:49:15 10/27/2017 
-- Design Name: 
-- Module Name:    pt_buffer - Behavioral 
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

entity pt_buffer is
    Port ( inByte : in  STD_LOGIC_VECTOR (7 downto 0);
           w : in  STD_LOGIC;
			  index : in STD_LOGIC_VECTOR (3 downto 0);
			  clk : in STD_LOGIC;
           pt : out  STD_LOGIC_VECTOR (127 downto 0)
			 );			  
end pt_buffer;

architecture Behavioral of pt_buffer is

type buff is array (0 to 15)
        of STD_LOGIC_VECTOR(7 downto 0);
		  
signal pt_buf : buff := (others => "00000000");

begin

PROCESS(clk)
BEGIN	

	if rising_edge(clk) then	
		pt <= pt_buf(0) & pt_buf(1) & pt_buf(2) & pt_buf(3)
			& pt_buf(4) & pt_buf(5) & pt_buf(6) & pt_buf(7)
			& pt_buf(8) & pt_buf(9) & pt_buf(10) & pt_buf(11)
			& pt_buf(12) & pt_buf(13) & pt_buf(14) & pt_buf(15);
	
		if w = '1' then
			pt_buf(to_integer(unsigned(index))) <= inByte;
		end if;
		
	end if;
	
END PROCESS;

end Behavioral;






