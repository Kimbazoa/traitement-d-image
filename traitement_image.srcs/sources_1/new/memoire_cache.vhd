----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2024 09:42:55
-- Design Name: 
-- Module Name: memoire_cache - Behavioral
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

entity memoire_cache is
Port (
    entre: in std_logic_vector(7 downto 0);
    sortie: out std_logic_vector(7 downto 0);
    clk : in std_logic;
    reset: in std_logic; 
    enable: in std_logic );
end memoire_cache;

architecture Behavioral of memoire_cache is

component flipflop
Port ( D: in STD_LOGIC_VECTOR (7 downto 0);
       Q : out STD_LOGIC_VECTOR (7 downto 0);
       clk: in std_logic;
       reset: in std_logic;
       enable: in std_logic );
end component flipflop;

component machine_a_etat
port (
    a : in std_logic;
    b : in std_logic;
    S1 : out std_logic;
    S2 : out std_logic;
    clk : in std_logic;
    reset : in std_logic;
    en: in std_logic );

end component;

component fifo_generator_0
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
  end component fifo_generator_0;
  
  component Compteur126 
  port (clk   : in  STD_LOGIC;  -- Signal d'horloge
        reset : in  STD_LOGIC;  -- Réinitialisation
        enable: in  STD_LOGIC;  -- Activation
        count : out STD_LOGIC_VECTOR(7 downto 0)); -- Sortie du compteur (7 bits));
        
  end component ; 
  
constant clk_period : time:=5 ns;
signal clk_s: std_logic;
signal srst_s: std_logic;
signal din_s: std_logic_vector(7 DOWNTO 0);
signal wr_en_s1: std_logic;
signal rd_en_s1: std_logic;
signal wr_en_s2: std_logic;
signal rd_en_s2: std_logic;
signal prog_full_thresh_s1: std_logic_vector(9 DOWNTO 0);
signal prog_full_thresh_s2: std_logic_vector(9 DOWNTO 0);
signal dout1_s: std_logic_vector(7 DOWNTO 0);
signal dout2_s: std_logic_vector( 7 downto 0);
signal full_s1: std_logic;
signal empty_s1: std_logic;
signal full_s2: std_logic;
signal empty_s2: std_logic;
signal Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8: std_logic_vector(7 downto 0);
signal reset_s : std_logic;
signal enable_s: std_logic;
signal data_av: std_logic;
signal clkcompt1: std_logic;
signal count_s1: std_logic_vector(7 downto 0);
signal enable_s1: std_logic;
signal clkcompt2: std_logic;
signal count_s2: std_logic_vector( 7 downto 0); 
signal enable_s2: std_logic;
signal reset_s1: std_logic; 
signal reset_s2: std_logic;
signal prog_full_s1: std_logic;
signal prog_full_s2: std_logic;
 

type liste_etat is (initialisation, bascules, fifo_1,fifo_2);
signal etat : liste_etat;


begin
compteur1:compteur126 
port map (clk=>clk_s,
reset=>reset_s,
enable=>enable_s1,
count=>count_s1
 
 );




ff1: flipflop
port map (clk=>clk_s,
          reset=>reset_s,
          D=>entre,
          Q=>Q1,
          enable=>enable_s);
          
ff2: flipflop
port map (clk=>clk_s,
          reset=>reset_s,
          D=>Q1,
          Q=>Q2,
          enable=>enable_s);
          
ff3: flipflop
port map (clk=>clk_s,
          reset=>reset_s,
          D=>Q2,
          Q=>Q3,
          enable=>enable_s);

fifo1: fifo_generator_0
port map(clk=>clk_s,
 srst=>reset_s,
 din=>Q3,
 wr_en=>wr_en_s1,
 rd_en=>rd_en_s1,
 prog_full_thresh=> "0010100000",
 dout=>dout1_s,
 full=>full_s1,
 empty=>empty_s1,
 prog_full=>prog_full_s1);
 
