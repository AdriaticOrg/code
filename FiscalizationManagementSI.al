codeunit 13062632 "Fisc. Management SI-ADL"
{
    trigger OnRun()
    begin

    end;
procedure SetCalledFromPosting(NewCalledFromPosting : Boolean)
begin
    CalledFromPosting := NewCalledFromPosting;
end;
procedure CreateInvoiceDoc(SalesInvoiceHeader : Record "Sales Invoice Header")
begin
        //IF NOT IsFiscActive(SalesInvoiceHeader."Posting Date") THEN
        //    ERROR(Text009,SalesInvoiceHeader."Posting Date");

        //IF SalesInvoiceHeader."Prepayment Invoice" THEN
        //    CreateInitalLogEntry(8,SalesInvoiceHeader)
        //ELSE
        //    CreateInitalLogEntry(2,SalesInvoiceHeader);

        //CalcZOIInvoice(SalesInvoiceHeader);

        //IF SalesInvoiceHeader."Prepayment Invoice" THEN
        //FiscInvoiceAdd(8,SalesInvoiceHeader)
        //ELSE
        //FiscInvoiceAdd(2,SalesInvoiceHeader);

        //IF FiscPostedSalesDocAdd.GET(SalesInvoiceHeader."Fisc. Entry No.") AND (EOR <> '') THEN BEGIN
        //FiscPostedSalesDocAdd."Late Delivery" := (NOT CalledFromPosting);
        //FiscPostedSalesDocAdd."Tax Authority Doc. No." := EOR;
        //FiscPostedSalesDocAdd."Fisc. Registered" := TRUE;
        //FiscPostedSalesDocAdd.MODIFY;
        //END;
end;
procedure IsFiscActive(PostingDate : Date) : Boolean
var
    FiscalizationSetup : Record "Fiscalization Setup-ADL";
begin
    IF NOT FiscalizationSetup.GET THEN
    EXIT(FALSE);

    IF PostingDate < FiscalizationSetup."Start Date" THEN
        EXIT(FALSE);

    EXIT(TRUE);
end;
var
    CalledFromPosting : Boolean;
    Text009 : TextConst ENU = 'Fiscalization is not active until %1.';
}