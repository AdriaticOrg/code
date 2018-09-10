page 13062642 "FAS Sectors"
{
    Caption = 'Finance Sectors';
    PageType = List;
    SourceTable = "FAS Sector";
    Editable = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1100636000)
            {
                IndentationControls = Description;
                ShowCaption = false;
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(Totaling; Totaling)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Indentation; Indentation)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Show Credit/Debit"; "Show Credit/Debit")
                {
                    ApplicationArea = All;
                }
                field("Index Code"; "Index Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}