compteur2: compteur126
port map ( clk=>clk_s,
reset=>reset_s,
enable=>enable_s2,
count=>count_s2
 
 );
 
ff4: flipflop
port map (clk=>clk_s,
          reset=>reset_s,
          D=>dout1_s,
          Q=>Q4,
          enable=>enable_s);
          
ff5: flipflop
port map (clk=>clk_s,
          reset=>reset_s,
          D=>Q4,
          Q=>Q5,
          enable=>enable_s);
          
ff6: flipflop
port map (clk=>clk_s,
          reset=>reset_s,
          D=>Q5,
          Q=>Q6,
          enable=>enable_s);
          
fifo2: fifo_generator_0
port map(clk=>clk_s,
     srst=>reset_s,
     din=>Q6,
     wr_en=>wr_en_s2,
     rd_en=>rd_en_s2,
     prog_full_thresh=> "0010100000",
     dout=>dout2_s,
     full=>full_s2,
     empty=>empty_s2,
     prog_full=>prog_full_s2);
 
  ff7: flipflop
port map (clk=>clk_s,
          reset=>reset_s,
          D=>dout2_s,
          Q=>Q7,
          enable=>enable_s);
          
ff8: flipflop
port map (clk=>clk_s,
          reset=>reset_s,
          D=>Q7,
          Q=>Q8,
          enable=>enable_s);
          
ff9: flipflop
port map (clk=>clk_s,
          reset=>reset_s,
          D=>Q8,
          Q=>sortie,
          enable=>enable_s);
          
          



          
          
clock: process
begin 
clk_s<= '0';
wait for clk_period/2; 
clk_s<='1';
wait for clk_period/2;
end process;           




mae: process(clk)
begin
 
 
 if (reset_s='1') then
  
    srst_s<='1';
    wr_en_s1<='0';
    wr_en_s1<='0';
    rd_en_s1<='0';
    rd_en_s2<='0';
    etat<= initialisation ; 
 
 elsif rising_edge(clk) then 
 
 case etat is 
    when initialisation =>

    if (reset='1') then etat<= initialisation ;
    elsif rising_edge(clk) then
    
    etat<= bascules; 
     end if;
    when bascules =>
    reset_s1<= '0';
    reset_s1<= '0'; 
    enable_s1<='1';
    enable_s<='1'; 
    
    if count_s1 = "00000100"   
    then etat <= fifo_1 ;
    end if; 
    if count_s1<= "10000000" 
    then etat<=bascules;
    end if ;
    
    if count_s1="10000001" then 
    enable_s2<='1';
    end if; 
    
    if count_s2 = "00000011"   
    then etat <= fifo_2;
    end if; 
    if count_s2<= "10000000" 
    then etat<=bascules;
    end if ;  
    
    when fifo_1 =>
    
    if count_s1= "00000011"
    then 
    --if ( full_s1= '0' and empty_s2= '1') then 
    wr_en_s1<='1'; 
    rd_en_s1<=prog_full_s1;
    end if;
    --end if;
    if count_s1="10000000" then 
    rd_en_s1<='1';
    end if;
    etat<= bascules; 
    if ( wr_en_s1='1' and rd_en_s1='1') then 
    etat<= bascules; 
    end if ; 
    
    
     when fifo_2 =>
    
    if count_s2= "00000011"
    then 
    if ( full_s2= '0' and empty_s2= '1') then 
    wr_en_s2<='1'; 
    rd_en_s2<=prog_full_s1;
    end if;
    if count_s2="10000000" then 
    rd_en_s2<='1';
    end if;
    etat<= bascules; 
    if ( wr_en_s2='1' and rd_en_s2='1') then 
    etat<= bascules; 
    end if ; 

end if;
end case;    
end if; 
end process; 
 
 compteur11: process 
begin 
reset_s1<='1';

enable_s1<='0';

--wait until (rising_edge(clk)); 
wait for 5 ns;
reset_s1<='0';

enable_s1<='1';

wait;
end process;     


end Behavioral;
