-- DROP VIEW View_SNxDoc
CREATE VIEW View_SNxDoc AS

SELECT 
		SN."CardCode", 
		SN."CardType",
		SN."Notes",
		SN1."Street",
		SN1."City",
		SN."LicTradNum",
		SN1."Block",
		SN."CardName" 
	FROM 
		OCRD AS SN LEFT JOIN
		CRD1 AS SN1 ON SN."CardCode" = SN1."CardCode" 
		
	WHERE 
		SN."CardType" = 'C' AND 
		SN1."LineNum" = 0
		
	GROUP BY
	SN."CardCode", 
		SN."CardType",
		SN."Notes",
		SN1."Street",
		SN1."City",
		SN."LicTradNum",
		SN1."Block",
		SN."CardName"