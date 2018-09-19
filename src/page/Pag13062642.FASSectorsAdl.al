page 13062642 "FAS Sectors-Adl"
{
    Caption = 'FAS Finance Sectors';
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
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field(Totaling; Totaling)
                {
                    Editable = true;
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field(Indentation; Indentation)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Show Credit/Debit"; "Show Credit/Debit")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Index Code"; "Index Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
            }
        }
    }
}