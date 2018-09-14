page 13062785 "Fisc. Location List-ADL"
{   
    UsageCategory = Documents;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Fiscalization Location-ADL";
    CardPageId = "Fisc. Location Card-ADL";
    layout
    {
        area(content)
        {
            repeater(List)
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
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fisc. Active"; "Fisc. Active")
                {
                    Editable = false;
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
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
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
        VisibleSI : boolean;
        VisibleHR : boolean;
        FiscManagementSI : Codeunit "Fisc. Management-ADL";
        FiscLocation : Record "Fiscalization Location-ADL";
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