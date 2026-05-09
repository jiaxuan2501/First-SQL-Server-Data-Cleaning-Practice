--This project is to practice data cleaning using SQL
------------------------------------------------------
--Query all data in the current table
SELECT * FROM Housing

--Clean Up Date Type in SaleDate Column
ALTER TABLE Housing
ADD Sale_Date DATE

UPDATE Housing
SET Sale_Date = CONVERT(DATE,SaleDate)

Select SaleDate,Sale_Date FROM Housing

ALTER TABLE Housing  
Drop Column SaleDate   --Drop Column SaleDate as Sale_Date had replaced it

--Populate Missing Property Data
--------------------------------------------------------------------------
SELECT * FROM Housing 
--WHERE PropertyAddress is NULL
ORDER BY ParcelID

--Finding record with address by using parcelID
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
From Housing a
JOIN Housing b
on a.ParcelID = b.ParcelID 
AND a.UniqueID <> b.UniqueID  --This is to make sure the same row not to be compared
Where a.PropertyAddress is null --Find the null Property Address in the table

--Updating blank property address
UPDATE a
SET a.PropertyAddress = b.PropertyAddress
FROM Housing a
JOIN Housing b
ON a.ParcelID = b.ParcelID
AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL
AND b.PropertyAddress IS NOT NULL

--Double Check if there are still blank property address
SELECT * FROM Housing 
WHERE PropertyAddress IS NULL

--Check duplicate Property Address
Select PropertyAddress, Count(*) AS duplicate_count
FROM Housing
Group By PropertyAddress
Having Count(*) > 1

--Delete duplicate property address
DELETE a 
FROM Housing a
JOIN Housing b
ON a.PropertyAddress = b.PropertyAddress
AND a.UniqueID > b.UniqueID
WHERE a.PropertyAddress IS NOT NULL

--Query all column for final result
SELECT * FROM Housing
