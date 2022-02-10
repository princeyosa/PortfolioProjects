SELECT * 
FROM PortfolioProjects..CoVidDeaths$
--where continent is not null
ORDER BY 3,4

--SELECT * 
--FROM PortfolioProjects..['CoVid Vaccinations$']
--ORDER BY 3,4

SELECT location,date,total_cases,new_cases, total_deaths, population 
FROM PortfolioProjects..CoVidDeaths$
where continent is not null
ORDER BY 1,2


-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in Ghana

SELECT location,date,total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
FROM PortfolioProjects..CoVidDeaths$
where location like 'Ghan%' and continent is not null
ORDER BY 1,2

-- Looking at Total vs Population

SELECT location,date,Population, total_cases , (total_cases/population)*100 as CasePercentage 
FROM PortfolioProjects..CoVidDeaths$
--where location like 'Ghan%' and continent is not null
ORDER BY 1,2


-- Looking at Countries with highest infection rate compared to Pouplation

SELECT location,Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases)/population)*100 as PercentagePopulationInfected 
FROM PortfolioProjects..CoVidDeaths$
--where location like 'Ghan%'
Group by Location, Population
where continent is not null
ORDER BY PercentagePopulationInfected desc

-- Showing the countries with the highest death count per population

SELECT location,MAX(cast(Total_deaths as int)) as TotalDeathCount 
FROM PortfolioProjects..CoVidDeaths$
--where location like 'Ghan%'
where continent is not null
Group by Location
ORDER BY TotalDeathCount desc


-- Let's Break things down by Continent 

-- Showing the continents with the highest death count per population

SELECT continent,MAX(cast(Total_deaths as int)) as TotalDeathCount 
FROM PortfolioProjects..CoVidDeaths$
--where location like 'Ghan%'
where continent is not null
Group by continent
ORDER BY TotalDeathCount desc 



-- GLOBAL NUMBERS

SELECT SUM(new_cases) as TotalCases, sum(cast(new_deaths as int)) as TotalDeaths, (sum(cast(new_deaths as int))/sum(new_cases)) * 100 as DeathPercentage   --, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
FROM PortfolioProjects..CoVidDeaths$
--where location like 'Ghan%' 
where continent is not null
--Group by date
ORDER BY 1,2


-- looking at Total Population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, 
	dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
FROM PortfolioProjects..CoVidDeaths$ dea
JOIN PortfolioProjects..CoVidVaccinations$ vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
order by 2,3


-- USE CTE

With Popvsvac (Continent, Location, Date, Population, New_Vaccinations , RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, 
	dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
FROM PortfolioProjects..CoVidDeaths$ dea
JOIN PortfolioProjects..CoVidVaccinations$ vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/population)*100 as PerVaccPerDay
from Popvsvac



-- TEMP TABLE

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, 
	dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
FROM PortfolioProjects..CoVidDeaths$ dea
JOIN PortfolioProjects..CoVidVaccinations$ vac
	ON dea.location = vac.location
	and dea.date = vac.date
-- WHERE dea.continent is not null
--order by 2,3
Select *, (RollingPeopleVaccinated/population)*100 as PerVaccPerDay
from #PercentPopulationVaccinated  


-- Create view to store data for later visualizations

Create View PercentPopulations as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(convert(bigint,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, 
	dea.date) as RollingPeopleVaccinated
--	, (RollingPeopleVaccinated/population)*100
FROM PortfolioProjects..CoVidDeaths$ dea
JOIN PortfolioProjects..CoVidVaccinations$ vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--order by 2,3

