report 13062681 "Suggest BST Lines-Adl"
{
    UsageCategory = Administration;
    ProcessingOnly = true;
    Caption = 'Suggest BST Lines';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Posting Date", "Document No.";

            trigger OnPreDataItem()
            begin
                BSTRepLine.SetRange("Document No.", BSTRepHead."No.");
                if DeleteExisting then begin
                    BSTRepLine.Reset();
                    BSTRepLine.SetRange("Document No.", BSTRepHead."No.");
                    BSTRepLine.DeleteAll(true);
                end;

                if BSTRepLine.FindLast() then
                    NewLineNo += BSTRepLine."Line No";
            end;

            trigger OnAfterGetRecord()
            begin
                BSTRepLine.SetRange("Document No.", BSTRepHead."No.");
                BSTRepLine.SetRange("BST Code", "BST Code-Adl");
                BSTRepLine.SetRange("Country/Region Code", "Country/Region Code-Adl");
                if BSTRepLine.FindSet(true, false) then begin
                    AppendBSTValue(BSTRepLine, "G/L Account No.", Amount);
                    BSTRepLine.Modify(true);
                end else begin
                    BSTRepLine.Init();
                    NewLineNo += 10000;
                    BSTRepLine."Document No." := BSTRepHead."No.";
                    BSTRepLine."Line No" := NewLineNo;
                    BSTRepLine.Validate("BST Code", "BST Code-Adl");
                    BSTRepLine.Validate("Country/Region Code", "Country/Region Code-Adl");
                    AppendBSTValue(BSTRepLine, "G/L Account No.", Amount);
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
                    field(DeleteExisting; DeleteExisting)
                    {
                        ApplicationArea = All;
                        Caption = 'Delete existing lines';
                        ToolTip = 'TODO: Tooltip - Reporting';
                    }
                }
            }
        }
    }

    var
        BSTRepLine: Record "BST Report Line-Adl";
        BSTRepHead: Record "BST Report Header-Adl";
        DeleteExisting: Boolean;
        BSTRepDocNo: Code[20];
        NewLineNo: Integer;

    procedure SetBSTRepDocNo(BSTDocNoLcl: Code[20])
    begin
        BSTRepDocNo := BSTDocNoLcl;
        BSTRepHead.get(BSTRepDocNo);
    end;

    local procedure AppendBSTValue(var BSTRepLine: Record "BST Report Line-Adl"; GLAccNo: Code[20]; Amt: Decimal)
    var
        GLAcc: Record "G/L Account";
    begin
        GLAcc.get(GLAccNo);
        case GLAcc."BST Value Posting-Adl" of
            GLAcc."BST Value Posting-Adl"::Credit:
                BSTRepLine."Income Amount" += (-Amt);
            GLAcc."BST Value Posting-Adl"::Debit:
                BSTRepLine."Expense Amount" += Amt;
            GLAcc."BST Value Posting-Adl"::Both:
                if Amt > 0 then
                    BSTRepLine."Expense Amount" += Amt
                else
                    BSTRepLine."Income Amount" += (-Amt);
        end;
    end;
}