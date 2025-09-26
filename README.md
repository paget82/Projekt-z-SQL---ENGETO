#  Projekt z SQL



## Úvod do projektu
V analytickém oddělení nezávislé společnosti, která se zabývá zkoumáním životní úrovně obyvatel, jste se rozhodli zaměřit na několik výzkumných otázek souvisejících s dostupností základních potravin pro širokou veřejnost. Tyto otázky již byly definovány a cílem je připravit podklady, které umožní poskytnout relevantní odpovědi. Výsledky budou následně prezentovány tiskovým oddělením na nadcházející konferenci zaměřené na tuto problematiku.
Vaším úkolem je připravit robustní datové podklady, které umožní porovnat dostupnost vybraných potravin v kontextu průměrných příjmů za sledované časové období.
Jako doplňující materiál je třeba zpracovat také tabulku s ukazateli HDP, GINI koeficientu a populací vybraných evropských států za stejné období, aby bylo možné poskytnout širší kontext k primární analýze pro Českou republiku.
Datové sady, které lze využít k získání potřebných podkladů:


###  Soubory ke stažení
- Primární tabulky:
czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.
czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.
czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.
czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.
czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.
Číselníky sdílených informací o ČR:
czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2.
czechia_district – Číselník okresů České republiky dle normy LAU.

Tabulka Tab1 – primary final vznikla spojením tabulky cen potravin czechia_price, tabulky průměrných mezd v ČR czechia_payroll, tabulky cen potravin s detailním popisem czechia_price_category a tabulky pracovních kategorií czechia_payroll_industry_branch.
Tabulka Tab2 – secondary final vznikla spojením tabulek economies a countries.


## Cíl projektu: Cílem projektu je odpovědět na několik výzkumných otázek:

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

Mzdy obecně rostou ve všech odvětvích, avšak v některých letech podle dat krátkodobě klesly.

Administrativní a podpůrné činnosti – rostly v letech 2006–2018, pokles v roce 2013.

Doprava a skladování – rostly v letech 2006–2018, pokles v roce 2011.

Informační a komunikační činnosti – rostly v letech 2006–2018, pokles v roce 2013.

Kulturní, zábavní a rekreační činnosti – rostly v letech 2006–2018, pokles v roce 2013.

Ostatní činnosti – rostly v letech 2006–2018.

Peněžnictví a pojišťovnictví – rostly v letech 2006–2018, pokles v roce 2013.

Profesní, vědecké a technické činnosti – rostly v letech 2006–2018, pokles v letech 2010 a 2013.

Stavebnictví – rostlo v letech 2006–2018, pokles v roce 2013.

Těžba a dobývání – rostla v letech 2006–2018, pokles v letech 2009, 2013, 2014 a 2016.

Ubytování, stravování a pohostinství – rostlo v letech 2006–2018, pokles v letech 2009 a 2011.

Velkoobchod a maloobchod; opravy a údržba motorových vozidel – rostly v letech 2006–2018, pokles v roce 2013.

Veřejná správa a obrana; povinné sociální zabezpečení – rostly v letech 2006–2018, pokles v letech 2010 a 2011.

Vzdělávání – rostlo v letech 2006–2018, pokles v roce 2010.

Výroba a rozvod elektřiny, plynu, tepla a klimatizovaného vzduchu – rostla v letech 2006–2018, pokles v letech 2011, 2013 a 2015.

Zdravotní a sociální péče – rostla v letech 2006–2018.

Zemědělství, lesnictví a rybářství – rostlo v letech 2006–2018, pokles v roce 2009.

Zásobování vodou; činnosti související s odpady a sanacemi – rostly v letech 2006–2018, pokles v roce 2013.

Činnosti v oblasti nemovitostí – rostly v letech 2006–2018, pokles v letech 2009 a 2013.

2. Kolik je možné si koupit litrů mléka a kilogramů chleba za průměrnou mzdu v prvním a posledním sledovaném období?

V roce 2006 bylo možné za průměrnou mzdu koupit 1314 chlebů a 1469 litrů mléka.

V roce 2018 bylo možné za průměrnou mzdu koupit 1367 chlebů a 1671 litrů mléka.

3. Která kategorie potravin zdražuje nejpomaleji (má nejnižší procentuální meziroční nárůst)?

Nejpomaleji zdražují banány žluté, s růstem pouze 0,81 %.

4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (více než 10 %)?

V poskytnutých datech neexistuje rok, kdy by nárůst cen potravin přesáhl 10 %. Nejvyšší zaznamenaný růst byl 7,1 % v roce 2013.

5. Má výše HDP vliv na změny ve mzdách a cenách potravin?

