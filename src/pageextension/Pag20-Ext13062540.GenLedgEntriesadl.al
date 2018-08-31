pageextension 13062540 "GenLedgEntries-adl" extends "General Ledger Entries"  //20
{
    layout
    {
        // <adl.24>
        addlast(Control1) {
            field("FAS Instrument Code";"FAS Instrument Code") {
                ApplicationArea = All;
            }
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
        }
        // </adl.24>
    }
    
    actions
    {
        addlast("F&unctions")
        {
            action("GLExport")
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