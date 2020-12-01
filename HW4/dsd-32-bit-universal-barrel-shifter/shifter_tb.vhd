LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY shifter_tb IS
END shifter_tb;

ARCHITECTURE test of shifter_tb IS
    COMPONENT shifter IS

    PORT(
        clk     : IN std_logic;
        nrst    : IN std_logic;
        din     : IN std_logic_vector(31 DOWNTO 0);
        sin     : IN std_logic;
        sham    : IN std_logic_vector(4 DOWNTO 0);
        shty    : IN std_logic_vector(1 DOWNTO 0);
        dir     : IN std_logic;
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

        SH_INS : shifter PORT MAP(clk_t, nrst_t, din_t, sin_t, sham_t, shty_t, dir_t, sout_t, dout_t);

        ---------------------
        --Input assignments--
        ---------------------
        clk_t <= NOT clk_t AFTER 5 ns;
        nrst_t <= '1' AFTER 9 ns;
        sin_t <= '0';
        din_t <=  X"e0000007";
        sham_t <= "00010" AFTER 8 ns  ;
        shty_t <= "00", "01" AFTER 32 ns, "10" AFTER 44 ns, "11" AFTER 56 ns;
        dir_t <= '0', '1' AFTER 68 ns; 
END test;