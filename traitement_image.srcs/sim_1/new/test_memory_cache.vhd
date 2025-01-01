----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.10.2024 14:29:35
-- Design Name: 
-- Module Name: MACH1 - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_cache is
--Port ()
end memory_cache;

architecture Behavioral of memory_cache is
    constant clock_period: time:= 4ps; 
    signal data_s: std_logic_vector( 7 downto 0); 
    signal reset_s: std_logic; 
    signal clk_s : std_logic;
    signal Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8 :std_logic_vector(7 downto 0); 
     
     



begin
process memoire_cache

end Behavioral;

