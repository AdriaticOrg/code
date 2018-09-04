page 13062601 "VIES Report Subform"
{
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "VIES Report Line";
    AutoSplitKey = true;
    Caption = 'VIES Report Subform';
    
    layout
    {
        area(Content)
        {
            repeater(Group) {
                field(Type;Type) {
                    ApplicationArea = All;
                }
                field("Applies-to Report No.";"Applies-to Report No.") {
                    ApplicationArea = All;
                }
                field("Period Year";"Period Year") {
                    ApplicationArea = All;
                }
                field("Period Round";"Period Round") {
                    ApplicationArea = All;
                }
                field("Country/Region Code";"Country/Region Code") {
                    ApplicationArea = All;
                }
                field("VAT Registration No.";"VAT Registration No.") {
                    ApplicationArea = All;
                }
                field("EU Sales Type";"EU Sales Type") {
                    ApplicationArea = All;
                }
                field("EU 3-Party Trade";"EU 3-Party Trade") {
                    ApplicationArea = All;
                }
                field("EU Customs Procedure";"EU Customs Procedure") {
                    ApplicationArea = All;
                }
                field(Amount;Amount) {
                    ApplicationArea = All;
                }
            }
        }
    }    
}