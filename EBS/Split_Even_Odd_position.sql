SELECT RPAD (
          SUM (
               DECODE (MOD (LEVEL, 2), 1, SUBSTR ( :num, LEVEL, 1), 0)
             * POWER (10, TRUNC (LENGTH ( :num) / 2) - TRUNC ( (LEVEL) / 2))),
          ROUND (LENGTH ( :num) / 2))
          odd_number,
       LPAD (
          SUM (
               DECODE (MOD (LEVEL, 2), 0, SUBSTR ( :num, LEVEL, 1), 0)
             * POWER (10, TRUNC (LENGTH ( :num) / 2) - TRUNC ( (LEVEL) / 2))),
          TRUNC (LENGTH ( :num) / 2),
          '0')
          even_number
  FROM DUAL
CONNECT BY LEVEL <= LENGTH ( :num)