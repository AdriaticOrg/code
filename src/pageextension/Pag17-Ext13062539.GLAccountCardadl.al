pageextension 13062539 "GLAccountCard-adl" extends "G/L Account Card" //17
{
    layout
    {
        // <adl.24>
        addlast(Reporting) {
            field("FAS Account";"FAS Account") {
                ApplicationArea = All;
                Visible = FASEnabled;                
            }
            field("FAS Sector Posting";"FAS Sector Posting") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field ("FAS Instrument Posting";"FAS Instrument Posting") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field ("FAS Instrument Code";"FAS Instrument Code") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            // <adl.26>
            field("BST Value Posting";"BST Value Posting") {
                ApplicationArea = All;
                Visible = BSTEnabled;
            }
            field("BST Code";"BST Code") {
                ApplicationArea = All;
                Visible = BSTEnabled;
            }
            // </adl.26>
        }         
        // </adl.24>
    }
    actions
    {   
        addafter("A&ccount") 
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
    // <adl.24>
    trigger OnOpenPage()
    begin
        RepSIMgt.GetReporSIEnabled(FASEnabled,KRDEnabled,BSTEnabled);
    end;
    var
        RepSIMgt:Codeunit "Reporting SI Mgt.";
        FASEnabled:Boolean;
        KRDEnabled:Boolean;
        BSTEnabled:Boolean;
    // </adl.24> 
}