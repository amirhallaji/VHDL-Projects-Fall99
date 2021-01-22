LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE types IS  
    TYPE imageType IS ARRAY (0 TO 3000010) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    TYPE headerType  IS ARRAY (0 TO 53) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
END types;

PACKAGE BODY types IS
END types;

ENTITY rotate IS 
    PORT(
        init                :IN STD_LOGIC;
        degree              :IN INTEGER RANGE 3 DOWNTO 0;
        input_width         :IN INTEGER RANGE 2047 DOWNTO 0;
        input_height        :IN INTEGER RANGE 2047 DOWNTO 0;
        input_image         :IN imageType;

        output_image        :OUT imageType;
        output_width        :OUT INTEGER RANGE 2047 DOWNTO 0;
        output_height       :OUT INTEGER RANGE 2047 DOWNTO 0
    );
END rotate;

ARCHITECTURE amir_alireza OF rotate IS

BEGIN
    PROCESS
    
    VARIABLE a, b        :INTEGER;
    VARIABLE x0, y0      :INTEGER;
    VARIABLE xx, yy      :INTEGER;
    VARIABLE sinf, cosf  :INTEGER;

    BEGIN

    END PROCESS;

END amir_alireza;
