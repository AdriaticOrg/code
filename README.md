# Adriatic Localization

Localization features are transferred from Microsoft to Partners after version 4.0 SP1. In year 2018 four partner's has joined on Microsoft initiative. Partners are NPS, GoPro, Business Solutions (BS) and Adacta. There goal is to build common localization for Microsoft Dynamics - Business Central. Microsoft is helping partners with Ready to GO localization program.

## [VAT Posting](https://github.com/AdriaticOrg/code/issues?q=is%3Aopen+is%3Aissue+project%3AAdriaticOrg%2Fcode%2F1)

No.|Feature Name|Country Specific|Responsible Partner|Sub-range
-:|-|-|-|-
[#6](/../../issues/6)|[VAT Date](https://github.com/AdriaticOrg/sdd/blob/master/features/VATDate.md)||NPS|13.062.525..13.062.550
[#10](/../../issues/10)|[Postponed VAT](https://github.com/AdriaticOrg/sdd/blob/master/features/PostponedVAT.md)||NPS|13.062.525..13.062.550
[#11](/../../issues/11)|[Full VAT Posting](https://github.com/AdriaticOrg/sdd/blob/master/features/FullVATPorting.md)||GoPro|13.062.525..13.062.550
[#12](/../../issues/12)|[Reverse Charge Posting](https://github.com/AdriaticOrg/sdd/blob/master/features/ReverseChargePosting.md)||NPS|13.062.525..13.062.550
[#13](/../../issues/13)|[Informative VAT](https://github.com/AdriaticOrg/sdd/blob/master/features/InformativeVAT.md)|SI|BS|13.062.551..13.062.560
[#14](/../../issues/14)|[VAT Identifier](https://github.com/AdriaticOrg/sdd/blob/master/features/VATIdentifier.md)||GoPro|13.062.525..13.062.550

## [General Ledger](https://github.com/AdriaticOrg/code/issues?q=is%3Aopen+is%3Aissue+project%3AAdriaticOrg%2Fcode%2F2)

No.|Feature Name|Country Specific|Responsible Partner|Sub-range
-:|-|-|-|-
[#7](/../../issues/7)|[Red reversal Posting](https://github.com/AdriaticOrg/sdd/blob/master/features/RedReversalPosting.md)||GoPro|13.062.561..13.062.570
[#16](/../../issues/16)|[Forced Debit / Credit Posting](https://github.com/AdriaticOrg/sdd/blob/master/features/ForcedDebitCreditPosting.md)||GoPro|13.062.571..13.062.580

## [Sales & Purchase](https://github.com/AdriaticOrg/code/issues?q=is%3Aopen+is%3Aissue+project%3AAdriaticOrg%2Fcode%2F3)

No.|Feature Name|Country Specific|Responsible Partner|Sub-range
-:|-|-|-|-
[#18](/../../issues/16)|[Return Orders](https://github.com/AdriaticOrg/sdd/blob/master/features/ReturnOrders.md)||Adacta|13.062.581..13.062.590
[#19](/../../issues/19)|[Sales Documents](https://github.com/AdriaticOrg/sdd/blob/master/features/SalesDocuments.md)||Adacta|13.062.751..13.062.780
[#20](/../../issues/20)|[Fiscalization](https://github.com/AdriaticOrg/sdd/blob/master/features/Fiscalization.md)|HR,SI|Adacta|13.062.781..13.062.810
[#22](/../../issues/22)|[VIES Feature](https://github.com/AdriaticOrg/sdd/blob/master/features/VIESFeature.md)|SI|BS|13.062.601..13.062.620
[#23](/../../issues/23)|[Delivery Declaration](https://github.com/AdriaticOrg/sdd/blob/master/features/DeliveryDeclaration.md)|SI|BS|13.062.621..13.062.640

## [Reports](https://github.com/AdriaticOrg/code/issues?q=is%3Aopen+is%3Aissue+project%3AAdriaticOrg%2Fcode%2F4)
No.|Feature Name|Country Specific|Responsible Partner|Sub-range
-:|-|-|-|-
[#5](/../../issues/5)|[VAT Books](https://github.com/AdriaticOrg/sdd/blob/master/features/VATBooks.md)||NPS|13.062.591..13.062.600
[#21](/../../issues/21)|[Export G/L and VAT](https://github.com/AdriaticOrg/sdd/blob/master/features/ExportGLandVAT.md)|SI|Adacta|13.062.701..13.062.730
[#24](/../../issues/24)|[FAS Report](https://github.com/AdriaticOrg/sdd/blob/master/features/FAS.md)|SI|BS|13.062.641..13.062.660
[#25](/../../issues/25)|[KRD Report](https://github.com/AdriaticOrg/sdd/blob/master/features/KRD.md)|SI|BS|13.062.661..13.062.680
[#26](/../../issues/26)|[BST Report](https://github.com/AdriaticOrg/sdd/blob/master/features/BST.md)|SI|BS|13.062.681..13.062.700
[#27](/../../issues/27)|[Detail Trial Balance Extended](https://github.com/AdriaticOrg/sdd/blob/master/features/DetailTrialBalanceExtended.md)|HR|Adacta|13.062.731..13.062.740
[#28](/../../issues/28)|[Unpaid Receivables](https://github.com/AdriaticOrg/sdd/blob/master/features/UnpaidReceivables.md)|HR|Adacta|13.062.741..13.062.750

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
