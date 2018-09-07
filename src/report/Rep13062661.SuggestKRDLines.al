report 13062661 "Suggest KRD Lines"
{
    UsageCategory = Administration;
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
                GenLedgSetup.get();
                GenLedgSetup.TestField("LCY Code"); 

                KRDRepLine.Reset();
                KRDRepLine.SetRange("Document No.",KRDRepHead."No.");
                if DeleteExisting then
                    KRDRepLine.DeleteAll(true);
                
                if KRDRepLine.FindLast() then
                    NewLineNo := KRDRepLine."Line No";

                InitialRep := KRDRepHead."Previous Report No." = '';                    
                   
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
        GenLedgSetup:Record "General Ledger Setup";
        InitialRep:Boolean;
        NewLineNo:Integer;
        Msg01:Label 'Processing complete';
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
        if CLE."Currency Code" = '' then
            CLE."Currency Code" := GenLedgSetup."LCY Code";
        if VLE."Currency Code" = '' then
            VLE."Currency Code" := GenLedgSetup."LCY Code";

        case EntryType of
            EntryType::Customer:
                begin
                    cle.SetRange("Date Filter",KRDRepHead."Period Start Date",KRDRepHead."Period End Date");
                    cle.CalcFields("Remaining Amount");

                    GetCLEAmts(cle,IncrAmt,DecrAmt);                   

                    KRDRepLine.Reset();
                    KRDRepLine.SetRange("Document No.",KRDRepHead."No.");
                    KRDRepLine.SetRange("Affiliation Type",cle."KRD Affiliation Type");
                    KRDRepLine.SetRange("Instrument Type",cle."KRD Instrument Type");
                    KRDRepLine.SetRange(Maturity,CLE."KRD Maturity");
                    KRDRepLine.SetRange("Claim/Liability",cle."KRD Claim/Liability");
                    KRDRepLine.SetRange("Non-Residnet Sector Code",cle."KRD Non-Residnet Sector Code");
                    KRDRepLine.SetRange("Country/Region Code",cle."KRD Country/Region Code");
                    KRDRepLine.SetRange("Currency Code",cle."Currency Code");                    
                    //KRDRepLine.SetRange("Other Changes",cle."FAS Other Changes");
                    if KRDRepLine.FindSet() then begin
                        if not cle."KRD Other Changes" then begin
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

                        KRDRepLine."Affiliation Type" := cle."KRD Affiliation Type";
                        KRDRepLine."Instrument Type" := cle."KRD Instrument Type";
                        KRDRepLine.Maturity := cle."KRD Maturity";
                        KRDRepLine."Claim/Liability" := cle."KRD Claim/Liability";
                        KRDRepLine."Non-Residnet Sector Code" := cle."KRD Non-Residnet Sector Code";
                        KRDRepLine.validate("Country/Region Code",cle."KRD Country/Region Code");
                        KRDRepLine.validate("Currency Code",cle."Currency Code");

                        KRDRepLine."Opening Balance" := GetOpeningBalance(cle."KRD Affiliation Type",cle."KRD Instrument Type",
                        cle."KRD Maturity",cle."KRD Claim/Liability",cle."KRD Non-Residnet Sector Code",cle."KRD Country/Region Code",
                         cle."Currency Code",cle."KRD Other Changes");

                        if not cle."KRD Other Changes" then begin
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
                    KRDRepLine.SetRange("Affiliation Type",VLE."KRD Affiliation Type");
                    KRDRepLine.SetRange("Instrument Type",VLE."KRD Instrument Type");
                    KRDRepLine.SetRange(Maturity,VLE."KRD Maturity");
                    KRDRepLine.SetRange("Claim/Liability",VLE."KRD Claim/Liability");
                    KRDRepLine.SetRange("Non-Residnet Sector Code",VLE."KRD Non-Residnet Sector Code");
                    KRDRepLine.SetRange("Country/Region Code",VLE."KRD Country/Region Code");
                    KRDRepLine.SetRange("Currency Code",VLE."Currency Code");
                    //KRDRepLine.SetRange("Other Changes",VLE."FAS Other Changes");
                    if KRDRepLine.FindSet() then begin
                        if not vle."KRD Other Changes" then begin
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

                        KRDRepLine."Affiliation Type" := VLE."KRD Affiliation Type";
                        KRDRepLine."Instrument Type" := VLE."KRD Instrument Type";
                        KRDRepLine.Maturity := VLE."KRD Maturity";
                        KRDRepLine."Claim/Liability" := VLE."KRD Claim/Liability";
                        KRDRepLine."Non-Residnet Sector Code" := VLE."KRD Non-Residnet Sector Code";
                        KRDRepLine.validate("Country/Region Code",VLE."KRD Country/Region Code");
                        KRDRepLine.validate("Currency Code",VLE."Currency Code");

                        KRDRepLine."Opening Balance" := GetOpeningBalance(VLE."KRD Affiliation Type",VLE."KRD Instrument Type",
                        VLE."KRD Maturity",VLE."KRD Claim/Liability",VLE."KRD Non-Residnet Sector Code",VLE."KRD Country/Region Code",
                         VLE."Currency Code",VLE."KRD Other Changes");

                        if not vle."KRD Other Changes" then begin
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
            OldCLE.SetRange("KRD Affiliation Type",AffiliationTypeCode);
            OldCLE.SetRange("KRD Instrument Type",InstrumentTypeCode);
            OldCLE.SetRange("KRD Maturity",MaturityCode);
            OldCLE.SetRange("KRD Claim/Liability",ClaimLiabType);
            OldCLE.SetRange("KRD Non-Residnet Sector Code",NonResSecCode);
            OldCLE.SetRange("KRD Country/Region Code",CountryCode);
            OldCLE.SetRange("Currency Code",CurrencyCode);
            OldCLE.SetRange("KRD Other Changes",OtherChanges);
            OldCLE.SetFilter("Date Filter",'<%1',KRDRepHead."Period Start Date");
            
            if OldCLE.FindSet() then begin
                repeat
                    GetCLEAmts(OldCLE,IncrAmt,DecrAmt);
                    OpeningBal := OpeningBal + IncrAmt - DecrAmt;
                until OldCLE.Next() = 0;
            end;

            OldVLE.Reset();
            OldVLE.SetRange("KRD Affiliation Type",AffiliationTypeCode);
            OldVLE.SetRange("KRD Instrument Type",InstrumentTypeCode);
            OldVLE.SetRange("KRD Maturity",MaturityCode);
            OldVLE.SetRange("KRD Claim/Liability",ClaimLiabType);
            OldVLE.SetRange("KRD Non-Residnet Sector Code",NonResSecCode);
            OldVLE.SetRange("KRD Country/Region Code",CountryCode);
            OldVLE.SetRange("Currency Code",CurrencyCode);
            OldVLE.SetRange("KRD Other Changes",OtherChanges);
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
                    OpeningBal := OpeningBal + OldKRDRepLine."Closing Balance";
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

        if cle."KRD Claim/Liability" = cle."KRD Claim/Liability"::Claim then begin
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

        if vle."KRD Claim/Liability" = vle."KRD Claim/Liability"::Claim then begin
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