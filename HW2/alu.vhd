LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY alu IS
    PORT (
        A       : IN std_logic_vector(31 DOWNTO 0);
        B       : IN std_logic_vector(31 DOWNTO 0);
        cin     : IN std_logic;
        sin     : IN std_logic;
        func    : IN std_logic_vector(3 DOWNTO 0);
        cout    : OUT std_logic;
        sout    : OUT std_logic;
        OV      : OUT std_logic;
        Z       : OUT std_logic_vector(31 DOWNTO 0)
    );
END alu;
ARCHITECTURE behavioral OF alu IS
    SIGNAL temp     :   std_logic_vector(31 DOWNTO 0);
    SIGNAL cout_sig :   std_logic;
BEGIN
    PROCESS (clk)
    BEGIN
        IF clk = '1' THEN
            IF nrst = '0' THEN
                temp <= (OTHERS => '0');
            ELSE
                IF func = 0000 THEN
                    temp <= -B;                        
                    
                ELSIF func = 0001 THEN
                    temp <= A + B;     

                ELSIF func = 0010 THEN
                    temp <= A XOR B XOR cin ;
                    cout_sig <= (A AND B) OR (A AND cin) OR (B AND cin);

                ELSIF func = 0011 THEN
                    temp <= A + (~B + 1); 
                    
                ELSIF func = 0100 THEN
                    temp <= ~B + 1; 

                ELSIF func = 0101 THEN
                    temp <= ~B;

                ELSIF func = 0110 THEN
                    temp <= A AND B;
                
                ELSIF func = 0111 THEN
                    temp <= A OR B;
                
                ELSIF func = 1000 THEN
                    temp <= A XOR B;
                
                ELSIF func = 1001 THEN
                    temp <= A << 1;

                ELSIF func = 1010 THEN
                    temp <= A | B;

                ELSIF func = 1011 THEN
                    temp <= A | B;
                
                ELSIF func = 1100 THEN
                    temp <= A | B;
                
                ELSIF func = 1101 THEN
                    IF A > B THEN
                        temp <= "00000000000000000000000000000001";
                    ELSE
                        temp <= "00000000000000000000000000000000";
                    END IF;
        
                
                ELSIF func = 1110 THEN
                    IF A < B THEN
                        temp <= "00000000000000000000000000000001";
                    ELSE
                        temp <= "00000000000000000000000000000000";
                    END IF;
                
                ELSIF func = 1111 THEN
                    IF A == B THEN
                        temp <= "00000000000000000000000000000001";
                    ELSE
                        temp <= "00000000000000000000000000000000";
                    END IF;

                END IF;
            END IF;
        END IF;
    END PROCESS;

    dout <= temp;
END behavioral;
                    