page 13062813 "Extended Setup-Adl"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Extended Setup-Adl";
    Caption = 'Adriatic Extended Setup';

    layout
    {
        area(Content)
        {
            group(VAT)
            {
                Caption = 'VAT';
                field("VAT Enabled"; "VAT Enabled")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if Extended VAT functionality is enabled.';
                }
            }
            // <adl.22>
            group(VIES)
            {
                Caption = 'VIES';
                field("Use VAT Output Date"; "Use VAT Output Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if VAT Output Date is used when posting document.';
                }
            }
            // </adl.22>
            // <adl.28>
            group(UnpaidReceivables)
            {
                Caption = 'Unpaid Receivables';
                field("Unpaid Receivables Enabled"; "Unpaid Receivables Enabled")
                {
                    ToolTip = 'Specifies if Unpaid Receivables functionality is enabled.';
                    ApplicationArea = All;
                }
                field("Exteded Data Start Bal. Date"; "Ext. Data Start Bal. Date")
                {
                    ToolTip = 'Enter extended data start balance date';
                    ApplicationArea = AdlUnpaidReceivables;
                }
            }
            // </adl.28>
        }
    }
}