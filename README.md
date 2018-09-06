# Adriatic Localization

Localization features are transferred from Microsoft to Partners after version 4.0 SP1. In year 2018 four partner's has joined on Microsoft initiative. Partners are NPS, GoPro, Business Solutions (BS) and Adacta. There goal is to build common localization for Microsoft Dynamics - Business Central. Microsoft is helping partners with Ready to GO localization program. 

## Feature List

Supported features:

No.|Feature Name|Country Specific|Responsible Partner|Status|Sub-range
-:|-|-|-|-|-
1.|[VAT Date](https://github.com/AdriaticOrg/sdd/blob/master/features/VATDate.md)||NPS|Coding|13.062.525..13.062.550
2.|[Postponed VAT](https://github.com/AdriaticOrg/sdd/blob/master/features/PostponedVAT.md)||NPS|Coding|13.062.525..13.062.550
3.|[Full VAT Posting](https://github.com/AdriaticOrg/sdd/blob/master/features/FullVATPorting.md)||NPS|Coding|13.062.525..13.062.550
4.|[Reverse Charge Posting](https://github.com/AdriaticOrg/sdd/blob/master/features/ReverseChargePosting.md)||NPS/GoPro|Coding|13.062.525..13.062.550
5.|Informative VAT|SI|BS|Coding|13.062.551..13.062.560
6.|Red reversal Posting||GoPro|Coding|13.062.561..13.062.570
7.|Forced Debit / Credit Posting||GoPro|Coding|13.062.571..13.062.580
8.|Internal Correction||GoPro|Coding|13.062.581..13.062.590
9.|Return Orders||Adacta|Design|13.062.591..13.062.600
10.|VAT Books||NPS|Testing|13.062.591..13.062.600
11.|VIES Feature|SI|BS|Design|13.062.601..13.062.620
12.|Delivery Declaration|SI|BS|Design|13.062.621..13.062.640
13.|[FAS Report](https://github.com/AdriaticOrg/sdd/blob/master/features/FAS.md)|SI|BS|Coding|13.062.641..13.062.660
14.|KRD Report|SI|BS|Design|13.062.661..13.062.680
15.|BST Report|SI|BS|Design|13.062.681..13.062.700
16.|[Export G/L and VAT](https://github.com/AdriaticOrg/sdd/blob/master/features/ExportGLandVAT.md)|SI|Adacta|Design|13.062.701..13.062.730
17.|[Detail Trial Balance Extended](https://github.com/AdriaticOrg/sdd/blob/master/features/DetailTrialBalanceExtended.md)|HR|Adacta|Design|13.062.731..13.062.740
18.|[Unpaid Receivables](https://github.com/AdriaticOrg/sdd/blob/master/features/UnpaidReceivables.md)|HR|Adacta|Coding|13.062.741..13.062.750
19.|Sales Documents||Adacta|Design|13.062.751..13.062.780
20.|[Fiscalization](https://github.com/AdriaticOrg/sdd/blob/master/features/Fiscalization.md)|HR,SI|Adacta|Design|13.062.781..13.062.810

Test Toolset:

No.|Test name|Responsible Partner|Status|Sub-range
--:|---------|-------------------|------|---------
1.|VAT|Adacta|Testing|13.063.401..13.063.490

Upgrade:

No.|Test name|Responsible Partner|Status|Sub-range
--:|---------|-------------------|------|---------
1.|Reserved|None|Reserved|13.063.491..13.063.500

## Registered Range

Object ranges are used for registering licenses for partners and customers.

Id|Module Name|Type|Range from|Range to
-:|-|-|-|-
13062520|Adriatic Localization for Business Central|Add-on|13.062.525|13.063.524
13062530|BC Adriatic Localization|Granule|13.062.525|13.063.509
13063530|BC Serbian Localization|Granule|13.063.510|13.063.510
13062540|BC Slovenian Localization|Granule|13.063.511|13.063.511
13062550|BC Croatian Localization|Granule|13.063.512|13.063.512
13062560|BC Macedonian Localization|Granule|13.063.513|13.063.513
13062570|BC Montenegrin Localization|Granule|13.063.514|13.063.514

## Registered postfix

Countries postfixes are:

Country|Postfix
-|-
Adriatic Localization|-adl
Slovenia|-si
Croatia|-hr
Serbia|-rs
