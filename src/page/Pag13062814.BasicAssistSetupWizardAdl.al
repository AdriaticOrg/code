page 13062814 "Basic Assist. Setup Wizard-Adl"
{
    Caption = 'Adl Basic Setup Wizard';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = NavigatePage;
    PromotedActionCategories = 'New,Process,Report,Step 4,Step 5';
    ShowFilter = false;
    SourceTable = "Config. Setup";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                ShowCaption = false;
                Editable = false;
                Visible = TopBannerVisible AND NOT FinishActionEnabled;
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(FinishedBanner)
            {
                ShowCaption = false;
                Editable = false;
                Visible = TopBannerVisible AND FinishActionEnabled;
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }

            group(Step1)
            {
                Visible = Step1Visible;
                group("Welcome to Adriatic Localization Company Setup.")
                {
                    Caption = 'Welcome to Adriatic Localization basic feature setup.';
                    InstructionalText = 'To prepare Dynamics 365 Business Central with Adriatic Localization for first use, you need to choose features you will use.';
                    Visible = Step1Visible;
                    group("Para1.1")
                    {
                        ShowCaption = false;
                        group("Para1.2.1")
                        {
                            ShowCaption = false;
                            InstructionalText = 'Help';

                            field(HelpLblPrivacy; HelpLbl)
                            {
                                ApplicationArea = All;
                                ShowCaption = false;
                                ToolTip = 'Link to help';

                                trigger OnDrillDown()
                                begin
                                    Hyperlink(HelpLinkTxt);
                                end;
                            }
                            group("Para1.2.2")
                            {
                                ShowCaption = false;
                                InstructionalText = 'Privacy Notice for more information.';

                                field(PrivacyNotice; PrivacyNoticeTxt)
                                {
                                    ApplicationArea = all;
                                    ShowCaption = false;
                                    ToolTip = 'Link to privacy statement';

                                    trigger OnDrillDown()
                                    begin
                                        Hyperlink(PrivacyNoticeUrlTxt);
                                    end;
                                }
                                field(AgreePrivacy; AgreePrivacy)
                                {
                                    ApplicationArea = All;
                                    Caption = 'I accept warning & privacy notice.';
                                    ShowCaption = true;
                                    ToolTip = 'Select to accept warning & privacy notice';

                                    trigger OnValidate()
                                    begin
                                        if AgreePrivacy then
                                            NextActionEnabled := true
                                        else NextActionEnabled := false;
                                    end;
                                }
                            }
                        }
                    }
                }
                group("Let's go!")
                {
                    Caption = 'Let''s go!';
                    group(Group22)
                    {
                        Caption = '';
                        InstructionalText = 'Choose Next so you can specify basic Adriatic Localization features.';
                    }
                }
            }

            group(Step2)
            {
                //Extended setup
                Caption = 'Adriatic Localization core features';
                InstructionalText = 'With this setup you can choose which features you want to enable for Adriatic Localization';
                Visible = Step2Visible;

                group(CoreSetup)
                {
                    Caption = 'Core Setup';
                    Visible = Step2Visible;
                    field("ADL Enabled-Adl"; "ADL Enabled-Adl")
                    {
                        Caption = 'Adriatic Localization Enabled';
                        ApplicationArea = All;
                        ToolTip = 'Specifies if ADL is enabled';

                        trigger OnValidate()
                        begin
                            if "ADL Enabled-Adl" then
                                NextActionEnabled := true
                            else NextActionEnabled := false;
                        end;
                    }
                }

                group(VAT)
                {
                    Caption = 'VAT';
                    field("VAT Enabled"; "VAT Enabled-Adl")
                    {
                        //Visible = "ADL Enabled-Adl";
                        ApplicationArea = All;
                        ToolTip = 'Specifies use of VAT extension';
                    }
                    field("Use VAT Output Date"; "Use VAT Output Date")
                    {
                        //Visible = "ADL Enabled-Adl";
                        ApplicationArea = All;
                        ToolTip = 'Specifies use of VAT output date';
                    }
                }
                group(ForceDebitCredit)
                {
                    Caption = 'General Ledger';
                    field("Forced Credit/Debit Enabled-Adl"; "Forced Credit/Debit Enabled-Adl")
                    {
                        Visible = "ADL Enabled-Adl";
                        ApplicationArea = All;
                        ToolTip = 'Specifies use of force debit/credit';
                    }
                }

            }

            group(Step3)
            {
                Visible = Step3Visible;
                group(Group23)
                {
                    Caption = '';
                    InstructionalText = 'You have succesfully completed basic Adriatic Localization setup.';
                }
                group("That's it!")
                {
                    Caption = 'That''s it!';
                    group(Group25)
                    {
                        Caption = '';
                        InstructionalText = 'To save this setup, choose Finish.';
                    }
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("ActionBack")
            {
                ApplicationArea = All;
                Caption = 'Back';
                Enabled = BackActionEnabled;
                Image = PreviousRecord;
                InFooterBar = true;
                trigger OnAction();
                begin
                    NextStep(true);
                end;
            }
            action("ActionNext")
            {
                ApplicationArea = All;
                Caption = 'Next';
                Enabled = NextActionEnabled;
                Image = NextRecord;
                InFooterBar = true;
                trigger OnAction();
                begin
                    NextStep(false);
                end;
            }
            action("ActionFinish")
            {
                ApplicationArea = All;
                Caption = 'Finish';
                Enabled = FinishActionEnabled;
                Image = Approve;
                InFooterBar = true;
                trigger OnAction();
                begin
                    FinishAction();
                end;
            }
        }
    }
    trigger Oninit();
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage();
    begin
        InitializeRecord();
        Step := Step::Start;
        EnableControls();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        AssistedSetupAdl: Record "Assisted Setup-adl";
    begin
        if CloseAction = ACTION::OK then
            IF AssistedSetupAdl.GetStatus(PAGE::"Basic Assist. Setup Wizard-Adl") = AssistedSetupAdl.Status::"Not Completed" THEN
                IF NOT Confirm(NotSetUpQst, FALSE) THEN
                    Error('');
    end;

    var
        MediaRepositoryStandard: Record "Media Repository";
        MediaRepositoryDone: Record "Media Repository";
        MediaResourcesStandard: Record "Media Resources";
        MediaResourcesDone: Record "Media Resources";
        Step: Option Start,Step2,Finish;
        TopBannerVisible: Boolean;
        Step1Visible: Boolean;
        Step2Visible: Boolean;
        Step3Visible: Boolean;
        FinishActionEnabled: Boolean;
        BackActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        AgreePrivacy: Boolean;
        HelpLbl: Label 'Learn more about setting up your company';
        HelpLinkTxt: Label 'https://adriaticorg.github.io/help', Locked = true;
        PrivacyNoticeTxt: Label 'Privacy Notice';

        NotSetUpQst: Label 'The application has not been set up. Setup could be run again from role center notification.\\Are you sure that you want to exit?';
        PrivacyNoticeUrlTxt: Label 'https://privacy.microsoft.com/en-us/privacystatement#mainnoticetoendusersmodule', Locked = true;

    local procedure EnableControls();
    begin
        ResetControls();

        CASE Step OF
            Step::Start:
                begin
                    ShowStep1();
                    If AgreePrivacy then
                        NextActionEnabled := true;
                end;
            Step::Step2:
                begin
                    ShowStep2();
                    NextActionEnabled := "ADL Enabled-Adl";
                end;
            Step::Finish:
                ShowStep3();
        END;
    end;

    local procedure InitializeRecord()
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        init();
        If CoreSetup.Get() then
            TransferfieldsFromDataSetup(CoreSetup);
        insert();
    end;

    local procedure TransferfieldsFromDataSetup(var CoreSetup: Record "CoreSetup-Adl")
    var
        ExtendedSetup: Record "Extended Setup-Adl";
    begin
        if CoreSetup."ADL Enabled" then begin
            "ADL Enabled-Adl" := CoreSetup."ADL Enabled";
            if ExtendedSetup.Get() then begin
                "VAT Enabled-Adl" := ExtendedSetup."VAT Enabled";
                "Use VAT Output Date" := ExtendedSetup."Use VAT Output Date";
                "Forced Credit/Debit Enabled-Adl" := ExtendedSetup."Forced Credit/Debit Enabled";
            end;
        end;
    end;

    local procedure FinishAction();
    var
        AssistedSetupAdl: Record "Assisted Setup-adl";
    begin
        StoreSetupData();
        AssistedSetupAdl.SetStatus(PAGE::"Basic Assist. Setup Wizard-Adl", AssistedSetupAdl.Status::Completed);
        CurrPage.Close();
    end;

    local procedure NextStep(Backwards: Boolean);
    begin
        if Backwards then
            Step := Step - 1
        ELSE
            Step := Step + 1;

        EnableControls();
    end;

    local procedure ShowStep1();
    begin
        Step1Visible := true;
        if AgreePrivacy then
            NextActionEnabled := true;
        FinishActionEnabled := false;
        BackActionEnabled := false;
    end;

    local procedure ShowStep2();
    begin
        Step2Visible := true;
    end;

    local procedure ShowStep3();
    begin
        Step3Visible := true;

        NextActionEnabled := false;
        FinishActionEnabled := true;
    end;

    local procedure ResetControls();
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;

        Step1Visible := false;
        Step2Visible := false;
        Step3Visible := false;
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.GET('AssistedSetup-NoText-400px.png', FORMAT(CurrentClientType())) AND
           MediaRepositoryDone.GET('AssistedSetupDone-NoText-400px.png', FORMAT(CurrentClientType()))
        then
            if MediaResourcesStandard.GET(MediaRepositoryStandard."Media Resources Ref") AND
               MediaResourcesDone.GET(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HASVALUE();
    end;

    procedure StoreSetupData()
    var
        ExtendedSetup: Record "Extended Setup-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        CoreEnabled: Boolean;
    begin
        If ("VAT Enabled-Adl" or
            "Use VAT Output Date" or
            "Forced Credit/Debit Enabled-Adl")
        then begin
            if not ExtendedSetup.get() then
                CoreEnabled := ExtendedSetup.Insert(true);
            ExtendedSetup."VAT Enabled" := "VAT Enabled-Adl";
            ExtendedSetup."Use VAT Output Date" := "Use VAT Output Date";
            ExtendedSetup."Forced Credit/Debit Enabled" := "Forced Credit/Debit Enabled-Adl";
            ExtendedSetup.Modify(true);
        end;
        CoreSetup.EnableOrDisableFeature("ADLFeatures-Adl"::Core, "ADL Enabled-Adl");
        CoreSetup.EnableOrDisableFeature("ADLFeatures-Adl"::ForcedCreditDebit, "Forced Credit/Debit Enabled-Adl");
        CoreSetup.EnableOrDisableFeature("ADLFeatures-Adl"::VAT, "VAT Enabled-Adl");
    end;
}