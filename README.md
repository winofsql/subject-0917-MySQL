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
