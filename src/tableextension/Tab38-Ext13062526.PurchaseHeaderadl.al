tableextension 13062526 "PurchaseHeader-Adl" extends "Purchase Header"  //38
{
    fields
    {
        field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';

            trigger OnValidate();
            begin
                if "VAT Date-Adl" <> "Posting Date" then
                    "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Postponed VAT"
                else
                    "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Realized VAT";
            end;
        }
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}