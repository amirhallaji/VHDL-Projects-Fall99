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
        dout    : OUT std_logic_vector(31 DOWNTO 0)
    );
    END COMPONENT;

    SIGNAL clk_t, nrst_t             : std_logic := '0';
    SIGNAL sham_t                    : std_logic_vector(4 DOWNTO 0);
    SIGNAL shty_t                    : std_logic_vector(1 DOWNTO 0);
    SIGNAL sin_t, dir_t, sout_t      : std_logic;
    SIGNAL din_t, dout_t             : std_logic_vector(31 DOWNTO 0);

    BEGIN

        ---------------------
        --- INSTANTIATION----
        ---------------------

        SH_INS : shifter PORT MAP(din_t, sham_t, shty_t, sin_t, clk_t, dir_t, nrst_t, sout_t, dout_t);

        ---------------------
        --Input assignments--
        ---------------------
        clk_t <= NOT clk_t AFTER 5 ns;
        din_t <= X"07";
        sham_t <= X"00" AFTER 10 ns  ;
        shty_t <= B"00", B"01" AFTER 20 ns, B"10" AFTER 30 ns, B"11" AFTER 40 ns;
        dir_t <= '0', '1' AFTER 50 ns; 
END test;