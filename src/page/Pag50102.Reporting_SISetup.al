page 50102 "Reporting_SI Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Reporting_SI Setup";
    
    layout
    {
        area(Content)
        {
            group(FAS)
            {
                field("FAS Report No. Series";"FAS Report No. Series") {
                    ApplicationArea = All;
                }
                field("FAS Resp. Name";"FAS Resp. Name") {
                    ApplicationArea = All;
                }
                field("FAS Resp. Email";"FAS Resp. Email") {
                    ApplicationArea = All;
                }
                field("FAS Resp. Phone";"FAS Resp. Phone") {
                    ApplicationArea = All;
                }
                field("FAS Resp. Position";"FAS Resp. Position") {
                    ApplicationArea = All;
                }
                field("FAS Prep. By Name";"FAS Prep. By Name") {
                    ApplicationArea = All;
                }
                field("FAS Prep. By Email";"FAS Prep. By Email") {
                    ApplicationArea = All;
                }
                field("FAS Prep. By Phone";"FAS Prep. By Phone") {
                    ApplicationArea = All;
                }
                field("FAS Prep. By Position";"FAS Prep. By Position") {
                    ApplicationArea = All;
                }  
            }
            group(KRD){
                field("KRD Report No. Series";"KRD Report No. Series") {
                    ApplicationArea = All;
                }

            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}