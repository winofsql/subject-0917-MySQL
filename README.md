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
    ROUND(( SELECT AVG(給与) FROM 社員マスタ )) AS 平均給与
```
