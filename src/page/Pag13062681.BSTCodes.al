page 13062681 "BST Codes"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
    SourceTable = "BST Code";
    
    layout
    {
        area(Content)
        {
            repeater(Control1100636000)
            {
                IndentationControls = Description;
                ShowCaption = false;

                field(Code;Code) {
                    ApplicationArea = All;
                }
                field("Serial Num.";"Serial Num.") {
                    ApplicationArea = All;
                }
                field(Description;Description) {
                    ApplicationArea = All;
                }
                field(Totaling;Totaling) {
                    ApplicationArea = All;
                }
                field(Type;Type) {
                    ApplicationArea = All;
                }
                field(Indentaion;Indentation) {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}