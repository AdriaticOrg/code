report 13062741 "Overdue and Uncoll.Rec-adl"
{

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportlayout/Rep13062741.OverdueandUncollRecadl.rdlc';

    Caption = 'Overdue and Uncollected Receivables';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

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
            column(Text004; Text004)
            {
            }
            column(Text005; STRSUBSTNO(Text005, FORMAT(EndDueDate, 0, '<Day,2>.<Month,2>.<Year4>'), FORMAT(EndPaymentDate, 0, '<Day,2>.<Month,2>.<Year4>')))
            {
            }
            column(TextHeaderI; TextHeaderI)
            {
            }
            column(TextHeaderI1; TextHeaderI1)
            {
            }
            column(TextHeaderI2; TextHeaderI2)
            {
            }
            column(TextHeaderI3; TextHeaderI3)
            {
            }
            column(TextHeaderII; TextHeaderII)
            {
            }
            column(TextHeaderLine1; TextHeaderLine1)
            {
            }
            column(TextHeaderLine2; TextHeaderLine2)
            {
            }
            column(TextHeaderLine3; TextHeaderLine3)
            {
            }
            column(TextHeaderLine4; TextHeaderLine4)
            {
            }
            column(TextHeaderLine5; TextHeaderLine5)
            {
            }
            column(TextHeaderLine6; TextHeaderLine6)
            {
            }
            column(TextHeaderLine7; TextHeaderLine7)
            {
            }
            column(TextHeaderLine8; TextHeaderLine8)
            {
            }
            column(TextHeaderLine9; TextHeaderLine9)
            {
            }
            column(TextHeaderLine10; TextHeaderLine10)
            {
            }
            column(TextHeaderLine11; TextHeaderLine11)
            {
            }
            column(TextHeaderLine12; TextHeaderLine12)
            {
            }
            column(TextHeaderLine13; TextHeaderLine13)
            {
            }
            column(TextHeaderLine14; TextHeaderLine14)
            {
            }
            column(TextTotal; TextTotal)
            {
            }
            column(TextTotalUpperCase; TextTotalUpperCase)
            {
            }
            column(TextHeaderIII; TextHeaderIII)
            {
            }
            column(TextHeaderIV; TextHeaderIV + FORMAT(WORKDATE, 0, '<Day,2>.<Month,2>.<Year4>'))
            {
            }
            column(TextHeaderV; TextHeaderV /* + CompanyOfficial."First Name" + ' ' + CompanyOfficial."Last Name"*/)
            {
            }
            column(TextHeaderVI; TextHeaderVI)
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
                        DetailedCustLedgEntry.RESET;
                        DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                        DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", "Entry No.");
                        DetailedCustLedgEntry.SETRANGE("Posting Date", 0D, EndPaymentDate);
                        RemainingAmount := 0;
                        RemainingAmountLCY := 0;
                        if DetailedCustLedgEntry.FINDSET then begin
                            repeat
                                if not (DetailedCustLedgEntry."Entry Type" in [DetailedCustLedgEntry."Entry Type"::"Unrealized Gain",
                                  DetailedCustLedgEntry."Entry Type"::"Unrealized Loss"]) and
                                  (DetailedCustLedgEntry."Entry Type" <> DetailedCustLedgEntry."Entry Type"::"Initial Entry") then begin
                                    RemainingAmount := RemainingAmount + DetailedCustLedgEntry.Amount;
                                    RemainingAmountLCY := RemainingAmountLCY + DetailedCustLedgEntry."Amount (LCY)";
                                end;
                            until DetailedCustLedgEntry.NEXT = 0;
                        end;

                        DetailedCustLedgEntry.RESET;
                        DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                        DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", "Entry No.");
                        DetailedCustLedgEntry.SETRANGE("Posting Date", 0D, "Cust. Ledger Entry"."Posting Date");
                        if DetailedCustLedgEntry.FINDSET then begin
                            repeat
                                if DetailedCustLedgEntry."Entry Type" = DetailedCustLedgEntry."Entry Type"::"Initial Entry" then begin
                                    RemainingAmount := RemainingAmount + DetailedCustLedgEntry.Amount;
                                    if (Customer."Country/Region Code" <> '') and (Customer."Country/Region Code" <> CompanyInformation."Country/Region Code") then begin
                                        if CustLedgerEntryExtData.GET("Entry No.", false) then
                                            RemainingAmountLCY := RemainingAmountLCY + CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal."
                                        //RemainingAmountLCY:=CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal.";
                                        else
                                            RemainingAmountLCY := RemainingAmountLCY + DetailedCustLedgEntry."Amount (LCY)";
                                    end else

                                        RemainingAmountLCY := RemainingAmountLCY + DetailedCustLedgEntry."Amount (LCY)";
                                end;
                            until DetailedCustLedgEntry.NEXT = 0;
                        end;
                        /*
                        IF (Customer."Country/Region Code" <> '') AND (Customer."Country/Region Code" <> CompanyInformation."Country/Region Code") THEN BEGIN
                          IF CustLedgerEntryExtData.GET("Entry No.",FALSE) THEN
                            RemainingAmountLCY:=RemainingAmountLCY + CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal.";
                            //RemainingAmountLCY:=CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal.";
                        END;
                        */
                        if RemainingAmount = 0 then
                            CurrReport.SKIP;

                        VATEntry.RESET;
                        VATEntry.SETCURRENTKEY("Document No.", "Posting Date"); //"VAT Date");
                        VATEntry.SETRANGE(Type, VATEntry.Type::Sale);
                        VATEntry.SETFILTER("Document No.", "Cust. Ledger Entry"."Document No.");
                        VATAmount := 0;
                        InvoiceAmount := 0;
                        if VATEntry.FINDSET then begin
                            repeat
                                InvoiceAmount := InvoiceAmount - VATEntry.Base;
                                VATAmount := VATAmount - VATEntry.Amount;
                            until VATEntry.NEXT = 0;
                        end else begin
                            if CustLedgerEntryExtData.GET("Entry No.", false) then begin
                                InvoiceAmount := CustLedgerEntryExtData."Original Document Amount (LCY)";
                                VATAmount := CustLedgerEntryExtData."Original VAT Amount (LCY)";
                            end;
                            if (InvoiceAmount = 0) and (SalesReceivablesSetup."Exteded Data Start Bal. Date" <> 0D) then
                                ERROR(STRSUBSTNO(Text011, "Entry No."));
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

                        TempOverdueandUncollectedBuffer.RESET;
                        TempBufferLineNo := 0;
                        if TempOverdueandUncollectedBuffer.FINDLAST then
                            TempBufferLineNo := TempOverdueandUncollectedBuffer."Line No.";

                        TempOverdueandUncollectedBuffer.INIT;
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
                        TempOverdueandUncollectedBuffer.INSERT;

                        TempOverdueandUncollectedBufferHeader.RESET;
                        TempOverdueandUncollectedBufferHeader.SETCURRENTKEY("VAT Registration Type", "VAT Registration No.", "Line Type");
                        TempOverdueandUncollectedBufferHeader.SETFILTER("VAT Registration Type", '%1', CustomerVATTypeInteger);
                        TempOverdueandUncollectedBufferHeader.SETFILTER("VAT Registration No.", '%1', CustomerVATRegNo);
                        TempOverdueandUncollectedBufferHeader.SETRANGE("Line Type", 0);
                        if not TempOverdueandUncollectedBufferHeader.FINDFIRST then begin
                            TempOverdueandUncollectedBufferHeader.RESET;
                            TempBufferLineNo := 0;
                            if TempOverdueandUncollectedBufferHeader.FINDLAST then
                                TempBufferLineNo := TempOverdueandUncollectedBufferHeader."Line No.";

                            TempOverdueandUncollectedBufferHeader.INIT;
                            TempOverdueandUncollectedBufferHeader."Line No." := TempBufferLineNo + 1;
                            TempOverdueandUncollectedBufferHeader."VAT Registration Type" := CustomerVATTypeInteger;
                            TempOverdueandUncollectedBufferHeader."VAT Registration No." := CustomerVATRegNo;
                            TempOverdueandUncollectedBufferHeader."Line Type" := 0;
                            TempOverdueandUncollectedBufferHeader."Customer Name" := Customer.Name;
                            TempOverdueandUncollectedBufferHeader.INSERT;
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
                        TempOverdueandUncollectedBufferHeader.MODIFY;

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
                        SETRANGE("Due Date", StartDate, EndDueDate);
                        SETRANGE("Document Date", StartDate, EndDueDate); //NEW LINE
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

                    CustLedgerEntry.RESET;
                    CustLedgerEntry.SETCURRENTKEY("Customer No.", Open, Positive, "Due Date", "Currency Code");
                    CustLedgerEntry.SETFILTER("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);
                    CustLedgerEntry.COPYFILTERS(CLEForFilter);
                    CustLedgerEntry.SETFILTER("Customer No.", "No.");
                    CustLedgerEntry.SETRANGE("Due Date", StartDate, EndDueDate);
                    CustLedgerEntry.SETRANGE("Document Date", StartDate, EndDueDate); //NEW LINE
                    CustLedgerEntry.SETFILTER("Date Filter", '..%1', EndPaymentDate);
                    RemainingAmount := 0;
                    if CustLedgerEntry.FINDSET then
                        repeat
                            //    CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                            //    RemainingAmount := RemainingAmount + CustLedgerEntry."Remaining Amt. (LCY)";
                            DetailedCustLedgEntry.RESET;
                            DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                            DetailedCustLedgEntry.SETRANGE("Posting Date", 0D, EndPaymentDate);

                            if DetailedCustLedgEntry.FINDSET then begin
                                repeat
                                    if not (DetailedCustLedgEntry."Entry Type" in [DetailedCustLedgEntry."Entry Type"::"Unrealized Gain",
                                      DetailedCustLedgEntry."Entry Type"::"Unrealized Loss"]) and
                                      (DetailedCustLedgEntry."Entry Type" <> DetailedCustLedgEntry."Entry Type"::"Initial Entry") then begin
                                        RemainingAmount := RemainingAmount + DetailedCustLedgEntry."Amount (LCY)";
                                    end;
                                until DetailedCustLedgEntry.NEXT = 0;
                            end;
                            DetailedCustLedgEntry.RESET;
                            DetailedCustLedgEntry.SETCURRENTKEY("Cust. Ledger Entry No.", "Entry Type", "Posting Date");
                            DetailedCustLedgEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgerEntry."Entry No.");
                            DetailedCustLedgEntry.SETRANGE("Posting Date", 0D, CustLedgerEntry."Posting Date");

                            if DetailedCustLedgEntry.FINDSET then begin
                                repeat
                                    if DetailedCustLedgEntry."Entry Type" = DetailedCustLedgEntry."Entry Type"::"Initial Entry" then begin
                                        RemainingAmount := RemainingAmount + DetailedCustLedgEntry."Amount (LCY)";
                                    end;
                                until DetailedCustLedgEntry.NEXT = 0;
                            end;

                        until CustLedgerEntry.NEXT = 0;

                    if RemainingAmount = 0 then
                        CurrReport.SKIP;

                    CustomerLineNo := CustomerLineNo + 1;

                    CustomerVATTypeInteger := 1;
                    if ("Country/Region Code" = '') or ("Country/Region Code" = CompanyInformation."Country/Region Code") then begin
                        CustomerVATType := Text001;
                        CustomerVATTypeInteger := 1;
                    end else begin
                        if CountryRegion.GET("Country/Region Code") then begin
                            if CountryRegion."EU Country/Region Code" <> '' then begin
                                CustomerVATType := Text002;
                                CustomerVATTypeInteger := 2;
                            end else begin
                                CustomerVATType := Text003;
                                CustomerVATTypeInteger := 3;
                            end;
                        end;
                    end;

                    if "VAT Registration No." = '' then begin
                        CustomerVATType := Text003;
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
                            TempOverdueandUncollectedBuffer.FINDFIRST
                        else
                            TempOverdueandUncollectedBuffer.NEXT;

                        LineNo := LineNo + 1;
                        /* 
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
                        end; */
                    end;

                    trigger OnPostDataItem();
                    begin
                        /*  if ExportToXML then begin
                             ExportFile.WRITE(NodeEnd('Racuni'));
                             ExportFile.WRITE(NodeEnd('Kupac'));
                         end; */
                    end;

                    trigger OnPreDataItem();
                    begin
                        TempOverdueandUncollectedBuffer.RESET;
                        TempOverdueandUncollectedBuffer.SETCURRENTKEY("VAT Registration Type", "VAT Registration No.", "Line Type");
                        TempOverdueandUncollectedBuffer.SETRANGE("VAT Registration Type", TempOverdueandUncollectedBufferHeader."VAT Registration Type");
                        TempOverdueandUncollectedBuffer.SETFILTER("VAT Registration No.", TempOverdueandUncollectedBufferHeader."VAT Registration No.");
                        TempOverdueandUncollectedBuffer.SETRANGE("Line Type", 1);
                        if TempOverdueandUncollectedBuffer.FINDSET then
                            SETRANGE(Number, 1, TempOverdueandUncollectedBuffer.COUNT)
                        else
                            CurrReport.BREAK;

                        LineNo := 0;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number = 1 then
                        TempOverdueandUncollectedBufferHeader.FINDFIRST
                    else
                        TempOverdueandUncollectedBufferHeader.NEXT;

                    if TempOverdueandUncollectedBufferHeader."Invoice Amount without VAT" = 0 then
                        CurrReport.SKIP;

                    CustomerLineNo := CustomerLineNo + 1;

                    /*if ExportToXML then begin
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
                    end; */
                end;

                trigger OnPreDataItem();
                begin

                    TempOverdueandUncollectedBufferHeader.RESET;
                    TempOverdueandUncollectedBufferHeader.SETCURRENTKEY("VAT Registration Type", "VAT Registration No.", "Line Type");
                    TempOverdueandUncollectedBufferHeader.SETRANGE("Line Type", 0);
                    if TempOverdueandUncollectedBufferHeader.FINDSET then
                        SETRANGE(Number, 1, TempOverdueandUncollectedBufferHeader.COUNT)
                    else
                        CurrReport.BREAK;

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
                        ApplicationArea = All;
                    }

                    /*  field(ExportToXML; ExportToXML)
                     {
                         Caption = 'Export to XML File';
                     } */

                    field(CompanyOfficialNo; CompanyOfficialNo)
                    {
                        Caption = 'Company InformaationB';
                        TableRelation = "Company Information";
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
        SalesReceivablesSetup.GET;
        //StartDate:=CALCDATE('-<6Y>',EndDueDate);
        StartDate := CALCDATE('-<6Y+1D>', EndDueDate); //new

        EndPaymentDate := CALCDATE('1M-1D', EndDueDate + 1);
        CLEForFilter.COPYFILTERS("Cust. Ledger Entry");

        CompanyInformation.GET;
        LocalGUID := CREATEGUID;
        LocalGUID := DELCHR(LocalGUID, '=', '{}');
        LocalGUID := LOWERCASE(LocalGUID);

        CompanyOfficial.GET(CompanyOfficialNo);

        TempOverdueandUncollectedBuffer.DELETEALL;
        TempOverdueandUncollectedBufferHeader.DELETEALL;
    end;

    trigger OnPostReport();
    begin
        /*if ExportToXML then begin
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
            ExportFile.CLOSE;
            if Total9 = 0 then begin
                if EXISTS(ServerFile) then
                    ERASE(ServerFile);
                MESSAGE(Text006);
            end else begin
                if FileMgt.IsWindowsClient then begin
                    FileMgt.DownloadToFile(ServerFile, FileName);
                    MESSAGE(STRSUBSTNO(Text010, Text009, CONVERTSTR(FileName, '\', '/')));
                end else begin
                    FileName := STRSUBSTNO(Text012, FORMAT(EndDueDate)) + '.xml';
                    DOWNLOAD(ServerFile, Text007, '', '', FileName);
                    MESSAGE(STRSUBSTNO(Text013, CONVERTSTR(FileName, '\', '/')));
                end;
            end;
        end;
        */
    end;

    var
        CompanyInformation: Record "Company Information";
        CustomerVATType: Text;
        CustomerVATTypeInteger: Integer;
        VATEntry: Record "VAT Entry";
        Text001: Label 'VAT Registration No.';
        Text002: Label 'VAT ID';
        Text003: Label 'Other';
        CountryRegion: Record "Country/Region";
        InvoiceAmount: Decimal;
        VATAmount: Decimal;
        DocumentNo: Code[20];
        NoOfOverdueDays: Integer;
        LineNo: Integer;
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        StartDate: Date;
        EndDueDate: Date;
        EndPaymentDate: Date;
        RemainingAmount: Decimal;
        RemainingAmountLCY: Decimal;
        CustomerLineNo: Integer;
        Text004: Label 'STATISTICAL REPORT';
        Text005: Label 'OF DUE, NOT PAID INVOICES ON DATE %1 WHICH WERE NOT PAID UNTIL %2';
        TextHeaderI: Label 'I. INFORMATION OF TAX PAYER/APPLICANT OF REPORT';
        TextHeaderI1: Label 'NAME/FIRST AND LAST NAME:';
        TextHeaderI2: Label 'VAT REGISTRATION NO.:';
        TextHeaderI3: Label 'ADDRESS:';
        TextHeaderII: Label 'II. INFORMATION OF DUE, NONPAID INVOICES ISSUED IN ACCORDANCE WITH VAT LAW';
        TextHeaderLine1: Label 'LINE NO.';
        TextHeaderLine2: Label 'VAT REGISTRATION NO. TYPE';
        TextHeaderLine3: Label 'VAT REGISTRATION NO.';
        TextHeaderLine4: Label 'NAME/FIRST AND LAST NAME';
        TextHeaderLine5: Label 'INVOICE LINE NO.';
        TextHeaderLine6: Label 'INVOICE NO.';
        TextHeaderLine7: Label 'DATE OF INVOICE';
        TextHeaderLine8: Label 'INVOICE DUE DATE';
        TextHeaderLine9: Label 'NO. OF OVERDUE DAYS';
        TextHeaderLine10: Label 'INVOICE AMOUNT';
        TextHeaderLine11: Label 'VAT AMOUNT';
        TextHeaderLine12: Label 'INVOICE AMOUNT INCL. VAT';
        TextHeaderLine13: Label 'PAID AMOUNT';
        TextHeaderLine14: Label 'UNPAID AMOUNT';
        TextTotal: Label 'Total';
        TextTotalUpperCase: Label 'TOTAL';
        TextHeaderIII: Label 'III. INFORMATION OF DUE, NONPAID INVOICES ISSUED IN ACCORDANCE WITH OPZ REGULATIONS';
        TextHeaderIV: Label '"IV. Date: "';
        TextHeaderV: Label '"V. Created by (first name and last name): "';
        TextHeaderVI: Label 'VI. Signature:';
        ExportToXML: Boolean;
        ExportFile: File;
        ServerFile: Text;
        FileMgt: Codeunit "File Management";
        TextError001: Label 'Error creating file on server.';
        LocalGUID: Text;
        InvoiceExportFile: File;
        InvoiceServerFilename: Text;
        CustomerTotal5: Decimal;
        CustomerTotal6: Decimal;
        CustomerTotal7: Decimal;
        CustomerTotal8: Decimal;
        CustomerTotal9: Decimal;
        FileLength: Integer;
        FileLineString: Text[1024];
        Total5: Decimal;
        Total6: Decimal;
        Total7: Decimal;
        Total8: Decimal;
        Total9: Decimal;
        Text006: Label 'No entries were found to create file.';
        LastSpacePos: Integer;
        CompanyOfficial: Record "Company Information";
        CompanyOfficialNo: Code[20];
        Text007: Label 'Export to XML File';
        Text008: Label 'XML Files (*.xml)|*.xml|All Files (*.*)|*.*';
        FileName: Text;
        Text009: Label 'File is saved on:';
        Text010: Label '%1 %2';
        CustLedgerEntryExtData: Record "Cust.Ledger Entry ExtData-adl";
        Text011: Label 'Original Invoice Amount (LCY) for Customer Ledger Entry No. %1 cannot be 0 or less.';
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CLEForFilter: Record "Cust. Ledger Entry";
        DocumentDate: Date;
        TempOverdueandUncollectedBufferHeader: Record "Overdue and Uncol. Buffer-adl" temporary;
        TempOverdueandUncollectedBuffer: Record "Overdue and Uncol. Buffer-adl" temporary;
        TempBufferLineNo: Integer;
        CustomerVATRegNo: Code[20];
        Text012: Label 'Uncollected_Ovedrue_Entries_%1';
        Text013: Label 'File %1 was created.';

    local procedure Add(Name: Text[1024]; Value: Text[1024]): Text[1024];
    begin
        Value := CheckAllowedChars(Value); //new line
        Value := DELCHR(Value, '=', '&');
        exit('<' + Name + '>' + Value + '</' + Name + '>');
    end;

    local procedure NodeStart(NodeValue: Text[1024]): Text[1024];
    begin
        exit('<' + NodeValue + '>');
    end;

    local procedure NodeEnd(NodeValue: Text[1024]): Text[1024];
    begin
        exit('</' + NodeValue + '>');
    end;

    procedure RevStrPos(String: Text[1024]; Substring: Text[1024]): Integer;
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
            if STRPOS('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-?:().,ŠĐČĆŽšđčćž@+', CharToCheck) > 0 then begin
                ExitText := ExitText + CharToCheck;
            end else begin
                ExitText := ExitText + FORMAT(' ');
            end;
        end;
        TextToConvert := ExitText;
        ExitText := DELCHR(ExitText, '<', ' ');
        ExitText := DELCHR(ExitText, '<', '-');
        exit(ExitText);
    end;
}