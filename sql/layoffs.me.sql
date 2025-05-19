SELECT * FROM data_cleaning.layoffs_raw;

SELECT * FROM data_cleaning.layoffs_raw
WHERE company like 'carvana%';
SET SQL_SAFE_UPDATES=0;
update data_cleaning.layoffs_raw
SET industry='Transportation'
WHERE company ='Carvana'AND industry='';

SET SQL_SAFE_UPDATES=0;
UPDATE data_cleaning.layoffs_raw
SET industry='Travel' 
WHERE company='Airbnb' AND industry='';


SELECT * FROM data_cleaning.layoffs_raw
WHERE company like 'Airbnb%';


SELECT *,
row_number() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,stage,country,funds_raised_millions)
FROM data_cleaning.layoffs_raw;

with duplicates_cte AS 
(select *,
row_number() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage, country, funds_raised_millions) as row_num
FROM data_cleaning.layoffs_raw
)
select * from duplicates_cte
where row_num > 1;
select * from data_cleaning.layoffs_raw
where company='Casper';


CREATE TABLE `layoffs_raw2`(
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` json DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET SQL_SAFE_UPDATES=0;
INSERT INTO layoffs_raw2
(select *,
row_number() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage, country, funds_raised_millions) as row_num
FROM data_cleaning.layoffs_raw
);
UPDATE  layoffs_raw2
SET 
industry='Consumer' 
WHERE company ='Juul'AND industry='';

DELETE from layoffs_raw2 
WHERE row_num > 1;

select * from layoffs_raw2 
where company='Juul';

DELETE 
 FROM layoffs_raw2 
 where percentage_laid_off IS NULL AND total_Laid_off is null AND funds_raised_millions is null;

select * from layoffs_raw2 ;

select company, total_laid_off,`date`

FROM layoffs_raw2
group by `date`


