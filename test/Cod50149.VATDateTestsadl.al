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
    LibrarySetupAdl : codeunit "Library Setup-adl";
    LibraryFiscalYear : Codeunit "Library - Fiscal Year";

  local procedure Initialize();
  var
    //CompanyInfo : Record 79;
    GeneralPostingSetup : Record "General Posting Setup";
    VATPostingSetup : Record "VAT Posting Setup";
  begin
    LibraryVariableStorage.Clear;
    LibrarySetupStorage.Restore;
    //??SalesHeader.DontNotifyCurrentUserAgain(SalesHeader.GetModifyBillToCustomerAddressNotificationId);
    //??SalesHeader.DontNotifyCurrentUserAgain(SalesHeader.GetModifyCustomerAddressNotificationId);

    if isInitialized then
      exit;

    LibraryApplicationArea.EnableFoundationSetup;
    
    LibraryPatterns.SETNoSeries;
    LibrarySales.SetPostedNoSeriesInSetup;
    LibraryERM.FindVATPostingSetup(VATPostingSetup,VATPostingSetup."VAT Calculation Type"::"Normal VAT");
    
    LibrarySetupAdl.CreateGenPostingGroupGetAccounts;
    LibrarySetupAdl.CreateInventoryPostingSetupGetAccounts;

    LibraryERMCountryData.CreateVATData;
    LibraryERMCountryData.UpdateGeneralLedgerSetup;
    LibraryERMCountryData.UpdateSalesReceivablesSetup;
    LibraryERMCountryData.UpdateGeneralPostingSetup;
    LibrarySetupStorage.Save(DATABASE::"Sales & Receivables Setup");
    LibrarySetupStorage.Save(DATABASE::"General Ledger Setup");

    isInitialized := TRUE;
  end;

  local procedure CreateFiscalYearAndInventoryPeriod() PostingDate : Date;
  var
    InventoryPeriod : Record "Inventory Period";
  begin
    LibraryFiscalYear.CreateFiscalYear;
    PostingDate := LibraryFiscalYear.GetLastPostingDate(FALSE);
    LibraryInventory.CreateInventoryPeriod(InventoryPeriod,PostingDate);
  end;

  [ConfirmHandler]
  procedure ConfirmHandler(ConfirmMessage: Text[1024]; var Result: Boolean);
  begin;
    Result := TRUE;
  end;

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
    PostingDate : Date;
    InventoryPostingSetup : Record "Inventory Posting Setup";
  begin
    // Setup
    Initialize;

    LibraryInventory.FindUnitOfMeasure(UnitOfMeasure);
    ItemNo := LibraryInventory.CreateItemNo();
    PostingDate := CreateFiscalYearAndInventoryPeriod;

    InventoryPostingSetup.FindFirst();
    LibrarySales.CreateCustomerWithLocationCode(Customer, InventoryPostingSetup."Location Code");
    

    SalesInvoicePage.OpenEdit();
    SalesInvoicePage.New();
    SalesInvoicePage."Sell-to Customer No.".Value(Customer."No.");
    
    //TODO: The field with ID = 2 is not found on the page. ( ApplicationArea #Advanced )
    //SalesInvoicePage.SalesLines.Type.VALUE(FORMAT(SalesLine.Type::Item));
    SalesInvoicePage.SalesLines."No.".VALUE(ItemNo);
    SalesInvoicePage.SalesLines.Quantity.VALUE(FORMAT(LibraryRandom.RandInt(5)));
    SalesInvoicePage."Currency Code".VALUE(Currency.Code);
    //SalesInvoicePage."Posting Date".SetValue(PostingDate);
    DocumentNo := SalesInvoicePage."No.".VALUE;
    

    //TODO: Unhandled UI: Confirm
    //Confirm.Test = T.SalesHeader.DocumentNotPostedClosePageQst ( not public )
    SalesInvoicePage.CLOSE;

    SalesHeader.SetCurrentKey("Document Type","No.");
    SalesHeader.GET(SalesHeader."Document Type"::Invoice, DocumentNo);
    PostedDocumentNo := LibrarySales.PostSalesDocument(SalesHeader,FALSE,TRUE);

   //TODO: REMOVE! Error('VATDate.dbg: DocumentNo=%1, PostedDocumentNo=%2', DocumentNo, PostedDocumentNo);

    //VerifyCurrencyInSalesLine(SalesLine."Document Type"::Invoice,DocumentNo,Resource."No.",Currency.Code);
  end;
}