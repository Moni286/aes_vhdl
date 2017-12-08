----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:52:27 10/27/2017 
-- Design Name: 
-- Module Name:    fpga_impl - Behavioral 
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

entity fpga_impl is
    Port ( inBit : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           outBit : out  STD_LOGIC;
			  led_signals : out STD_LOGIC_VECTOR(2 downto 0));
end fpga_impl;

architecture Behavioral of fpga_impl is

COMPONENT control is
	Port (
		clk : IN STD_LOGIC;
		byte_recvd: IN STD_LOGIC;
		rx_byte : IN STD_LOGIC_VECTOR(7 downto 0);
		enc_done : IN STD_LOGIC;
		send_done : IN STD_LOGIC;
		tx_active : IN STD_LOGIC;
		key_w : OUT STD_LOGIC;
		pt_w : OUT STD_LOGIC;
		index : OUT STD_LOGIC_VECTOR (3 downto 0);
		enc_reset : OUT STD_LOGIC;
		ct_w : OUT STD_LOGIC;
		o_state : OUT STD_LOGIC_VECTOR(2 downto 0);
		send : OUT STD_LOGIC
	);
end COMPONENT control;

COMPONENT pt_buffer is
    Port ( inByte : in  STD_LOGIC_VECTOR (7 downto 0);
           w : in  STD_LOGIC;
			  index : in STD_LOGIC_VECTOR (3 downto 0);
			  clk : in STD_LOGIC;
           pt : out  STD_LOGIC_VECTOR (127 downto 0)
			 );			  
end COMPONENT pt_buffer;

COMPONENT ct_buf is
    Port ( ct : in  STD_LOGIC_VECTOR (127 downto 0);
           w : in  STD_LOGIC;
			  clk : in STD_LOGIC;
			  index : in STD_LOGIC_VECTOR (3 downto 0);
           ct_byte : out  STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT ct_buf;

COMPONENT UART_TX is
  generic (
    g_CLKS_PER_BIT : integer := 87     -- Needs to be set correctly
    );
  port (
    i_Clk       : in  std_logic;
    i_TX_DV     : in  std_logic;
    i_TX_Byte   : in  std_logic_vector(7 downto 0);
    o_TX_Active : out std_logic;
    o_TX_Serial : out std_logic;
    o_TX_Done   : out std_logic
    );
end COMPONENT UART_TX;

COMPONENT UART_RX is
  generic (
    g_CLKS_PER_BIT : integer := 87 -- Needs to be set correctly
    );
  port (
    i_Clk       : in  std_logic;
    i_RX_Serial : in  std_logic;
    o_RX_DV     : out std_logic;
    o_RX_Byte   : out std_logic_vector(7 downto 0)
    );
end COMPONENT UART_RX;

COMPONENT toplevel is
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
			  -- r : out std_logic_vector(3 downto 0);
           originalKey : in  STD_LOGIC_VECTOR (127 downto 0);
           plaintext : in  STD_LOGIC_VECTOR (127 downto 0);
           ciphertext : out  STD_LOGIC_VECTOR (127 downto 0);
			  done : out STD_LOGIC);
end COMPONENT toplevel;

signal pt_write : STD_LOGIC;
signal key_write : STD_LOGIC;

signal byte_recvd : STD_LOGIC;
signal rx_byte : STD_LOGIC_VECTOR(7 downto 0);
signal enc_done : STD_LOGIC;
signal send_done : STD_LOGIC;
signal key_w : STD_LOGIC;
signal pt_w : STD_LOGIC;
signal index : STD_LOGIC_VECTOR(3 downto 0);
signal enc_reset : STD_LOGIC;
signal out_w : STD_LOGIC;
signal state : STD_LOGIC_VECTOR(2 downto 0);
signal send : STD_LOGIC;
signal tx_active : STD_LOGIC;

signal pt : STD_LOGIC_VECTOR(127 downto 0);
signal key : STD_LOGIC_VECTOR(127 downto 0);
signal ct : STD_LOGIC_VECTOR(127 downto 0);

signal ct_byte : STD_LOGIC_VECTOR(7 downto 0);

begin

	led_signals <= state;

	recv: UART_RX PORT MAP(clk, inBit, byte_recvd, rx_byte);
	
	ctrl : control PORT MAP (clk, byte_recvd, rx_byte, 
								enc_done, send_done, tx_active, key_w, pt_w,
								index, enc_reset, out_w, state, send);

	pt_buff : pt_buffer PORT MAP(rx_byte, pt_w, index, clk, pt);
	key_buff : pt_buffer PORT MAP(rx_byte, key_w, index, clk, key);
	
	encrypt : toplevel PORT MAP(clk, enc_reset, key, pt, ct, enc_done);
	
	ct_buff : ct_buf PORT MAP(ct, out_w, clk, index, ct_byte);
	 
	transmit : UART_TX PORT MAP(clk, send, ct_byte, tx_active, outBit, send_done);
	
end Behavioral;









