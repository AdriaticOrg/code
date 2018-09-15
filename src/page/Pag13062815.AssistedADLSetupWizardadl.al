page 13062815 "Assisted ADL Setup Wizard-adl"
{
    Caption = 'Company Setup';
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
            group(MediaResourceStandard)
            {
                Editable = false;
                ShowCaption = false;
                Visible = TopBannerVisible AND NOT DoneVisible;
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(MediaResourceDone)
            {
                Editable = false;
                ShowCaption = false;
                Visible = TopBannerVisible AND DoneVisible;
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(StartStep)
            {
                ShowCaption = false;
                Visible = IntroVisible;
                group("Welcome to Adriatic Localization Company Setup.")
                {
                    Caption = 'Welcome to Adriatic Localization Company Company Setup.';
                    InstructionalText = 'To prepare Dynamics 365 Business Central with Adriatic Localization for first use, you must specify which features of this module you will use. We will also guide you through specifiying some basic information about your company. This information is used to enable on your external documents, such as sales invoices, and includes your company logo and bank information';
                }
                group("Let's go!")
                {
                    Caption = 'Let''s go!';
                    InstructionalText = 'Choose Next so you can specify basic Adriatic Localization features.';
                }
            }
            group(Step1)
            {
                ShowCaption = false;
                Visible = SelectTypeVisible AND TypeSelectionEnabled;
                group("Extended Setup")
                {
                    Caption = 'Adriatic Localization Setup';
                    InstructionalText = 'The company will be ready to use when Setup has completed.';
                    Visible = ExtendedVisible;
                    field(Extended; TypeExtended)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Set up as Adriatic Localization';

                        trigger OnValidate()
                        begin
                            if TypeExtended then
                                TypeEvaluation := false;
                            CalcCompanyData();
                        end;
                    }

                    field(RapidFromHttp; RapidFromHttp)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Download RapidStart data from web';
                    }


                }
                /*group("Evaluation Setup")
                {
                    Caption = 'Evaluation Setup';
                    InstructionalText = 'The company will be set up in demonstration mode for exploring and testing.';
                    Visible = EvaluationVisible;
                    field(Evaluation; TypeEvaluation)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Set up as Evaluation';

                        trigger OnValidate()
                        begin
                            if TypeEvaluation then
                                TypeStandard := false;
                            CalcCompanyData();
                        end;
                    }
                }*/
                group(Important)
                {
                    Caption = 'Important';
                    InstructionalText = 'You cannot change your choice of setup after you choose Next.';
                    Visible = TypeExtended or TypeStandard or TypeEvaluation;
                }
            }

            group(step2)
            {
                Caption = 'Adriatic Localization core features';
                InstructionalText = 'With this setup you can choose which features you want to enable for Adriatic Localization';
                Visible = CoreSetupDetailsVisible;

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
                                NextEnabled := true
                            else NextEnabled := false;
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

            group(Step3)
            {
                ShowCaption = false;
                Visible = CompanyDetailsVisible;
                group("Specify your company's address information and logo.")
                {
                    Caption = 'Specify your company''s address information and logo.';
                    InstructionalText = 'This is used in invoices and other documents where general information about your company is printed.';
                    field(Name; Name)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Company Name';
                        NotBlank = true;
                        ShowMandatory = true;
                    }
                    field(Address; Address)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Address 2"; "Address 2")
                    {
                        ApplicationArea = Advanced;
                        Visible = false;
                    }
                    field("Post Code"; "Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field(City; City)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Country/Region Code"; "Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        TableRelation = "Country/Region".Code;
                    }
                    field("VAT Registration No."; "VAT Registration No.")
                    {
                        ApplicationArea = Advanced;
                        Visible = false;
                    }
                    field("Industrial Classification"; "Industrial Classification")
                    {
                        ApplicationArea = Advanced;
                        NotBlank = true;
                        ShowMandatory = true;
                        Visible = false;
                    }
                    field(Picture; Picture)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Company Logo';

                        trigger OnValidate()
                        begin
                            LogoPositionOnDocumentsShown := Picture.hasValue();
                            if LogoPositionOnDocumentsShown then begin
                                if "Logo Position on Documents" = "Logo Position on Documents"::"No Logo" then
                                    "Logo Position on Documents" := "Logo Position on Documents"::Right;
                            end else
                                "Logo Position on Documents" := "Logo Position on Documents"::"No Logo";
                            CurrPage.UPDATE(true);
                        end;
                    }
                    field("Logo Position on Documents"; "Logo Position on Documents")
                    {
                        ApplicationArea = Advanced;
                        Editable = LogoPositionOnDocumentsShown;
                    }
                }
            }
            group(Step4)
            {
                ShowCaption = false;
                Visible = CommunicationDetailsVisible;
                group("Specify the contact details for your company.")
                {
                    Caption = 'Specify the contact details for your company.';
                    InstructionalText = 'This is used in invoices and other documents where general information about your company is printed.';
                    field("Phone No."; "Phone No.")
                    {
                        ApplicationArea = Basic, Suite;

                        trigger OnValidate()
                        var
                            TypeHelper: Codeunit "Type Helper";
                        begin
                            if "Phone No." = '' then
                                exit;

                            if not TypeHelper.IsPhoneNumber("Phone No.") then
                                ERROR(InvalidPhoneNumberErr)
                        end;
                    }
                    field("E-Mail"; "E-Mail")
                    {
                        ApplicationArea = Basic, Suite;
                        ExtendedDatatype = EMail;

                        trigger OnValidate()
                        var
                            MailManagement: Codeunit "Mail Management";
                        begin
                            if "E-Mail" = '' then
                                exit;

                            MailManagement.CheckValidEmailAddress("E-Mail");
                        end;
                    }
                    field("Home Page"; "Home Page")
                    {
                        ApplicationArea = Basic, Suite;

                        trigger OnValidate()
                        var
                            WebRequestHelper: Codeunit "Web Request Helper";
                        begin
                            if "Home Page" = '' then
                                exit;

                            WebRequestHelper.IsValidUriWithoutProtocol("Home Page");
                        end;
                    }
                }
            }

            group("Select bank account.")
            {
                Caption = 'Select bank account.';
                Visible = SelectBankAccountVisible;
                part(OnlineBanckAccountLinkPagePart; "Online Bank Accounts")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Bank)
            {
                ShowCaption = false;
                Visible = PaymentDetailsVisible;
                group("Specify your company's bank information.")
                {
                    Caption = 'Specify your company''s bank information.';
                    InstructionalText = 'This information is included on documents that you send to customer and vendors to inform about payments to your bank account.';
                    field("Bank Name"; "Bank Name")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Bank Branch No."; "Bank Branch No.")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field("Bank Account No."; "Bank Account No.")
                    {
                        ApplicationArea = Basic, Suite;

                        trigger OnValidate()
                        begin
                            ShowBankAccountCreationWarning := not ValidateBankAccountNotEmpty();
                        end;
                    }
                    field("SWIFT Code"; "SWIFT Code")
                    {
                        ApplicationArea = Basic, Suite;
                    }
                    field(IBAN; IBAN)
                    {
                        ApplicationArea = Basic, Suite;
                    }
                }
            }


            group(Finish)
            {
                ShowCaption = false;
                Visible = DoneVisible;
                group("That's it!")
                {
                    Caption = 'That''s it!';
                    InstructionalText = 'Choose Finish to prepare the application for first use. This will take a few moments.';
                    field(HelpLbl; HelpLbl)
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            HYPERLINK(HelpLinkTxt);
                        end;
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
                ApplicationArea = Basic, Suite;
                Caption = 'Back';
                Enabled = BackEnabled;
                Image = PreviousRecord;
                InFooterBar = true;

                trigger OnAction()
                begin
                    NextStep(true);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Next';
                Enabled = NextEnabled;
                Image = NextRecord;
                InFooterBar = true;

                trigger OnAction()
                begin
                    if (Step = Step::"Select Type") and not (TypeExtended or TypeStandard or TypeEvaluation) then
                        if not CONFIRM(NoSetupTypeSelectedQst, false) then
                            ERROR('');
                    NextStep(false);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Finish';
                Enabled = FinishEnabled;
                Image = Approve;
                InFooterBar = true;

                trigger OnAction()
                var
                    AssistedSetupAdl: Record "Assisted Setup-adl";
                    AssistedCompanySetup: Codeunit "Assisted Company Setup";
                    ErrorText: Text;
                begin
                    //AssistedCompanySetup.WaitForPackageImportToComplete();
                    BankAccount.TransferFields(TempBankAccount, true);
                    CopyCoreSetupInfo();
                    AssistedCompanySetup.ApplyUserInput(Rec, BankAccount, 0D, TypeEvaluation);

                    AssistedSetupAdl.SetStatus(PAGE::"Assisted ADL Setup Wizard-adl", AssistedSetupAdl.Status::Completed);
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        LogoPositionOnDocumentsShown := Picture.HasValue();
    end;

    trigger OnInit()
    begin
        InitializeRecord();
        LoadTopBanners();
    end;

    trigger OnOpenPage()
    begin
        ResetWizardControls();
        ShowIntroStep();
        TypeSelectionEnabled := LoadConfigTypes() and not PackageImported();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        AssistedSetupAdl: Record "Assisted Setup-adl";
    begin
        if CloseAction = ACTION::OK then
            IF AssistedSetupAdl.GetStatus(PAGE::"Assisted ADL Setup Wizard-adl") = AssistedSetupAdl.Status::"Not Completed" THEN
                IF NOT Confirm(NotSetUpQst, FALSE) THEN
                    Error('');
    end;

    var
        MediaRepositoryStandard: Record "Media Repository";
        TempSavedBankAccount: Record "Bank Account" temporary;
        TempBankAccount: Record "Bank Account" temporary;
        BankAccount: Record "Bank Account";
        TempOnlineBankAccLink: Record "Online Bank Acc. Link" temporary;
        MediaRepositoryDone: Record "Media Repository";
        MediaResourcesStandard: Record "Media Resources";
        MediaResourcesDone: Record "Media Resources";
        InventorySetup: Record "Inventory Setup";
        ClientTypeManagement: Codeunit ClientTypeManagement;
        RapidStartWizard: Codeunit "Wizard RapidStart-adl";
        CompanyData: Option "Evaluation Data","Standard Data","None","Extended Data","Full No Data";
        TypeStandard: Boolean;
        TypeExtended: Boolean;
        TypeEvaluation: Boolean;
        Step: Option Intro,Sync,"Select Type","Core Setup","Company Details","Communication Details",SelectBankAccont,"Payment Details",Done;
        BackEnabled: Boolean;
        NextEnabled: Boolean;
        FinishEnabled: Boolean;
        TopBannerVisible: Boolean;
        IntroVisible: Boolean;
        SelectTypeVisible: Boolean;
        CompanyDetailsVisible: Boolean;
        CommunicationDetailsVisible: Boolean;
        PaymentDetailsVisible: Boolean;
        CoreSetupDetailsVisible: Boolean;
        DoneVisible: Boolean;
        TypeSelectionEnabled: Boolean;
        ExtendedVisible: Boolean;
        StandardVisible: Boolean;
        EvaluationVisible: Boolean;
        NotSetUpQst: Label 'The application has not been set up. Setup could be run again from role center notification.\\Are you sure that you want to exit?';
        HideBankStatementProvider: Boolean;
        NoSetupTypeSelectedQst: Label 'You have not selected any setup type. If you proceed, the application will not be fully functional, until you set it up manually.\\Do you want to continue?';
        HelpLbl: Label 'Learn more about setting up your company';
        HelpLinkTxt: Label 'http://go.microsoft.com/fwlink/?LinkId=746160', Locked = true;
        BankStatementConfirmationVisible: Boolean;
        UseBankStatementFeed: Boolean;
        RapidFromHttp: Boolean;

        BankAccountInformationUpdated: Boolean;
        CoreSetupUpdated: Boolean;
        SelectBankAccountVisible: Boolean;
        TermsOfUseLbl: Label 'Envestnet Yodlee Terms of Use';
        TermsOfUseUrlTxt: Label '', Locked = true;
        LogoPositionOnDocumentsShown: Boolean;
        ShowBankAccountCreationWarning: Boolean;
        InvalidPhoneNumberErr: Label 'The phone number is invalid.';
        CostMethodeLbl: Label 'Learn more';
        CostMethodUrlTxt: Label 'https://go.microsoft.com/fwlink/?linkid=858295', Locked = true;

    local procedure NextStep(Backwards: Boolean)
    begin
        ResetWizardControls();

        if Backwards then
            Step := Step - 1
        else
            Step := Step + 1;

        case Step of
            Step::Intro:
                ShowIntroStep;
            Step::Sync:
                ShowSyncStep(Backwards);
            Step::"Select Type":
                if not TypeSelectionEnabled then
                    NextStep(Backwards)
                else
                    ShowSelectTypeStep();
            step::"Core Setup":
                if TypeEvaluation then begin
                    Step := Step::Done;
                    ShowDoneStep;
                end else begin
                    ShowCoreSetupDetailsStep();
                    NextEnabled := "ADL Enabled";
                end;

            Step::"Company Details":
                if TypeEvaluation then begin
                    Step := Step::Done;
                    ShowDoneStep;
                end else
                    ShowCompanyDetailsStep;
            Step::"Communication Details":
                ShowCommunicationDetailsStep;
            Step::SelectBankAccont:
                if not ShowSelectBankAccountStep then
                    NextStep(Backwards)
                else
                    ShowSelectBankAccount;
            Step::"Payment Details":
                begin
                    if not Backwards then
                        PopulateBankAccountInformation;
                    ShowPaymentDetailsStep;
                    ShowBankAccountCreationWarning := not ValidateBankAccountNotEmpty;
                end;
            Step::Done:
                ShowDoneStep;
        end;
        CurrPage.UPDATE(true);
    end;

    local procedure ShowIntroStep()
    begin
        IntroVisible := true;
        BackEnabled := false;
    end;

    local procedure ShowSyncStep(Backwards: Boolean)
    begin
        NextStep(Backwards);
    end;

    local procedure ShowSelectTypeStep()
    begin
        SelectTypeVisible := true;
    end;

    local procedure ShowCoreSetupType()
    begin
        CoreSetupDetailsVisible := true;
    end;

    local procedure ShowCompanyDetailsStep()
    begin
        CompanyDetailsVisible := true;
    end;

    local procedure ShowCommunicationDetailsStep()
    begin
        CommunicationDetailsVisible := true;
    end;

    local procedure ShowPaymentDetailsStep()
    begin
        PaymentDetailsVisible := true;
    end;

    local procedure ShowCoreSetupDetailsStep()
    begin
        CoreSetupDetailsVisible := true;
        if TypeSelectionEnabled then begin
            StartConfigPackageImport();
            BackEnabled := false;
        end;
    end;

    local procedure ShowDoneStep()
    begin
        DoneVisible := true;
        NextEnabled := false;
        FinishEnabled := true;
        if TypeEvaluation then begin
            StartConfigPackageImport();
            BackEnabled := false;
        end;
    end;

    local procedure ResetWizardControls()
    begin
        CompanyData := CompanyData::None;

        BackEnabled := true;
        NextEnabled := true;
        FinishEnabled := false;

        IntroVisible := false;
        SelectTypeVisible := false;
        CompanyDetailsVisible := false;
        CommunicationDetailsVisible := false;
        BankStatementConfirmationVisible := false;
        SelectBankAccountVisible := false;
        PaymentDetailsVisible := false;
        DoneVisible := false;
        CoreSetupDetailsVisible := false;

    end;

    local procedure InitializeRecord()
    var
        CompanyInformation: Record "Company Information";
        CoreSetup: Record "CoreSetup-Adl";
    begin
        Init();
        if CompanyInformation.Get() then begin
            TRANSFERFIELDS(CompanyInformation);
            if Name = '' then
                Name := CompanyName();
        end else
            Name := CompanyName();

        If CoreSetup.Get() then
            TransferfieldsFromCoreSetup(CoreSetup);
        Insert();
    end;

    local procedure CalcCompanyData()
    begin
        CompanyData := CompanyData::None;
        If TypeExtended then
            CompanyData := CompanyData::"Extended Data";
        if TypeStandard then
            CompanyData := CompanyData::"Standard Data";
        if TypeEvaluation then
            CompanyData := CompanyData::"Evaluation Data";
    end;

    local procedure TransferfieldsFromCoreSetup(var CoreSetup: Record "CoreSetup-Adl")
    begin
        "ADL Enabled" := CoreSetup."ADL Enabled";
        "BST Enabled" := CoreSetup."BST Enabled";
        "EU Customs" := CoreSetup."EU Customs";
        "FAS Enabled" := CoreSetup."FAS Enabled";
        "KRD Enabled" := CoreSetup."KRD Enabled";
        "Rep HR Enabled" := CoreSetup."Rep HR Enabled";
        "Rep SI Enabled" := CoreSetup."Rep SI Enabled";
        "Rep RS Enabled" := CoreSetup."Rep RS Enabled";
        "Unpaid Receivables Enabled" := CoreSetup."Unpaid Receivables Enabled";
        "VAT Enabled" := CoreSetup."VAT Enabled";
        "VIES Enabled" := CoreSetup."VIES Enabled";
    end;

    local procedure StartConfigPackageImport()
    begin
        if not TypeSelectionEnabled then
            exit;
        //if CompanyData in [CompanyData::"Extended Data"] then begin
        RapidStartWizard.ReadFromHttp(Rec);
        //
        //end else exit;
        //if AssistedCompanySetup.IsCompanySetupInProgress(CompanyName()) then
        //    exit
    end;

    local procedure LoadConfigTypes(): Boolean
    var
        AssistedSetupAdl: Record "Assisted Setup-adl";
    begin
        ExtendedVisible := true;
        exit(ExtendedVisible or StandardVisible or EvaluationVisible);
    end;

    local procedure PackageImported(): Boolean
    var
        AssistedSetupAdl: Record "Assisted Setup-adl";
    begin
        exit(false);
        //exit(AssistedSetupAdl."Package Imported" or AssistedSetupAdl."Import Failed");
    end;

    local procedure LoadTopBanners()
    begin
        if MediaRepositoryStandard.GET('AssistedSetup-NoText-400px.png', FORMAT(ClientTypeManagement.GetCurrentClientType())) and
           MediaRepositoryDone.GET('AssistedSetupDone-NoText-400px.png', FORMAT(ClientTypeManagement.GetCurrentClientType()))
        then
            if MediaResourcesStandard.GET(MediaRepositoryStandard."Media Resources Ref") and
               MediaResourcesDone.GET(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue();
    end;

    local procedure PopulateBankAccountInformation()
    begin
        if BankAccountInformationUpdated then
            if TempOnlineBankAccLink.Count() = 0 then begin
                RestoreBankAccountInformation(TempSavedBankAccount);
                exit;
            end;

        if TempOnlineBankAccLink.Count() = 1 then
            TempOnlineBankAccLink.FindFirst()
        else
            CurrPage.OnlineBanckAccountLinkPagePart.PAGE.GETRECORD(TempOnlineBankAccLink);

        if (TempBankAccount."Bank Account No." = TempOnlineBankAccLink."Bank Account No.") and
           (TempBankAccount.Name = TempOnlineBankAccLink.Name)
        then
            exit;

        if not IsBankAccountFormatValid(TempOnlineBankAccLink."Bank Account No.") then
            Clear(TempOnlineBankAccLink."Bank Account No.");

        if not BankAccountInformationUpdated then
            StoreBankAccountInformation(TempSavedBankAccount);

        TempBankAccount.Init();
        TempBankAccount.CreateNewAccount(TempOnlineBankAccLink);
        RestoreBankAccountInformation(TempBankAccount);
        BankAccountInformationUpdated := true;
    end;

    local procedure StoreBankAccountInformation(var BufferBankAccount: Record "Bank Account")
    begin
        if not BufferBankAccount.IsEmpty() then
            exit;
        BufferBankAccount.Init();
        BufferBankAccount."Bank Account No." := "Bank Account No.";
        BufferBankAccount.Name := "Bank Name";
        BufferBankAccount."Bank Branch No." := "Bank Branch No.";
        BufferBankAccount."SWIFT Code" := "SWIFT Code";
        BufferBankAccount.IBAN := IBAN;
        BufferBankAccount.Insert();
    end;

    local procedure RestoreBankAccountInformation(var BufferBankAccount: Record "Bank Account")
    begin
        if BufferBankAccount.IsEmpty() then
            exit;
        "Bank Account No." := BufferBankAccount."Bank Account No.";
        "Bank Name" := BufferBankAccount.Name;
        "Bank Branch No." := BufferBankAccount."Bank Branch No.";
        "SWIFT Code" := BufferBankAccount."SWIFT Code";
        IBAN := BufferBankAccount.IBAN;
    end;

    local procedure ShowSelectBankAccountStep(): Boolean
    begin
        exit(TempOnlineBankAccLink.Count() > 1);
    end;

    local procedure ShowSelectBankAccount()
    begin
        SelectBankAccountVisible := true;
    end;

    local procedure IsBankAccountFormatValid(BankAccount: Text): Boolean
    var
        VarInt: Integer;
        Which: Text;
    begin
        Which := ' -';
        exit(EVALUATE(VarInt, DELCHR(BankAccount, '=', Which)));
    end;

    local procedure ValidateBankAccountNotEmpty(): Boolean
    begin
        exit(("Bank Account No." <> '') or TempOnlineBankAccLink.IsEmpty());
    end;

}