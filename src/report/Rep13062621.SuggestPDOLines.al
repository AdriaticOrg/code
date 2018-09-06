report 13062621 "Suggest PDO Lines"
{
    UsageCategory = Administration;
    ProcessingOnly = true;
    Caption = 'Suggest PDO Lines'; 
  
    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = sorting("Type") where ("Type"=const(Sale));
            RequestFilterFields = "Posting Date","Document No.";

            trigger OnPreDataItem()
            begin
                if DeleteExisting then begin
                    PDORepLine.Reset();
                    PDORepLine.SetRange("Document No.",PDORepDocNo);
                    PDORepLine.DeleteAll(true);
                end; 

                if PDORepLine.FindLast() then
                    NewLineNo := PDORepLine."Line No";
            end;

            trigger OnPostDataItem()
            var
                PDORepHead:Record "PDO Report Header";
            begin
                PDORepHead.Get(PDORepDocNo);
                PDORepHead."Last Suggest on Date" := Today;
                PDORepHead."Last Suggest at Time" := time;
                PDORepHead.Modify(true);
                Message(Msg01);
            end;
            
            trigger OnAfterGetRecord()  
            var
                Cust:Record Customer;
                VATPstSetup:Record "VAT Posting Setup";             
            begin
                if VATPstSetup.get("VAT Bus. Posting Group","VAT Prod. Posting Group") then begin
                    if VATPstSetup."VAT % (informative)-Adl" <> 0 then begin
                        if Cust.get("Bill-to/Pay-to No.") then begin
                            Cust.TestField("VAT Registration No.");
                            TestField("Country/Region Code");
                            
                            if "VAT Correction Date" = 0D then begin
                                ProcessVATEntry("VAT Entry",Cust,OldPDORepHead,0);
                            end else begin                                
                                OldPDORepHead.reset;
                                OldPDORepHead.SetFilter("Period Start Date",'<=%1',"VAT Correction Date");
                                OldPDORepHead.SetFilter("Period End Date",'>=%1',"VAT Correction Date");                                
                                OldPDORepHead.FindSet();                 

                                ProcessVATEntry("VAT Entry",Cust,OldPDORepHead,1);      

                                OldVATEntry.reset;
                                OldVATEntry.SetCurrentKey(Type,Closed,"VAT Bus. Posting Group","VAT Prod. Posting Group","Posting Date");
                                OldVATEntry.SetRange(Type,OldVATEntry.Type::Sale);
                                OldVATEntry.Setfilter("Posting Date",'>=%1&<=%2',OldPDORepHead."Period Start Date",OldPDORepHead."Period End Date");
                                OldVATEntry.SetRange("Bill-to/Pay-to No.","Bill-to/Pay-to No.");
                                if OldVATEntry.FindSet() then begin
                                    repeat
                                        ProcessVATEntry(OldVATEntry,Cust,OldPDORepHead,1);
                                    until OldVATEntry.Next() = 0
                                end;

                            end;
                              
                        end;
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
    PDORepDocNo:Code[20];
    NewLineNo:Integer;
    PDORepLine:record "PDO Report Line";
    OldPDORepHead:Record "PDO Report Header";
    OldVATEntry:Record "VAT Entry";


    Msg01:Label 'Processing complete';

    procedure SetPDORepDocNo(PDODocNoLcl:Code[20]) 
    begin
        PDORepDocNo := PDODocNoLcl;        
    end;   

    local procedure ProcessVATEntry(VATEntry:record "VAT Entry";Cust2:Record Customer;
     OldRepHead:Record "PDO Report Header";RepType:option "New","Correction")
    var
        VATSetup:Record "VAT Posting Setup";
    begin
        if VATSetup.get(VATEntry."VAT Bus. Posting Group",VATEntry."VAT Prod. Posting Group") then begin
            if VATSetup."VAT % (informative)-Adl" <> 0 then begin

                with VATEntry do begin
                    PDORepLine.reset;

                    PDORepLine.SetRange(Type,RepType);
                    if RepType = RepType::Correction then begin
                        PDORepLine.SetRange(Type,PDORepLine.type::Correction);
                        PDORepLine.SetRange("Period Year",OldRepHead."Period Year");
                        PDORepLine.SetRange("Period Round",OldRepHead."Period Round");
                        PDORepLine.SetRange("Applies-to Report No.",OldRepHead."No.");
                    end;

                    PDORepLine.SetRange("Document No.",PDORepDocNo);                            
                    PDORepLine.SetRange("Country/Region Code","Country/Region Code");
                    PDORepLine.SetRange("VAT Registration No.",Cust2."VAT Registration No.");                                                                          
                
                    if PDORepLine.FindSet() then begin
                        PDORepLine."Amount (LCY)" += (-Base);
                        PDORepLine.Modify(true);
                    end else begin
                        NewLineNo += 10000;
                        PDORepLine.Init();
                        PDORepLine."Document No." := PDORepDocNo;
                        PDORepLine."Line No" := NewLineNo;                                     
                        PDORepLine.Type := RepType;
                        PDORepLine."Country/Region Code" := "Country/Region Code";
                        PDORepLine."VAT Registration No." := Cust2."VAT Registration No.";

                        if RepType = RepType::Correction then begin
                            PDORepLine."Applies-to Report No." := OldRepHead."No.";
                            PDORepLine."Period Year" := OldRepHead."Period Year";
                            PDORepLine."Period Round" := OldRepHead."Period Round";
                        end;                            

                        PDORepLine."Amount (LCY)" := -(Base);
                        PDORepLine.Insert(true);
                    end;  
                end;
            end;
        end;
    end; 
}