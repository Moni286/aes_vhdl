----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:32:42 12/08/2017 
-- Design Name: 
-- Module Name:    fullEncrypter - Behavioral 
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

Library UNISIM;
use UNISIM.vcomponents.all;

entity fullEncrypter is
    Port ( plaintext : in  STD_LOGIC_VECTOR (127 downto 0);
           clk : in  STD_LOGIC;
			  clr : in STD_LOGIC;
           roundKey : in  STD_LOGIC_VECTOR (127 downto 0);
			  roundNumber : in STD_LOGIC_VECTOR(3 downto 0);
           ciphertext : out  STD_LOGIC_VECTOR (127 downto 0);
			  fast_clk : out STD_LOGIC);
end fullEncrypter;

architecture Behavioral of fullEncrypter is

COMPONENT encrypt is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           roundNumber : in  STD_LOGIC_VECTOR (3 downto 0);
           roundKey : in  STD_LOGIC_VECTOR (127 downto 0);
           plaintext : in  STD_LOGIC_VECTOR (127 downto 0);
           ciphertext : out  STD_LOGIC_VECTOR (127 downto 0));
end COMPONENT encrypt;

COMPONENT finalRound is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           rkey : in  STD_LOGIC_VECTOR (127 downto 0);
           state : in  STD_LOGIC_VECTOR (127 downto 0);
           ciphertext : out  STD_LOGIC_VECTOR (127 downto 0));
end COMPONENT finalRound;

signal fromRound1 : STD_LOGIC_VECTOR(127 downto 0);
signal fromRound9 : STD_LOGIC_VECTOR(127 downto 0);
signal CLKFX : STD_LOGIC;

begin

-- DCM_SP: Digital Clock Manager
   --         Spartan-6
   -- Xilinx HDL Language Template, version 14.7

   DCM_SP_inst : DCM_SP
   generic map (
      CLKDV_DIVIDE => 2.0,                   -- CLKDV divide value
                                             -- (1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,9,10,11,12,13,14,15,16).
      CLKFX_DIVIDE => 2,                     -- Divide value on CLKFX outputs - D - (1-32)
      CLKFX_MULTIPLY => 5,                   -- Multiply value on CLKFX outputs - M - (2-32)
      CLKIN_DIVIDE_BY_2 => FALSE,            -- CLKIN divide by two (TRUE/FALSE)
      CLKIN_PERIOD => 10.0,                  -- Input clock period specified in nS
      CLKOUT_PHASE_SHIFT => "NONE",          -- Output phase shift (NONE, FIXED, VARIABLE)
      CLK_FEEDBACK => "1X",                  -- Feedback source (NONE, 1X, 2X)
      DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS", -- SYSTEM_SYNCHRNOUS or SOURCE_SYNCHRONOUS
      DFS_FREQUENCY_MODE => "LOW",           -- Unsupported - Do not change value
      DLL_FREQUENCY_MODE => "LOW",           -- Unsupported - Do not change value
      DSS_MODE => "NONE",                    -- Unsupported - Do not change value
      DUTY_CYCLE_CORRECTION => TRUE,         -- Unsupported - Do not change value
      FACTORY_JF => X"c080",                 -- Unsupported - Do not change value
      PHASE_SHIFT => 0,                      -- Amount of fixed phase shift (-255 to 255)
      STARTUP_WAIT => FALSE                  -- Delay config DONE until DCM_SP LOCKED (TRUE/FALSE)
   )
   port map (
      CLK0 => open,         -- 1-bit output: 0 degree clock output
      CLK180 => open,     -- 1-bit output: 180 degree clock output
      CLK270 => open,     -- 1-bit output: 270 degree clock output
      CLK2X => open,       -- 1-bit output: 2X clock frequency clock output
      CLK2X180 => open, -- 1-bit output: 2X clock frequency, 180 degree clock output
      CLK90 => open,       -- 1-bit output: 90 degree clock output
      CLKDV => open,       -- 1-bit output: Divided clock output
      CLKFX => CLKFX,       -- 1-bit output: Digital Frequency Synthesizer output (DFS)
      CLKFX180 => open, -- 1-bit output: 180 degree CLKFX output
      LOCKED => open,     -- 1-bit output: DCM_SP Lock Output
      PSDONE => open,     -- 1-bit output: Phase shift done output
      STATUS => open,     -- 8-bit output: DCM_SP status output
      CLKFB => CLKFX,       -- 1-bit input: Clock feedback input
      CLKIN => clk,       -- 1-bit input: Clock input
      DSSEN => '0',       -- 1-bit input: Unsupported, specify to GND.
      PSCLK => '0',       -- 1-bit input: Phase shift clock input
      PSEN => '0',         -- 1-bit input: Phase shift enable
      PSINCDEC => '0', -- 1-bit input: Phase shift increment/decrement input
      RST => '0'            -- 1-bit input: Active high reset input
   );

PROCESS (CLKFX)
BEGIN
	if rising_edge(CLKFX) then
		if clr = '0' then
			fromRound1 <= plaintext xor fromRound1;
		end if;
	end if;
END PROCESS;

roundsx9 : encrypt PORT MAP(CLKFX, clr, roundNumber, roundKey, fromRound1, fromRound9);
final : finalRound PORT MAP(CLKFX, clr, roundKey, fromRound9, ciphertext);
fast_clk <= CLKFX;
end Behavioral;








