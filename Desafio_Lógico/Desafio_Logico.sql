-- Modelo de recuperção simples usando banco de AdventureWorks para Desafio DIO
--
  SELECT 
	
	P.ProductID
	,P.Name                   
	,PM.Name		AS MODEL
	,PC.Name                        AS category    
	,PMD.ProductDescriptionID
	,P.ListPrice
	,P.Color
	,P.ProductNumber
	,P.StandardCost
	,P.ProductNumber 
	,P.Size
	,P.SellStartDate
	,P.SellEndDate
	,P.Weight
	,P.ProductModelID
	,P.DiscontinuedDate      
	,PC.ProductCategoryID
	,P.rowguid
	,P.ModifiedDate
	

FROM SalesLT.Product									   AS P                 with(nolock)           

left join SalesLT.ProductCategory                         AS PC                 with(nolock)             
	on	P.ProductCategoryID = PC.ProductCategoryID

left join SalesLT.ProductModelProductDescription		  as  PMD    with(nolock) 
	on P.ProductModelID = PMD.ProductModelID

left join SalesLT.ProductModel								as PM with(nolock) 
	on P.ProductModelID = PM.ProductModelID

Left join SalesLT.ProductDescription						as PD with(nolock) 
	on PMD.ProductDescriptionID = PD.ProductDescriptionID

WHERE  ProductID IS NOT NULL 

ORDER BY ProductID ASC





---- Modelo  2


  SELECT 
     C.ProductCategoryID
    ,PC.Name AS Category
    ,PM.Name AS Model
    ,AVG(P.ListPrice) AS AvgListPrice
    ,AVG(P.StandardCost) AS AvgStandardCost
    ,COUNT(P.ProductID) AS ProductCount

FROM SalesLT.Product AS P WITH(NOLOCK)

LEFT JOIN SalesLT.ProductCategory AS PC WITH(NOLOCK) 
    ON P.ProductCategoryID = PC.ProductCategoryID

LEFT JOIN SalesLT.ProductModel AS PM WITH(NOLOCK) 
    ON P.ProductModelID = PM.ProductModelID

LEFT JOIN SalesLT.ProductModelProductDescription AS PMD WITH(NOLOCK) 
    ON P.ProductModelID = PMD.ProductModelID

LEFT JOIN SalesLT.ProductDescription AS PD WITH(NOLOCK) 
    ON PMD.ProductDescriptionID = PD.ProductDescriptionID

WHERE P.ProductID IS NOT NULL

GROUP BY 
    PC.ProductCategoryID,
    PC.Name,
    PM.Name

HAVING AVG(P.ListPrice) > 100 -- Filtra categorias com preço médio acima de 100

ORDER BY PC.ProductCategoryID ASC;
