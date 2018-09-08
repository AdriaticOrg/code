pageextension 13062540 "GenLedgEntries-adl" extends "General Ledger Entries"  //20
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("FAS Type"; "FAS Type")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Instrument Code"; "FAS Instrument Code")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Sector Code"; "FAS Sector Code")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            // </adl.24>
            // <adl.26>
            field("BST Code"; "BST Code")
            {
                ApplicationArea = All;
                Visible = BSTFeatureEnabled;
            }
            // </adl.26>
        }
    }

    // <adl.24>
    actions
    {
        addlast("F&unctions")
        {

            group(ChangeData)
            {
                Caption = 'Change Data';
                Image = ChangeStatus;
                Visible = FASFeatureEnabled;
                action(ChangeFinInstr)
                {
                    Caption = 'Finance Instrument';
                    Image = ListPage;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        FASInstrument: Record "FAS Instrument";
                    begin
                        FASInstrument.Reset();
                        FASInstrument.SetRange(Type, FASInstrument.Type::Posting);
                        if FASInstrument.get("FAS Instrument Code") then;

                        if page.RunModal(0, FASInstrument) = Action::LookupOK then begin
                            "FAS Instrument Code" := FASInstrument.Code;
                            Modify();
                        end;
                    end;
                }
                action(ChangeFinSect)
                {
                    Caption = 'Finance Sector';
                    Image = ListPage;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        FASSector: Record "FAS Sector";
                    begin
                        FASSector.Reset();
                        FASSector.SetRange(Type, FASSector.Type::Posting);
                        if FASSector.get("FAS Sector Code") then;

                        if page.RunModal(0, FASSector) = Action::LookupOK then begin
                            "FAS Sector Code" := FASSector.Code;
                            Modify();
                        end;
                    end;
                }
                // <adl.26>
                action(ChangeBST)
                {
                    Caption = 'BST Code';
                    Image = ListPage;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BSTCode: Record "BST Code";
                    begin
                        BSTCode.Reset();
                        BSTCode.SetRange(Type, BSTCode.Type::Posting);
                        if BSTcode.get("BST Code") then;

                        if page.RunModal(0, BSTCode) = Action::LookupOK then begin
                            "BST Code" := BSTCode.Code;
                            Modify();
                        end;
                    end;
                }
                // </adl.26>                       
            }
        }
    }
    // </adl.24>
    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        FASFeatureEnabled: Boolean;
        KRDFeatureEnabled: Boolean;
        BSTFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled("ADL Features"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::VAT);
        FASFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::FAS);
        KRDFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::KRD);
        BSTFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::BST);
        // </adl.0>
    end;

}