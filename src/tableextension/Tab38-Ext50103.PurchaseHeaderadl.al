tableextension 50103 "PurchaseHeader-adl" extends "Purchase Header"  //38
{
    fields
    {
        field(50000; "VAT Date-adl"; Date)
        {
            Caption = 'VAT Date';

            trigger OnValidate();            
            begin  
                if "VAT Date-adl" <> "Posting Date" then
                    "Postponed VAT-adl" := "Postponed VAT-adl"::"Postponed VAT"
                else
                    "Postponed VAT-adl" := "Postponed VAT-adl"::"Realized VAT";
            end;
        }
        field(50001; "Postponed VAT-adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}