Po porovnání vývoje mezd a cen potravin lze konstatovat, že neexistuje jednoznačná závislost mezi růstem HDP a vývojem mezd či cen potravin. Změna HDP se významně neprojevuje ani ve stejném, ani v následujícím roce.
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?




# Projekt z SQL

## Úvod do projektu
V analytickém oddělení nezávislé společnosti, která se zabývá zkoumáním životní úrovně obyvatel, jste se rozhodli zaměřit na několik výzkumných otázek souvisejících s dostupností základních potravin pro širokou veřejnost. Tyto otázky již byly definovány a cílem je připravit podklady, které umožní poskytnout relevantní odpovědi. Výsledky budou následně prezentovány tiskovým oddělením na nadcházející konferenci zaměřené na tuto problematiku.

Vaším úkolem je připravit robustní datové podklady, které umožní porovnat dostupnost vybraných potravin v kontextu průměrných příjmů za sledované časové období.  

Jako doplňující materiál je třeba zpracovat také tabulku s ukazateli **HDP, GINI koeficientu a populací** vybraných evropských států za stejné období, aby bylo možné poskytnout širší kontext k primární analýze pro Českou republiku.  

---

### Datové sady
Datové sady, které lze využít k získání potřebných podkladů:

#### Soubory ke stažení
- **Primární tabulky:**
  - `czechia_payroll` – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
  - `czechia_payroll_calculation` – Číselník kalkulací v tabulce mezd.
  - `czechia_payroll_industry_branch` – Číselník odvětví v tabulce mezd.
  - `czechia_payroll_unit` – Číselník jednotek hodnot v tabulce mezd.
  - `czechia_payroll_value_type` – Číselník typů hodnot v tabulce mezd.
  - `czechia_price` – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
  - `czechia_price_category` – Číselník kategorií potravin, které se vyskytují v našem přehledu.

- **Číselníky sdílených informací o ČR:**
  - `czechia_region` – Číselník krajů České republiky dle normy CZ-NUTS 2.
  - `czechia_district` – Číselník okresů České republiky dle normy LAU.

#### Výsledné tabulky
- **Tabulka `Tab1 – primary final`** vznikla spojením tabulky cen potravin `czechia_price`, tabulky průměrných mezd v ČR `czechia_payroll`, tabulky cen potravin s detailním popisem `czechia_price_category` a tabulky pracovních kategorií `czechia_payroll_industry_branch`.  
- **Tabulka `Tab2 – secondary final`** vznikla spojením tabulek `economies` a `countries`.

---

## Cíl projektu
Cílem projektu je odpovědět na několik výzkumných otázek:

### 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
- Mzdy obecně rostou ve všech odvětvích, avšak v některých letech podle dat krátkodobě klesly.  
- **Příklady odvětví:**
  - Administrativní a podpůrné činnosti – pokles v roce 2013.  
  - Doprava a skladování – pokles v roce 2011.  
  - Informační a komunikační činnosti – pokles v roce 2013.  
  - Kulturní, zábavní a rekreační činnosti – pokles v roce 2013.  
  - Profesní, vědecké a technické činnosti – pokles v letech 2010 a 2013.  
  - Těžba a dobývání – pokles v letech 2009, 2013, 2014 a 2016.  
  - Ubytování, stravování a pohostinství – pokles v letech 2009 a 2011.  
  - Výroba a rozvod elektřiny, plynu, tepla a klimatizovaného vzduchu – pokles v letech 2011, 2013 a 2015.  
  - Zemědělství, lesnictví a rybářství – pokles v roce 2009.  
  - Činnosti v oblasti nemovitostí – pokles v letech 2009 a 2013.  

---

### 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za průměrnou mzdu v prvním a posledním sledovaném období?
- **2006:** 1314 chlebů a 1469 litrů mléka  
- **2018:** 1367 chlebů a 1671 litrů mléka  

---

### 3. Která kategorie potravin zdražuje nejpomaleji (má nejnižší procentuální meziroční nárůst)?
- Nejpomaleji zdražují **banány žluté** – růst pouze **0,81 %**.  

---

### 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (více než 10 %)?
- V poskytnutých datech **neexistuje** rok, kdy by nárůst cen potravin přesáhl 10 %.  
- Nejvyšší zaznamenaný růst byl **7,1 % v roce 2013**.  

---

### 5. Má výše HDP vliv na změny ve mzdách a cenách potravin?
- Po porovnání vývoje mezd a cen potravin lze konstatovat, že **neexistuje jednoznačná závislost** mezi růstem HDP a vývojem mezd či cen potravin.  
- Změna HDP se významně neprojevuje ani ve stejném, ani v následujícím roce.  
