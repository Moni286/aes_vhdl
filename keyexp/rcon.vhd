----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:32:11 10/08/2017 
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

entity rcon is port (
	clk : in  STD_LOGIC;
	i   : in  STD_LOGIC_VECTOR (3 downto 0);
	win : in  STD_LOGIC_VECTOR (31 downto 0);
	wout: out STD_LOGIC_VECTOR (31 downto 0));
end rcon;

architecture Behavioral of rcon is
	COMPONENT rbox IS PORT( 
		clk : IN STD_LOGIC;
		d : IN   STD_LOGIC_VECTOR (3 downto 0);
		q : OUT  STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT rbox;

	COMPONENT xor8 IS PORT ( 
		d0 : in  STD_LOGIC_VECTOR (7 downto 0);
		d1 : in  STD_LOGIC_VECTOR (7 downto 0);
		q : out  STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT xor8;
	
	SIGNAL rconi : STD_LOGIC_VECTOR(7 downto 0);
begin
	rconbox: rbox port map(clk, i, rconi);
	rconiXORinput: xor8 port map(rconi, win(31 downto 24), wout(31 downto 24));
	
	wout(23 downto 0) <= win(23 downto 0);

end Behavioral;

