pageextension 13062741 "Sales & Receivables Setup-Adl" extends "Sales & Receivables Setup" //459
{
    layout
    {
        // <adl.28>
        addlast(General)
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
