page 13062785 "Fisc. Location List-Adl"
{   // <adl.20>
    Caption = 'Fiscalization Location List';
    UsageCategory = Documents;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Fiscalization Location-Adl";
    CardPageId = "Fisc. Location Card-Adl";
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
                    FiscalizationLocationMapping: Record "Fiscalization Loc. Mapping-Adl";
                    FiscalizationLocationMappingPage: Page "Fisc. Location Mapping-Adl";
                begin
                    FiscalizationLocationMapping.SETRANGE("Fisc. Location Code", "Fisc. Location Code");
                    FiscalizationLocationMappingPage.SETTABLEVIEW(FiscalizationLocationMapping);
                    FiscalizationLocationMappingPage.RUNMODAL();
                end;
            }
        }
    }

    var
        FiscLocation: Record "Fiscalization Location-Adl";
        FiscManagementSI: Codeunit "Fisc. Management-Adl";
        VisibleSI: boolean;
        VisibleHR: boolean;

    trigger OnInit()
    var
        FiscalizationSetup: Record "Fiscalization Setup-Adl";
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
    // </adl.20>
}