report 13062681 "Suggest BST"
{
    UsageCategory = Administration;
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

                if BSTRepLine.FindLast() then
                    NewLineNo += BSTRepLine."Line No";
            end;

            trigger OnAfterGetRecord()  
            begin                
                BSTRepLine.SetRange("BST Code","BST Code");
                if BSTRepLine.FindSet(true,false) then begin
                    AppendBSTValue(BSTRepLine,"G/L Account No.",Amount);
                    BSTRepLine.Modify(true);  
                end else begin
                    BSTRepLine.Init();
                    NewLineNo += 10000;
                    BSTRepLine."Document No." := BSTRepHead."No.";
                    BSTRepLine."Line No" := NewLineNo;
                    BSTRepLine.Validate("BST Code","BST Code");
                    AppendBSTValue(BSTRepLine,"G/L Account No.",Amount);
                    BSTRepLine.Insert(true);
                end;                
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
        NewLineNo:Integer;

    procedure SetBSTRepDocNo(BSTDocNoLcl:Code[20]) 
    begin
        BSTRepDocNo := BSTDocNoLcl;        
        BSTRepHead.get(BSTRepDocNo);
    end;          

    local procedure AppendBSTValue(var BSTRepLine:Record "BST Report Line";GLAccNo:Code[20];Amt:Decimal)
    var
        GLAcc:Record "G/L Account";
    begin
        GLAcc.get(GLAccNo);
        case GLAcc."BST Value Posting" of
            GLAcc."BST Value Posting"::Credit:
                begin
                    BSTRepLine."Income Amount" += abs(Amt);                                
                end;
            GLAcc."BST Value Posting"::Debit:
                begin
                    BSTRepLine."Expense Amount" += abs(Amt); 
                end;
            GLAcc."BST Value Posting"::Both:
                begin
                    if Amt > 0 then
                        BSTRepLine."Income Amount" += Amt
                    else
                        BSTRepLine."Expense Amount" += abs(Amt);
                end;
        end;        
    end;
}