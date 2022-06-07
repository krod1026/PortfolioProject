--SELECT * 
--FROM dbo.CovidVaccinations$
--ORDER BY 3,4;

--Select data that I will be using

SELECT Location,date, total_cases, new_cases,total_deaths, population 
FROM dbo.CovidDeaths$
ORDER BY 1,2;

--Looking at total cases vs total deaths as a Death percentage
--Shows likelihood of dying if you get covid in your country
SELECT Location,date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM dbo.CovidDeaths$
WHERE location='United States'
ORDER BY 1,2;

--Looking at total cases vs population
--Shows what % of population got Covid
SELECT Location,date, population,total_cases, (total_cases/population)*100 as InfectedPercentage
FROM dbo.CovidDeaths$
WHERE location='United States'
ORDER BY 1,2;

--Shows what countries have highest infection rates compared to Population
SELECT Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as InfectedPercentage
FROM dbo.CovidDeaths$
--WHERE location='United States'
GROUP BY location, population
ORDER BY InfectedPercentage desc;

--Shows what countries have highest deaths compared to Population
SELECT Location, MAX(cast (total_deaths as int)) as HighestDeathCount, MAX((total_deaths/population))*100 as DeathPercentage
FROM dbo.CovidDeaths$
WHERE continent is not null
GROUP BY location
ORDER BY HighestDeathCount desc;

--Showing continents with highest death count
SELECT location, MAX(cast (total_deaths as int)) as TotalDeathCount, MAX((total_deaths/population))*100 as DeathPercentage
FROM dbo.CovidDeaths$
WHERE continent is`` null
GROUP BY location
ORDER BY TotalDeathCount desc;

--Global Numbers
SELECT  SUM(new_cases),SUM(cast (new_deaths as int))-- (total_deaths/total_cases)*100 as DeathPercentage
FROM dbo.CovidDeaths$
Where continent is not null
ORDER BY 1,2;

--Looking at total population vs vaccination
SELECT d.continent, d.location,d.date, d.population,v.new_vaccinations, SUM(cast(v.new_vaccinations as int)) OVER (Partition by d.location Order by d.location, d.date) as RollingPeopleVaccinated
FROM dbo.CovidDeaths$ as d
JOIN dbo.CovidVaccinations$ as v
ON d.location = v.location
AND d.date=v.date
WHERE d.location = 'United States' AND d.continent is not null)
--ORDER BY 2,3)
SELECT *, (RollingPeopleVaccinated/Population)*100 
FROM PopvsVac

--USE CTE
With PopvsVac (Continent, location, date, population, New_vaccinations, RollingPeopleVaccinated)
as( 
SELECT d.continent, d.location,d.date, d.population,v.new_vaccinations, SUM(cast(v.new_vaccinations as int)) OVER (Partition by d.location Order by d.location, d.date) as RollingPeopleVaccinated
FROM dbo.CovidDeaths$ as d
JOIN dbo.CovidVaccinations$ as v
ON d.location = v.location
AND d.date=v.date
WHERE d.location = 'United States' AND d.continent is not null)
--ORDER BY 2,3)
SELECT *, (RollingPeopleVaccinated/Population)*100 
FROM PopvsVac

--TEMP TABLE
DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(Continent nvarchar(255),
location nvarchar(255),
date datetime,
Population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric,
)
INSERT INTO #PercentPopulationVaccinated
SELECT d.continent, d.location,d.date, d.population,v.new_vaccinations, SUM(cast(v.new_vaccinations as int)) OVER (Partition by d.location Order by d.location, d.date) as RollingPeopleVaccinated
FROM dbo.CovidDeaths$ as d
JOIN dbo.CovidVaccinations$ as v
ON d.location = v.location
AND d.date=v.date
--ORDER BY 2,3)
SELECT *, (RollingPeopleVaccinated/Population)*100 
FROM #PercentPopulationVaccinated

--Create View to store data for later visualizations
CREATE VIEW PercentPopulationVaccinated as
SELECT d.continent, d.location,d.date, d.population,v.new_vaccinations, SUM(cast(v.new_vaccinations as int)) OVER (Partition by d.location Order by d.location, d.date) as RollingPeopleVaccinated
--,(TollingPeopleVaccinated/population)*100
FROM dbo.CovidDeaths$ as d
JOIN dbo.CovidVaccinations$ as v
ON d.location = v.location
AND d.date=v.date
WHERE d.location is not null
--ORDER BY 2,3)

Select * from PercentPopulationVaccinated