--Cleaning Data in SQL Queries

SELECT * from 
master.dbo.NashvilleHousing;

--Standardize date format
SELECT SaleDateConverted, Convert(Date,SaleDate) 
from master.dbo.NashvilleHousing;

Alter Table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted=CONVERT(Date,SaleDate)


--Populate Property Address data

SELECT a.parcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from master.dbo.NashvilleHousing a
JOIN master.dbo.NashvilleHousing b
on a.ParcelId=b.ParcelId
and a.[UniqueID]<>b.[UniqueID]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from master.dbo.NashvilleHousing a
JOIN master.dbo.NashvilleHousing b
on a.ParcelId=b.ParcelId
and a.[UniqueID]<>b.[UniqueID]
Where a.PropertyAddress is null

--Breaking out Address into Individual Columns (substring, char index)
SELECT PropertyAddress from 
master.dbo.NashvilleHousing;

SELECT
SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address --The 1 says where to start looking, CHARINDEX says what to look for and provides a #. # is the position it finds the comma. -1 subtracts 1 from that number and removes comma.
, SUBSTRING (PropertyAddress, (CHARINDEX(',', PropertyAddress)+1), LEN(PropertyAddress))--If we removed +1, the second comma would start with comma followed by city name
FROM
master.dbo.NashvilleHousing

Alter Table NashvilleHousing
Add PropertySplitAddress nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress=SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

Alter Table NashvilleHousing
Add PropertySplitCity nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity=SUBSTRING (PropertyAddress, (CHARINDEX(',', PropertyAddress)+1), LEN(PropertyAddress))

SELECT OwnerAddress from 
master.dbo.NashvilleHousing;

SELECT PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
 from 
master.dbo.NashvilleHousing;

Alter Table NashvilleHousing
Add OwnerSplitAddress nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress=PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

Alter Table NashvilleHousing
Add OwnerSplitCity nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity=PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

Alter Table NashvilleHousing
Add OwnerSplitState nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState=PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

--Change Y and N to Yes and No in Sold as Vacant
Select Distinct(SoldAsVacant),COUNT(SoldasVacant)
 from 
master.dbo.NashvilleHousing
GROUP BY soldasvacant
ORDER BY 2;

SELECT soldasvacant,
Case when soldasvacant='Y' then 'Yes'
 when soldasvacant='N' then 'No'
ELSE SoldasVacant
END
from 
master.dbo.NashvilleHousing

Update NashvilleHousing
SET  soldasvacant =
Case when soldasvacant='Y' then 'Yes'
 when soldasvacant='N' then 'No'
ELSE SoldasVacant
END

--Remove Duplicates (CTE?)
SELECT * FROM
master.dbo.NashvilleHousing;

WITH RowNumCTE AS(
SELECT *,
ROW_NUMBER()OVER(Partition by ParcelID,PropertyAddress,SAlePrice, SaleDAte,LegalReference
ORDER By UniqueID) row_num
from 
master.dbo.NashvilleHousing)
--ORder by ParcelD)
Select * FROM RowNumCTE
Where row_num >1
--Order By PropertyAddress



--Delete Unused Columns
SELECT *
FROM
master.dbo.NashvilleHousing;

ALTER TABLE master.dbo.NashvilleHousing
drop column SaleDate