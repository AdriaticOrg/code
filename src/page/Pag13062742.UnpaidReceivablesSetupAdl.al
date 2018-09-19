page 13062742 "Unpaid Receivables Setup-Adl"
{
    PageType = Card;
    ApplicationArea = AdlUnpaidReceivables;
    UsageCategory = Administration;
    SourceTable = "Unpaid Receivables Setup-Adl";
    Caption = 'Unpaid Receivables Setup';

    layout
    {
        area(Content)
        {
            group(UnpaidReceivables)
            {
                field("Exteded Data Start Bal. Date"; "Ext. Data Start Bal. Date-Adl")
                {
                    Caption = 'Extended Data Start Balance Date';
                    ToolTip = 'Enter extended data start balance date';
                    ApplicationArea = AdlUnpaidReceivables;
                }
            }
        }
    }
}