----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2024 13:36:21
-- Design Name: 
-- Module Name: flipflop - Behavioral
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

entity flipflop is
generic (Bus_width : integer:=8);


Port ( D: in STD_LOGIC_VECTOR (Bus_width-1 downto 0);
       Q : out STD_LOGIC_VECTOR (Bus_width-1 downto 0);
       clk: in std_logic;
       reset: in std_logic;
       enable: in std_logic );
end flipflop;

architecture Behavioral of flipflop is
signal temp: std_logic_vector(7 downto 0); 
 

begin

 
    flip_flop : process (clk)
    begin 
    if (reset= '1') then temp <= (others =>'0');
    elsif (rising_edge(clk))
    then temp <= D;
    end if; 
    end process flip_flop; 
    
    Q <= temp;

end Behavioral;
