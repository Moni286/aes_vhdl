----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:52:01 10/15/2017 
-- Design Name: 
-- Module Name:    sbox16B - Behavioral 
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

entity sbox16B is
    Port ( clk : in  STD_LOGIC;
           d : in  STD_LOGIC_VECTOR (127 downto 0);
           q : out  STD_LOGIC_VECTOR (127 downto 0));
end sbox16B;

architecture Behavioral of sbox16B is
	COMPONENT sbox4B IS PORT ( clk  : in  STD_LOGIC;
		win  : in  STD_LOGIC_VECTOR (31 downto 0);
		wout : out STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT sbox4B;
begin
	sbox4B0: sbox4B port map(clk, d(127 downto 96), q(127 downto 96));
	sbox4B1: sbox4B port map(clk, d( 95 downto 64), q( 95 downto 64));
	sbox4B2: sbox4B port map(clk, d( 63 downto 32), q( 63 downto 32));
	sbox4B3: sbox4B port map(clk, d( 31 downto  0), q( 31 downto  0));

end Behavioral;

