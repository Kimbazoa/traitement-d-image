----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2024 08:22:59
-- Design Name: 
-- Module Name: Compteur126 - Behavioral
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

entity Compteur126 is
 Port (clk   : in  STD_LOGIC;  -- Signal d'horloge
        reset : in  STD_LOGIC;  -- Réinitialisation
        enable: in  STD_LOGIC;  -- Activation
        count : out STD_LOGIC_VECTOR(7 downto 0) -- Sortie du compteur (7 bits)
     );
end Compteur126;

architecture Behavioral of Compteur126 is
constant clk_period: time:=5ns;
signal compteur_interne : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal clk_s: std_logic;
begin



clock: process
begin 
clk_s <= '0';
wait for clk_period; 
clk_s<='1';
wait for clk_period;
end process; 

 process(clk, reset)
    begin
        if reset = '1' then
            compteur_interne <= (others => '0'); -- Réinitialisation à 0
        elsif rising_edge(clk) then
            if enable = '1' then
                if compteur_interne = "10000001" then -- Si compteur atteint 126
                    compteur_interne <= (others => '0'); -- Réinitialisation à 0
                else
                    compteur_interne <= compteur_interne + 1; -- Incrémentation
                end if;
            end if;
        end if;
    end process;

    count <= compteur_interne; -- Sortie du compteur

end Behavioral;
