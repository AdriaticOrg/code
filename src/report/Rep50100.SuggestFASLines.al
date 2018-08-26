report 50100 "Suggest FAS Lines"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Suggest FAS Lines'; 
  
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Posting Date","Document No.","G/L Account No.";

            trigger OnPreDataItem()
            begin
                if DeleteExisting then begin
                    FASRepLine.Reset();
                    FASRepLine.SetRange("Document No.",FASRepDocNo);
                    FASRepLine.DeleteAll(true);
                end; 

                if FASRepLine.FindLast() then
                    NewLineNo := FASRepLine."Line No";
            end;

            trigger OnPostDataItem()
            var
                FASRepHead:Record "FAS Report Header";
            begin
                FASRepHead.Get(FASRepDocNo);
                FASRepHead."Last Suggest on Date" := Today;
                FASRepHead."Last Suggest at Time" := time;
                FASRepHead.Modify(true);
                Message(Msg01);
            end;
            
            trigger OnAfterGetRecord()  
            var
                GLAcc:Record "G/L Account";              
            begin
                if GLAcc.get("G/L Account No.") and GLAcc."FAS Account" then begin
                    FASRepLine.SetRange("Document No.",FASRepDocNo);
                    FASRepLine.SetRange("Sector Code","FAS Sector Code");
                    FASRepLine.SetRange("Instrument Code","FAS Instrument Code");
                    if FASRepLine.FindSet() then begin
                        FASRepLine.Amount += Amount;
                        FASRepLine.Modify(true);
                    end else begin
                        NewLineNo += 10000;
                        FASRepLine.Init();
                        FASRepLine."Document No." := FASRepDocNo;
                        FASRepLine."Line No" := NewLineNo;    
                        FASRepLine.validate("Sector Code","FAS Sector Code");
                        FASRepLine.validate("Instrument Code","FAS Instrument Code");
                        FASRepLine.Amount := Amount;
                        FASRepLine.Insert(true);            
                    end;  
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
                    field(DeleteExisting;DeleteExisting)
                    {
                        Caption = 'Delete existing lines';
                        ApplicationArea = All;                        
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
    FASRepDocNo:Code[20];
    NewLineNo:Integer;
    FASRepLine:record "FAS Report Line";

    Msg01:TextConst ENU='Processing complete';

    procedure SetFASRepDocNo(FASDocNoLcl:Code[20]) 
    begin
        FASRepDocNo := FASDocNoLcl;        
    end;   
 
}