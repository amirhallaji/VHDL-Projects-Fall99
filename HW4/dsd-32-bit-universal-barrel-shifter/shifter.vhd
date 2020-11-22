LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY shifter IS
    PORT (
        din     : IN std_logic_vector(31 DOWNTO 0);
        sham    : IN std_logic_vector(4 DOWNTO 0);
        shty    : IN std_logic_vector(1 DOWNTO 0);
        sin     : IN std_logic;
        clk     : IN std_logic;
        dir     : IN std_logic;
        nrst    : IN std_logic;
        sout    : OUT std_logic;
        dout     : OUT std_logic_vector(31 DOWNTO 0)
    );
END shifter;

ARCHITECTURE behavioral OF shifter IS

    SIGNAL temp         : std_logic_vector(31 DOWNTO 0);
    SIGNAL sout_sig     : std_logic;

BEGIN
    PROCESS (clk)

        VARIABLE sham_int := to_integer(unsigned(sham));

    BEGIN
        IF clk = '1' THEN
            IF nrst = '0' THEN
                temp <= (OTHERS => '0');

            ELSE
                IF shty = "00" THEN     -- logical
                    IF dir = '0' THEN
                    ELSE
                    END IF;

                ELSIF shty = "01" THEN  -- arithmetic
                    IF dir = '0' THEN
                    ELSE
                    END IF;

                ELSIF shty = "10" THEN  -- circular
                    IF dir = '0' THEN
                        temp <= din(sham_int DOWNTO 0) & din(31 DOWNTO sham_int+1);
                    ELSE
                        temp <= din(sham_int-1 DOWNTO 0) & din(31 DOWNTO sham_int);
                    END IF;

                ELSE                    -- register
                    temp <= din;

                END IF;
            END IF;
        END IF;
    END PROCESS;

    dout <= temp;
    sout <= sout_sig;

END behavioral;
