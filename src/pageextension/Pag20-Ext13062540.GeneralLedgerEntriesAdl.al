pageextension 13062540 "General Ledger Entries-Adl" extends "General Ledger Entries"  //20
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("FAS Type"; "FAS Type-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Instrument Code"; "FAS Instrument Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Sector Code"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            // </adl.24>
            // <adl.26>
            field("BST Code"; "BST Code-Adl")
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
                action("ChangeFinInstr-Adl")
                {
                    Caption = 'Finance Instrument';
                    Image = ListPage;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        FASInstrument: Record "FAS Instrument-Adl";
                    begin
                        FASInstrument.Reset();
                        FASInstrument.SetRange(Type, FASInstrument.Type::Posting);
                        if FASInstrument.get("FAS Instrument Code-Adl") then;

                        if page.RunModal(0, FASInstrument) = Action::LookupOK then begin
                            "FAS Instrument Code-Adl" := FASInstrument.Code;
                            Modify();
                        end;
                    end;
                }
                action("ChangeFinSect-Adl")
                {
                    Caption = 'Finance Sector';
                    Image = ListPage;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        FASSector: Record "FAS Sector-Adl";
                    begin
                        FASSector.Reset();
                        FASSector.SetRange(Type, FASSector.Type::Posting);
                        if FASSector.get("FAS Sector Code-Adl") then;

                        if page.RunModal(0, FASSector) = Action::LookupOK then begin
                            "FAS Sector Code-Adl" := FASSector.Code;
                            Modify();
                        end;
                    end;
                }
                // <adl.26>
                action("ChangeBST-Adl")
                {
                    Caption = 'BST Code';
                    Image = ListPage;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        BSTCode: Record "BST Code-Adl";
                    begin
                        BSTCode.Reset();
                        BSTCode.SetRange(Type, BSTCode.Type::Posting);
                        if BSTcode.get("BST Code-Adl") then;

                        if page.RunModal(0, BSTCode) = Action::LookupOK then begin
                            "BST Code-Adl" := BSTCode.Code;
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
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        FASFeatureEnabled: Boolean;
        KRDFeatureEnabled: Boolean;
        BSTFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        FASFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS);
        KRDFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::KRD);
        BSTFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::BST);
        // </adl.0>
    end;

}