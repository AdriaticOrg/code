pageextension 13062552 "Currency-adl" extends "Currency Card" //495
{
    layout
    {
        // <adl.24>
        addafter(Code) {
            field("Numeric Code";"Numeric Code") {
                ApplicationArea = All;
            }
        }
        // </adl.24>        
    }
}