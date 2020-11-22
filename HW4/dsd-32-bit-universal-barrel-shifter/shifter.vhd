LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY alu IS
    PORT (
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
END alu;

ARCHITECTURE behavioral OF alu IS

    SIGNAL temp         : std_logic_vector(31 DOWNTO 0);
    SIGNAL sout_sig     : std_logic;
    SIGNAL sham_int     : integer;
    SIGNAL zero         : STD_LOGIC_VECTOR (31 DOWNTO 0) :=  "00000000000000000000000000000000";
	SIGNAL one          : STD_LOGIC_VECTOR (31 DOWNTO 0) :=  "11111111111111111111111111111111";

BEGIN

    sham_int <= to_integer(unsigned(sham));

    PROCESS (clk)

    BEGIN
        IF clk = '1' THEN
            IF nrst = '0' THEN
                temp <= (OTHERS => '0');

            ELSE
                IF shty = "00" THEN     -- logical
                    IF dir = '0' THEN
                        sout_sig <= temp(32-sham_int);
                        IF sin = '0' THEN
                            temp <= din(31 - sham_int DOWNTO 0) & zero(sham_int-1 DOWNTO 0);
                        ELSE
                            temp <= din(31 - sham_int DOWNTO 0) & one(sham_int-1 DOWNTO 0);
                        END IF;
                    ELSE
                        sout_sig <= temp(sham_int-1);
                        IF sin = '0' THEN
                            temp <= zero(sham_int-1 DOWNTO 0) & din(31 DOWNTO sham_int);
                        ELSE
                            temp <= one(sham_int-1 DOWNTO 0) & din(31 DOWNTO sham_int);
                        END IF;
                    END IF;

                ELSIF shty = "01" THEN  -- arithmetic
                    IF dir = '0' THEN
                        sout_sig <= temp(32-sham_int);
                        IF sin = '0' THEN
                            temp <= din(31 - sham_int DOWNTO 0) & zero(sham_int-1 DOWNTO 0);
                        ELSE
                            temp <= din(31 - sham_int DOWNTO 0) & one(sham_int-1 DOWNTO 0);
                        END IF;
                    ELSE
                        sout_sig <= temp(sham_int-1);
                        IF din(31) = '0' THEN
                            temp <= zero(sham_int-1 DOWNTO 0) & din(31 DOWNTO sham_int);
                        ELSE
                            temp <= one(sham_int-1 DOWNTO 0) & din(31 DOWNTO sham_int);
                        END IF;
                    END IF;

                ELSIF shty = "10" THEN  -- circular
                    IF dir = '0' THEN
                        sout_sig <= temp(32-sham_int);
                        temp <= din(31 - sham_int DOWNTO 0) & din(sham_int-1 DOWNTO 0);
                    ELSE
                        sout_sig <= temp(sham_int-1);
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