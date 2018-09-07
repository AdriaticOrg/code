page 13062811 "Core Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CoreSetup-Adl";
    Caption = 'Core Setup';
    
    layout
    {
        area(Content)
        {
            group(General) {
                Caption = 'General';
                field("ADL Enabled";"ADL Enabled") {
                    ApplicationArea = All;
                }
            }
            group(ReportingSI)        
            {
                Caption = 'Reporting SI';
                field("FAS Enabled";"FAS Enabled") {
                    ApplicationArea = All;
                }
                field("KRD Enabled";"KRD Enabled") {
                    ApplicationArea = All;
                }
                field("BST Enabled";"BST Enabled") {
                    ApplicationArea = All;
                }
                
            }
        }
    }
    
}