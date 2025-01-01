----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2024 09:41:33
-- Design Name: 
-- Module Name: machine_a_etat - Behavioral
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

entity machine_a_etat is
Port (
    a : in std_logic;
    b : in std_logic;
    S1 : out std_logic;
    S2 : out std_logic;
    clk : in std_logic;
    reset : in std_logic;
    en: in std_logic );
end machine_a_etat;



architecture Behavioral of machine_a_etat is

component compteur
port (
        clk   : in  STD_LOGIC;  -- Signal d'horloge
        reset : in  STD_LOGIC;  -- Signal de remise à zéro
        count : out STD_LOGIC_VECTOR(3 downto 0) -- Sortie du compteur (4 bits)
    );
end component compteur;

    type liste_etat is (etat0,etat1, etat2, etat3, etat4,etat5,etat6);
    constant clk_period: time:= 4ps;
    signal etatx: liste_etat;
    signal clk_s: std_logic;
    signal reset_s: std_logic; 
    signal a_s: std_logic;
    signal w1: std_logic;
    signal w2: std_logic;
    signal r1: std_logic;
    signal r2: std_logic;
    signal count_reg : UNSIGNED(3 downto 0) := (others => '0'); -- Signal interne
    
begin

compt1: compteur port map
(   clk=>clk_s,
    reset=>reset_s
    );
    
    mach: process (clk, reset)
    begin 
    
    if(reset='1') then etatx<=etat1;
    
        case etatx is 
            when etat0 =>
            if  count_reg = 0 
            then
            a_s<='1';
            w1<='0';
            w2<='0';
            r1<='0';
            r2<='0'; 
            
            if count_reg=1 
            then 
            etatx<=etat1;
            end if; 
                  
    end if;
            when etat1=>
            w1<='1';
            w2<='0';
            r1<='0';
            r2<='0'; 
            if count_reg=128
            then etatx<=etat2;
            end if; 
            
            when etat2=>
            w1<='1';
            w2<='0';
            r1<='0';
            r2<='0'; 
            if count_reg=128
            then etatx<=etat3;
            end if;
            
            when etat3=>
            w1<='1';
            w2<='0';
            r1<='1';
            r2<='0'; 
            if count_reg=131
            then etatx<=etat4;
            end if ;
            
            when etat4=>
            w1<='1';
            w2<='1';
            r1<='1';
            r2<='0'; 
            if count_reg=134
            then etatx<=etat5;
            end if ; 
            
             when etat5=>
            w1<='1';
            w2<='1';
            r1<='1';
            r2<='1'; 
            if count_reg=259
            then etatx<=etat6;
            end if ;
            when others =>
            etatx<=etat1;
            
    end case;
    end if;
    end process;

end Behavioral;
