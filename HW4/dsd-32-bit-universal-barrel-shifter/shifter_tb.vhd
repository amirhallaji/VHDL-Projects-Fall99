LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY shifter_tb IS
END shifter_tb;

ARCHITECTURE test of shifter_tb IS
    COMPONENT shifter IS

    PORT(
        din     : IN std_logic_vector(31 DOWNTO 0);
        sham    : IN std_logic_vector(4 DOWNTO 0);
        shty    : IN std_logic_vector(1 DOWNTO 0);
        sin     : IN std_logic;
        clk     : IN std_logic;
        dir     : IN std_logic;
        nrst    : IN std_logic;
        sout    : OUT std_logic;
        din     : OUT std_logic_vector(31 DOWNTO 0)
    );
    END COMPONENT;

BEGIN
END test;