LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE packages IS 
    TYPE imageType IS ARRAY (0 TO 47) OF INTEGER RANGE 0 TO 255;
    TYPE headerType IS ARRAY (0 TO 53) OF  INTEGER;
END packages;

PACKAGE BODY packages IS
END packages;

USE work.utils.all;


ENTITY rotate IS 
    PORT(
        init                :IN STD_LOGIC;
        degree              :IN INTEGER RANGE 3 DOWNTO 0; -- 0, 90, 180, 270
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
    PROCESS(init)
    
    VARIABLE a, b                       :INTEGER;
    VARIABLE x0, y0                     :INTEGER;
    VARIABLE xx, yy                     :INTEGER;
    VARIABLE x, y                       :INTEGER;
    VARIABLE sinf, cosf                 :INTEGER;
    VARIABLE temp_image                 :imageType;
    VARIABLE output_width_variable      :INTEGER RANGE 2047 DOWNTO 0;
    VARIABLE output_height_variable     :INTEGER RANGE 2047 DOWNTO 0;

    BEGIN
        IF init = '1' THEN
            x0 := 0.5 * (input_width - 1);
            y0 := 0.5 * (input_height - 1);

            IF degree = 0 THEN -- 0
                sinf := 0;
                cosf := 1;

            ELSIF degree = 1 THEN -- 90
                sinf := 1;
                cosf := 0;
            ELSIF degree = 2 THEN -- 180
                sinf := 0;
                cosf := -1;

            ELSIF degree = 3 THEN -- 270
                sinf := -1;
                cosf := 0;
            END IF;

            FOR x IN 0 TO input_width - 1 LOOP
               
                FOR y IN 0 TO input_height - 1 LOOP
                    a := x - x0;
                    b := y - y0;

                    xx := a * cosf - b * sinf + x0;
                    yy := a * sinf + b * cosf + y0;

                    IF xx >= 0 AND xx < input_width AND yy >= 0 AND yy < input_height THEN
                        temp_image((y * input_height + x) * 3 + 0) := input_image((yy * input_height + xx) * 3 + 0);
                        temp_image((y * input_height + x) * 3 + 1) := input_image((yy * input_height + xx) * 3 + 1); 
                        temp_image((y * input_height + x) * 3 + 2) := input_image((yy * input_height + xx) * 3 + 2); 
                    END IF;
                END LOOP;
            END LOOP;
            output_image <= temp_image;
        END IF;

    END PROCESS;

END amir_alireza;