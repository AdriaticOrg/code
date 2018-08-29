page 13062660 "Reporting_SI Setup"
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
                field("FAS Resp. User ID";"FAS Resp. User ID") {
                    ApplicationArea = All;
                }
                field("FAS Prep. By User ID";"FAS Prep. By User ID") {
                    ApplicationArea = All;
                }
                field("FAS Director User ID";"FAS Director User ID") {
                    ApplicationArea = All;
                }
                field("Budget User Code";"Budget User Code") {
                    ApplicationArea = All;
                }
                field("Company Sector Code";"Company Sector Code") {
                    ApplicationArea = All;
                }
            }
            group(KRD){
                field("KRD Report No. Series";"KRD Report No. Series") {
                    ApplicationArea = All;
                }
                field("KRD Resp. User ID";"KRD Resp. User ID") {
                    ApplicationArea = All;
                }
                field("KRD Prep. By User ID";"KRD Prep. By User ID") {
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