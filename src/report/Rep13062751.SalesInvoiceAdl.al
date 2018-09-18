Report 13062751 "Sales - Invoice-Adl"
{
    // version NAVW113.00

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportlayout/Rep13062751.SalesInvoiceAdl.rdl';
    Caption = 'Sales - Invoice';
    EnableHyperlinks = true;
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;

    dataset
    {

        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(No_SalesInvHdr; "No.")
            {
            }
            column(InvDiscountAmtCaption; InvDiscountAmtCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(PaymentTermsDescCaption; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShptMethodDescCaption; ShptMethodDescCaptionLbl)
            {
            }
            column(VATPercentageCaption; VATPercentageCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATAmtCaption; VATAmtCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
            {
            }
            column(VAT_Date_Adl; "VAT Date-Adl")
            {
            }
            column(VAT_Date_AdlCaption; VAT_Date_AdlCaptionLbl)
            {
            }
            column(VATPercInfAdlCaption; VATPercInfAdlCaptionLbl)
            {
            }
            column(VATAmtInfAdlCaption; VATAmtInfAdlCaptionLbl)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                    column(HomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(EMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(DocumentCaptionCopyText; STRSUBSTNO(DocumentCaption(), CopyText))
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Posting Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesInvHdr; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Due Date", 0, 4))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourReference_SalesInvHdr; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(HdrOrderNo_SalesInvHdr; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(DocDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Document Date", 0, 4))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo_SalesInvHdr; FORMAT("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption; PageNumberFormatTok)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCptn; CompanyInfoVATRegNoCptnLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCptn; CompanyInfoBankNameCptnLbl)
                    {
                    }
                    column(CompanyInfoBankAccNoCptn; CompanyInfoBankAccNoCptnLbl)
                    {
                    }
                    column(SalesInvDueDateCaption; SalesInvDueDateCaptionLbl)
                    {
                    }
                    column(InvNoCaption; InvNoCaptionLbl)
                    {
                    }
                    column(SalesInvPostingDateCptn; SalesInvPostingDateCptnLbl)
                    {
                    }
                    column(BilltoCustNo_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Number; Number)
                        {
                        }
                        column(HeaderDimCaption; HeaderDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FINDSET() then
                                    CurrReport.BREAK();
                            end else
                                if not Continue then
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := CopyStr(StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code"), 1, 120)
                                else
                                    DimText :=
                                        CopyStr(
                                            StrSubstNo(
                                                '%1, %2 %3', DimText,
                                                DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code"), 1, 120);
                                if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.NEXT() = 0;
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not ShowInternalInfo then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING ("Document No.", "Line No.");
                        column(LineAmt_SalesInvLine; "Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesInvLine; Description)
                        {
                        }
                        column(No_SalesInvLine; "No.")
                        {
                        }
                        column(Qty_SalesInvLine; Quantity)
                        {
                        }
                        column(UOM_SalesInvLine; "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine; "Unit Price")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Discount_SalesInvLine; "Line Discount %")
                        {
                        }
                        column(VATIdentifier_SalesInvLine; "VAT Identifier")
                        {
                        }
                        column(PostedShipmentDate; FORMAT("Shipment Date"))
                        {
                        }
                        column(Type_SalesInvLine; FORMAT(Type))
                        {
                        }
                        column(InvDiscLineAmt_SalesInvLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmount; TotalInvDiscAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amount_SalesInvLine; Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Amount_AmtInclVAT; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmtInclVAT_SalesInvLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountVAT; TotalAmountVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineAmtAfterInvDiscAmt; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscOnVAT; TotalPaymentDiscOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_SalesInvLine; TotalInclVATText)
                        {
                        }
                        column(VATAmtText_SalesInvLine; VATAmountLine.VATAmountText())
                        {
                        }
                        column(DocNo_SalesInvLine; "Document No.")
                        {
                        }
                        column(LineNo_SalesInvLine; "Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(SalesInvLineDiscCaption; SalesInvLineDiscCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(PostedShipmentDateCaption; PostedShipmentDateCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(LineAmtAfterInvDiscCptn; LineAmtAfterInvDiscCptnLbl)
                        {
                        }
                        column(Desc_SalesInvLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(No_SalesInvLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_SalesInvLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesInvLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_SalesInvLineCaption; FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(IsLineWithTotals; LineNoWithTotal = "Line No.")
                        {
                        }
                        dataitem("Sales Shipment Buffer"; "Integer")
                        {
                            DataItemTableView = SORTING (Number);
                            column(SalesShptBufferPostDate; FORMAT(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShptBufferQty; SalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShipmentCaption; ShipmentCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then
                                    SalesShipmentBuffer.FIND('-')
                                else
                                    SalesShipmentBuffer.NEXT();
                            end;

                            trigger OnPreDataItem();
                            begin
                                SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");

                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT());
                            end;
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 ..));
                            column(DimText_DimLoop; DimText)
                            {
                            }
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FINDSET() then
                                        CurrReport.BREAK();
                                end else
                                    if not Continue then
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := CopyStr(STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code"), 1, MaxStrLen(DimText))
                                    else
                                        DimText :=
                                            CopyStr(
                                                STRSUBSTNO(
                                                    '%1, %2 %3', DimText,
                                                    DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code"), 1, MaxStrLen(DimText));
                                    if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.NEXT() = 0;
                            end;

                            trigger OnPreDataItem();
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = SORTING (Number);
                            column(TempPostedAsmLineNo; BlanksForIndent() + TempPostedAsmLine."No.")
                            {
                            }
                            column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent() + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostAsmLineVartCode; BlanksForIndent() + TempPostedAsmLine."Variant Code")
                            {
                            }
                            column(TempPostedAsmLineUOM; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                            }

                            trigger OnAfterGetRecord();
                            var
                                ItemTranslation: Record "Item Translation";
                            begin
                                if Number = 1 then
                                    TempPostedAsmLine.FINDSET()
                                else
                                    TempPostedAsmLine.NEXT();

                                if ItemTranslation.GET(TempPostedAsmLine."No.",
                                     TempPostedAsmLine."Variant Code",
                                     "Sales Invoice Header"."Language Code")
                                then
                                    TempPostedAsmLine.Description := ItemTranslation.Description;
                            end;

                            trigger OnPreDataItem();
                            begin
                                CLEAR(TempPostedAsmLine);
                                if not DisplayAssemblyInformation then
                                    CurrReport.BREAK();
                                CollectAsmInformation();
                                CLEAR(TempPostedAsmLine);
                                SETRANGE(Number, 1, TempPostedAsmLine.COUNT());
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            InitializeShipmentBuffer();
                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
                                "No." := '';

                            VATAmountLine.INIT();
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            if "Allow Invoice Disc." then
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            // <adl.13>
                            if "VAT % (informative)-Adl" <> 0 then begin
                                VATAmountLine."VAT % (informative)-Adl" := "VAT % (informative)-Adl";
                                ShowVATInformative := TRUE;
                            end;
                            // <adl.13>
                            VATAmountLine.InsertLine();
                            CalcVATAmountLineLCY(
                              "Sales Invoice Header", VATAmountLine, TempVATAmountLineLCY,
                              VATBaseRemainderAfterRoundingLCY, AmtInclVATRemainderAfterRoundingLCY);

                            TotalSubTotal += "Line Amount";
                            TotalInvDiscAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                        end;

                        trigger OnPreDataItem();
                        begin
                            VATAmountLine.DELETEALL();
                            TempVATAmountLineLCY.DELETEALL();
                            VATBaseRemainderAfterRoundingLCY := 0;
                            AmtInclVATRemainderAfterRoundingLCY := 0;
                            SalesShipmentBuffer.RESET();
                            SalesShipmentBuffer.DELETEALL();
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            LineNoWithTotal := "Line No.";
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPer; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecificationCptn; VATAmtSpecificationCptnLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(VATAmtLineVATPerInf; VATAmountLine."VAT % (informative)-Adl")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATAmtInf; VATAmtLineVATAmtInf)
                        {
                        }
                        column(ShowVATInformative; ShowVATInformative)
                        {
                        }
                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                            // <adl.13>
                            VATAmtLineVATAmtInf :=
                              ROUND(VATAmountLine."VAT Base" * VATAmountLine."VAT % (informative)-Adl" / 100, GLSetup."Amount Rounding Precision");
                            // </adl.13>
                        end;

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(Number, 1, VATAmountLine.COUNT());
                        end;
                    }
                    dataitem(VATClauseEntryCounter; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(VATClauseVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATClauseCode; VATAmountLine."VAT Clause Code")
                        {
                        }
                        column(VATClauseDescription; VATClause.Description)
                        {
                        }
                        column(VATClauseDescription2; VATClause."Description 2")
                        {
                        }
                        column(VATClauseAmount; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATClausesCaption; VATClauseColumnCaptionLbl)
                        {
                        }
                        column(VATClauseVATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption; VATAmtCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            VATAmountLine.GetLine(Number);
                            if not VATClause.GET(VATAmountLine."VAT Clause Code") then
                                CurrReport.SKIP();
                            VATClause.TranslateDescription("Sales Invoice Header"."Language Code");
                        end;

                        trigger OnPreDataItem();
                        begin
                            CLEAR(VATClause);
                            SETRANGE(Number, 1, VATAmountLine.COUNT());
                        end;
                    }
                    dataitem(VatCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING (Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATPer_VATCounterLCY; TempVATAmountLineLCY."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifier_VATCounterLCY; TempVATAmountLineLCY."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            TempVATAmountLineLCY.GetLine(Number);
                            VALVATBaseLCY := TempVATAmountLineLCY."VAT Base";
                            VALVATAmountLCY := TempVATAmountLineLCY."Amount Including VAT" - TempVATAmountLineLCY."VAT Base";
                        end;

                        trigger OnPreDataItem();
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Invoice Header"."Currency Code" = '')
                            then
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, VATAmountLine.COUNT());

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := VATAmountCurrencySpecLbl + LocalCurrencyLbl
                            else
                                VALSpecLCYHeader := VATAmountCurrencySpecLbl + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := CopyStr(STRSUBSTNO(ExchangeRateFormatLbl, CalculatedExchRate, CurrExchRate."Exchange Rate Amount"), 1, MaxStrLen(VALExchRate));
                        end;
                    }
                    dataitem(PaymentReportingArgument; "Payment Reporting Argument")
                    {
                        DataItemTableView = SORTING (Key);
                        UseTemporary = true;
                        column(PaymentServiceLogo; Logo)
                        {
                        }
                        column(PaymentServiceURLText; "URL Caption")
                        {
                        }
                        column(PaymentServiceURL; GetTargetURL())
                        {
                        }

                        trigger OnPreDataItem();
                        var
                            PaymentServiceSetup: Record "Payment Service Setup";
                        begin
                            PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, "Sales Invoice Header");
                            if ISEMPTY() then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                        column(SelltoCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem();
                        begin
                            if not ShowShippingAddr then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(LineFee; "Integer")
                    {
                        DataItemTableView = SORTING (Number) ORDER(Ascending) WHERE (Number = FILTER (1 ..));
                        column(LineFeeCaptionLbl; TempLineFeeNoteOnReportHist.ReportText)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if not DisplayAdditionalFeeNote then
                                CurrReport.BREAK();

                            if Number = 1 then begin
                                if not TempLineFeeNoteOnReportHist.FINDSET() then
                                    CurrReport.BREAK()
                            end else
                                if TempLineFeeNoteOnReportHist.NEXT() = 0 then
                                    CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;

                    TotalSubTotal := 0;
                    TotalInvDiscAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscOnVAT := 0;
                end;

                trigger OnPostDataItem();
                begin
                    if not IsReportInPreviewMode() then
                        CODEUNIT.RUN(CODEUNIT::"Sales Inv.-Printed", "Sales Invoice Header");
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }


            trigger OnAfterGetRecord();
            var
                Handled: Boolean;
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatAddressFields("Sales Invoice Header");
                FormatDocumentFields("Sales Invoice Header");

                if not Cust.GET("Bill-to Customer No.") then
                    CLEAR(Cust);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                GetLineFeeNoteOnReportHist("No.");

                OnAfterGetRecordSalesInvoiceHeader("Sales Invoice Header");
                OnGetReferenceText("Sales Invoice Header", ReferenceText, Handled);
            end;
        }

    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Assembly;
                        Caption = 'Show Assembly Components';
                        ToolTip = 'Specifies if you want the report to include information about components that were used in linked assembly orders that supplied the item(s) being sold.';
                    }
                    field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Additional Fee Note';
                        ToolTip = 'Specifies that any notes about additional fees are included on the document.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage();
        begin
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;

    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        GLSetup.GET();
        SalesSetup.GET();
        CompanyInfo.GET();
        CompanyInfo.VerifyAndSetPaymentInfo();
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    trigger OnPostReport();
    begin
        if LogInteraction and not IsReportInPreviewMode() then
            if "Sales Invoice Header".FINDSET() then
                repeat
                    if "Sales Invoice Header"."Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          SegManagement.SalesInvoiceInterDocType(), "Sales Invoice Header"."No.", 0, 0, DATABASE::Contact,
                          "Sales Invoice Header"."Bill-to Contact No.", "Sales Invoice Header"."Salesperson Code",
                          "Sales Invoice Header"."Campaign No.", "Sales Invoice Header"."Posting Description", '')
                    else
                        SegManagement.LogDocument(
                          SegManagement.SalesInvoiceInterDocType(), "Sales Invoice Header"."No.", 0, 0, DATABASE::Customer,
                          "Sales Invoice Header"."Bill-to Customer No.", "Sales Invoice Header"."Salesperson Code",
                          "Sales Invoice Header"."Campaign No.", "Sales Invoice Header"."Posting Description", '');
                until "Sales Invoice Header".NEXT() = 0;
    end;

    trigger OnPreReport();
    begin
        if not CurrReport.USEREQUESTPAGE() then
            InitLogInteraction();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        TempVATAmountLineLCY: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        VATClause: Record "VAT Clause";
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        SalesInvoiceCaptionFormatTok: Label 'Sales - Invoice %1';
        PageNumberFormatTok: Label 'Page %1 of %2';
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[80];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[120];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VATAmountCurrencySpecLbl: Label '"VAT Amount Specification in "';
        LocalCurrencyLbl: Label 'Local Currency';
        VALExchRate: Text[50];
        ExchangeRateFormatLbl: Label 'Exchange rate: %1/%2';
        CalculatedExchRate: Decimal;
        SalesPrepaymentInvoiceFormatLbl: Label 'Sales - Prepayment Invoice %1';
        OutputNo: Integer;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCptnLbl: Label 'VAT Reg. No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCptnLbl: Label 'Bank';
        CompanyInfoBankAccNoCptnLbl: Label 'Account No.';
        SalesInvDueDateCaptionLbl: Label 'Due Date';
        InvNoCaptionLbl: Label 'Invoice No.';
        SalesInvPostingDateCptnLbl: Label 'Posting Date';
        HeaderDimCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        SalesInvLineDiscCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        VATClauseColumnCaptionLbl: Label 'VAT Clause';
        PostedShipmentDateCaptionLbl: Label 'Posted Shipment Date';
        SubtotalCaptionLbl: Label 'Subtotal';
        LineAmtAfterInvDiscCptnLbl: Label 'Payment Discount on VAT';
        ShipmentCaptionLbl: Label 'Shipment';
        LineDimCaptionLbl: Label 'Line Dimensions';
        VATAmtSpecificationCptnLbl: Label 'VAT Amount Specification';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmtCaptionLbl: Label 'Line Amount';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        InvDiscountAmtCaptionLbl: Label 'Invoice Discount Amount';
        DocumentDateCaptionLbl: Label 'Document Date';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms';
        ShptMethodDescCaptionLbl: Label 'Shipment Method';
        VATPercentageCaptionLbl: Label 'VAT %';
        TotalCaptionLbl: Label 'Total';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        HomePageCaptionLbl: Label 'Home Page';
        EMailCaptionLbl: Label 'Email';
        VAT_Date_AdlCaptionLbl: Label 'VAT Date';
        DisplayAdditionalFeeNote: Boolean;
        LineNoWithTotal: Integer;
        VATBaseRemainderAfterRoundingLCY: Decimal;
        AmtInclVATRemainderAfterRoundingLCY: Decimal;
        // <adl.13>
        VATAmtLineVATAmtInf: Decimal;
        ShowVATInformative: Boolean;
        VATPercInfAdlCaptionLbl: Label 'VAT % (informative)';
        VATAmtInfAdlCaptionLbl: Label 'VAT Amount (informative)';
        // </adl.13>
    procedure InitLogInteraction();
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    local procedure IsReportInPreviewMode(): Boolean;
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.PREVIEW() or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure InitializeShipmentBuffer();
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        TempSalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        if "Sales Invoice Line"."Shipment No." <> '' then
            if SalesShipmentHeader.GET("Sales Invoice Line"."Shipment No.") then
                exit;

        if "Sales Invoice Header"."Order No." = '' then
            exit;

        case "Sales Invoice Line".Type of
            "Sales Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Invoice Line");
            "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource,
          "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Invoice Line");
        end;

        SalesShipmentBuffer.RESET();
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
        if SalesShipmentBuffer.FIND('-') then begin
            TempSalesShipmentBuffer := SalesShipmentBuffer;
            if SalesShipmentBuffer.NEXT() = 0 then begin
                SalesShipmentBuffer.GET(
                  TempSalesShipmentBuffer."Document No.", TempSalesShipmentBuffer."Line No.", TempSalesShipmentBuffer."Entry No.");
                SalesShipmentBuffer.DELETE();
                exit;
            end;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            if SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity then begin
                SalesShipmentBuffer.DELETEALL();
                exit;
            end;
        end;
    end;

    local procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line");
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        if ValueEntry.FIND('-') then
            repeat
                if ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") then begin
                    if SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 then
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    else
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesInvoiceLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            until (ValueEntry.NEXT() = 0) or (TotalQuantity = 0);
    end;

    local procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line");
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        if SalesInvoiceHeader.FIND('-') then
            repeat
                SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SETRANGE("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                if SalesInvoiceLine2.FIND('-') then
                    repeat
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    until SalesInvoiceLine2.NEXT() = 0;
            until SalesInvoiceHeader.NEXT() = 0;

        SalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        SalesShipmentLine.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SETRANGE("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SETRANGE("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);

        if SalesShipmentLine.FIND('-') then
            repeat
                if "Sales Invoice Header"."Get Shipment Used" then
                    CorrectShipment(SalesShipmentLine);
                if ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) then
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                else begin
                    if ABS(SalesShipmentLine.Quantity) > ABS(TotalQuantity) then
                        SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity :=
                      SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                    if SalesShipmentHeader.GET(SalesShipmentLine."Document No.") then
                        AddBufferEntry(
                          SalesInvoiceLine,
                          Quantity,
                          SalesShipmentHeader."Posting Date");
                end;
            until (SalesShipmentLine.NEXT() = 0) or (TotalQuantity = 0);
    end;

    local procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line");
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.", SalesShipmentLine."Line No.");
        if SalesInvoiceLine.FIND('-') then
            repeat
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            until SalesInvoiceLine.NEXT() = 0;
    end;

    local procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date);
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        if SalesShipmentBuffer.FIND('-') then begin
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
            SalesShipmentBuffer.MODIFY();
            exit;
        end;

        with SalesShipmentBuffer do begin
            "Document No." := SalesInvoiceLine."Document No.";
            "Line No." := SalesInvoiceLine."Line No.";
            "Entry No." := NextEntryNo;
            Type := SalesInvoiceLine.Type;
            "No." := SalesInvoiceLine."No.";
            Quantity := QtyOnShipment;
            "Posting Date" := PostingDate;
            INSERT();
            NextEntryNo := NextEntryNo + 1
        end;
    end;

    local procedure DocumentCaption(): Text[250];
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption("Sales Invoice Header", DocCaption);
        if DocCaption <> '' then
            exit(CopyStr(DocCaption, 1, 250));
        if "Sales Invoice Header"."Prepayment Invoice" then
            exit(CopyStr(SalesPrepaymentInvoiceFormatLbl, 1, 250));
        exit(CopyStr(SalesInvoiceCaptionFormatTok, 1, 250));
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; DisplayAsmInfo: Boolean);
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure FormatDocumentFields(SalesInvoiceHeader: Record "Sales Invoice Header");
    var
        LocSalesPersonText: Text[50];
    begin
        with SalesInvoiceHeader do begin
            LocSalesPersonText := SalesPersonText;
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", LocSalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");

            OrderNoText := FormatDocument.SetText("Order No." <> '', CopyStr(FIELDCAPTION("Order No."), 1, 80));
            ReferenceText := FormatDocument.SetText("Your Reference" <> '', CopyStr(FIELDCAPTION("Your Reference"), 1, 80));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', CopyStr(FIELDCAPTION("VAT Registration No."), 1, 80));
        end;
    end;

    local procedure FormatAddressFields(SalesInvoiceHeader: Record "Sales Invoice Header");
    begin
        FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
        ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);
    end;

    local procedure CollectAsmInformation();
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        TempPostedAsmLine.DELETEALL();
        if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item then
            exit;
        with ValueEntry do begin
            SETCURRENTKEY("Document No.");
            SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
            SETRANGE("Document Type", "Document Type"::"Sales Invoice");
            SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
            SETRANGE(Adjustment, false);
            if not FINDSET() then
                exit;
        end;
        repeat
            if ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") then
                if ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" then begin
                    SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) then begin
                        PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                        if PostedAsmLine.FINDSET() then
                            repeat
                                TreatAsmLineBuffer(PostedAsmLine);
                            until PostedAsmLine.NEXT() = 0;
                    end;
                end;
        until ValueEntry.NEXT() = 0;
    end;

    local procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line");
    begin
        CLEAR(TempPostedAsmLine);
        TempPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        if TempPostedAsmLine.FINDFIRST() then begin
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.MODIFY();
        end else begin
            CLEAR(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.INSERT();
        end;
    end;

    local procedure GetUOMText(UOMCode: Code[10]): Text[10];
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.GET(UOMCode) then
            exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10];
    begin
        exit(CopyStr(PADSTR('', 2, ' '), 1, 10));
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20]);
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DELETEALL();
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeaderNo);
        if not CustLedgerEntry.FINDFIRST() then
            exit;

        if not Customer.GET(CustLedgerEntry."Customer No.") then
            exit;

        LineFeeNoteOnReportHist.SETRANGE("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SETRANGE("Language Code", Customer."Language Code");
        if LineFeeNoteOnReportHist.FINDSET() then
            repeat
                InsertTempLineFeeNoteOnReportHist(LineFeeNoteOnReportHist, TempLineFeeNoteOnReportHist);
            until LineFeeNoteOnReportHist.NEXT() = 0
        else begin
            LineFeeNoteOnReportHist.SETRANGE("Language Code", Language.GetUserLanguage());
            if LineFeeNoteOnReportHist.FINDSET() then
                repeat
                    InsertTempLineFeeNoteOnReportHist(LineFeeNoteOnReportHist, TempLineFeeNoteOnReportHist);
                until LineFeeNoteOnReportHist.NEXT() = 0;
        end;
    end;

    local procedure CalcVATAmountLineLCY(SalesInvoiceHeader: Record "Sales Invoice Header"; TempVATAmountLine2: Record "VAT Amount Line" temporary; var TempVATAmountLineLCY2: Record "VAT Amount Line" temporary; var VATBaseRemainderAfterRoundingLCY2: Decimal; var AmtInclVATRemainderAfterRoundingLCY2: Decimal);
    var
        VATBaseLCY: Decimal;
        AmtInclVATLCY: Decimal;
    begin

        if (not GLSetup."Print VAT specification in LCY") or
           (SalesInvoiceHeader."Currency Code" = '')
        then
            exit;

        TempVATAmountLineLCY2.INIT();
        TempVATAmountLineLCY2 := TempVATAmountLine2;
        with SalesInvoiceHeader do begin
            VATBaseLCY :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                "Posting Date", "Currency Code", TempVATAmountLine2."VAT Base", "Currency Factor") +
              VATBaseRemainderAfterRoundingLCY2;
            AmtInclVATLCY :=
              CurrExchRate.ExchangeAmtFCYToLCY(
                "Posting Date", "Currency Code", TempVATAmountLine2."Amount Including VAT", "Currency Factor") +
              AmtInclVATRemainderAfterRoundingLCY2;
        end;
        TempVATAmountLineLCY2."VAT Base" := ROUND(VATBaseLCY);
        TempVATAmountLineLCY2."Amount Including VAT" := ROUND(AmtInclVATLCY);
        TempVATAmountLineLCY2.InsertLine();

        VATBaseRemainderAfterRoundingLCY2 := VATBaseLCY - TempVATAmountLineLCY2."VAT Base";
        AmtInclVATRemainderAfterRoundingLCY2 := AmtInclVATLCY - TempVATAmountLineLCY2."Amount Including VAT";

    end;

    local procedure InsertTempLineFeeNoteOnReportHist(var LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist."; var TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary);
    begin
        repeat
            TempLineFeeNoteOnReportHist.INIT();
            TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
            TempLineFeeNoteOnReportHist.INSERT();
        until TempLineFeeNoteOnReportHist.NEXT() = 0;
    end;

    [IntegrationEvent(false, TRUE)]
    procedure OnAfterGetRecordSalesInvoiceHeader(SalesInvoiceHeader: Record "Sales Invoice Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesInvoiceHeader: Record "Sales Invoice Header"; var DocCaption: Text);
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnGetReferenceText(SalesInvoiceHeader: Record "Sales Invoice Header"; var ReferenceText: Text[80]; var Handled: Boolean);
    begin
    end;

}