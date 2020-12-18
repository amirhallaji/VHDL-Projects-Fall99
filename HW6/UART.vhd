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
    com: PROCESS(clk)

    IF ntrst = '0' THEN

        IF start /= '1' THEN
            tx <= '1';
        ELSE
        --Parallel To Serial
            start <= '0';
            tx <= '0'; 
            WAIT(baud);

            L1: FOR i IN 0 TO 7 LOOP
                tx <= data_in(i);
                WAIT(baud);
            END L1;
            ----------
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
                data_out(i) <= rx;
                WAIT(baud);
            END L2;
            ----------
            WAIT(baud);
            WAIT(baud);
        END IF;
    END IF;

    END PROCESS com;
END amir_alireza;