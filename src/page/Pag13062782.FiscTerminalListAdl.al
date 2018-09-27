page 13062782 "Fisc. Terminal List-Adl"
{
    // <adl.20>
    Caption = 'Fiscalization Terminal List';
    PageType = List;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "Fiscalization Terminal-Adl";
    SourceTableView = SORTING ("Fisc. Terminal Code", "Fisc. Location Code", "User ID");

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

    var
        VisibleHR: Boolean;
        //UNUSED//VisibleSI: Boolean;

    trigger OnInit()
    var
        FiscalizationSetup: Record "Fiscalization Setup-Adl";
    begin
        FiscalizationSetup.GET();
        CASE TRUE OF
            // SI
            //UNUSED//FiscalizationSetup.CountryCodeSI:
            //UNUSED//VisibleSI := TRUE;
            // HR
            FiscalizationSetup.CountryCodeHR():
                VisibleHR := TRUE;
        END;
    end;
    // </adl.20>
}