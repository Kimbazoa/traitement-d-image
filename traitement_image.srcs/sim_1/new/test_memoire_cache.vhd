----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2024 10:10:46
-- Design Name: 
-- Module Name: test_memoire_cache - Behavioral
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
use std.textio.all;
use ieee.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_memoire_cache is
--  Port ( );
end test_memoire_cache;

architecture Behavioral of test_memoire_cache is

component memoire_cache
port (
    entre: in std_logic_vector(7 downto 0);
    sortie: out std_logic_vector(7 downto 0);
    clk : in std_logic;
    reset: in std_logic; 
    enable: in std_logic );
end component memoire_cache;



constant clk_period : time:=5 ns;
  signal I1 : std_logic_vector (7 downto 0);
  signal CLK : std_logic;
  signal O1 : std_logic_vector (7 downto 0); 
  signal DATA_AVAILABLE : std_logic;
  signal reset_s: std_logic;
  signal enable_s: std_logic;



begin


  mem_cache: memoire_cache port map (
  entre=> I1,
  sortie=> O1,
  clk=>CLK,
  reset=>reset_s,
  enable=>enable_s
  );
  
clock: process
begin 
CLK<= '0';
wait for clk_period; 
CLK<='1';
wait for clk_period;
end process; 

on_mem: process 
begin
reset_s<= '1';
enable_s<= '0';
wait for 100 ns;
reset_s<='0';
enable_s<='1';
wait;
end process;


 p_read : process
  FILE vectors : text;
  variable Iline : line;
  variable I1_var :std_logic_vector (7 downto 0);
 
    begin
	DATA_AVAILABLE <= '0';
    file_open (vectors,"C:\Users\noliv\traitement_image\Lena128x128g_8bits.dat", read_mode);
    
    while not endfile(vectors) loop
      readline (vectors,Iline);
      read (Iline,I1_var);
                
      I1 <= I1_var;
	  DATA_AVAILABLE <= '1';
	  wait for 10 ns;
    end loop;
    DATA_AVAILABLE <= '0';
    wait for 10 ns;
    file_close (vectors);
    wait;
 end process;

p_write: process
  file results : text;
  variable OLine : line;
  variable O1_var :std_logic_vector (7 downto 0);
    
    begin
    file_open (results,"C:\Users\noliv\traitement_image\Lena128x128g_8bits_r.dat", write_mode);
    wait for 10 ns;
    wait until DATA_AVAILABLE = '1';

    while not DATA_AVAILABLE ='1' loop
      write (Oline, O1, right, 2);
      writeline (results, Oline);
      wait for 10 ns;  
    end loop;
    file_close (results);
    wait;
 end process;
--Instancier composant filtre à place de la simple recopie entre I1 vers sortie O1 (top)
--O1 <= I1;

end Behavioral;
