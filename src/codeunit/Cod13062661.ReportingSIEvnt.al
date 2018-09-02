codeunit 13062661 "Reporting SI Evnt."
{
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostCustomerEntry', '', false,false)]
    local procedure PostCustEntry(VAR GenJnlLine : Record "Gen. Journal Line";SalesHeader : Record "Sales Header";VAR TotalSalesLine : Record "Sales Line";VAR TotalSalesLineLCY : Record "Sales Line";CommitIsSuppressed : Boolean;PreviewMode:Boolean)
    var
        Cust:Record Customer;
    begin
        with GenJnlLine do begin
            if Cust.get("Account No.") then
                "FAS Sector Code" := Cust."FAS Sector Code";
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostVendorEntry', '', false,false)]
    local procedure PostVendEntry(VAR GenJnlLine : Record "Gen. Journal Line";PurchHeader : Record "Sales Header";VAR TotalPurchLine : Record "Purchase Line";VAR TotalPurchLineLCY : Record "Purchase Line";PreviewMode:Boolean;CommitIsSupressed:Boolean)
    var
        Vend:Record Vendor;
    begin
        with GenJnlLine do begin
            if Vend.get("Account No.") then
                "FAS Sector Code" := Vend."FAS Sector Code";
        end;
    end;    

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforePostGenJnlLine', '', false,false)]
    local procedure PostGenJnlLine(VAR GenJournalLine : Record "Gen. Journal Line";Balancing : Boolean)
    var
        Cust:Record Customer;
        Vend:Record Vendor;
        BankAcc:Record "Bank Account";
    begin
        with GenJournalLine do begin
            case "Source Type" of
                "Source Type"::Customer:
                    begin
                        if Cust.get("Source No.") then
                            "FAS Sector Code" := Cust."FAS Sector Code";
                    end;
                "Source Type"::Vendor:
                    begin
                        if Vend.get("Source No.") then
                            "FAS Sector Code" := Vend."FAS Sector Code";
                    end;
                "Source Type"::"Bank Account":
                    begin
                        if BankAcc.get("Source No.") then begin
                            "FAS Instrument Code" := BankAcc."FAS Instrument Code";
                            "FAS Sector Code" := BankAcc."FAS Sector Code";
                        end;

                    end;
            end;
            case "Account Type" of
                "Account Type"::Customer:
                    begin
                        if Cust.get("Account No.") then
                            "FAS Sector Code" := Cust."FAS Sector Code";
                    end;
                "Account Type"::Vendor:
                    begin
                        if Vend.get("Account No.") then
                            "FAS Sector Code" := vend."FAS Sector Code";
                    end;
                "Account Type"::"Bank Account":
                    begin
                        if BankAcc.get("Account No.") then begin
                            "FAS Sector Code" := BankAcc."FAS Sector Code";
                            "FAS Instrument Code" := BankAcc."FAS Instrument Code";
                        end;
                    end;            
            end
        end;
        
    end;
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertGlobalGLEntry', '', false, false)]
    local procedure GLEntryInsert(VAR GlobalGLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        GLAcc: Record "G/L Account";
        AccNo:Code[20];
    begin 
        if GlobalGLEntry."G/L Account No." = GenJournalLine."Bal. Account No." then begin
            GenJournalLine."FAS Sector Code" := GenJournalLine."Bal. FAS Sector Code";
            GenJournalLine."FAS Instrument Code" := GenJournalLine."Bal. FAS Instrument Code";
        end;
        if GLAcc.GET(GlobalGLEntry."G/L Account No.") then begin
            if GLAcc."FAS Account" then begin
                case GLAcc."FAS Instrument Posting" of
                    GLAcc."FAS Instrument Posting"::" ":
                        begin
                            GlobalGLEntry."FAS Instrument Code" := GenJournalLine."FAS Instrument Code";                            
                        end;
                    GLAcc."FAS Instrument Posting"::"Code Mandatory":
                        begin
                            GenJournalLine.TestField("FAS Instrument Code");                            
                            GlobalGLEntry."FAS Instrument Code" := GenJournalLine."FAS Instrument Code";                            
                        end;
                    GLAcc."FAS Instrument Posting"::"Same Code":
                        begin
                            GlobalGLEntry."FAS Instrument Code" := GLAcc."FAS Instrument Code";
                        end;
                    GLAcc."FAS Instrument Posting"::"No Code":
                        begin
                            GenJournalLine.TestField("FAS Instrument Code", '');
                        end;
                end;

                case GLAcc."FAS Sector Posting" of
                    GLAcc."FAS Sector Posting"::" ":
                        begin                            
                            GlobalGLEntry."FAS Sector Code" := GenJournalLine."FAS Sector Code";
                        end;
                    GLAcc."FAS Sector Posting"::"Code Mandatory":
                        begin
                            GenJournalLine.TestField("FAS Sector Code");                            
                            GlobalGLEntry."FAS Sector Code" := GenJournalLine."FAS Sector Code";                            
                        end;
                    GLAcc."FAS Sector Posting"::"Same Code":
                        begin
                            GlobalGLEntry."FAS Sector Code" := GLAcc."FAS Sector Code";                            
                        end;
                    GLAcc."FAS Sector Posting"::"No Code":
                        begin
                            GenJournalLine.TestField("FAS Sector Code", '');                        
                        end;
                end;                

                GlobalGLEntry."BST Code" := GLAcc."BST Code";
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure CustLedgEntryInsert(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        CustPstgGrp: Record "Customer Posting Group";
        ReportSISetup:Record "Reporting_SI Setup";

    begin
        ReportSISetup.Get();
        ReportSISetup.TestField("Default KRD Affiliation Type"); 

        if Cust.get(CustLedgerEntry."Customer No.") then begin
            CustLedgerEntry."KRD Country/Region Code" := Cust."Country/Region Code";
            CustLedgerEntry."FAS Sector Code" := Cust."FAS Sector Code";
            CustLedgerEntry."KRD Non-Residnet Sector Code" := Cust."KRD Non-Residnet Sector Code";
            CustLedgerEntry."KRD Affiliation Type" := Cust."KRD Affiliation Type";

            if CustLedgerEntry."KRD Affiliation Type" = '' then
                CustLedgerEntry."KRD Affiliation Type" := ReportSISetup."Default KRD Affiliation Type";
        end;

        if CustPstgGrp.get(CustLedgerEntry."Customer Posting Group") then begin
            CustLedgerEntry."KRD Instrument Type" := CustPstgGrp."KRD Instrument Type";
            CustLedgerEntry."KRD Claim/Liability" := CustPstgGrp."KRD Claim/Liability";
            CustLedgerEntry."KRD Maturity" := CustPstgGrp."KRD Maturity";
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitVendLedgEntry', '', false, false)]
    local procedure VendLedgEntryInsert(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Vend: Record Vendor;
        VendPstgGrp: Record "Vendor Posting Group";
        ReportSISetup:Record "Reporting_SI Setup";

    begin
        ReportSISetup.Get();
        ReportSISetup.TestField("Default KRD Affiliation Type");  

        if Vend.get(VendorLedgerEntry."Vendor No.") then begin
            VendorLedgerEntry."KRD Country/Region Code" := Vend."Country/Region Code";
            VendorLedgerEntry."FAS Sector Code" := Vend."FAS Sector Code";
            VendorLedgerEntry."KRD Non-Residnet Sector Code" := Vend."KRD Non-Residnet Sector Code";
            VendorLedgerEntry."KRD Affiliation Type" := Vend."KRD Affiliation Type";

            if VendorLedgerEntry."KRD Affiliation Type" = '' then
                VendorLedgerEntry."KRD Affiliation Type" := ReportSISetup."Default KRD Affiliation Type";
        end;

        if VendPstgGrp.get(VendorLedgerEntry."Vendor Posting Group") then begin
            VendorLedgerEntry."KRD Instrument Type" := VendPstgGrp."KRD Instrument Type";
            VendorLedgerEntry."KRD Claim/Liability" := VendPstgGrp."KRD Claim/Liability";
            VendorLedgerEntry."KRD Maturity" := VendPstgGrp."KRD Maturity";
        end;

    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterAccountNoOnValidateGetCustomerAccount', '', false, false)]
    local procedure GETFASFromCust(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Customer: Record Customer)

    begin
        GenJournalLine."FAS Sector Code" := Customer."FAS Sector Code";
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterAccountNoOnValidateGetVendorAccount', '', false, false)]
    local procedure GETFASFromVend(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Vendor: Record Vendor)

    begin
        GenJournalLine."FAS Sector Code" := Vendor."FAS Sector Code";
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterAccountNoOnValidateGetBankAccount', '', false, false)]
    local procedure GETFASFromBank(VAR GenJournalLine: Record "Gen. Journal Line"; VAR BankAccount: Record "Bank Account")

    begin
        GenJournalLine."FAS Sector Code" := BankAccount."FAS Sector Code";
        GenJournalLine."FAS Instrument Code" :=BankAccount."FAS Instrument Code";
    end;
    
    [EventSubscriber(ObjectType::Table, 81, 'OnAfterAccountNoOnValidateGetCustomerBalAccount', '', false, false)]
    local procedure BalGETFASFromVend(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Customer: Record Customer)

    begin
        GenJournalLine."Bal. FAS Sector Code" := Customer."FAS Sector Code";
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterAccountNoOnValidateGetVendorBalAccount', '', false, false)]
    local procedure BalGETFASFromCust(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Vendor: Record "Vendor")

    begin
        GenJournalLine."Bal. FAS Sector Code" := Vendor."FAS Sector Code";
    end;  

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterAccountNoOnValidateGetBankBalAccount', '', false, false)]
    local procedure BalGETFASFromBank(VAR GenJournalLine: Record "Gen. Journal Line"; VAR BankAccount: Record "Bank Account")

    begin
        GenJournalLine."Bal. FAS Sector Code" := BankAccount."FAS Sector Code";
        GenJournalLine."Bal. FAS Instrument Code" := BankAccount."FAS Instrument Code";
    end;    


}