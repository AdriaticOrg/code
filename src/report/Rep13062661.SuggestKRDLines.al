report 13062661 "Suggest KRD Lines"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Suggest KRD Lines';
    
    dataset
    {        
        dataitem("Cust. Ledger Entry";"Cust. Ledger Entry")
        {
            RequestFilterFields = "Posting Date","Document No.","Customer No.";

            trigger OnPreDataItem()
            var
                KRDRepLine:Record "KRD Report Line";
            begin
                KRDRepLine.Reset();
                KRDRepLine.SetRange("Document No.",KRDRepHead."No.");
                if DeleteExisting then
                    KRDRepLine.DeleteAll(true);
                
                if KRDRepLine.FindLast() then
                    NewLineNo := KRDRepLine."Line No";

                if KRDRepHead."Previous Report No." = '' then
                    InitialRep := true;
            end;

            trigger OnPostDataItem()
            begin                
                KRDRepHead."Last Suggest on Date" := Today;
                KRDRepHead."Last Suggest at Time" := time;
                KRDRepHead.Modify(true);
                Message(Msg01);                 
            end;

            trigger OnAfterGetRecord()
            begin
                ProcessEntry(0,"Cust. Ledger Entry","Vendor Ledger Entry");
            end;
        }
        dataitem("Vendor Ledger Entry";"Vendor Ledger Entry")
        {
            RequestFilterFields = "Posting Date","Document No.","Vendor No.";

            trigger OnAfterGetRecord()
            begin
                ProcessEntry(1,"Cust. Ledger Entry","Vendor Ledger Entry");
            end;
        }        
    }
    
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(DeleteExisting;DeleteExisting)
                    {
                        Caption = 'Delete existing lines';
                        ApplicationArea = All;                        
                    }
                }
            }
        }
    
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;                    
                }
            }
        }
    }

    var
        DeleteExisting:Boolean;
        KRDRepDocNo:Code[20];
        KRDRepHead:Record "KRD Report Header";
        InitialRep:Boolean;
        NewLineNo:Integer;
        Msg01:Label 'Processgin complete';
    procedure SetKRDRepDocNo(KRDDocNoLcl:Code[20]) 
    begin
        KRDRepDocNo := KRDDocNoLcl;        
        KRDRepHead.get(KRDRepDocNo);
    end;        
    local procedure ProcessEntry(EntryType:Option Customer,Vendor;CLE:Record "Cust. Ledger Entry";VLE:Record "Vendor Ledger Entry") 
    var
        KRDRepLine:Record "KRD Report Line";
        IncrAmt:Decimal;
        DecrAmt:Decimal;        
    begin
        case EntryType of
            EntryType::Customer:
                begin
                    cle.SetRange("Date Filter",KRDRepHead."Period Start Date",KRDRepHead."Period End Date");
                    cle.CalcFields("Remaining Amount");

                    GetCLEAmts(cle,IncrAmt,DecrAmt);                   

                    KRDRepLine.Reset();
                    KRDRepLine.SetRange("Document No.",KRDRepHead."No.");
                    KRDRepLine.SetRange("Affiliation Type",cle."FAS Affiliation Type");
                    KRDRepLine.SetRange("Instrument Type",cle."FAS Instrument Type");
                    KRDRepLine.SetRange(Maturity,CLE."FAS Maturity");
                    KRDRepLine.SetRange("Claim/Liability",cle."FAS Claim/Liability");
                    KRDRepLine.SetRange("Non-Residnet Sector Code",cle."FAS Non-Residnet Sector Code");
                    KRDRepLine.SetRange("Country/Region Code",cle."FAS Country/Region Code");
                    KRDRepLine.SetRange("Currency Code",cle."Currency Code");                    
                    //KRDRepLine.SetRange("Other Changes",cle."FAS Other Changes");
                    if KRDRepLine.FindSet() then begin
                        if not cle."FAS Other Changes" then begin
                            KRDRepLine."Increase Amount" += IncrAmt;
                            KRDRepLine."Decrease Amount" += DecrAmt;
                            KRDRepLine.Validate("Increase Amount");
                            KRDRepLine.Validate("Decrease Amount");
                        end else begin
                            KRDRepLine."Other Changes" := KRDRepLine."Other Changes" + IncrAmt - DecrAmt;
                        end;
                        KRDRepLine.Modify(true);
                    end else begin
                        NewLineNo += 10000;

                        KRDRepLine.Init();
                        KRDRepLine."Document No." := KRDRepHead."No.";
                        KRDRepLine."Line No" := NewLineNo;

                        KRDRepLine."Affiliation Type" := cle."FAS Affiliation Type";
                        KRDRepLine."Instrument Type" := cle."FAS Instrument Type";
                        KRDRepLine.Maturity := cle."FAS Maturity";
                        KRDRepLine."Claim/Liability" := cle."FAS Claim/Liability";
                        KRDRepLine."Non-Residnet Sector Code" := cle."FAS Non-Residnet Sector Code";
                        KRDRepLine.validate("Country/Region Code",cle."FAS Country/Region Code");
                        KRDRepLine.validate("Currency Code",cle."Currency Code");

                        KRDRepLine."Opening Balance" := GetOpeningBalance(cle."FAS Affiliation Type",cle."FAS Instrument Type",
                        cle."FAS Maturity",cle."FAS Claim/Liability",cle."FAS Non-Residnet Sector Code",cle."FAS Country/Region Code",
                         cle."Currency Code",cle."FAS Other Changes");

                        if not cle."FAS Other Changes" then begin
                            KRDRepLine.validate("Increase Amount",IncrAmt);
                            KRDRepLine.validate("Decrease Amount",DecrAmt);
                        end else begin
                            KRDRepLine."Other Changes" := IncrAmt - DecrAmt;
                        end;
                        KRDRepLine.Insert(true);
                    end;
                end; 
            EntryType::Vendor:
                begin
                    VLE.SetRange("Date Filter",KRDRepHead."Period Start Date",KRDRepHead."Period End Date");
                    VLE.CalcFields("Remaining Amount");

                    GetVLEAmts(VLE,IncrAmt,DecrAmt);                   

                    KRDRepLine.Reset();
                    KRDRepLine.SetRange("Document No.",KRDRepHead."No.");
                    KRDRepLine.SetRange("Affiliation Type",VLE."FAS Affiliation Type");
                    KRDRepLine.SetRange("Instrument Type",VLE."FAS Instrument Type");
                    KRDRepLine.SetRange(Maturity,VLE."FAS Maturity");
                    KRDRepLine.SetRange("Claim/Liability",VLE."FAS Claim/Liability");
                    KRDRepLine.SetRange("Non-Residnet Sector Code",VLE."FAS Non-Residnet Sector Code");
                    KRDRepLine.SetRange("Country/Region Code",VLE."FAS Country/Region Code");
                    KRDRepLine.SetRange("Currency Code",VLE."Currency Code");
                    //KRDRepLine.SetRange("Other Changes",VLE."FAS Other Changes");
                    if KRDRepLine.FindSet() then begin
                        if not vle."FAS Other Changes" then begin
                            KRDRepLine."Increase Amount" += IncrAmt;
                            KRDRepLine."Decrease Amount" += DecrAmt;
                            KRDRepLine.Validate("Increase Amount");
                            KRDRepLine.Validate("Decrease Amount");
                        end else begin
                            KRDRepLine."Other Changes" := KRDRepLine."Other Changes" + IncrAmt - DecrAmt;
                        end;
                        KRDRepLine.Modify(true);
                    end else begin
                        NewLineNo += 10000;

                        KRDRepLine.Init();
                        KRDRepLine."Document No." := KRDRepHead."No.";
                        KRDRepLine."Line No" := NewLineNo;

                        KRDRepLine."Affiliation Type" := VLE."FAS Affiliation Type";
                        KRDRepLine."Instrument Type" := VLE."FAS Instrument Type";
                        KRDRepLine.Maturity := VLE."FAS Maturity";
                        KRDRepLine."Claim/Liability" := VLE."FAS Claim/Liability";
                        KRDRepLine."Non-Residnet Sector Code" := VLE."FAS Non-Residnet Sector Code";
                        KRDRepLine.validate("Country/Region Code",VLE."FAS Country/Region Code");
                        KRDRepLine.validate("Currency Code",VLE."Currency Code");

                        KRDRepLine."Opening Balance" := GetOpeningBalance(VLE."FAS Affiliation Type",VLE."FAS Instrument Type",
                        VLE."FAS Maturity",VLE."FAS Claim/Liability",VLE."FAS Non-Residnet Sector Code",VLE."FAS Country/Region Code",
                         VLE."Currency Code",VLE."FAS Other Changes");

                        if not vle."FAS Other Changes" then begin
                            KRDRepLine.validate("Increase Amount",IncrAmt);
                            KRDRepLine.validate("Decrease Amount",DecrAmt);
                        end else begin
                            KRDRepLine."Other Changes" := IncrAmt - DecrAmt;
                        end;
                        KRDRepLine.Insert(true);
                    end;                    
                end;                              
        end;

    end;

    local procedure GetOpeningBalance(AffiliationTypeCode:code[10];InstrumentTypeCode:Code[10];MaturityCode:code[10];
    ClaimLiabType:Option " ",Claim,Liability;NonResSecCode:Code[10];CountryCode:Code[10];CurrencyCode:Code[10];OtherChanges:Boolean):Decimal
    var
        OldCLE:Record "Cust. Ledger Entry";
        OldVLE:Record "Vendor Ledger Entry";
        OldKRDRepLine:Record "KRD Report Line";
        OpeningBal:Decimal;
        IncrAmt:Decimal;
        DecrAmt:Decimal;
    begin
        if InitialRep then begin
            OldCLE.Reset();
            OldCLE.SetRange("FAS Affiliation Type",AffiliationTypeCode);
            OldCLE.SetRange("FAS Instrument Type",InstrumentTypeCode);
            OldCLE.SetRange("FAS Maturity",MaturityCode);
            OldCLE.SetRange("FAS Claim/Liability",ClaimLiabType);
            OldCLE.SetRange("FAS Non-Residnet Sector Code",NonResSecCode);
            OldCLE.SetRange("FAS Country/Region Code",CountryCode);
            OldCLE.SetRange("Currency Code",CurrencyCode);
            OldCLE.SetRange("FAS Other Changes",OtherChanges);
            OldCLE.SetFilter("Date Filter",'<%1',KRDRepHead."Period Start Date");
            
            if OldCLE.FindSet() then begin
                repeat
                    GetCLEAmts(OldCLE,IncrAmt,DecrAmt);
                    OpeningBal := OpeningBal + IncrAmt - DecrAmt;
                until OldCLE.Next() = 0;
            end;

            OldVLE.Reset();
            OldVLE.SetRange("FAS Affiliation Type",AffiliationTypeCode);
            OldVLE.SetRange("FAS Instrument Type",InstrumentTypeCode);
            OldVLE.SetRange("FAS Maturity",MaturityCode);
            OldVLE.SetRange("FAS Claim/Liability",ClaimLiabType);
            OldVLE.SetRange("FAS Non-Residnet Sector Code",NonResSecCode);
            OldVLE.SetRange("FAS Country/Region Code",CountryCode);
            OldVLE.SetRange("Currency Code",CurrencyCode);
            OldVLE.SetRange("FAS Other Changes",OtherChanges);
            OldVLE.SetFilter("Date Filter",'<%1',KRDRepHead."Period Start Date");
            
            if OldVLE.FindSet() then begin
                repeat
                    GetVLEAmts(OldVLE,IncrAmt,DecrAmt);
                    OpeningBal := OpeningBal + IncrAmt - DecrAmt;
                until OldVLE.Next() = 0;
            end;            
        end else begin
            OldKRDRepLine.Reset();
            OldKRDRepLine.SetRange("Document No.",KRDRepHead."Previous Report No.");
            OldKRDRepLine.SetRange("Affiliation Type",AffiliationTypeCode);
            OldKRDRepLine.SetRange("Instrument Type",InstrumentTypeCode);
            OldKRDRepLine.SetRange(Maturity,MaturityCode);
            OldKRDRepLine.SetRange("Claim/Liability",ClaimLiabType);
            OldKRDRepLine.SetRange("Non-Residnet Sector Code",NonResSecCode);
            OldKRDRepLine.SetRange("Country/Region Code",CountryCode);
            OldKRDRepLine.SetRange("Currency Code",CurrencyCode);
            //OldKRDRepLine.SetRange("Other Changes",OtherChanges);
            if OldKRDRepLine.FindSet() then begin
                repeat
                    OpeningBal := OpeningBal + OldKRDRepLine."Increase Amount" - OldKRDRepLine."Decrease Amount";
                until OldKRDRepLine.Next() = 0;
            end;
            
        end;

        exit(OpeningBal);

    end;
    local procedure GetCLEAmts(var CLE:Record "Cust. Ledger Entry";var IncrAmt:decimal;var DecrAmt:Decimal)
    var
    begin
        clear(IncrAmt);
        clear(DecrAmt);

        if cle."FAS Claim/Liability" = cle."FAS Claim/Liability"::Claim then begin
            if cle.Positive then
                IncrAmt := abs(cle."Remaining Amount")
            else
                DecrAmt := abs(cle."Remaining Amount");
        end else begin
            if cle.Positive then
                DecrAmt := abs(cle."Remaining Amount")
            else
                IncrAmt := abs(cle."Remaining Amount");                            
        end;        
    end;
    local procedure GetVLEAmts(var VLE:Record "Vendor Ledger Entry";var IncrAmt:decimal;var DecrAmt:Decimal)
    var
    begin
        clear(IncrAmt);
        clear(DecrAmt);

        if vle."FAS Claim/Liability" = vle."FAS Claim/Liability"::Claim then begin
            if vle.Positive then
                IncrAmt := abs(vle."Remaining Amount")
            else
                DecrAmt := abs(vle."Remaining Amount");
        end else begin
            if vle.Positive then
                DecrAmt := abs(vle."Remaining Amount")
            else
                IncrAmt := abs(vle."Remaining Amount");                            
        end;        
    end;    
}