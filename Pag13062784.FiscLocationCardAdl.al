page 13062784 "Fisc. Location Card-Adl"
{
    PageType = Card;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "Fiscalization Location-ADL";
    
    layout
    {
        area(content)
        {
            group(GroupName)
            {
                field("Fisc. Location Code"; "Fisc. Location Code")
                {
                    ApplicationArea = All;
                }
                field("Fisc. Street"; "Fisc. Street")
                {
                    ApplicationArea = All;
                }
                field("Fisc. House Number"; "Fisc. House Number")
                {
                    ApplicationArea = All;
                }
                field("Fisc. House Number Appendix"; "Fisc. House Number Appendix")
                {
                    ApplicationArea = All;
                }
                field("Fisc. Settlement"; "Fisc. Settlement")
                {
                    ApplicationArea = All;
                }
                field("Fisc. City/Municipality"; "Fisc. City/Municipality")
                {
                    ApplicationArea = All;
                }
                field("Fisc. Post Code"; "Fisc. Post Code")
                {
                    ApplicationArea = All;
                }
                field("Fisc. Location Description"; "Fisc. Location Description")
                {
                    ApplicationArea = All;
                }
                field("Working Hours"; "Working Hours")
                {
                    ApplicationArea = All;
                }
                field("Date Of Application"; "Date Of Application")
                {
                    ApplicationArea = All;
                }
                field("Fisc. No. Series"; "Fisc. No. Series")
                {
                    Importance = Additional;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fisc. Active"; "Fisc. Active")
                {
                    Editable = NOT VisibleSI;
                    ApplicationArea = All;
                }
                field("Creation Date"; "Creation Date")
                {
                    Editable = NOT VisibleHR;
                    ApplicationArea = All;
                }
                field("Creation Time"; "Creation Time")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    
                }
                field("Ending Date"; "Ending Date")
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

            action("Fiscalization Location Mapping")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                  FiscalizationLocationMappingPage : Page "Fisc. Location Mapping-ADL";
                  FiscalizationLocationMapping : Record "Fiscalization Loc. Mapping-ADL";
                begin
                    FiscalizationLocationMapping.SETRANGE("Fisc. Location Code","Fisc. Location Code");
                    FiscalizationLocationMappingPage.SETTABLEVIEW(FiscalizationLocationMapping);
                    FiscalizationLocationMappingPage.RUNMODAL();
                end;
            }

        }
    }
    
    var
        FiscalizationSetup : Record "Fiscalization Setup-ADL";
        FiscManagementSI : Codeunit "Fisc. Management-ADL";
        FiscLocation : Record "Fiscalization Location-ADL";
        VisibleSI : Boolean;
        visibleHR : Boolean;
    trigger OnInit()
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
    trigger OnOpenPage()
    begin
        IF NOT GET() THEN
          INIT();
    end;
}