page 13062782 "Fisc. Terminal List-ADL"
{
    PageType = List;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "Fiscalization Terminal-ADL";
    SourceTableView = SORTING("Fisc. Terminal Code","Fisc. Location Code","User ID");
    
    layout
    {
        area(content)
        {
            repeater(List)
            {
                field("Fisc. Terminal Code"; "Fisc. Terminal Code")
                {
                    ApplicationArea = All;
                }
                 field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Fisc. No. Series"; "Fisc. No. Series")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                  Visible = VisibleHR;   
                  ApplicationArea = All;
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Creation Time"; "Creation Time")
                {
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
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
    
    var
      VisibleHR : Boolean;
      VisibleSI : Boolean;
        myInt: Integer;
    trigger OnInit()
    var
      FiscalizationSetup : Record "Fiscalization Setup-ADL";
    begin
        FiscalizationSetup.GET();
        CASE TRUE OF
        // SI
        FiscalizationSetup.CountryCodeSI:
            VisibleSI := TRUE;
        // HR
        FiscalizationSetup.CountryCodeHR:
            VisibleHR := TRUE;
        END;
    end;
}