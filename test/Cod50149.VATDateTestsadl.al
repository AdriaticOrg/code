codeunit 50149 "VAT Date Tests-adl"
{
  Subtype = Test;

  TestPermissions = Disabled;

  var
    Initialized : Boolean;
    Assert : Codeunit Assert;
    LibraryRandom : Codeunit "Library - Random";
    LibraryERM : Codeunit "Library - ERM";
    LibrarySales : Codeunit "Library - Sales";
    LibraryInventory : Codeunit "Library - Inventory";

  local procedure Initialize();
  var
    //CompanyInfo : Record 79;
  begin
    IF Initialized THEN
      EXIT;

    Initialized := TRUE;
  end;

  [Test]
  //[HandlerFunctions('AccountSetupPageModalPageHandler,ConfirmHandler,SelectPaymentServiceTypeHandler')]
  procedure UpdateVATDateOnSalesInvoicePage();
  var
    Customer : Record Customer;
    SalesInvoicePage : TestPage "Sales Invoice";
    SalesHeader : Record "Sales Header";
    SalesLine : Record "Sales Line";
    ItemNo : Code[20];
    Currency : Record Currency;
    DocumentNo : Code[20];
    PostedDocumentNo : Code[20];
  begin
    // Setup
    Initialize;

    LibrarySales.CreateCustomer(Customer);
    ItemNo := LibraryInventory.CreateItemNo();

    SalesInvoicePage.OpenEdit();
    SalesInvoicePage.New();
    SalesInvoicePage."Sell-to Customer No.".Value(Customer."No.");
    SalesInvoicePage.SalesLines.Type.VALUE(FORMAT(SalesLine.Type::Item));
    SalesInvoicePage.SalesLines."No.".VALUE(ItemNo);
    SalesInvoicePage.SalesLines.Quantity.VALUE(FORMAT(LibraryRandom.RandInt(5)));
    SalesInvoicePage."Currency Code".VALUE(Currency.Code);
    DocumentNo := SalesInvoicePage."No.".VALUE;
    SalesInvoicePage.CLOSE;
    
    SalesHeader.SetCurrentKey("Document Type","No.");
    SalesHeader .GET(SalesHeader."Document Type"::Invoice, DocumentNo);
    PostedDocumentNo := LibrarySales.PostSalesDocument(SalesHeader,FALSE,TRUE);

    //VerifyCurrencyInSalesLine(SalesLine."Document Type"::Invoice,DocumentNo,Resource."No.",Currency.Code);
  end;
}