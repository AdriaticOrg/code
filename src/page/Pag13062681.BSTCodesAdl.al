page 13062681 "BST Codes-Adl"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;
    SourceTable = "BST Code-Adl";

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
                }
                field("Serial Num."; "Serial Num.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Totaling; Totaling)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(Indentaion; Indentation)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}