----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:45:23 12/10/2010 
-- Design Name: 
-- Module Name:    compt_decompt - compt_decompt_archi 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compteur is
    Port (
        clk   : in  STD_LOGIC;  -- Signal d'horloge
        reset : in  STD_LOGIC;  -- Signal de remise à zéro
        count : out STD_LOGIC_VECTOR(3 downto 0) -- Sortie du compteur (4 bits)
    );
end compteur;

architecture compteur_archi of compteur is

signal count_reg : UNSIGNED(3 downto 0) := (others => '0'); -- Signal interne
begin

    process(clk, reset)
    begin
        if reset = '1' then
            count_reg <= (others => '0'); -- Remise à zéro du compteur
        elsif rising_edge(clk) then
            count_reg <= count_reg + 1; -- Incrémentation du compteur
        end if;
    end process;

    count <= STD_LOGIC_VECTOR(count_reg); -- Conversion du signal interne en sortie
end compteur_archi;
