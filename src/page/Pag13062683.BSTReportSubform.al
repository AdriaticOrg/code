page 13062683 "BST Report Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BST Report Line";
    AutoSplitKey = true;
    Caption = 'BST Report Subform';
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("BST Code";"BST Code") {
                    ApplicationArea = All;
                }     
                field("BST Serial No.";"BST Serial No.") {
                    ApplicationArea = All;
                }    
                field(Description;Description) {
                    ApplicationArea = All;
                }
                field("Country/Region Code";"Country/Region Code") {
                    ApplicationArea = All;
                }
                field("Country/Region No.";"Country/Region Code") {
                    ApplicationArea = All;
                }
                field("Income Amount";"Income Amount") {
                    ApplicationArea = All;
                }
                field("Expense Amount";"Expense Amount") {
                    ApplicationArea = All;
                }
            }
        }
    }    
}