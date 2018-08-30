pageextension 13062538 "CompanyInfo-adl" extends "Company Information" //1
{
    layout
    {
        // <adl.24>
        addafter("VAT Registration No.") {
            field("Registration No.";"Registration No.") {
                ApplicationArea = All;
            }
        }
        // <adl.24>        
    }
    
    actions
    {
    }
}