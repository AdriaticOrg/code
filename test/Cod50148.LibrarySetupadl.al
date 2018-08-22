codeunit 50148 "Library Setup-adl"
{
  Subtype = Normal;

  var
    LibraryERM : Codeunit "Library - ERM";
    LibraryInventory : Codeunit "Library - Inventory";
    LibraryWarehouse : Codeunit "Library - Warehouse";
  procedure CreateGenPostingGroupGetAccounts();
  var
    GeneralLedgerSetup : Record "General Ledger Setup";
    GenBusinessPostingGroup : Record "Gen. Business Posting Group";
    GenProductPostingGroup : Record "Gen. Product Posting Group";
    GeneralPostingSetup : Record "General Posting Setup";
  begin
    GeneralLedgerSetup.GET;
    GeneralLedgerSetup."Adjust for Payment Disc." := TRUE;
    GeneralLedgerSetup.Modify(true);

    LibraryERM.CreateGenBusPostingGroup(GenBusinessPostingGroup);
    LibraryERM.CreateGenProdPostingGroup(GenProductPostingGroup);
    LibraryERM.CreateGeneralPostingSetup(GeneralPostingSetup,GenBusinessPostingGroup.Code,GenProductPostingGroup.Code);

    with GeneralPostingSetup do begin
      LibraryERM.SetGeneralPostingSetupSalesAccounts(GeneralPostingSetup);
      LibraryERM.SetGeneralPostingSetupSalesPmtDiscAccounts(GeneralPostingSetup);
      LibraryERM.SetGeneralPostingSetupPurchAccounts(GeneralPostingSetup);
      LibraryERM.SetGeneralPostingSetupPurchPmtDiscAccounts(GeneralPostingSetup);
      LibraryERM.SetGeneralPostingSetupInvtAccounts(GeneralPostingSetup);
      LibraryERM.SetGeneralPostingSetupPrepAccounts(GeneralPostingSetup);
      LibraryERM.SetGeneralPostingSetupMfgAccounts(GeneralPostingSetup);
      "Purch. FA Disc. Account" := LibraryERM.CreateGLAccountNo;
      Modify(true);
    end;
  end;
procedure CreateInventoryPostingSetupGetAccounts();
  var
    Location : Record "Location";
    InventoryPostingGroup : Record "Inventory Posting Group";
    InventoryPostingSetup : Record "Inventory Posting Setup";
  begin
    LibraryWarehouse.CreateLocation(Location);

    if not InventoryPostingGroup.FindFirst() then
      LibraryInventory.CreateInventoryPostingGroup(InventoryPostingGroup);

    LibraryInventory.CreateInventoryPostingSetup(InventoryPostingSetup,Location.Code,InventoryPostingGroup.Code);
    
    with InventoryPostingSetup do begin
        "Inventory Account" := LibraryERM.CreateGLAccountNo;
        "Inventory Account (Interim)" := LibraryERM.CreateGLAccountNo;
        "WIP Account" := LibraryERM.CreateGLAccountNo;
        "Material Variance Account" := LibraryERM.CreateGLAccountNo;
        "Capacity Variance Account" := LibraryERM.CreateGLAccountNo;
        "Mfg. Overhead Variance Account" := LibraryERM.CreateGLAccountNo;
        "Cap. Overhead Variance Account" := LibraryERM.CreateGLAccountNo;
        "Subcontracted Variance Account" := LibraryERM.CreateGLAccountNo;
        Modify(true);
    end;
  end;
  }