report 13062663 "Adjust KRD on Entries-Adl"
{
    ProcessingOnly = true;
    Caption = 'Adjust KRD on Entries';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Document No.", "Customer No.";

            trigger OnPreDataItem()
            begin
                if not Confirm(ConfrimMsg, false) then
                    Error(AbortByUserMsg);
            end;

            trigger OnAfterGetRecord()
            var
                CustPstGrp: Record "Customer Posting Group";
                CustLedgEntry: Record "Cust. Ledger Entry";
                Cust: Record Customer;
            begin
                if (not CustPstGrp.get("Customer Posting Group")) or (not Cust.get("Customer No.")) then
                    CurrReport.Skip();

                with CustLedgEntry do begin
                    get("Cust. Ledger Entry"."Entry No.");

                    "KRD Instrument Type-Adl" := CustPstGrp."KRD Instrument Type-Adl";
                    "KRD Claim/Liability-Adl" := CustPstGrp."KRD Claim/Liability-Adl";
                    "KRD Maturity-Adl" := CustPstGrp."KRD Maturity-Adl";

                    "KRD Country/Region Code-Adl" := Cust."Country/Region Code";
                    "KRD Non-Residnet Sector Code-Adl" := Cust."KRD Non-Residnet Sector Code-Adl";
                    "KRD Affiliation Type-Adl" := Cust."KRD Affiliation Type-Adl";

                    if ("KRD Affiliation Type-Adl" = '') and ReportSISetup.Get() then
                        "KRD Affiliation Type-Adl" := ReportSISetup."Default KRD Affiliation Type";

                    Modify();
                end;
            end;
        }
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Posting Date", "Document No.", "Vendor No.";

            trigger OnAfterGetRecord()
            var
                VendPstGrp: Record "Vendor Posting Group";
                VendLedgEntry: Record "Vendor Ledger Entry";
                Vend: Record Vendor;
            begin
                if (not VendPstGrp.get("Vendor Posting Group")) or (not Vend.get("Vendor No.")) then
                    CurrReport.Skip();

                with VendLedgEntry do begin
                    get("Vendor Ledger Entry"."Entry No.");

                    "KRD Instrument Type-Adl" := VendPstGrp."KRD Instrument Type-Adl";
                    "KRD Claim/Liability-Adl" := VendPstGrp."KRD Claim/Liability-Adl";
                    "KRD Maturity-Adl" := VendPstGrp."KRD Maturity-Adl";

                    "KRD Country/Region Code-Adl" := Vend."Country/Region Code";
                    "KRD Non-Residnet Sector Code-Adl" := Vend."KRD Non-Residnet Sector Code-Adl";
                    "KRD Affiliation Type-Adl" := Vend."KRD Affiliation Type-Adl";

                    if ("KRD Affiliation Type-Adl" = '') and ReportSISetup.Get() then
                        "KRD Affiliation Type-Adl" := ReportSISetup."Default KRD Affiliation Type";

                    Modify();
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message(FinishMsg);
            end;
        }

    }

    var
        GLAcc: Record "G/L Account";
        ReportSISetup: Record "Reporting_SI Setup-Adl";
        ConfrimMsg: Label 'Are you sure you want to update entries based on values in master tables?';
        FinishMsg: Label 'Processing finished.';
        AbortByUserMsg: Label 'Aborted by user';
}