LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.utils.all;


ENTITY rotate_tb IS
END rotate_tb;

ARCHITECTURE test_bench OF rotate_tb IS
    COMPONENT rotate IS 
        PORT(
            degree              :IN INTEGER RANGE 3 DOWNTO 0; -- 0, 90, 180, 270
            input_width         :IN INTEGER := 32;
            input_height        :IN INTEGER := 32;
            input_image         :IN imageType;
    
            output_image        :OUT imageType;
            output_width        :OUT INTEGER RANGE 1023 DOWNTO 0;
            output_height       :OUT INTEGER RANGE 1023 DOWNTO 0
        );
    END COMPONENT;   

    SIGNAL degree_t            :INTEGER;
    SIGNAL input_width_t       :INTEGER;
    SIGNAL input_height_t      :INTEGER;
    SIGNAL input_image_t:      imageType :=  (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27);
    SIGNAL output_image_t:     imageType;
    SIGNAL output_width_t:     :INTEGER;
    SIGNAL output_height_t:    :INTEGER;
    SIGNAL output_image_t:     imageType;

    BEGIN
    u1: rotate PORT MAP(degree_t, input_width_t, input_height_t, input_image_t, output_image_t, output_width_t, output_height_t);

    PROCESS
        BEGIN
            WAIT FOR 5 ns;
            degree_t <= 0;

            WAIT FOR 10 ns;
            degree_t <= 1;

            WAIT FOR 15 ns;
            degree_t <= 2;

            WAIT FOR 20 ns;
            degree_t <= 3;

        WAIT;
    END PROCESS;


END test_bench;

