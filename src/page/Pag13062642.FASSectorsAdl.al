page 13062642 "FAS Sectors-Adl"
{
    Caption = 'FAS Sectors';
    PageType = List;
    SourceTable = "FAS Sector-Adl";
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
                    ToolTip = 'Specifies Code';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Description';
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Type';
                }
                field(Totaling; Totaling)
                {
                    Editable = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies Totaling';
                }
                field(Indentation; Indentation)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies Indentation';
                }
                field("Show Credit/Debit"; "Show Credit/Debit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Show Credit/Debit';
                }
                field("Index Code"; "Index Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Index Code';
                }
            }
        }
    }
}
