page 13062641 "FAS Instruments-Adl"
{
    Caption = 'Finance Instruments';
    PageType = List;
    DelayedInsert = true;
    SourceTable = "FAS Instrument-Adl";
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
                field("AOP Code"; "AOP Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
            }
        }
    }
}