page 13062814 "ADL Setup Wizard-adl NEW"
{
    Caption = 'ADL Setup Wizard';
    Pagetype = NavigatePage;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    SourceTable = "Config. Setup";
    SourceTableTemporary = true;
    Permissions = tabledata 8621 = rimd;

    layout
    {
        area(content)
        {
            group(StandardBanner)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and not FinishActionEnabled;
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(FinishedBanner)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible and FinishActionEnabled;
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
                group("Welcome to ADL Setup Wizard")
                {
                    Caption = 'Welcome to Adriatic Localization Setup';
                    Visible = Step1Visible;
                    group(Group18)
                    {
                        Caption = '';
                        InstructionalText = 'This assisted setup will guide you through enabeling diffrent modules of Adriatic Localization and RapidStart configuration.';
                    }
                }
                group("Let's go!")
                {
                    Caption = 'Let''s go!';
                    group(Group22)
                    {
                        Caption = '';
                        InstructionalText = 'Choose Next so you can enable core modules of Adriatic Localizatin.';
                    }
                }

                group("Para1.2")
                {
                    Caption = 'Warning';
                    group("Para1.2.1")
                    {
                        ShowCaption = false;
                        InstructionalText = 'Help';

                        field(HelpTxt; HelpTxt)
                        {
                            ApplicationArea = Basic, Suite;
                            ShowCaption = false;

                            trigger OnDrillDown()
                            begin
                                Hyperlink(HelpUrlTxt);
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

                                trigger OnDrillDown()
                                begin
                                    Hyperlink(PrivacyNoticeUrlTxt);
                                end;
                            }
                            field(AgreePrivacy; AgreePrivacy)
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'I accept warning & privacy notice.';
                                ShowCaption = true;

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


            group(step2)
            {

            }
            group(Step7)
            {
                Caption = '';
                InstructionalText = 'Core features';
                Visible = Step7Visible;

                group(General)
                {
                    Caption = 'General';
                    field("ADL Enabled"; "ADL Enabled")
                    {
                        Caption = 'Adriatic Localization Enabled';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if "ADL Enabled" then
                                NextActionEnabled := true
                            else NextActionEnabled := false;
                        end;
                    }
                }
                group(VAT)
                {
                    Caption = 'VAT';
                    field("VAT Enabled"; "VAT Enabled")
                    {
                        ApplicationArea = All;
                    }
                    field("Unpaid Receivables Enabled"; "Unpaid Receivables Enabled")
                    {
                        ApplicationArea = All;
                    }

                }
                group(Reporting)
                {
                    Caption = 'Reporting';
                    field("Rep HR Enabled"; "Rep HR Enabled")
                    {
                        Caption = 'Reporting HR Enabled';
                        ApplicationArea = All;
                    }
                    field("Rep RS Enabled"; "Rep RS Enabled")
                    {
                        Caption = 'Reporting RS Enabled';
                        ApplicationArea = All;
                    }
                    field("Rep SI Enabled"; "Rep SI Enabled")
                    {
                        Caption = 'Reporting SI Enabled';
                        ApplicationArea = All;
                    }
                    field("EU Customs"; "EU Customs")
                    {
                        ApplicationArea = All;
                    }
                }
                group(ReportingSI)
                {
                    Caption = 'Reporting SI';
                    field("FAS Enabled"; "FAS Enabled")
                    {
                        ApplicationArea = All;
                    }
                    field("KRD Enabled"; "KRD Enabled")
                    {
                        ApplicationArea = All;
                    }
                    field("BST Enabled"; "BST Enabled")
                    {
                        ApplicationArea = All;
                    }
                }
            }

            group(Step10)
            {
                Visible = Step10Visible;
                group(Group23)
                {
                    Caption = '';
                    InstructionalText = 'Finish your setup';
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
            action(ActionBack)
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
            action(ActionNext)
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
            action(ActionFinish)
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
    trigger OnInit();
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage();
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        Init();
        if CoreSetup.Get() then
            TransferFields(CoreSetup);
        Insert();

        Step := Step::Start;
        EnableControls();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        IF CloseAction = ACTION::OK THEN
            IF ADLAssistedSetup.GetStatus(PAGE::"ADL Setup Wizard-adl") = ADLAssistedSetup.Status::"Not Completed" THEN
                IF NOT Confirm(ADLNotSetUpQst, FALSE) THEN
                    Error('');
    end;

    var
        MediaRepositoryStandard: Record "Media Repository";
        MediaRepositoryDone: Record "Media Repository";
        MediaResourcesStandard: Record "Media Resources";
        MediaResourcesDone: Record "Media Resources";
        ADLAssistedSetup: Record "ADL Assisted Setup-adl";
        ADLInitialize: Codeunit "Wizard Initialize-adl";
        Step: Option Start,Step1,Step2,Step3,Step4,Step5,Step6,Step7,Step8,Step9,Finish;
        TopBannerVisible: Boolean;
        Step1Visible: Boolean;
        Step7Visible: Boolean;
        Step10Visible: Boolean;
        FinishActionEnabled: Boolean;
        BackActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        ADLNotSetUpQst: Label 'ADL has not been set up.\\Are you sure you want to exit?';
        HelpTxt: Label 'Help';
        HelpUrlTxt: Label 'https://docs.microsoft.com/{0}/dynamics365/business-central/', Locked = true;
        PrivacyNoticeTxt: Label 'Privacy Notice';
        AgreePrivacy: Boolean;
        PrivacyNoticeUrlTxt: Label 'https://privacy.microsoft.com/en-us/privacystatement#mainnoticetoendusersmodule', Locked = true;

    local procedure EnableControls();
    begin
        ResetControls();

        CASE Step OF
            Step::Start:
                ShowStep1;
            Step::Step2:
                ShowStep2;
            Step::step3:
                ShowStep3;
            Step::step4:
                ShowStep4;
            Step::step5:
                ShowStep5;
            Step::step6:
                ShowStep6;
            Step::Step7:
                ShowStep7;
            Step::Step8:
                ShowStep8;
            Step::Step9:
                ShowStep9;
            Step::Finish:
                ShowStep10;
        END;
    end;

    local procedure StoreCoreSetup();
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        if not CoreSetup.Get() then begin
            CoreSetup.Init();
            CoreSetup.Insert();
        END;

        CoreSetup."ADL Enabled" := "ADL Enabled";
        CoreSetup."BST Enabled" := "BST Enabled";
        CoreSetup."EU Customs" := "EU Customs";
        CoreSetup."FAS Enabled" := "FAS Enabled";
        CoreSetup."KRD Enabled" := "KRD Enabled";
        CoreSetup."Rep HR Enabled" := "Rep HR Enabled";
        CoreSetup."Rep SI Enabled" := "Rep SI Enabled";
        CoreSetup."Rep RS Enabled" := "Rep RS Enabled";
        CoreSetup."Unpaid Receivables Enabled" := "Unpaid Receivables Enabled";
        CoreSetup."VAT Enabled" := "VAT Enabled";
        CoreSetup."VIES Enabled" := "VIES Enabled";
        CoreSetup.Modify(true);
        Commit();
    end;


    local procedure FinishAction();
    begin
        StoreCoreSetup();
        ADLAssistedSetup.SetStatus(PAGE::"ADL Setup Wizard-adl", ADLAssistedSetup.Status::Completed);
        CurrPage.Close();
    end;

    local procedure NextStep(Backwards: Boolean);
    begin
        if Backwards then
            Step := Step - 1
        else
            Step := Step + 1;

        EnableControls();
    end;

    local procedure ShowStep1();
    begin
        Step1Visible := true;

        FinishActionEnabled := false;
        BackActionEnabled := false;
        if AgreePrivacy then
            NextActionEnabled := true
        else NextActionEnabled := false;
    end;

    local procedure ShowStep2();
    begin

    end;

    local procedure ShowStep3();
    begin

    end;

    local procedure ShowStep4();
    begin

    end;

    local procedure ShowStep5();
    begin

    end;

    local procedure ShowStep6();
    begin

    end;

    local procedure ShowStep7();
    begin
        Step7Visible := true;
        NextActionEnabled := "ADL Enabled";
    end;

    local procedure ShowStep8();
    begin

    end;

    local procedure ShowStep9();
    begin

    end;

    local procedure ShowStep10();
    begin
        Step10Visible := true;

        NextActionEnabled := false;
        FinishActionEnabled := true;
    end;

    local procedure ResetControls();
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;

        Step1Visible := false;
        Step7Visible := false;
        Step10Visible := false;
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-notext-400px.png', Format(CurrentClientType())) and
           MediaRepositoryDone.Get('AssistedSetupDone-notext-400px.png', Format(CurrentClientType()))
        then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
               MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue();
    end;
}