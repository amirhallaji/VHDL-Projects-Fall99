LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY uart IS
    PORT (
        clk : IN STD_LOGIC;
        ntrst : IN STD_LOGIC;
        rx : IN STD_LOGIC;
        start : IN STD_LOGIC;
        data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        baud : IN STD_LOGIC_VECTOR(7 DOWNTO 0);

        tx : OUT STD_LOGIC;
        data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        data_ready : OUT STD_LOGIC := '0'
    );
END uart;

ARCHITECTURE amir_alireza OF uart IS

    SIGNAL parity : STD_LOGIC;
    SIGNAL parity_in : STD_LOGIC;
    SIGNAL baud_int : INTEGER;

BEGIN

    baud_int <= to_integer(unsigned(baud));

    PROCESS (clk)

        VARIABLE clk_ctr : INTEGER;
        VARIABLE i : INTEGER;
        VARIABLE bool_p2s : INTEGER := 1;
        VARIABLE bool_s2p : INTEGER := 1;
        VARIABLE s2p : INTEGER := 1;
        VARIABLE p2s : INTEGER := 1;

    BEGIN

        clk_ctr := clk_ctr + 1;

        IF ntrst = '0' THEN

            data_ready <= '0';

            IF start /= '1' THEN
                tx <= '1';

            ELSE
                -----------------Parallel To Serial-----------------

                IF bool_p2s = 1 THEN

                    bool_p2s := 0;
                    tx <= '0';
                    i := 0;
                    parity <= '0';

                END IF;

                IF (clk_ctr MOD baud_int = 0) AND p2s = 1 THEN

                    IF i < 8 THEN

                        IF data_in(i) = '1' THEN
                            parity <= NOT parity;
                        END IF;

                        tx <= data_in(i);

                    END IF;

                    IF i = 8 THEN -- 9th baud

                        tx <= parity;

                    END IF;

                    IF i = 10 THEN -- 11th baud

                        IF rx = '1' THEN
                            p2s := 0;

                        END IF;

                        bool_p2s := 1;

                    END IF;

                    i := i + 1;

                END IF;

            END IF;
            IF rx = '0' THEN
                -----------------Serial To Parallel-----------------

                IF bool_s2p = 1 THEN
                    bool_s2p := 0;
                    i := 0;
                    parity <= '0';

                END IF;

                IF (clk_ctr MOD baud_int = 0) AND s2p = 1 THEN

                    IF i < 8 THEN

                        IF rx = '1' THEN
                            parity <= NOT parity;
                        END IF;

                        data_out(i) <= rx;

                    END IF;

                    IF i = 8 THEN -- 9th baud
                        parity_in <= rx;
                    END IF;

                    IF i = 10 THEN -- 11th baud

                        IF parity = parity_in THEN
                            data_ready <= '1';
                            s2p := 0;
                        ELSE
                            tx <= '0';
                        END IF;

                        bool_s2p := 1;

                    END IF;

                    i := i + 1;

                END IF;

            END IF;
        END IF;

    END PROCESS;
END amir_alireza;