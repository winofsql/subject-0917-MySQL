SELECT * FROM
 ( 
    SELECT
        得意先コード,
        得意先名,
        担当者,
        氏名,
        REPLACE(住所１,'－','')||REPLACE(住所２,'－','') AS 住所,
        締日,
        締日区分,
        支払日
    FROM 得意先マスタ 
    LEFT OUTER JOIN 社員マスタ
    ON 得意先マスタ.担当者 = 社員マスタ.社員コード
 )
 AS 得意先データ
;
-- 得意先マスタと社員マスタの結合
-- 住所１と住所２の文字列結合( AS で別名を追加 )
-- REPLACE(str,from_str,to_str) で 住所を短く
SELECT
    得意先コード,
    得意先名,
    担当者,
    氏名,
    REPLACE(住所１,'－','')||REPLACE(住所２,'－','') AS 住所,
    締日,
    締日区分,
    支払日
 FROM 得意先マスタ 
 LEFT OUTER JOIN 社員マスタ
 ON 得意先マスタ.担当者 = 社員マスタ.社員コード
;

-- データ収集( サブクエリリスト )
SELECT
    ( SELECT MAX(給与) FROM 社員マスタ ) AS 最高給与,
    ( SELECT MIN(給与) FROM 社員マスタ ) AS 最低給与,
    ( SELECT AVG(給与) FROM 社員マスタ ) AS 平均,
    ROUND(( SELECT AVG(給与) FROM 社員マスタ )) AS 平均給与,
    ( SELECT SUM(給与) FROM 社員マスタ ) AS 給与合計,
    ( SELECT COUNT(*) FROM 社員マスタ ) AS 社員数,
    ( SELECT COUNT(*) FROM 商品マスタ ) AS 商品数,
    CURDATE() AS 当日日付
;
-- 平均給与以上の社員一覧
SELECT * FROM 社員マスタ
    WHERE 給与 >= ( SELECT AVG(給与) FROM 社員マスタ )
;

-- 最も高い給与の社員一覧
SELECT * FROM 社員マスタ
    WHERE 給与 = ( SELECT MAX(給与) FROM 社員マスタ )
;

-- 給与と手当の合算
-- NULL を使った演算は NULL になる
SELECT 給与 + 手当 AS 支給額 FROM 社員マスタ
;

-- 給与と手当の正しい合算
SELECT 給与 + IFNULL(手当,0) AS 支給額 FROM 社員マスタ
;

-- インラインビューで支給額を設定する
SELECT * FROM
 (
    SELECT 社員マスタ.*,給与 + IFNULL(手当,0) AS 支給額 FROM 社員マスタ
 )
 AS 社員データ
;

CREATE OR REPLACE VIEW v_社員マスタ
AS
SELECT 社員マスタ.*,給与 + IFNULL(手当,0) AS 支給額 FROM 社員マスタ
;

-- -- 平均支給額以上の社員一覧
SELECT * FROM v_社員マスタ
    WHERE 支給額 >= ( SELECT AVG(支給額) FROM v_社員マスタ )
;
