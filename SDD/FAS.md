# FAS Reporting

## Current objects related to this feature

ID|No.|Type|Object ID|Name
--|--|----|-----------:|--------
a|1. |Table |9  |Country/Region
a|2. |Table |270  |Bank Account
a|3. |Table |277  |Bank Account Posting Group
a|4. |Table |92  |Customer Posting Group
a|5. |Table |18  |Customer
a|6. |Table |23  |Vendor
a|7. |Table |5050 |Contact
a|8. |Table |15 |G/L Account
a|9. |Table |81 |Gen. Journal Line
a|10. |Table |17 |G/L Entry
a|11. |Page |10 |Countries/Regions
a|12. |Page |370 |Bank Account Card
a|13. |Page |373 |Bank Account Posting Groups
a|14. |Page |110 |Customer Posting Groups
a|15. |Page |111 |Vendor Posting Groups
a|16. |Page |21 |Customer Card
a|17. |Page |26 |Vendor Card
a|18. |Page |5050 |Contact Card
a|19. |Page |17 |G/L Account Card
a|20. |Page |39 |General Journal
a|21. |Page |20 |General Ledger Entries
a|22. |Codeunit |12  |Gen. Jnl.-Post Line

## Feature requirement

According to Bank of Slovenian rules, business entities, who are requested to submit finance account statistics data, should report data on the state of financial assets and liabilities in financial accounts and on transaction changes in value of financial assets and liabilities.

The data for financial accounts statistics must be submitted by all institutional units which, according to the standard classification of institutional sectors according to the regulation, are classified into sectors 11, 12 and 13 and are determined by the decision on reporting or the criteria for assessing the reporting obligations by the Bank of Slovenia:

-for sector 11 or non-financial corporations, the balance sheet total (asset value) at the end of the calendar year prior to the reporting period, EUR 2 million or more,

-for sector 12 or financial corporations, the balance sheet total (asset value) at the end of the calendar year, before the period for which data are reported, EUR 1 million or more,

-for sector 13 or institutional units of central and local government, the balance sheet total (asset value) at the end of the calendar year, before the reporting period, is EUR 8 million or more.

Institutional units established during the year assess the reporting obligation by assessing the balance sheet at the end of the quarter for which data are reported.

## New required objects

No.|Type|Object ID|Name
--:|----|-----------:|--------
1.|Table Extension|New Object|Tab9-Extxxxxx.CountryRegion-adl
2.|Table Extension|New Object|Tab270-Extxxxxx.BankAccount-adl
3.|Table Extension|New Object|Tab277-Extxxxxx.BankAccPostingGroup-adl
4.|Table Extension|New Object|Tab92-Extxxxxx.CustPostingGroup-adl
5.|Table Extension|New Object|Tab93-Extxxxxx.VendPostingGroup-adl
6.|Table Extension|New Object|Tab18-Extxxxxx.Customer-adl
7.|Table Extension|New Object|Tab23-Extxxxxx.Vendor-adl
8.|Table Extension|New Object|Tab5050-Extxxxxx.Contact-adl
9.|Table Extension|New Object|Tab15-Extxxxxx.GLAccount-adl
10.|Table Extension|New Object|Tab81-Extxxxxx.GenJnlLine-adl
11.|Table Extension|New Object|Tab17-Extxxxxx.GLEntry-adl
12.|Page Extension|New Object|Pag10-Extxxxxx.CountryRegions-adl
13.|Page Extension|New Object|Pag370-Extxxxxx.BankAccount-adl
14.|Page Extension|New Object|Pag373-Extxxxxx.BankAccPostingGroups-adl
15.|Page Extension|New Object|Pag110-Extxxxxx.CustPostingGroups-adl
16.|Page Extension|New Object|Pag111-Extxxxxx.VendPostingGroups-adl
17.|Page Extension|New Object|Pag21-Extxxxxx.Customer-adl
18.|Page Extension|New Object|Pag26-Extxxxxx.Vendor-adl
19.|Page Extension|New Object|Pag5050-Extxxxxx.Contact-adl
20.|Page Extension|New Object|Pag17-Extxxxxx.GLAccount-adl
21.|Page Extension|New Object|Pag39-Extxxxxx.GenJnlLine-adl
22.|Page Extension|New Object|Pag20-Extxxxxx.GLEntries-adl

1. Table Extension 9
    - 1 new field
      -FAS Sector Code

2. Table Extension 270
    - 1 new field
      -FAS Sector Code

3. Table Extension 277
    - 1 new field
      -FAS Instrument Code

4. Table Extension 92
    - 1 new field
      -FAS Instrument Code

5. Table Extension 93
    - 1 new field
      -FAS Instrument Code

6. Table Extension 18
    - 1 new field
      -FAS Sector Code

7. Table Extension 23
    - 1 new field
      -FAS Sector Code

8. Table Extension 5050
    - 1 new field
      -FAS Sector Code

9. Table Extension 15
    - 5 new fields
      -FAS Account
      -FAS Sector Posting
      -FAS Instrument Posting
      -FAS Sector Code
      -FAS Instrument Code

10. Table Extension 81
    - 2 new fields
      -FAS Sector Code
      -FAS Instrument Code      

>Note: file still incomplete...