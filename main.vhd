----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:34:46 10/20/2017 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
    Port ( pt : in  STD_LOGIC_VECTOR (127 downto 0);
           en : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           key : in  STD_LOGIC_VECTOR (127 downto 0);
           ct : in  STD_LOGIC_VECTOR (127 downto 0));
end main;

architecture Behavioral of main is



begin


end Behavioral;

