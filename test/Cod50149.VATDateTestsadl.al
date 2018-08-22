codeunit 50149 "VAT Date Tests-adl"
{
  Subtype = Test;

  TestPermissions = Disabled;

  var
    isInitialized : Boolean;
    Assert : Codeunit Assert;
    LibraryVariableStorage : Codeunit "Library - Variable Storage";
    LibrarySetupStorage : Codeunit "Library - Setup Storage";
    LibraryApplicationArea : Codeunit "Library - Application Area";
    LibraryPatterns : Codeunit "Library - Patterns";
    LibraryERMCountryData : Codeunit "Library - ERM Country Data";
    LibraryRandom : Codeunit "Library - Random";
    LibraryERM : Codeunit "Library - ERM";
    LibrarySales : Codeunit "Library - Sales";
    LibraryInventory : Codeunit "Library - Inventory";

  local procedure Initialize();
  var
    //CompanyInfo : Record 79;
  begin
    LibraryVariableStorage.Clear;
    LibrarySetupStorage.Restore;
    //??SalesHeader.DontNotifyCurrentUserAgain(SalesHeader.GetModifyBillToCustomerAddressNotificationId);
    //??SalesHeader.DontNotifyCurrentUserAgain(SalesHeader.GetModifyCustomerAddressNotificationId);

    IF isInitialized THEN
      EXIT;

    LibraryApplicationArea.EnableFoundationSetup;
    
    LibraryPatterns.SETNoSeries;
    LibrarySales.SetPostedNoSeriesInSetup;

    LibraryERMCountryData.CreateVATData;
    LibraryERMCountryData.UpdateGeneralLedgerSetup;
    LibraryERMCountryData.UpdateSalesReceivablesSetup;
    LibraryERMCountryData.UpdateGeneralPostingSetup;
    LibrarySetupStorage.Save(DATABASE::"Sales & Receivables Setup");
    LibrarySetupStorage.Save(DATABASE::"General Ledger Setup");

    isInitialized := TRUE;
  end;

  [ConfirmHandler]
  procedure ConfirmHandler(ConfirmMessage: Text[1024]; var Result: Boolean);
  BEGIN
    Result := TRUE;
  END;

  [Test]
  [HandlerFunctions('ConfirmHandler')]
  procedure UpdateVATDateOnSalesInvoicePage();
  var
    Customer : Record Customer;
    SalesInvoicePage : TestPage "Sales Invoice";
    UnitOfMeasure : Record "Unit of Measure";
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
    LibraryInventory.FindUnitOfMeasure(UnitOfMeasure);
    ItemNo := LibraryInventory.CreateItemNo();

    SalesInvoicePage.OpenEdit();
    SalesInvoicePage.New();
    //Error('VATDate.dbg.123');
    SalesInvoicePage."Sell-to Customer No.".Value(Customer."No.");
    //TODO: The field with ID = 2 is not found on the page. ( ApplicationArea #Advanced )
    //SalesInvoicePage.SalesLines.Type.VALUE(FORMAT(SalesLine.Type::Item));
    SalesInvoicePage.SalesLines."No.".VALUE(ItemNo);
    SalesInvoicePage.SalesLines.Quantity.VALUE(FORMAT(LibraryRandom.RandInt(5)));
    SalesInvoicePage."Currency Code".VALUE(Currency.Code);

    //TODO: The field with ID = 2 is not found on the page.
    //DocumentNo := SalesInvoicePage."No.".VALUE;

    //TODO: Unhandled UI: Confirm
    //Confirm.Test = T.SalesHeader.DocumentNotPostedClosePageQst ( not public )
    
    SalesInvoicePage.CLOSE;

    //Error('VATDate.dbg.21');
    
    // SalesHeader.SetCurrentKey("Document Type","No.");
    // SalesHeader .GET(SalesHeader."Document Type"::Invoice, DocumentNo);
    // PostedDocumentNo := LibrarySales.PostSalesDocument(SalesHeader,FALSE,TRUE);

    //VerifyCurrencyInSalesLine(SalesLine."Document Type"::Invoice,DocumentNo,Resource."No.",Currency.Code);
  end;
}