page 13062664 "KRD Codes-Adl"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "KRD Code-Adl";
    Caption = 'KRD Codes';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Type';
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Code';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Description';
                }
            }
        }
    }
}
