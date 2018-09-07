codeunit 13062631 "Finalize Fiscalization SI-ADL"
{
    trigger OnRun()
    var FiscManagSI : Codeunit "Fisc. Management SI-ADL";
        FiscSubject : Boolean;
        DocumentType : Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
    begin
        //CLEAR(FiscManagSI);
        //FiscManagSI.SetCalledFromPosting(TRUE);
        //CASE TRUE OF
        //FiscSubject AND (DocumentType IN [DocumentType::Order,DocumentType::Invoice]) :
        //    BEGIN
        //    FiscManagSI.CreateInvoiceDoc(SalesInvoiceHeader);
        //    END;
        //FiscSubject AND (DocumentType IN [DocumentType::"Return Order",DocumentType::"Credit Memo"]) :
        //    BEGIN
        //    FiscManagSI.CreateCrMemoDoc(SalesCrMemoHeader);
        //    END;
        //NOT FiscSubject AND (DocumentType IN [DocumentType::Order,DocumentType::Invoice]) :
        //    BEGIN
        //    FiscManagSI.CalcZOIInvoice(SalesInvoiceHeader);
        //    END;
        //NOT FiscSubject AND (DocumentType IN [DocumentType::"Return Order",DocumentType::"Credit Memo"]) :
        //    BEGIN
        //    FiscManagSI.CalcZOICrMemo(SalesCrMemoHeader);
        //    END;
        //END;
    end;
procedure SetProperties(NewDocumentType : option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";NewFiscSubject : Boolean;NewSalesInvoiceHeader : Record "Sales Invoice Header";NewSalesCrMemoHeader : Record "Sales Cr.Memo Header")
    begin
        DocumentType := NewDocumentType;
        FiscSubject := NewFiscSubject;
        SalesInvoiceHeader := NewSalesInvoiceHeader;
        SalesCrMemoHeader := NewSalesCrMemoHeader;
    end;
var
    DocumentType : Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
    FiscSubject : Boolean;
    SalesInvoiceHeader : Record "Sales Invoice Header";
    SalesCrMemoHeader : Record "Sales Cr.Memo Header";
    ServiceInvoiceHeader : Record "Service Invoice Header";
    ServiceCrMemoHeader : Record "Service Cr.Memo Header";
}