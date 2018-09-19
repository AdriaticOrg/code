page 13062681 "BST Codes-Adl"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;
    SourceTable = "BST Code-Adl";
    Caption = 'BST Codes';

    layout
    {
        area(Content)
        {
            repeater(Control1100636000)
            {
                IndentationControls = Description;
                ShowCaption = false;

                field(Code; Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Code';
                }
                field("Serial Num."; "Serial Num.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Serial Num.';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Description';
                }
                field(Totaling; Totaling)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Totaling';
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Type';
                }
                field(Indentaion; Indentation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Indentation';
                }
            }
        }
    }
}
