report 13062683 "Adjust BST on Entries"
{
    ProcessingOnly = true;
    Caption = 'Adjust BST on Entries';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Posting Date", "Document No.", "G/L Account No.", "BST Code-Adl";

            trigger OnPreDataItem()
            begin
                if not Confirm(strsubstno(ConfrimMsg, GLAcc.TableCaption(), false)) then
                    Error(AbortByUserMsg);
            end;

            trigger OnAfterGetRecord()
            var
                GLEntry: Record "G/L Entry";
            begin
                if not GLAcc.get("G/L Account No.") then
                    CurrReport.Skip();

                GLEntry.get("Entry No.");
                GLEntry."BST Code-Adl" := GLAcc."BST Code-Adl";
                GLEntry.Modify();
            end;

            trigger OnPostDataItem()
            begin
                Message(FinishMsg);
            end;
        }

    }

    var
        GLAcc: Record "G/L Account";
        ConfrimMsg: Label 'Are you sure you want to update entries based on values in %1 table?';
        FinishMsg: Label 'Processing finished.';
        AbortByUserMsg: Label 'Aborted by user';
}