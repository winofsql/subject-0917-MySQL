# subject-0917-mysql

## my.ini
```
sql_mode=NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION,PIPES_AS_CONCAT
```

## インラインビュー
```sql
SELECT * FROM
 ( 
    SELECT 得意先コード,得意先名,担当者,氏名,住所１,住所２,締日,締日区分,支払日 FROM 得意先マスタ 
    LEFT OUTER JOIN 社員マスタ
    ON 得意先マスタ.担当者 = 社員マスタ.社員コード
 )
 AS 得意先データ
```

## データ収集( サブクエリリスト )
```sql
SELECT
    ( SELECT MAX(給与) FROM 社員マスタ ) AS 最高給与,
    ( SELECT MIN(給与) FROM 社員マスタ ) AS 最低給与,
    ( SELECT AVG(給与) FROM 社員マスタ ) AS 平均,
    ROUND(( SELECT AVG(給与) FROM 社員マスタ )) AS 平均給与,
    ( SELECT SUM(給与) FROM 社員マスタ ) AS 給与合計,
    ( SELECT COUNT(*) FROM 社員マスタ ) AS 社員数,
    ( SELECT COUNT(*) FROM 商品マスタ ) AS 商品数,
    CURDATE() AS 当日日付
```
**※ [ROUND 関数](https://dev.mysql.com/doc/refman/5.6/ja/mathematical-functions.html#function_round)、CURDATE 関数**

## 条件内サブクエリ
```sql
SELECT * FROM 社員マスタ
    WHERE 給与 >= ( SELECT AVG(給与) FROM 社員マスタ )
```

## NULL が含まれる演算( [IFNULL 関数](https://dev.mysql.com/doc/refman/5.6/ja/control-flow-functions.html#function_ifnull) )
```sql
SELECT 給与 + IFNULL(手当,0) AS 支給額 FROM 社員マスタ
```

## ストアドファンクション
```sql
CREATE OR REPLACE FUNCTION SB( PARAM_NUM int ) RETURNS VARCHAR(2)
BEGIN

    DECLARE WK_NAME VARCHAR(2);
    IF PARAM_NUM = 0 THEN
        SET WK_NAME = '男性';
    ELSE
        SET WK_NAME = '女性';
    END IF;

    RETURN WK_NAME;

END;
```
