
DROP FUNCTION IF EXISTS `max_number_on_range`;

DELIMITER $$
CREATE
FUNCTION `max_number_on_range`(rango VARCHAR(255))
  RETURNS INT(11)
DETERMINISTIC
  COMMENT 'le das un rango de varchar como por ejempo \"127-115\" y te devuelve el mayor de los dos numeros del rango\'115\' y si no es un rango devuelve el numero simple.'
  BEGIN

    SET @locate = LOCATE("-", rango);
    SET @number1 = (SELECT CAST(`rango` AS UNSIGNED));


    IF LOCATE("-", rango) > 0
    THEN
      SET @locateP = LOCATE("-", rango);
      SET @length = LENGTH(rango);
      SET @lengthQ = @length - @locateP;
      SET @number = RIGHT(rango, @lengthQ);
      SET @number2 = (SELECT CAST(@number AS UNSIGNED));


      IF (@number1 > @number2)
      THEN
        SET @number = @number1;
      ELSE
        SET @number = @number2;
      END IF;

    ELSE
      SET @number = @number1;
    END IF;

    RETURN @number;
  END $$
DELIMITER ;
