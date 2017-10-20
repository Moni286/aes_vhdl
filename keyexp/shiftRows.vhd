----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:31:09 10/15/2017 
-- Design Name: 
-- Module Name:    shiftRows - Behavioral 
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

entity shiftRows is
    Port ( d : in  STD_LOGIC_VECTOR (127 downto 0);
           q : out  STD_LOGIC_VECTOR (127 downto 0));
end shiftRows;

architecture Behavioral of shiftRows is

begin
	q(127 downto 120) <= d(127 downto 120);	-- b0
	q( 87  downto 80) <= d(119 downto 112);	-- b1
	q( 47 downto  40) <= d(111 downto 104);	-- b2
	q(  7 downto   0) <= d(103 downto  96);	-- b3
	q( 95 downto  88) <= d( 95 downto  88);	-- b4
	q( 55 downto  48) <= d( 87 downto  80);	-- b5
	q( 15 downto   8) <= d( 79 downto  72);	-- b6
	q(103 downto  96) <= d( 71 downto  64);	-- b7
	q( 63 downto  56) <= d( 63 downto  56);	-- b8
	q( 23 downto  16) <= d( 55 downto  48);	-- b9
	q(111 downto 104) <= d( 47 downto  40);	-- b10
	q( 71 downto  64) <= d( 39 downto  32);	-- b11
	q( 31 downto  24) <= d( 31 downto  24);	-- b12
	q(119 downto 112) <= d( 23 downto  16);	-- b13
	q( 79 downto  72) <= d( 15 downto   8);	-- b14
	q( 39 downto  32) <= d(  7 downto   0);	-- b15

end Behavioral;

