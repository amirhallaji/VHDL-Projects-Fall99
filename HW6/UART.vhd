LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY uart IS 
    PORT(
        clk:         IN std_logic;
        ntrst:       IN std_logic;
        rx:          IN std_logic;
        start:       IN std_logic;
        data_in:     IN std_logic_vector(7 DOWNTO 0);
        baud:        IN std_logic_vector(7 DOWNTO 0);

        tx:          OUT std_logic;
        data_out:    OUT std_logic_vector(7 DOWNTO 0);
        data_ready:  OUT std_logic
    );
END uart;

ARCHITECTURE amir_alireza IS 

END amir_alireza;