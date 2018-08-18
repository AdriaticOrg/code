# Fiscalization Feature

- Part 1 - Time stamp in G/L Register

## Current object related to this feature

No.|Type|Object ID|Name
--:|----|-----------:|--------
1.|Table|112|Sales Invoice Header
2.|Table|114|Sales Cr. Memo Header

## Feature requirement

Time stamp in G/L Register enables additional information about start and end time of posting in G/L Register, posting time in VAT Entry and posting time in Posted Sales Invoice and Sales Credit Memo Header.

Due to Fiscalization Feature Creation Time Stamp was added to sales invoice and credit memo. Tax authorities must identify when request was send. For measuring purposes two fields was added to G/L Register table: Creation Start Time and Creation End Time. Fields are automatically filled when document is posted.

## New Required Objects

No.|Type|Object ID|Name
--:|----|-----------:|--------
1.|Table Extension|New Object|Tab112-Extxxxxx.SalesInvoiceHeader-ADL
2.|Table Extension|New Object|Tab114-Extxxxxx.SalesCrMemoHeader-ADL
3.|Codeunit|New Object|Codxxxxx.ALxxxxx

1. Table Extension 112
    - 1 new field 
      - Posting TimeStamp

2. Table Extension 114
    - 1 new field 
      - Posting TimeStamp

3. Codeunit will have functions that will be triggered from Codeunit 80 after creating(Inserting) Invoice or CrMemoHeader. This codeunit will fill new field in Table Extension 112 and 114.