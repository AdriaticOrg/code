page 50106 "KRD Report Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "KRD Report Line";
    AutoSplitKey = true;
    Caption = 'KRD Report Subform';
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Claim/Liability";"Claim/Liability") {
                    ApplicationArea = All;
                }
                field("Affiliation Type";"Affiliation Type") {
                    ApplicationArea = All;
                }
                field("Instrument Type";"Instrument Type") {
                    ApplicationArea = All;
                }
                field(Maturity;Maturity) {
                    ApplicationArea = All;
                }
                field("Non-Residnet Sector Code";"Non-Residnet Sector Code") {
                    ApplicationArea = All;
                }
                field("Country/Region Code";"Country/Region Code") {
                    ApplicationArea = All;
                }
                field("Country/Region No.";"Country/Region No.") {
                    ApplicationArea = All;
                }
                field("Currency Code";"Currency Code") {
                    ApplicationArea = All;
                }
                field("Other Changes";"Other Changes") {
                    ApplicationArea = All;
                }
                field("Currency No.";"Currency No.") {
                    ApplicationArea = All;
                }
                field("Opening Balance";"Opening Balance") {
                    ApplicationArea = All;
                }
                field("Increase Amount";"Increase Amount") {
                    ApplicationArea = All;
                }
                field("Decrease Amount";"Decrease Amount") {
                    ApplicationArea = All;
                }
                field("Closing Balance";"Closing Balance") {
                    ApplicationArea = All;
                }                
            }
        }
    }    
}