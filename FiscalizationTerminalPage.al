page 13062606 "Fisc. Terminal List-ADL"
{
    PageType = List;
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
                    
                }
                 field(Name; Name)
                {
                    
                }
                field("Fisc. No. Series"; "Fisc. No. Series")
                {
                    
                }
                field("User ID"; "User ID")
                {
                  Visible = VisibleHR;   
                }
                field("Creation Date"; "Creation Date")
                {
                    
                }
                field("Creation Time"; "Creation Time")
                {
                    
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
        FiscalizationSetup.GET;
        CASE TRUE OF
        // SI
        FiscalizationSetup.CountryCodeSI:
            BEGIN
            VisibleSI := TRUE;
            END;
        // HR
        FiscalizationSetup.CountryCodeHR:
            BEGIN
            VisibleHR := TRUE;
            END;
        END;
    end;
}