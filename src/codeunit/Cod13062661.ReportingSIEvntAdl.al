codeunit 13062661 "Reporting SI Evnt.-Adl"
{
    Permissions = tabledata 17 = rm,
                  tabledata 21 = rm,
                  tabledata 25 = rm,
                  tabledata 254 = rm;

    var
        CoreSetup: Record "CoreSetup-Adl";
        ADLCore: Codeunit "Adl Core-Adl";

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertVATEntry', '', true, false)]
    local procedure OnAfterInsertVATEntry(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)
    begin
        //TODO: what feature toggle should be checked here?
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;

        VATEntry."VAT Correction Date-Adl" := GenJnlLine."VAT Correction Date-Adl";
        VATEntry."EU Customs Procedure-Adl" := GenJnlLine."EU Customs Procedure-Adl";
        VATEntry.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", 'OnBeforePostCustomerEntry', '', false, false)]
    local procedure PostCustEntry(VAR GenJnlLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; VAR TotalSalesLine: Record "Sales Line"; VAR TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    var
        Cust: Record Customer;
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;

        if Cust.get(GenJnlLine."Account No.") then
            GenJnlLine.CopyFASFields(Cust);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Post", 'OnBeforePostVendorEntry', '', false, false)]
    local procedure PostVendEntry(VAR GenJnlLine: Record "Gen. Journal Line"; PurchHeader: Record "Sales Header"; VAR TotalPurchLine: Record "Purchase Line"; VAR TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    var
        Vend: Record Vendor;
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;

        with GenJnlLine do
            if Vend.get("Account No.") then
                GenJnlLine.CopyFASFields(Vend);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure PostGenJnlLine(VAR GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        Cust: Record Customer;
        Vend: Record Vendor;
        BankAcc: Record "Bank Account";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;

        with GenJournalLine do begin
            case "Source Type" of
                "Source Type"::Customer:
                    if Cust.get("Source No.") then
                        GenJournalLine.CopyFASFields(Cust);

                "Source Type"::Vendor:

                    if Vend.get("Source No.") then
                        GenJournalLine.CopyFASFields(Vend);

                "Source Type"::"Bank Account":
                    if BankAcc.get("Source No.") then
                        GenJournalLine.CopyFASFields(BankAcc);
            end;
            case "Account Type" of
                "Account Type"::Customer:
                    if Cust.get("Account No.") then
                        GenJournalLine.CopyFASFields(Cust);
                "Account Type"::Vendor:
                    if Vend.get("Account No.") then
                        GenJournalLine.CopyFASFields(Vend);
                "Account Type"::"Bank Account":
                    if BankAcc.get("Account No.") then
                        GenJournalLine.CopyFASFields(BankAcc);
            end
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, false)]
    local procedure OnAfterInitGLEntryFAS(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        GLAcc: Record "G/L Account";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;

        GLAcc.GET(GLEntry."G/L Account No.");
        if not GLAcc."FAS Account-Adl" then exit;

        if GenJournalLine."FAS Instrument Code-Adl" = '' then
            GenJournalLine."FAS Instrument Code-Adl" := GLAcc."FAS Instrument Code-Adl";

        if GenJournalLine."FAS Sector Code-Adl" = '' then
            GenJournalLine."FAS Sector Code-Adl" := GLAcc."FAS Sector Code-Adl";

        if GenJournalLine."FAS Type-Adl" = GenJournalLine."FAS Type-Adl"::" " then
            GenJournalLine."FAS Type-Adl" := GLAcc."FAS Type-Adl";

        GLEntry."FAS Instrument Code-Adl" := GenJournalLine."FAS Instrument Code-Adl";
        GLEntry."FAS Sector Code-Adl" := GenJournalLine."FAS Sector Code-Adl";
        GLEntry."FAS Type-Adl" := GenJournalLine."FAS Type-Adl";

        case GLAcc."FAS Instrument Posting-Adl" of
            GLAcc."FAS Instrument Posting-Adl"::"Code Mandatory":
                begin
                    GenJournalLine.TestField("FAS Type-Adl");
                    GenJournalLine.TestField("FAS Instrument Code-Adl");
                end;
            GLAcc."FAS Instrument Posting-Adl"::"Same Code":
                GenJournalLine.TestField("FAS Instrument Code-Adl", GLAcc."FAS Instrument Code-Adl");
            GLAcc."FAS Instrument Posting-Adl"::"No Code":
                GenJournalLine.TestField("FAS Instrument Code-Adl", '');
        end;

        case GLAcc."FAS Sector Posting-Adl" of
            GLAcc."FAS Sector Posting-Adl"::"Code Mandatory":
                GenJournalLine.TestField("FAS Sector Code-Adl");
            GLAcc."FAS Sector Posting-Adl"::"Same Code":
                GenJournalLine.TestField("FAS Sector Code-Adl", GLAcc."FAS Sector Code-Adl");
            GLAcc."FAS Sector Posting-Adl"::"No Code":
                GenJournalLine.TestField("FAS Sector Code-Adl", '');
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, false)]
    local procedure OnAfterInitGLEntryBST(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        GLAcc: Record "G/L Account";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::BST) then exit;

        if GLAcc.GET(GLEntry."G/L Account No.") then
            GLEntry."BST Code-Adl" := GLAcc."BST Code-Adl";

        GLEntry."Country/Region Code-Adl" := GenJournalLine."Country/Region Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure CustLedgEntryInsertFAS(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;

        Cust.get(CustLedgerEntry."Customer No.");
        CustLedgerEntry.CopyFASFields(Cust);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitCustLedgEntry', '', false, false)]
    local procedure CustLedgEntryInsertKRD(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        CustPstgGrp: Record "Customer Posting Group";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::KRD) then exit;

        Cust.get(CustLedgerEntry."Customer No.");
        CustLedgerEntry.CopyKRDFields(Cust);

        if CustPstgGrp.get(CustLedgerEntry."Customer Posting Group") then
            CustLedgerEntry.CopyKRDFields(CustPstgGrp);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', false, false)]
    local procedure VendLedgEntryInsertFAS(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Vend: Record Vendor;
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;

        Vend.get(VendorLedgerEntry."Vendor No.");
        VendorLedgerEntry.CopyFASFields(Vend);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', false, false)]
    local procedure VendLedgEntryInsertKRD(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Vend: Record Vendor;
        VendPstgGrp: Record "Vendor Posting Group";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::KRD) then exit;

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
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VIES) then exit;
        GenJournalLine.CopyVIESFields(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetCustomerAccount', '', false, false)]
    local procedure GETFASFromCust(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Customer: Record Customer)
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(Customer, 0);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetVendorAccount', '', false, false)]
    local procedure GETFASFromVend(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Vendor: Record Vendor)
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(Vendor, 0);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetBankAccount', '', false, false)]
    local procedure GETFASFromBank(VAR GenJournalLine: Record "Gen. Journal Line"; VAR BankAccount: Record "Bank Account")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(BankAccount, 0);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetGLAccount', '', false, false)]
    local procedure GETFASFromGLAcc(VAR GenJournalLine: Record "Gen. Journal Line"; VAR GLAccount: Record "G/L Account")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(GLAccount, 0);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetCustomerBalAccount', '', false, false)]
    local procedure BalGETFASFromVend(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Customer: Record Customer)
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(Customer, 1);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetVendorBalAccount', '', false, false)]
    local procedure BalGETFASFromCust(VAR GenJournalLine: Record "Gen. Journal Line"; VAR Vendor: Record "Vendor")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(Vendor, 1);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetBankBalAccount', '', false, false)]
    local procedure BalGETFASFromBank(VAR GenJournalLine: Record "Gen. Journal Line"; VAR BankAccount: Record "Bank Account")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(BankAccount, 1);
    end;

    [EventSubscriber(ObjectType::Table, database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetGLBalAccount', '', false, false)]
    local procedure BalGETFASFromGLAcc(VAR GenJournalLine: Record "Gen. Journal Line"; VAR GLAccount: Record "G/L Account")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS) then exit;
        GenJournalLine.CopyFASFields(GLAccount, 1);
    end;

}