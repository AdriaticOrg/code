pageextension 50104 "CompanyInfo-adl" extends "Company Information"
{
    layout
    {
        addafter("VAT Registration No.") {
            field("Registration No.";"Registration No.") {
                ApplicationArea = All;
            }
        }
        
    }
    
    actions
    {
    }
}