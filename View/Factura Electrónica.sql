SELECT 
CAB."DocNum", 
CAB."DocDate",
CAB."CardName", 
CAB."NumAtCard", 
CAB."TaxDate", 
CAB."DocDueDate", 
CAB."FolioPref", 
CAB."FolioNum", 
CAB."Comments", 
DET."TaxCode",
SN."CardType",
SN."Street",
SN."City",
SN."Notes",
SN."LicTradNum",
SN."Block",
CAST(DET."LineNum" AS Numeric) AS "LineNum",
DET."ItemCode" AS "ItemCode",
IFNULL(LOTE."Quantity",DET."Quantity") AS "CANTIDAD",
DET."Price", 
DET."DocEntry",
(CASE WHEN CAB."DocType" = 'S' THEN DET."LineTotal" ELSE (CASE WHEN LOTE."BatchNum" IS NULL THEN DET."LineTotal" ELSE ((DET."LineTotal" / DET."Quantity") * LOTE."Quantity") END)END) AS "LineTotal",
(CASE WHEN DET."TaxCode" = 'IVA_EXE' THEN '1' ELSE '' END) AS "IEXEN",
DET."unitMsr",
DET."U_GAL_REG_TEMP" AS "TEMP_ALMAC",
RPAD(LOTE."BatchNum",40,' ') AS "LOTE",
DET."Dscription"

FROM OINV AS CAB INNER JOIN INV1 AS DET	ON DET."DocEntry" = CAB."DocEntry"
LEFT JOIN IBT1 AS LOTE ON DET."ObjType" = LOTE."BaseType" AND DET."DocEntry" = LOTE."BaseEntry" AND DET."LineNum" = LOTE."BaseLinNum" AND LOTE."Quantity" > 0
INNER JOIN View_SNxDoc AS SN ON CAB."CardCode" = SN."CardCode"
		
WHERE CAB."DocEntry" = 235