tableextension 13062526 "PurchaseHeader-adl" extends "Purchase Header"  //38
{
    fields
    {
        field(13062525; "VAT Date-adl"; Date)
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
        field(13062526; "Postponed VAT-adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}