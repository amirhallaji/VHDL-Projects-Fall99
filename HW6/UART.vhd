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
        data_ready:  OUT std_logic := '0'
    );
END uart;

ARCHITECTURE amir_alireza OF uart IS 

    SIGNAL parity :std_logic;

BEGIN

    com: PROCESS(clk)
    BEGIN
    IF ntrst = '0' THEN

        IF start /= '1' THEN
            tx <= '1';
        ELSE
        -----------------Parallel To Serial-----------------
            start <= '0';
            tx <= '0'; 
            WAIT(baud);

            parity <= '0';
            L1: FOR i IN 0 TO 7 LOOP
                IF data_in(i) = '1' THEN
                    IF parity = '1' THEN
                        parity <= '0';
                    ELSE
                        parity <= '1';
                    END IF;
                END IF;
                tx <= data_in(i);
                WAIT(baud);
            END L1;
            ----------
            tx <= parity;

            WAIT(baud);
            WAIT(baud);
            IF rx = '0' THEN
                start <= '1';
            END IF;
        END IF;

        --Serial To Parallel
        IF rx = '0' THEN
            rx <= '1';
            
            L2:FOR i IN 0 TO 7 LOOP
                IF data_in(i) = '1' THEN
                    IF parity = '1' THEN
                        parity <= '0';
                    ELSE
                        parity <= '1';
                    END IF;
                END IF;                
            END L2;
            -------------------
            WAIT(baud);
            WAIT(baud);
            IF parity = rx THEN
                data_ready <= '1';
            ELSE
                tx <= '0';
            END IF;
        END IF;
    END IF;

    END PROCESS com;
END amir_alireza;