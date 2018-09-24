page 13062641 "FAS Instruments-Adl"
{
    Caption = 'FAS Instruments';
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
                field("AOP Code"; "AOP Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies AOP Code';
                }
            }
        }
    }
}
