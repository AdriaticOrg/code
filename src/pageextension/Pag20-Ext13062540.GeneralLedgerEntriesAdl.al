pageextension 13062540 "General Ledger Entries-Adl" extends "General Ledger Entries"  //20
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("FAS Type-Adl"; "FAS Type-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies FAS Type';
            }
            field("FAS Instrument Code-Adl"; "FAS Instrument Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies Instrument Code';
            }
            field("FAS Sector Code-Adl"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies FAS Sector Code';
            }
            // </adl.24>
            // <adl.26>
            field("Country/Region Code-Adl"; "Country/Region Code-Adl")
            {
                ApplicationArea = All;
                Visible = BSTFeatureEnabled;
                ToolTip = 'Specifies Country/Region Code';
            }
            field("BST Code-Adl"; "BST Code-Adl")
            {
                ApplicationArea = All;
                Visible = BSTFeatureEnabled;
                ToolTip = 'Specifies BST Code';
            }
            // </adl.26>
            // <adl.20>
            field("Full Fisc. Doc. No.-Adl"; "Full Fisc. Doc. No.-Adl")
            {
                Visible = FISCFeatureEnabled;
                ApplicationArea = All;
            }
            // </adl.20>
        }
    }

    // <adl.24>
    actions
    {
        addlast("F&unctions")
        {

            group("ChangeData-Adl")
            {
                Caption = 'Change Data';
                Image = ChangeStatus;
                Visible = FASFeatureEnabled;
                action("ChangeFinInstr-Adl")
                {
                    Caption = 'Finance Instrument';
                    Image = ListPage;
                    ApplicationArea = All;
                    ToolTip = 'Changes FAS Instrument Code-Adl';

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
                    ToolTip = 'Changes FAS Sector Code-Adl';

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
                    ToolTip = 'Changes BST Code-Adl';

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
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        FASFeatureEnabled: Boolean;
        KRDFeatureEnabled: Boolean;
        BSTFeatureEnabled: Boolean;
        FISCFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT);
        FASFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FAS);
        KRDFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::KRD);
        BSTFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::BST);
        FISCFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC);
        // </adl.0>
    end;

}
