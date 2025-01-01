----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2024 10:55:56
-- Design Name: 
-- Module Name: test_fifo - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_fifo is
--  Port ( );
end test_fifo;

architecture Behavioral of test_fifo is

COMPONENT fifo_generator_0 IS
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    prog_full_thresh : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    prog_full : OUT STD_LOGIC
  );
END component;


constant clk_period : time:=5 ns;
signal clk_s: std_logic;
signal srst_s: std_logic;
signal din_s: std_logic_vector(7 DOWNTO 0);
signal wr_en_s: std_logic;
signal rd_en_s: std_logic;
signal prog_full_thresh_s: std_logic_vector(9 DOWNTO 0);
signal dout_s: std_logic_vector(7 DOWNTO 0);
signal full_s: std_logic;
signal empty_s: std_logic;

 

begin

 fifo_generator:fifo_generator_0 port map (
 clk=>clk_s,
 srst=>srst_s,
 din=>din_s,
 wr_en=>wr_en_s,
 rd_en=>rd_en_s,
 prog_full_thresh=>prog_full_thresh_s,
 dout=>dout_s,
 full=>full_s,
 empty=>empty_s);  
 
 
clk_process: process
begin 
    clk_s<='0';
    wait for clk_period/2;
    clk_s<='1';
    wait for clk_period/2;
end process;



fifo_process :process
begin 

    
    
    srst_s<='0';
    din_s<=(others=>'0');
      wr_en_s <= '0';
      rd_en_s <= '0';
      prog_full_thresh_s <= "0000000000";
      wait for clk_period*2;
      srst_s <= '0';
      wait for clk_period*2;
      srst_s<='1';
      
      if (full_s='1' and empty_s='1') then
        wait for clk_period*10;
      end if;  
      
      
     
      
      wr_en_s <= '1';
      wait until (clk_s ='1');
      wait for 2 ns;
	  din_s <= x"AA";		
	  wait for clk_period;
	  din_s <= x"04";	
	  wait for clk_period;
	  din_s <= x"05";	
	  wait for clk_period;
	  din_s <= x"06";	
  	  wait for clk_period;
	  din_s <= x"07";
	  wait for clk_period;	
	  wr_en_s <= '0';	
	  wait for clk_period;
	  rd_en_s <= '1';
	  wait for clk_period*20;
	  rd_en_s <= '0';
	  wait for clk_period*20;
     --wait for clk_period_rd*10;
     
      wait;
   end process;


end Behavioral;
