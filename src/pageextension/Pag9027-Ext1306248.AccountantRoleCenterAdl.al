pageextension 13062558 "Accountant Role Center-Adl" extends "Accountant Role Center" // 9027
{
    actions
    {
        addafter("VAT Statements")
        {
            action("VAT Books")
            {
                ApplicationArea = All;
                RunObject = page "VAT Books-Adl";
            }
        }
    }
}