page 13062683 "BST Report Subform-Adl"
{
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "BST Report Line-Adl";
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
                         ToolTip = 'Specifies BST Code {';
                }     
                field("BST Serial No.";"BST Serial No.") {
                    ApplicationArea = All;
                        ToolTip = 'Specifies BST Serial No. {';
                }    
                field(Description;Description) {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Description {';
                }
                field("Country/Region Code";"Country/Region Code") {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Country/Region Code {';
                }
                field("Country/Region No.";"Country/Region No.") {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Country/Region No. {';
                }
                field("Income Amount";"Income Amount") {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Income Amount {';
                }
                field("Expense Amount";"Expense Amount") {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Expense Amount {';
                }
            }
        }
    }    
}
