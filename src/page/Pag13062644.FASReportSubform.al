page 13062644 "FAS Report Subform"
{
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "FAS Report Line";
    AutoSplitKey = true;
    Caption = 'FAS Report Subform';
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("FAS Type";"FAS Type") {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("AOP Code";"AOP Code")
                {
                    ApplicationArea = All;
                }
                field("Sector Code";"Sector Code")
                {
                    ApplicationArea = All;
                }
                field("Instrument Code";"Instrument Code")
                {
                    ApplicationArea = All;
                }
                field("Transactions Amt. in Period";"Transactions Amt. in Period") {
                    ApplicationArea = All;
                }
                field("Changes Amt. in Period";"Changes Amt. in Period") {
                    ApplicationArea = All;
                }
                field("Period Closing Balance";"Period Closing Balance") {
                    ApplicationArea = All;
                }                
                
            }
        }
    }    
}