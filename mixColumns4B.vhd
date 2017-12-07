----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:43:06 10/21/2017 
-- Design Name: 
-- Module Name:    mixColumns4B - Behavioral 
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

entity mixColumns4B is
    Port ( d : in  STD_LOGIC_VECTOR (31 downto 0);
           q : out  STD_LOGIC_VECTOR (31 downto 0));
end mixColumns4B;

architecture Behavioral of mixColumns4B is

	COMPONENT x2 PORT (
		d : in  STD_LOGIC_VECTOR (7 downto 0);
		q : out STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT x2;
	
	COMPONENT x3 PORT (
		d : in STD_LOGIC_VECTOR (7 downto 0);
		q : out STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT x3;
	
	signal b0x2 : STD_LOGIC_VECTOR(7 downto 0) := X"00";
	signal b1x2 : STD_LOGIC_VECTOR(7 downto 0) := X"00";
	signal b2x2 : STD_LOGIC_VECTOR(7 downto 0) := X"00";
	signal b3x2 : STD_LOGIC_VECTOR(7 downto 0) := X"00";	
	signal b0x3 : STD_LOGIC_VECTOR(7 downto 0) := X"00";
	signal b1x3 : STD_LOGIC_VECTOR(7 downto 0) := X"00";
	signal b2x3 : STD_LOGIC_VECTOR(7 downto 0) := X"00";
	signal b3x3 : STD_LOGIC_VECTOR(7 downto 0) := X"00";	
begin

b0x2lut: x2 port map(d(31 downto 24), b0x2); 
b1x2lut: x2 port map(d(23 downto 16), b1x2); 
b2x2lut: x2 port map(d(15 downto  8), b2x2); 
b3x2lut: x2 port map(d( 7 downto  0), b3x2); 

b0x3lut: x3 port map(d(31 downto 24), b0x3); 
b1x3lut: x3 port map(d(23 downto 16), b1x3); 
b2x3lut: x3 port map(d(15 downto  8), b2x3); 
b3x3lut: x3 port map(d( 7 downto  0), b3x3); 

	q(31 downto 24) <=  b0x2				xor b1x3					xor d(15 downto 8)	xor  d(7 downto 0); 
	q(23 downto 16) <=  d(31 downto 24)	xor b1x2					xor b2x3					xor  d(7 downto 0); 
	q(15 downto  8) <=  d(31 downto 24)	xor d(23 downto 16)	xor b2x2  				xor  b3x3; 
	q( 7 downto  0) <=  b0x3				xor d(23 downto 16)	xor d(15 downto 8)	xor b3x2; 

end Behavioral;

