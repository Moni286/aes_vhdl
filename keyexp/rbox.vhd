----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:13:13 10/08/2017 
-- Design Name: 
-- Module Name:    rbox - Behavioral 
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

entity rbox is
    Port ( 	clk : in STD_LOGIC;
				d   : in  STD_LOGIC_VECTOR (3 downto 0);
				q   : out  STD_LOGIC_VECTOR (7 downto 0));
end rbox;

architecture Behavioral of rbox is

	type t_rcon is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
	constant rconValues : t_rcon := 
	(X"8D", X"01", X"02", X"04", X"08", X"10", X"20", X"40", X"80", X"1B", X"36", X"6C", X"D8", X"AB", X"4D", X"9A");
	
begin
--	PROCESS(clk)
--	BEGIN
--		q <= rconValues(to_integer(unsigned(d)));
--	END PROCESS;
	q <= rconValues(to_integer(unsigned(d)));
end Behavioral;

