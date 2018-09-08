codeunit 13062661 "Reporting SI Evnt."
{
    Permissions = tabledata 17 = rm,
                  tabledata 21 = rm,
                  tabledata 25 = rm,
                  tabledata 254 = rm;

    var
        ADLCore: Codeunit "Adl Core";
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertVATEntry', '', true, false)]
    local procedure OnAfterInsertVATEntry(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)
    begin
        //TODO: what feature toggle should be checked here?
        if not ADLCore.FeatureEnabled("ADL Features"::VAT) then exit;

        //TODO: @janez changed from event OnAfterInsertVAT to OnAfterInsertVATEntry event
        VATEntry."VAT Correction Date" := GenJnlLine."VAT Correction Date";
        VATEntry."EU Customs Procedure" := GenJnlLine."EU Customs Procedure";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", 'OnBeforePostCustomerEntry', '', false, false)]
    local procedure PostCustEntry(VAR GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; VAR TotalSalesLine: Record "Sales Line"; VAR TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    var
        Cust: Record Customer;
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;

        if Cust.get(GenJnlLine."Account No.") then
            GenJnlLine.CopyFASFields(Cust);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Post", 'OnBeforePostVendorEntry', '', false, false)]
    local procedure PostVendEntry(VAR GenJnlLine: Record "Gen. Journal Line"; PurchHeader: Record "Sales Header"; VAR TotalPurchLine: Record "Purchase Line"; VAR TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    var
        Vend: Record Vendor;
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;

        with GenJnlLine do begin
            if Vend.get("Account No.") then
                GenJnlLine.CopyFASFields(Vend);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure PostGenJnlLine(VAR GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        Cust: Record Customer;
        Vend: Record Vendor;
        BankAcc: Record "Bank Account";
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;

        with GenJournalLine do begin
            case "Source Type" of
                "Source Type"::Customer:
                    begin
                        if Cust.get("Source No.") then
                            GenJournalLine.CopyFASFields(Cust);
                    end;
                "Source Type"::Vendor:
                    begin
                        if Vend.get("Source No.") then
                            GenJournalLine.CopyFASFields(Vend);
                    end;
                "Source Type"::"Bank Account":
                    begin
                        if BankAcc.get("Source No.") then begin
                            GenJournalLine.CopyFASFields(BankAcc);
                        end;

                    end;
            end;
            case "Account Type" of
                "Account Type"::Customer:
                    begin
                        if Cust.get("Account No.") then
                            GenJournalLine.CopyFASFields(Cust);
                    end;
                "Account Type"::Vendor:
                    begin
                        if Vend.get("Account No.") then
                            GenJournalLine.CopyFASFields(Vend);
                    end;
                "Account Type"::"Bank Account":
                    begin
                        if BankAcc.get("Account No.") then begin
                            GenJournalLine.CopyFASFields(BankAcc);
                        end;
                    end;
            end
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLineFAS(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    var
        GLAcc: Record "G/L Account";
        AccNo: Code[20];
        ReportSISetup: Record "Reporting_SI Setup";
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;

        GLAcc.GET(GLEntry."G/L Account No.");
        if not GLAcc."FAS Account" then exit;

        GLEntry."FAS Instrument Code" := GenJournalLine."FAS Instrument Code";
        GLEntry."FAS Sector Code" := GenJournalLine."FAS Sector Code";
        GLEntry."FAS Type" := GenJournalLine."FAS Type";

        case GLAcc."FAS Instrument Posting" of
            GLAcc."FAS Instrument Posting"::"Code Mandatory":
                begin
                    GenJournalLine.TestField("FAS Type");
                    GenJournalLine.TestField("FAS Instrument Code");
                end;
            GLAcc."FAS Instrument Posting"::"Same Code":
                GenJournalLine.TestField("FAS Instrument Code", GLAcc."FAS Instrument Code");
            GLAcc."FAS Instrument Posting"::"No Code":
                GenJournalLine.TestField("FAS Instrument Code", '');
        end;

        case GLAcc."FAS Sector Posting" of
            GLAcc."FAS Sector Posting"::"Code Mandatory":
                GenJournalLine.TestField("FAS Sector Code");
            GLAcc."FAS Sector Posting"::"Same Code":
                GenJournalLine.TestField("FAS Sector Code", GLAcc."FAS Sector Code");
            GLAcc."FAS Sector Posting"::"No Code":
                GenJournalLine.TestField("FAS Sector Code", '');
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLineBST(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    var
        GLAcc: Record "G/L Account";
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::BST) then exit;

        GLEntry."BST Code" := GLAcc."BST Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure CustLedgEntryInsertFAS(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;

        Cust.get(CustLedgerEntry."Customer No.");
        CustLedgerEntry.CopyFASFields(Cust);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure CustLedgEntryInsertKRD(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        CustPstgGrp: Record "Customer Posting Group";
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::KRD) then exit;

        Cust.get(CustLedgerEntry."Customer No.");
        CustLedgerEntry.CopyKRDFields(Cust);
        CustLedgerEntry.TestField("KRD Affiliation Type");

        if CustPstgGrp.get(CustLedgerEntry."Customer Posting Group") then
            CustLedgerEntry.CopyKRDFields(CustPstgGrp);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', false, false)]
    local procedure VendLedgEntryInsertFAS(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Vend: Record Vendor;
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;

        Vend.get(VendorLedgerEntry."Vendor No.");
        VendorLedgerEntry.CopyFASFields(Vend);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', false, false)]
    local procedure VendLedgEntryInsertKRD(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Vend: Record Vendor;
        VendPstgGrp: Record "Vendor Posting Group";
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::KRD) then exit;

        //TODO: default value should not be mandatory! ( check result instead ) ( suggest: removal )
        //ReportSISetup.TestField("Default KRD Affiliation Type");
        Vend.get(VendorLedgerEntry."Vendor No.");
        VendorLedgerEntry.CopyKRDFields(Vend);

        if VendPstgGrp.get(VendorLedgerEntry."Vendor Posting Group") then
            VendorLedgerEntry.CopyKRDFields(VendPstgGrp);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    local procedure CopyLineFromSalesHeader(SalesHeader: Record "Sales Header"; VAR GenJournalLine: Record "Gen. Journal Line")
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::VIES) then exit;
        GenJournalLine.CopyVIESFields(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetCustomerAccount', '', false, false)]
    local procedure GETFASFromCust(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Customer: Record Customer)
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(Customer);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetVendorAccount', '', false, false)]
    local procedure GETFASFromVend(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Vendor: Record Vendor)
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(Vendor);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetBankAccount', '', false, false)]
    local procedure GETFASFromBank(VAR GenJournalLine: Record "Gen. Journal Line"; VAR BankAccount: Record "Bank Account")
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(BankAccount);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetGLAccount', '', false, false)]
    local procedure GETFASFromGLAcc(VAR GenJournalLine: Record "Gen. Journal Line"; VAR GLAccount: Record "G/L Account")
    var
        ReportSISetup: Record "Reporting_SI Setup";
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(GLAccount);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetCustomerBalAccount', '', false, false)]
    local procedure BalGETFASFromVend(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Customer: Record Customer)
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(Customer);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetVendorBalAccount', '', false, false)]
    local procedure BalGETFASFromCust(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Vendor: Record "Vendor")
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(Vendor);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetBankBalAccount', '', false, false)]
    local procedure BalGETFASFromBank(VAR GenJournalLine: Record "Gen. Journal Line"; VAR BankAccount: Record "Bank Account")
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(BankAccount);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetGLBalAccount', '', false, false)]
    local procedure BalGETFASFromGLAcc(VAR GenJournalLine: Record "Gen. Journal Line"; VAR GLAccount: Record "G/L Account")
    begin
        if not ADLCore.FeatureEnabled("ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(GLAccount);
    end;

}