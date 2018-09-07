pageextension 13062554 "Chart Of Accounts-adl" extends "Chart of Accounts" //16
{
    actions{

        addlast(Reporting)
        {
            // <adl.21>
            action("GLExport")
            {
                Caption = 'GL Export';
                Promoted = true;
                PromotedCategory = Report;
                Image = Report;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GLExportSIadl : Report "GL ExportSI-adl";
                    GLAccount: Record "G/L Account";
                begin
                    GLAccount:= Rec;
                    GLAccount.SetRecFilter();
                    GLExportSIadl.SetTableView(GLAccount);
                    GLExportSIadl.RunModal();
                end;
            }
            // </adl.21> 
        }
    }    

}