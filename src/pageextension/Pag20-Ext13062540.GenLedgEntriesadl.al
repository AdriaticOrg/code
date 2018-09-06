pageextension 13062540 "GenLedgEntries-adl" extends "General Ledger Entries"  //20
{
    layout
    {
        // <adl.24>
        addlast(Control1)
        {
            field("FAS Instrument Code"; "FAS Instrument Code")
            {
                ApplicationArea = All;
            }
            field("FAS Sector Code"; "FAS Sector Code")
            {
                ApplicationArea = All;
            }
            // <adl.26>
            field("BST Code"; "BST Code")
            {
                ApplicationArea = All;
            }
            // </adl.26>
        }
        // </adl.24>
    }

    // <adl.24>
    actions
    {
        addlast("F&unctions") {
            
            group(ChangeData) { 
                Caption='Change Data';
                Image=ChangeStatus;
                action(ChangeFinInstr) {
                    Caption = 'Finance Instrument';
                    Image = ListPage;
                    ApplicationArea = All;    

                    trigger OnAction()
                    var
                        FASInstrument:Record "FAS Instrument";
                    begin
                        FASInstrument.Reset();
                        FASInstrument.SetRange(Type,FASInstrument.Type::Posting);
                        if FASInstrument.get("FAS Instrument Code") then;

                        if page.RunModal(0,FASInstrument) = Action::LookupOK then begin
                            "FAS Instrument Code" := FASInstrument.Code;
                            Modify();
                        end;
                    end;                                         
                }
                action(ChangeFinSect) {
                    Caption = 'Finance Sector';
                    Image = ListPage;
                    ApplicationArea = All;    

                    trigger OnAction()
                    var
                        FASSector:Record "FAS Sector";
                    begin
                        FASSector.Reset();
                        FASSector.SetRange(Type,FASSector.Type::Posting);
                        if FASSector.get("FAS Sector Code") then;

                        if page.RunModal(0,FASSector) = Action::LookupOK then begin
                            "FAS Sector Code" := FASSector.Code;
                            Modify();
                        end;
                    end;                                         
                } 
                // <adl.26>
                action(ChangeBST) {
                    Caption = 'BST Code';
                    Image = ListPage;
                    ApplicationArea = All;    

                    trigger OnAction()
                    var
                        BSTCode:Record "BST Code";                        
                    begin
                        BSTCode.Reset();
                        BSTCode.SetRange(Type,BSTCode.Type::Posting);
                        if BSTcode.get("BST Code") then;

                        if page.RunModal(0,BSTCode) = Action::LookupOK then begin
                            "BST Code" := BSTCode.Code;
                            Modify();
                        end;
                    end;                                         
                }   
                // </adl.26>  

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
	                    GLAccount.Get("G/L Account No.");
	                    GLAccount.SetFilter("No.", Rec."G/L Account No.");
	                    GLExportSIadl.SetTableView(GLAccount);
	                    GLExportSIadl.RunModal();
	                end;
            	}
		        // </adl.21>                        
            }
        }
    }
    // </adl.24>
}