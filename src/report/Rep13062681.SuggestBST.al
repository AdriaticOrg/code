report 13062681 "Suggest BST"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Suggest BST';
    
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Posting Date","Document No.";   

            trigger OnPreDataItem()
            begin
                if DeleteExisting then begin
                    BSTRepLine.Reset();
                    BSTRepLine.SetRange("Document No.",BSTRepHead."No.");
                    BSTRepLine.DeleteAll(true);
                end;
            end;
            trigger OnAfterGetRecord()
            begin
                
                
            end;
        }
    }
    
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(DeleteExisting;DeleteExisting) {
                        ApplicationArea = All;
                        Caption = 'Delete existing lines';
                    }
                }
            }
        }
    
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }

    var
        DeleteExisting:Boolean;
        BSTRepLine:Record "BST Report Line";
        BSTRepHead:Record "BST Report Header";
        BSTRepDocNo:Code[20];

    procedure SetBSTRepDocNo(BSTDocNoLcl:Code[20]) 
    begin
        BSTRepDocNo := BSTDocNoLcl;        
        BSTRepHead.get(BSTRepDocNo);
    end;          
}