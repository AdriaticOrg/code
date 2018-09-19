report 13062741 "Overdue and Uncoll.Rec-Adl"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportlayout/Rep13062741.OverdueandUncollRecAdl.rdlc';

    Caption = 'Overdue and Uncollected Receivables';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = AdlUnpaidReceivables;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1));
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(CompnayCity; CompanyInformation.City)
            {

            }
            column(CompanyPostCode; CompanyInformation."Post Code")
            {
            }
            column(CompanyVATRegistrationNo; CompanyInformation."VAT Registration No.")
            {
            }
            column(Text004; Text004Lbl)
            {
            }
            column(Text005; STRSUBSTNO(Text005Lbl, FORMAT(EndDueDate, 0, '<Day,2>.<Month,2>.<Year4>'), FORMAT(EndPaymentDate, 0, '<Day,2>.<Month,2>.<Year4>')))
            {
            }
            column(TextHeaderI; TextHeaderILbl)
            {
            }
            column(TextHeaderI1; TextHeaderI1Lbl)
            {
            }
            column(TextHeaderI2; TextHeaderI2Lbl)
            {
            }
            column(TextHeaderI3; TextHeaderI3Lbl)
            {
            }
            column(TextHeaderII; TextHeaderIILbl)
            {
            }
            column(TextHeaderLine1; TextHeaderLine1Lbl)
            {
            }
            column(TextHeaderLine2; TextHeaderLine2Lbl)
            {
            }
            column(TextHeaderLine3; TextHeaderLine3Lbl)
            {
            }
            column(TextHeaderLine4; TextHeaderLine4Lbl)
            {
            }
            column(TextHeaderLine5; TextHeaderLine5Lbl)
            {
            }
            column(TextHeaderLine6; TextHeaderLine6Lbl)
            {
            }
            column(TextHeaderLine7; TextHeaderLine7Lbl)
            {
            }
            column(TextHeaderLine8; TextHeaderLine8Lbl)
            {
            }
            column(TextHeaderLine9; TextHeaderLine9Lbl)
            {
            }
            column(TextHeaderLine10; TextHeaderLine10Lbl)
            {
            }
            column(TextHeaderLine11; TextHeaderLine11Lbl)
            {
            }
            column(TextHeaderLine12; TextHeaderLine12Lbl)
            {
            }
            column(TextHeaderLine13; TextHeaderLine13Lbl)
            {
            }
            column(TextHeaderLine14; TextHeaderLine14Lbl)
            {
            }
            column(TextTotal; TextTotalLbl)
            {
            }
            column(TextTotalUpperCase; TextTotalUpperCaseLbl)
            {
            }
            column(TextHeaderIII; TextHeaderIIILbl)
            {
            }
            column(TextHeaderIV; TextHeaderIVLbl + FORMAT(WorkDate(), 0, '<Day,2>.<Month,2>.<Year4>'))
            {
            }
            column(TextHeaderV; TextHeaderVLbl + ' ' + CompanyOfficial."Reporting Name-Adl")
            {
            }
            column(TextHeaderVI; TextHeaderVILbl)
            {
            }
            dataitem(Customer; Customer)
            {
                DataItemTableView = SORTING ("No.");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.";
                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Customer No." = FIELD ("No.");
                    DataItemTableView = SORTING ("Customer No.", Open, Positive, "Due Date", "Currency Code") WHERE ("Document Type" = FILTER (Invoice));
                    RequestFilterFields = "Customer No.", "Customer Posting Group";

                    trigger OnAfterGetRecord();
                    begin
                        DetailedCustLedgEntry.Reset();
                        DetailedCustLedgEntry.SetCurrentKey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                        DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", "Entry No.");
                        DetailedCustLedgEntry.SetRange("Posting Date", 0D, EndPaymentDate);
                        RemainingAmount := 0;
                        RemainingAmountLCY := 0;
                        if DetailedCustLedgEntry.findset() then
                            repeat
                                if not (DetailedCustLedgEntry."Entry Type" in [DetailedCustLedgEntry."Entry Type"::"Unrealized Gain",
                                  DetailedCustLedgEntry."Entry Type"::"Unrealized Loss"]) and
                                  (DetailedCustLedgEntry."Entry Type" <> DetailedCustLedgEntry."Entry Type"::"Initial Entry") then begin
                                    RemainingAmount := RemainingAmount + DetailedCustLedgEntry.Amount;
                                    RemainingAmountLCY := RemainingAmountLCY + DetailedCustLedgEntry."Amount (LCY)";
                                end;
                            until DetailedCustLedgEntry.Next() = 0;


                        DetailedCustLedgEntry.Reset();
                        DetailedCustLedgEntry.SetCurrentKey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                        DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", "Entry No.");
                        DetailedCustLedgEntry.SetRange("Posting Date", 0D, "Cust. Ledger Entry"."Posting Date");
                        if DetailedCustLedgEntry.findset() then
                            repeat
                                if DetailedCustLedgEntry."Entry Type" = DetailedCustLedgEntry."Entry Type"::"Initial Entry" then begin
                                    RemainingAmount := RemainingAmount + DetailedCustLedgEntry.Amount;
                                    if (Customer."Country/Region Code" <> '') and (Customer."Country/Region Code" <> CompanyInformation."Country/Region Code") then begin
                                        if CustLedgerEntryExtData.Get("Entry No.", false) then
                                            RemainingAmountLCY := RemainingAmountLCY + CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal."
                                        //RemainingAmountLCY:=CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal.";
                                        else
                                            RemainingAmountLCY := RemainingAmountLCY + DetailedCustLedgEntry."Amount (LCY)";
                                    end else

                                        RemainingAmountLCY := RemainingAmountLCY + DetailedCustLedgEntry."Amount (LCY)";
                                end;
                            until DetailedCustLedgEntry.Next() = 0;

                        /*
                        IF (Customer."Country/Region Code" <> '') AND (Customer."Country/Region Code" <> CompanyInformation."Country/Region Code") THEN BEGIN
                          IF CustLedgerEntryExtData.Get("Entry No.",FALSE) THEN
                            RemainingAmountLCY:=RemainingAmountLCY + CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal.";
                            //RemainingAmountLCY:=CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal.";
                        END;
                        */
                        if RemainingAmount = 0 then
                            CurrReport.Skip();

                        VATEntry.Reset();
                        VATEntry.SetCurrentKey("Document No.", "Posting Date"); //"VAT Date");
                        VATEntry.SetRange(Type, VATEntry.Type::Sale);
                        VATEntry.SetFilter("Document No.", "Cust. Ledger Entry"."Document No.");
                        VATAmount := 0;
                        InvoiceAmount := 0;
                        if VATEntry.findset() then
                            repeat
                                InvoiceAmount := InvoiceAmount - VATEntry.Base;
                                VATAmount := VATAmount - VATEntry.Amount;
                            until VATEntry.Next() = 0
                        else begin
                            if CustLedgerEntryExtData.Get("Entry No.", false) then begin
                                InvoiceAmount := CustLedgerEntryExtData."Original Document Amount (LCY)";
                                VATAmount := CustLedgerEntryExtData."Original VAT Amount (LCY)";
                            end;
                            if (InvoiceAmount = 0) and (UnpaidReceivablesSetup."Ext. Data Start Bal. Date-Adl" <> 0D) then
                                ERROR(STRSUBSTNO(Text011Lbl, "Entry No."));
                            InvoiceAmount := InvoiceAmount - VATAmount;
                        end;

                        //if "Cust. Ledger Entry"."Full Fisc. Doc. No." <> '' then
                        //    DocumentNo := "Cust. Ledger Entry"."Full Fisc. Doc. No."
                        //else
                        DocumentNo := "Document No.";

                        LineNo := LineNo + 1;

                        NoOfOverdueDays := EndPaymentDate - "Due Date";


                        if "Document Date" <> 0D then
                            DocumentDate := "Document Date"
                        else
                            DocumentDate := "Posting Date";

                        TempOverdueandUncollectedBuffer.Reset();
                        TempBufferLineNo := 0;
                        if TempOverdueandUncollectedBuffer.FindLast() then
                            TempBufferLineNo := TempOverdueandUncollectedBuffer."Line No.";

                        TempOverdueandUncollectedBuffer.Init();
                        TempOverdueandUncollectedBuffer."Line No." := TempBufferLineNo + 1;
                        TempOverdueandUncollectedBuffer."VAT Registration Type" := CustomerVATTypeInteger;
                        TempOverdueandUncollectedBuffer."VAT Registration No." := CustomerVATRegNo;
                        TempOverdueandUncollectedBuffer."Invoice No." := DocumentNo;
                        TempOverdueandUncollectedBuffer."Document Date" := DocumentDate;
                        TempOverdueandUncollectedBuffer."Due Date" := "Cust. Ledger Entry"."Due Date";
                        TempOverdueandUncollectedBuffer."No. of Overdue Days" := NoOfOverdueDays;
                        TempOverdueandUncollectedBuffer."Line Type" := 1;
                        TempOverdueandUncollectedBuffer."Invoice Amount without VAT" := TempOverdueandUncollectedBuffer."Invoice Amount without VAT" +
                          InvoiceAmount;
                        TempOverdueandUncollectedBuffer."VAT Amount" := TempOverdueandUncollectedBuffer."VAT Amount" +
                          VATAmount;
                        TempOverdueandUncollectedBuffer."Invoice Amount Incl. VAT" := TempOverdueandUncollectedBuffer."Invoice Amount Incl. VAT" +
                          InvoiceAmount + VATAmount;
                        TempOverdueandUncollectedBuffer."Paid Amount" := TempOverdueandUncollectedBuffer."Paid Amount" +
                          (VATAmount + InvoiceAmount - RemainingAmountLCY);
                        TempOverdueandUncollectedBuffer."Unpaid Amount" := TempOverdueandUncollectedBuffer."Unpaid Amount" +
                          RemainingAmountLCY;
                        TempOverdueandUncollectedBuffer.Insert();

                        TempOverdueandUncollectedBufferHeader.Reset();
                        TempOverdueandUncollectedBufferHeader.SetCurrentKey("VAT Registration Type", "VAT Registration No.", "Line Type");
                        TempOverdueandUncollectedBufferHeader.SetFilter("VAT Registration Type", '%1', CustomerVATTypeInteger);
                        TempOverdueandUncollectedBufferHeader.SetFilter("VAT Registration No.", '%1', CustomerVATRegNo);
                        TempOverdueandUncollectedBufferHeader.SetRange("Line Type", 0);
                        if not TempOverdueandUncollectedBufferHeader.FindFirst() then begin
                            TempOverdueandUncollectedBufferHeader.Reset();
                            TempBufferLineNo := 0;
                            if TempOverdueandUncollectedBufferHeader.FindLast() then
                                TempBufferLineNo := TempOverdueandUncollectedBufferHeader."Line No.";

                            TempOverdueandUncollectedBufferHeader.Init();
                            TempOverdueandUncollectedBufferHeader."Line No." := TempBufferLineNo + 1;
                            TempOverdueandUncollectedBufferHeader."VAT Registration Type" := CustomerVATTypeInteger;
                            TempOverdueandUncollectedBufferHeader."VAT Registration No." := CustomerVATRegNo;
                            TempOverdueandUncollectedBufferHeader."Line Type" := 0;
                            TempOverdueandUncollectedBufferHeader."Customer Name" := Customer.Name;
                            TempOverdueandUncollectedBufferHeader.Insert();
                        end;

                        TempOverdueandUncollectedBufferHeader."Invoice Amount without VAT" := TempOverdueandUncollectedBufferHeader."Invoice Amount without VAT" +
                          TempOverdueandUncollectedBuffer."Invoice Amount without VAT";
                        TempOverdueandUncollectedBufferHeader."VAT Amount" := TempOverdueandUncollectedBufferHeader."VAT Amount" +
                          TempOverdueandUncollectedBuffer."VAT Amount";
                        TempOverdueandUncollectedBufferHeader."Invoice Amount Incl. VAT" := TempOverdueandUncollectedBufferHeader."Invoice Amount Incl. VAT" +
                          TempOverdueandUncollectedBuffer."Invoice Amount Incl. VAT";
                        TempOverdueandUncollectedBufferHeader."Paid Amount" := TempOverdueandUncollectedBufferHeader."Paid Amount" +
                          TempOverdueandUncollectedBuffer."Paid Amount";
                        TempOverdueandUncollectedBufferHeader."Unpaid Amount" := TempOverdueandUncollectedBufferHeader."Unpaid Amount" +
                          TempOverdueandUncollectedBuffer."Unpaid Amount";
                        TempOverdueandUncollectedBufferHeader.Modify();

                        if ExportToXML then begin
                            CustomerTotal5 := CustomerTotal5 + InvoiceAmount;
                            CustomerTotal6 := CustomerTotal6 + VATAmount;
                            CustomerTotal7 := CustomerTotal7 + InvoiceAmount + VATAmount;
                            CustomerTotal8 := CustomerTotal8 + InvoiceAmount + VATAmount - RemainingAmountLCY;
                            CustomerTotal9 := CustomerTotal9 + RemainingAmountLCY;

                            Total5 := Total5 + InvoiceAmount;
                            Total6 := Total6 + VATAmount;
                            Total7 := Total7 + InvoiceAmount + VATAmount;
                            Total8 := Total8 + InvoiceAmount + VATAmount - RemainingAmountLCY;
                            Total9 := Total9 + RemainingAmountLCY;
                        end;

                    end;

                    trigger OnPostDataItem();
                    begin


                    end;

                    trigger OnPreDataItem();
                    begin
                        SetRange("Due Date", StartDate, EndDueDate);
                        SetRange("Document Date", StartDate, EndDueDate); //NEW LINE
                        LineNo := 0;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CustomerTotal5 := 0;
                    CustomerTotal6 := 0;
                    CustomerTotal7 := 0;
                    CustomerTotal8 := 0;
                    CustomerTotal9 := 0;

                    CustLedgerEntry.Reset();
                    CustLedgerEntry.SetCurrentKey("Customer No.", Open, Positive, "Due Date", "Currency Code");
                    CustLedgerEntry.SetFilter("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);
                    CustLedgerEntry.COPYFILTERS(CLEForFilter);
                    CustLedgerEntry.SetFilter("Customer No.", "No.");
                    CustLedgerEntry.SetRange("Due Date", StartDate, EndDueDate);
                    CustLedgerEntry.SetRange("Document Date", StartDate, EndDueDate); //NEW LINE
                    CustLedgerEntry.SetFilter("Date Filter", '..%1', EndPaymentDate);
                    RemainingAmount := 0;
                    if CustLedgerEntry.findset() then
                        repeat
                            //    CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                            //    RemainingAmount := RemainingAmount + CustLedgerEntry."Remaining Amt. (LCY)";
                            DetailedCustLedgEntry.Reset();
                            DetailedCustLedgEntry.SetCurrentKey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                            DetailedCustLedgEntry.SetRange("Posting Date", 0D, EndPaymentDate);

                            if DetailedCustLedgEntry.findset() then
                                repeat
                                    if not (DetailedCustLedgEntry."Entry Type" in [DetailedCustLedgEntry."Entry Type"::"Unrealized Gain",
                                      DetailedCustLedgEntry."Entry Type"::"Unrealized Loss"]) and
                                      (DetailedCustLedgEntry."Entry Type" <> DetailedCustLedgEntry."Entry Type"::"Initial Entry") then
                                        RemainingAmount := RemainingAmount + DetailedCustLedgEntry."Amount (LCY)";
                                until DetailedCustLedgEntry.Next() = 0;

                            DetailedCustLedgEntry.Reset();
                            DetailedCustLedgEntry.SetCurrentKey("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                            DetailedCustLedgEntry.SetRange("Posting Date", 0D, CustLedgerEntry."Posting Date");

                            if DetailedCustLedgEntry.findset() then
                                repeat
                                    if DetailedCustLedgEntry."Entry Type" = DetailedCustLedgEntry."Entry Type"::"Initial Entry" then
                                        RemainingAmount := RemainingAmount + DetailedCustLedgEntry."Amount (LCY)";
                                until DetailedCustLedgEntry.Next() = 0;

                        until CustLedgerEntry.Next() = 0;

                    if RemainingAmount = 0 then
                        CurrReport.Skip();

                    CustomerLineNo := CustomerLineNo + 1;

                    CustomerVATTypeInteger := 1;
                    if ("Country/Region Code" = '') or ("Country/Region Code" = CompanyInformation."Country/Region Code") then begin
                        CustomerVATType := Text001Lbl;
                        CustomerVATTypeInteger := 1;
                    end else
                        if CountryRegion.Get("Country/Region Code") then
                            if CountryRegion."EU Country/Region Code" <> '' then begin
                                CustomerVATType := Text002Lbl;
                                CustomerVATTypeInteger := 2;
                            end else begin
                                CustomerVATType := Text003Lbl;
                                CustomerVATTypeInteger := 3;
                            end;

                    if "VAT Registration No." = '' then begin
                        CustomerVATType := Text003Lbl;
                        CustomerVATTypeInteger := 3;
                    end;

                    if "VAT Registration No." = '' then
                        CustomerVATRegNo := "No."
                    else
                        CustomerVATRegNo := "VAT Registration No.";

                end;

                trigger OnPreDataItem();
                begin
                    CustomerLineNo := 0;
                end;
            }
            dataitem(TempHeader; "Integer")
            {
                DataItemTableView = SORTING (Number);
                PrintOnlyIfDetail = true;
                column(CustomerLineNo; CustomerLineNo)
                {
                }
                column(CustomerName; TempOverdueandUncollectedBufferHeader."Customer Name")
                {
                }
                column(CustomerVATRegistrationNo; TempOverdueandUncollectedBufferHeader."VAT Registration No.")
                {
                }
                column(CustomerVATType; TempOverdueandUncollectedBufferHeader."VAT Registration Type")
                {
                }
                dataitem(TempLine; "Integer")
                {
                    DataItemTableView = SORTING (Number);
                    column(LineNo; LineNo)
                    {
                    }
                    column(DocumentNo; TempOverdueandUncollectedBuffer."Invoice No.")
                    {
                    }
                    column(DocumentDate; TempOverdueandUncollectedBuffer."Document Date")
                    {
                    }
                    column(DocumentDueDate; TempOverdueandUncollectedBuffer."Due Date")
                    {
                    }
                    column(DocumentOverDueDays; TempOverdueandUncollectedBuffer."No. of Overdue Days")
                    {
                    }
                    column(DocumentInvoiceAmount; TempOverdueandUncollectedBuffer."Invoice Amount without VAT")
                    {
                    }
                    column(DocumentVATAmount; TempOverdueandUncollectedBuffer."VAT Amount")
                    {
                    }
                    column(DocumentTotal; TempOverdueandUncollectedBuffer."Invoice Amount Incl. VAT")
                    {
                    }
                    column(DocumentPaidAmount; TempOverdueandUncollectedBuffer."Paid Amount")
                    {
                    }
                    column(DocumentRemainingAmount; TempOverdueandUncollectedBuffer."Unpaid Amount")
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if Number = 1 then
                            TempOverdueandUncollectedBuffer.FindFirst()
                        else
                            TempOverdueandUncollectedBuffer.Next();

                        LineNo := LineNo + 1;

                        if ExportToXML then begin
                            ExportFile.WRITE(NodeStart('Racun'));

                            ExportFile.WRITE(Add('R1', FORMAT(LineNo)));
                            ExportFile.WRITE(Add('R2', TempOverdueandUncollectedBuffer."Invoice No."));
                            ExportFile.WRITE(Add('R3', FORMAT(TempOverdueandUncollectedBuffer."Document Date", 0, '<Year4,4>-<Month,2>-<Day,2>')));
                            ExportFile.WRITE(Add('R4', FORMAT(TempOverdueandUncollectedBuffer."Due Date", 0, '<Year4,4>-<Month,2>-<Day,2>')));
                            ExportFile.WRITE(Add('R5', FORMAT(TempOverdueandUncollectedBuffer."No. of Overdue Days")));
                            ExportFile.WRITE(Add('R6', FORMAT(TempOverdueandUncollectedBuffer."Invoice Amount without VAT", 0, '<Precision,2:2><Standard Format,9>')));
                            ExportFile.WRITE(Add('R7', FORMAT(TempOverdueandUncollectedBuffer."VAT Amount", 0, '<Precision,2:2><Standard Format,9>')));
                            ExportFile.WRITE(Add('R8', FORMAT(TempOverdueandUncollectedBuffer."Invoice Amount Incl. VAT", 0, '<Precision,2:2><Standard Format,9>')));
                            ExportFile.WRITE(Add('R9', FORMAT(TempOverdueandUncollectedBuffer."Paid Amount", 0, '<Precision,2:2><Standard Format,9>')));
                            ExportFile.WRITE(Add('R10', FORMAT(TempOverdueandUncollectedBuffer."Unpaid Amount", 0, '<Precision,2:2><Standard Format,9>')));
                            ExportFile.WRITE(NodeEnd('Racun'));
                        end;
                    end;

                    trigger OnPostDataItem();
                    begin
                        if ExportToXML then begin
                            ExportFile.WRITE(NodeEnd('Racuni'));
                            ExportFile.WRITE(NodeEnd('Kupac'));
                        end;
                    end;

                    trigger OnPreDataItem();
                    begin


                        TempOverdueandUncollectedBuffer.Reset();
                        TempOverdueandUncollectedBuffer.SetCurrentKey("VAT Registration Type", "VAT Registration No.", "Line Type");
                        TempOverdueandUncollectedBuffer.SetRange("VAT Registration Type", TempOverdueandUncollectedBufferHeader."VAT Registration Type");
                        TempOverdueandUncollectedBuffer.SetFilter("VAT Registration No.", TempOverdueandUncollectedBufferHeader."VAT Registration No.");
                        TempOverdueandUncollectedBuffer.SetRange("Line Type", 1);
                        if TempOverdueandUncollectedBuffer.findset() then
                            SetRange(Number, 1, TempOverdueandUncollectedBuffer.Count())
                        else
                            CurrReport.Break();

                        LineNo := 0;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number = 1 then
                        TempOverdueandUncollectedBufferHeader.FindFirst()
                    else
                        TempOverdueandUncollectedBufferHeader.Next();

                    if TempOverdueandUncollectedBufferHeader."Invoice Amount without VAT" = 0 then
                        CurrReport.Skip();

                    CustomerLineNo := CustomerLineNo + 1;

                    if ExportToXML then begin
                        ExportFile.WRITE(NodeStart('Kupac'));
                        ExportFile.WRITE(Add('K1', FORMAT(CustomerLineNo)));
                        ExportFile.WRITE(Add('K2', FORMAT(TempOverdueandUncollectedBufferHeader."VAT Registration Type")));
                        ExportFile.WRITE(Add('K3', TempOverdueandUncollectedBufferHeader."VAT Registration No."));
                        ExportFile.WRITE(Add('K4', TempOverdueandUncollectedBufferHeader."Customer Name"));
                        ExportFile.WRITE(Add('K5', FORMAT(TempOverdueandUncollectedBufferHeader."Invoice Amount without VAT", 0, '<Precision,2:2><Standard Format,9>')));
                        ExportFile.WRITE(Add('K6', FORMAT(TempOverdueandUncollectedBufferHeader."VAT Amount", 0, '<Precision,2:2><Standard Format,9>')));
                        ExportFile.WRITE(Add('K7', FORMAT(TempOverdueandUncollectedBufferHeader."Invoice Amount Incl. VAT", 0, '<Precision,2:2><Standard Format,9>')));
                        ExportFile.WRITE(Add('K8', FORMAT(TempOverdueandUncollectedBufferHeader."Paid Amount", 0, '<Precision,2:2><Standard Format,9>')));
                        ExportFile.WRITE(Add('K9', FORMAT(TempOverdueandUncollectedBufferHeader."Unpaid Amount", 0, '<Precision,2:2><Standard Format,9>')));
                        ExportFile.WRITE(NodeStart('Racuni'));
                    end;
                end;

                trigger OnPreDataItem();
                begin

                    TempOverdueandUncollectedBufferHeader.Reset();
                    TempOverdueandUncollectedBufferHeader.SetCurrentKey("VAT Registration Type", "VAT Registration No.", "Line Type");
                    TempOverdueandUncollectedBufferHeader.SetRange("Line Type", 0);
                    if TempOverdueandUncollectedBufferHeader.findset() then
                        SetRange(Number, 1, TempOverdueandUncollectedBufferHeader.Count())
                    else
                        CurrReport.Break();

                    CustomerLineNo := 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                Total5 := 0;
                Total6 := 0;
                Total7 := 0;
                Total8 := 0;
                Total9 := 0;
            end;
        }
    }

    requestpage
    {
        Caption = 'Overdue and Uncollected Receivables';

        layout
        {
            area(content)
            {
                group(Control3)
                {
                    Caption = 'General';
                    field(EndDueDate; EndDueDate)
                    {
                        Caption = 'Until Due Date';
                        ToolTip = 'Enter Due Date';
                        ApplicationArea = All;
                    }

                    field(ExportToXML; ExportToXML)
                    {
                        Caption = 'Export to XML File';
                        ToolTip = 'Selet to export file to XML';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            CreateStream();
                        end;
                    }

                    field(CompanyOfficialNo; CompanyOfficialNo)
                    {
                        Caption = 'Company official';
                        ToolTip = 'Select Company official';
                        TableRelation = "User Setup"."User ID";
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        UnpaidReceivablesSetup.Get();
        //StartDate:=CALCDATE('-<6Y>',EndDueDate);
        StartDate := CALCDATE('-<6Y+1D>', EndDueDate); //new

        EndPaymentDate := CALCDATE('1M-1D', EndDueDate + 1);
        CLEForFilter.COPYFILTERS("Cust. Ledger Entry");

        CompanyInformation.Get();
        LocalGUID := CreateGuid();
        LocalGUID := DELCHR(LocalGUID, '=', '{}');
        LocalGUID := LOWERCASE(LocalGUID);

        CompanyOfficial.Get(CompanyOfficialNo);

        TempOverdueandUncollectedBuffer.DeleteAll();
        TempOverdueandUncollectedBufferHeader.DeleteAll();

    end;

    trigger OnPostReport();
    begin
        if ExportToXML then begin
            ExportFile.WRITE(NodeEnd('Kupci'));
            ExportFile.WRITE(Add('UkupanIznosRacunaObrasca', FORMAT(Total5, 0, '<Precision,2:2><Standard Format,9>')));
            ExportFile.WRITE(Add('UkupanIznosPdvObrasca', FORMAT(Total6, 0, '<Precision,2:2><Standard Format,9>')));
            ExportFile.WRITE(Add('UkupanIznosRacunaSPdvObrasca', FORMAT(Total7, 0, '<Precision,2:2><Standard Format,9>')));
            ExportFile.WRITE(Add('UkupniPlaceniIznosRacunaObrasca', FORMAT(Total8, 0, '<Precision,2:2><Standard Format,9>')));
            ExportFile.WRITE(Add('NeplaceniIznosRacunaObrasca', FORMAT(Total9, 0, '<Precision,2:2><Standard Format,9>')));
            ExportFile.WRITE(Add('OPZUkupanIznosRacunaSPdv', '0.00'));
            ExportFile.WRITE(Add('OPZUkupanIznosPdv', '0.00'));
            ExportFile.WRITE(NodeEnd('Tijelo'));
            ExportFile.WRITE(NodeEnd('ObrazacOPZ'));

            if Total9 = 0 then
                MESSAGE(Text006Lbl)
            else begin
                FileName := STRSUBSTNO(Text012Lbl, FORMAT(EndDueDate)) + '.xml';
                Download(Text007Lbl, Text008Lbl, FileName);
                MESSAGE(STRSUBSTNO(Text013Lbl, CONVERTSTR(FileName, '\', '/')));
            end;
        end;
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyOfficial: Record "User Setup";
        UnpaidReceivablesSetup: Record "Unpaid Receivables Setup-Adl";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CLEForFilter: Record "Cust. Ledger Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        VATEntry: Record "VAT Entry";
        CountryRegion: Record "Country/Region";
        TempOverdueandUncollectedBufferHeader: Record "Overdue and Uncol. Buffer-Adl" temporary;
        TempOverdueandUncollectedBuffer: Record "Overdue and Uncol. Buffer-Adl" temporary;
        CustLedgerEntryExtData: Record "Cust.Ledger Entry ExtData-Adl";
        TmpBlobTemp: Record "TempBlob" temporary;
        FileMgt: Codeunit "File Management";
        TextWriter: Codeunit "TextWriter-Adl";
        ExportFile: OutStream;
        CustomerVATType: Text;
        CustomerVATTypeInteger: Integer;
        Text001Lbl: Label 'VAT Registration No.';
        Text002Lbl: Label 'VAT ID';
        Text003Lbl: Label 'Other';
        InvoiceAmount: Decimal;
        VATAmount: Decimal;
        DocumentNo: Code[20];
        NoOfOverdueDays: Integer;
        LineNo: Integer;
        StartDate: Date;
        EndDueDate: Date;
        EndPaymentDate: Date;
        RemainingAmount: Decimal;
        RemainingAmountLCY: Decimal;
        CustomerLineNo: Integer;
        Text004Lbl: Label 'STATISTICAL REPORT';
        Text005Lbl: Label 'OF DUE, NOT PAID INVOICES ON DATE %1 WHICH WERE NOT PAID UNTIL %2';
        TextHeaderILbl: Label 'I. INFORMATION OF TAX PAYER/APPLICANT OF REPORT';
        TextHeaderI1Lbl: Label 'NAME/FIRST AND LAST NAME:';
        TextHeaderI2Lbl: Label 'VAT REGISTRATION NO.:';
        TextHeaderI3Lbl: Label 'ADDRESS:';
        TextHeaderIILbl: Label 'II. INFORMATION OF DUE, NONPAID INVOICES ISSUED IN ACCORDANCE WITH VAT LAW';
        TextHeaderLine1Lbl: Label 'LINE NO.';
        TextHeaderLine2Lbl: Label 'VAT REGISTRATION NO. TYPE';
        TextHeaderLine3Lbl: Label 'VAT REGISTRATION NO.';
        TextHeaderLine4Lbl: Label 'NAME/FIRST AND LAST NAME';
        TextHeaderLine5Lbl: Label 'INVOICE LINE NO.';
        TextHeaderLine6Lbl: Label 'INVOICE NO.';
        TextHeaderLine7Lbl: Label 'DATE OF INVOICE';
        TextHeaderLine8Lbl: Label 'INVOICE DUE DATE';
        TextHeaderLine9Lbl: Label 'NO. OF OVERDUE DAYS';
        TextHeaderLine10Lbl: Label 'INVOICE AMOUNT';
        TextHeaderLine11Lbl: Label 'VAT AMOUNT';
        TextHeaderLine12Lbl: Label 'INVOICE AMOUNT INCL. VAT';
        TextHeaderLine13Lbl: Label 'PAID AMOUNT';
        TextHeaderLine14Lbl: Label 'UNPAID AMOUNT';
        TextTotalLbl: Label 'Total';
        TextTotalUpperCaseLbl: Label 'TOTAL';
        TextHeaderIIILbl: Label 'III. INFORMATION OF DUE, NONPAID INVOICES ISSUED IN ACCORDANCE WITH OPZ REGULATIONS';
        TextHeaderIVLbl: Label '"IV. Date: "';
        TextHeaderVLbl: Label '"V. Created by (first name and last name): "';
        TextHeaderVILbl: Label 'VI. Signature:';
        ExportToXML: Boolean;
        ServerFile: Text;
        TextError001Lbl: Label 'Error creating file on server.';
        LocalGUID: Text;
        InvoiceExportFile: File;
        CustomerTotal5: Decimal;
        CustomerTotal6: Decimal;
        CustomerTotal7: Decimal;
        CustomerTotal8: Decimal;
        CustomerTotal9: Decimal;
        FileLength: Integer;
        FileLineString: Text;
        Total5: Decimal;
        Total6: Decimal;
        Total7: Decimal;
        Total8: Decimal;
        Total9: Decimal;
        Text006Lbl: Label 'No entries were found to create file.';
        LastSpacePos: Integer;
        CompanyOfficialNo: Code[20];
        Text007Lbl: Label 'Export to XML File';
        Text008Lbl: Label 'XML Files (*.xml)|*.xml|All Files (*.*)|*.*';
        FileName: Text;
        Text009Lbl: Label 'File is saved on:';
        Text010Lbl: Label '%1 %2';
        Text011Lbl: Label 'Original Invoice Amount (LCY) for Customer Ledger Entry No. %1 cannot be 0 or less.';
        DocumentDate: Date;
        TempBufferLineNo: Integer;
        CustomerVATRegNo: Code[20];
        Text012Lbl: Label 'Uncollected_Ovedrue_Entries_%1';
        Text013Lbl: Label 'File %1 was created.';

    local procedure Add(Name: Text; Value: Text): Text;
    begin
        Value := CopyStr(CheckAllowedChars(Value), 1, MaxStrLen(Value)); //new line
        Value := CopyStr(DelChr(Value, '=', '&'), 1, MaxStrLen(Value));
        exit(CopyStr('<' + Name + '>' + Value + '</' + Name + '>', 1, MaxStrLen(Value)));
    end;

    local procedure NodeStart(NodeValue: Text): Text;
    begin
        exit(CopyStr('<' + NodeValue + '>', 1, MaxStrLen(NodeValue)));
    end;

    local procedure NodeEnd(NodeValue: Text): Text;
    begin
        exit(CopyStr('</' + NodeValue + '>', 1, MaxStrLen(NodeValue)));
    end;

    procedure RevStrPos(String: Text; Substring: Text): Integer;
    var
        i: Integer;
        SubstringLen: Integer;
        Found: Boolean;
    begin
        i := STRLEN(String);
        SubstringLen := STRLEN(Substring);

        if (i = 0) or (SubstringLen = 0) then
            exit(0);
        if SubstringLen > i then
            exit(0);

        Found := false;
        repeat
            if COPYSTR(String, i, SubstringLen) = Substring then
                Found := true
            else
                i -= 1;
        until (Found) or (i < 1);

        if Found then
            exit(i)
        else
            exit(0);
    end;

    local procedure CheckAllowedChars(TextToConvert: Text): Text;
    var
        ExitText: Text;
        I: Integer;
        CharToCheck: Text[1];
    begin
        ExitText := '';
        for I := 1 to STRLEN(TextToConvert) do begin
            CharToCheck := COPYSTR(TextToConvert, I, 1);
            if STRPOS('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-?:().,ŠĐČĆŽšđčćž@+', CharToCheck) > 0 then
                ExitText := ExitText + CharToCheck
            else
                ExitText := ExitText + FORMAT(' ');
        end;
        TextToConvert := ExitText;
        ExitText := DELCHR(ExitText, '<', ' ');
        ExitText := DELCHR(ExitText, '<', '-');
        exit(ExitText);
    end;

    local procedure CreateStream()
    begin
        TmpBlobTemp.Blob.CreateOutStream(ExportFile, TextEncoding::UTF8);
    end;

    procedure Download(DialogTitle: Text; ToFilter: Text; FileName: Text);
    var
        InStr: InStream;
    begin
        TmpBlobTemp.Blob.CreateInStream(InStr, TextEncoding::UTF8);
        File.DownloadFromStream(InStr, DialogTitle, '', ToFilter, FileName);
    end;
}