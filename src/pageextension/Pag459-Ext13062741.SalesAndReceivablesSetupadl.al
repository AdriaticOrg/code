pageextension 13062741 "SalesAndReceivablesSetupadl" extends "Sales & Receivables Setup" //459
{
    layout
    {
        // <adl.28>
        addlast("Dynamics 365 for Sales")
        {
            group(UnpaidReceivables)
            {
                field("Exteded Data Start Bal. Date"; "Exteded Data Start Bal. Date-Adl")
                {
                    Caption = 'Extended Data Start Balance Date';
                    ApplicationArea = All;
                }

            }
        }
        // <adl.28>
    }
}
