pageextension 50101 "GeneralLedgerEntries-adl" extends "General Ledger Entries"
{
    layout
    {
    }
    
    actions
    {
        addlast("F&unctions")
        {
            action("GL Export")
            {
                Promoted = true;
                PromotedCategory = Report;
                Image = Report;
                ApplicationArea = Basic,Suite;

                trigger OnAction()
                var
                    GLExportSIadl : Report "GL ExportSI-adl";
                    GLAccount: Record "G/L Account";
                begin
                    GLAccount.Get("G/L Account No.");
                    GLAccount.SetFilter("No.", Rec."G/L Account No.");
                    GLExportSIadl.SetTableView(GLAccount);
                    GLExportSIadl.RunModal();
                end;
            }

        }

    }
}
