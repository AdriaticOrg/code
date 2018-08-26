page 50104 "FAS Report Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
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
                field("Amount"; "Amount")
                {
                    ApplicationArea = All;
                }
                
            }
        }
    }    
}