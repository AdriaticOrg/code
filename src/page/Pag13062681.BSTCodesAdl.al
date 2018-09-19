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
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Serial Num."; "Serial Num.")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field(Totaling; Totaling)
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field(Indentaion; Indentation)
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
            }
        }
    }
}