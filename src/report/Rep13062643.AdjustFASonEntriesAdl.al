report 13062643 "Adjust FAS on Entries-Adl"
{
    ProcessingOnly = true;
    Caption = 'Adjust FAS on Entries';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Posting Date", "Document No.", "G/L Account No.", "FAS Instrument Code-Adl", "FAS Sector Code-Adl";

            trigger OnPreDataItem()
            begin
                if not Confirm(ConfrimMsg, false) then
                    Error(AbortByUserMsg);
            end;

            trigger OnAfterGetRecord()
            var
                GLAcc: Record "G/L Account";
                Vend: Record Vendor;
                Cust: Record Customer;
                GLEntry: Record "G/L Entry";
                BankAcc: Record "Bank Account";
            begin
                if not GLAcc.get("G/L Account No.") or not (Glacc."FAS Account-Adl") then
                    CurrReport.Skip();

                GLEntry.get("Entry No.");
                GLEntry."FAS Type-Adl" := GLAcc."FAS Type-Adl";
                GLEntry."FAS Instrument Code-Adl" := GLAcc."FAS Instrument Code-Adl";
                GLEntry."FAS Sector Code-Adl" := GLAcc."FAS Sector Code-Adl";

                case "Source Type" of
                    "Source Type"::Customer:
                        if Cust.get("Source No.") then
                            GLEntry."FAS Sector Code-Adl" := cust."FAS Sector Code-Adl";

                    "Source Type"::Vendor:
                        if Vend.get("Source No.") then
                            GLEntry."FAS Sector Code-Adl" := Vend."FAS Sector Code-Adl";

                    "Source Type"::"Bank Account":
                        if BankAcc.get("Source No.") then begin
                            GLEntry."FAS Sector Code-Adl" := BankAcc."FAS Sector Code-Adl";
                            GLEntry."FAS Instrument Code-Adl" := BankAcc."FAS Instrument Code-Adl";
                        end;
                end;

                GLEntry.Modify();

            end;

            trigger OnPostDataItem()
            begin
                Message(FinishMsg);
            end;
        }

    }

    var
        ConfrimMsg: Label 'Are you sure you want to update entries based on values in master tables?';
        FinishMsg: Label 'Processing finished.';
        AbortByUserMsg: Label 'Aborted by user';
}