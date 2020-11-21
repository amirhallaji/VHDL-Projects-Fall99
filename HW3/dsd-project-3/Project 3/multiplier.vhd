LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_STD.ALL;
ENTITY multiplier IS
    GENERIC (	
        n : integer := 8
    );
    PORT (
        clk         : IN std_logic;
        A, B        : IN std_logic_vector(0 TO n-1);
        result      : OUT std_logic_vector(0 TO (2*n)-1)
    );
END multiplier;
ARCHITECTURE concurrent OF multiplier IS

    TYPE arr1 IS ARRAY (0 TO n-1) OF std_logic_vector(0 TO n-1);
    TYPE arr2 IS ARRAY (0 TO n-1) OF std_logic_vector(0 TO (2*n)-1);

    SIGNAL and_of_bits  : arr1;
    SIGNAL c            : arr2 := (others => (others => '0'));
    SIGNAL partial_sum  : arr2 := (others => (others => '0'));
    SIGNAL temp         : std_logic_vector(0 TO (2*n)-1);

BEGIN

    L1: FOR i IN 0 TO n-1 GENERATE
        L2: FOR j IN 0 TO n-1 GENERATE
            and_of_bits(i)(j) <= A(i) AND B(j);
        END GENERATE L2;
    END GENERATE L1;

    L3: FOR i IN 1 TO n-1 GENERATE
        c(i)(i-1) <= '0';
    END GENERATE L3;


    PROCESS (clk)

        VARIABLE const : integer;

        BEGIN
            IF clk = '1' THEN

                FOR i IN 1 TO n-1 LOOP

                    const := i; 
                    partial_sum(1)(i) <= (and_of_bits(i)(0) XOR and_of_bits(i)(1) XOR c(1)(i-1));

                    FOR j IN i-2 DOWNTO 0 LOOP
                            partial_sum(const - j)(i)   <= (and_of_bits(j)(const-j) XOR partial_sum(const-j-1)(i) XOR c(const-j)(i-1));
                            
                            c(const - j)(i)     <= (and_of_bits(j)(const-j) AND partial_sum(const-j-1)(i)) 
                                                    OR (and_of_bits(j)(const-j) AND c(const-j)(i-1)) 
                                                    OR (partial_sum(const-j-1)(i) AND c(const-j)(i-1));
                        END LOOP;

                END LOOP;


                partial_sum(0)(n-1) <= '0';

                FOR i IN 1 TO n-1 LOOP

                    partial_sum(i-1)(i+n-1) <= partial_sum(i-1)(i+n-2);

                    FOR j IN n DOWNTO i+1 LOOP
                            partial_sum(n-j+i)(i+n-1)   <= (and_of_bits(j-1)(n-j+i) XOR partial_sum(n-j+i-1)(i+n-1) XOR c(n-j+i)(i+n-2));
                            
                            c(n - j)(i)     <= (and_of_bits(j-1)(n-j+i) AND partial_sum(n-j+i-1)(i+n-1)) 
                                                OR (and_of_bits(j-1)(n-j+i) AND c(n-j+i)(i+n-2)) 
                                                OR (partial_sum(n-j+i-1)(i+n-1) AND c(n-j+i)(i+n-2));
                        END LOOP;
                        
                END LOOP;


                temp(0) <= and_of_bits(0)(0);

                FOR i IN 1 TO (2*n)-2 LOOP
                    temp(i) <= partial_sum(n-1)(i);
                END LOOP;

                temp((2*n)-1) <= c(n-1)((2*n)-1);

            END IF;

        END PROCESS;

        result <= A*B;

END concurrent;
