page 13062812 "Assisted ADL Setup Wizard-Adl"
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    InstructionalText = 'To prepare Dynamics 365 Business Central with Adriatic Localization for first use, you need to choose features you will use. We will also guide you through specifiying some basic information about your company.';
                }
                group("Para1.2")
                {
                    Caption = 'Warning';
                    group("Para1.2.1")
                    {
                        ShowCaption = false;
                        InstructionalText = 'Help';

                        field(HelpLblPrivacy; HelpLbl)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;

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

                                trigger OnValidate()
                                begin
                                    if AgreePrivacy then
                                        NextEnabled := true
                                    else NextEnabled := false;
                                end;
                            }
                        }
                    }
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
                    Visible = true;
                    field(Extended; TypeExtended)
                    {
                        ApplicationArea = All;
                        Caption = 'Set up as Adriatic Localization';

                        trigger OnValidate()
                        begin
                            if TypeExtended then
                                TypeEvaluation := false;
                            CalcCompanyData();
                        end;
                    }
                }

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
                    field("ADL Enabled"; "ADL Enabled-Adl")
                    {
                        Caption = 'Adriatic Localization Enabled';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if "ADL Enabled-Adl" then
                                NextEnabled := true
                            else NextEnabled := false;
                        end;
                    }
                }
                group(VAT)
                {
                    Caption = 'VAT';
                    field("VAT Enabled"; "VAT Enabled-Adl")
                    {
                        ApplicationArea = All;
                    }
                    field("Unpaid Receivables Enabled"; "Unpaid Receivables Enabled-Adl")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        var
                            ApplicatonAreaMgmtAdl: Codeunit "Application Area Mgmt-Adl";
                        begin
                            if (ApplicatonAreaMgmtAdl.IsKRDApplicationAreaEnabled()) then
                                exit;
                            ApplicatonAreaMgmtAdl.EnableUnpaidReceivableApplicationArea();
                        end;
                    }

                }
                group(ReportingSI)
                {
                    Caption = 'Reporting SI';
                    field("FAS Enabled"; "FAS Enabled-Adl")
                    {
                        ApplicationArea = All;
                    }
                    field("KRD Enabled"; "KRD Enabled-Adl")
                    {
                        ApplicationArea = All;
                    }
                    field("BST Enabled"; "BST Enabled-Adl")
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
                        ApplicationArea = All;
                        Caption = 'Company Name';
                        NotBlank = true;
                        ShowMandatory = true;
                    }
                    field(Address; Address)
                    {
                        ApplicationArea = All;
                    }
                    field("Address 2"; "Address 2")
                    {
                        ApplicationArea = Advanced;
                        Visible = false;
                    }
                    field("Post Code"; "Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field(City; City)
                    {
                        ApplicationArea = All;
                    }
                    field("Country/Region Code"; "Country/Region Code")
                    {
                        ApplicationArea = All;
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
                        ApplicationArea = All;
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
                        ApplicationArea = All;

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
                        ApplicationArea = All;
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
                        ApplicationArea = All;

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
                    ApplicationArea = All;
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
                        ApplicationArea = All;
                    }
                    field("Bank Branch No."; "Bank Branch No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Bank Account No."; "Bank Account No.")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            ShowBankAccountCreationWarning := not ValidateBankAccountNotEmpty();
                        end;
                    }
                    field("SWIFT Code"; "SWIFT Code")
                    {
                        ApplicationArea = All;
                    }
                    field(IBAN; IBAN)
                    {
                        ApplicationArea = All;
                    }
                }
            }

            group("Select package.")
            {
                ShowCaption = false;
                Visible = PackageImportDetailesVIsible and TypeSelectionEnabled;

                group(Control2)
                {
                    Caption = 'Rapidstart data import';
                    InstructionalText = 'Here you can choose package data to import';

                    field(PackageDownloadBasicLbl; PackageDownloadBasicLbl)
                    {
                        ApplicationArea = All;
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            StartConfigPackageImport(0); //Basic setup
                        end;
                    }
                    field(PackageDownloadMasterLbl; PackageDownloadMasterLbl)
                    {
                        ApplicationArea = All;
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            StartConfigPackageImport(1); //Master data
                        end;
                    }

                    field(PackageFileNameRtc; PackageFileName)
                    {
                        ApplicationArea = All;
                        Caption = 'Select the configuration package you want to load:';
                        Editable = false;
                        ToolTip = 'Specifies the name of the configuration package that you have created.';

                        trigger OnDrillDown()
                        begin
                            if ConfigVisible then
                                Error(PackageIsAlreadyAppliedErr);
                            ApplyVisible := WizardMgmt.OpenRapidStartPackageStream(Rec);
                            PackageFileName := "Package File Name";
                        end;

                        trigger OnValidate()
                        begin
                            if "Package File Name" = '' then
                                ApplyVisible := false;

                            CurrPage.Update();
                        end;
                    }
                    field("Package Code"; "Package Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the code of the configuration package.';
                    }
                    field("Package Name"; "Package Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        ToolTip = 'Specifies the name of the package that contains the configuration information.';
                    }
                    field("Choose Apply Package action to load the data from the configuration to Business Central tables."; '')
                    {
                        ApplicationArea = All;
                        Caption = 'Choose Apply Package action to load the data from the configuration to Business Central tables.';
                        ToolTip = 'Specifies the action that loads the configuration data.';
                    }
                    field("Choose Configuration Worksheet if you want to edit and modify applied data."; '')
                    {
                        ApplicationArea = All;
                        Caption = 'Choose Configuration Worksheet if you want to edit and modify applied data.';
                        ToolTip = 'Specifies the action that loads the configuration data.';
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
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Apply Package")
            {
                ApplicationArea = All;
                Caption = 'Apply Package';
                Enabled = ApplyVisible;
                Visible = ApplyVisible;
                Image = Apply;
                InFooterBar = true;
                ToolTip = 'Import the configuration package and apply the package database data at the same time.';

                trigger OnAction()
                begin
                    if WizardMgmt.CompleteWizard(Rec, TempBlob) then
                        ConfigVisible := true
                    else
                        Error(SelectPackageAndApplyTxt);
                end;
            }
            action("Configuration Worksheet")
            {
                ApplicationArea = All;
                Caption = 'Configuration Worksheet';
                Enabled = ConfigVisible;
                Visible = ConfigVisible;
                InFooterBar = true;
                Image = SetupLines;
                RunObject = Page "Config. Worksheet";
                ToolTip = 'Plan and configure how to initialize a new solution based on legacy data and the customers requirements.';
            }
            action(ActionBack)
            {
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = 'Finish';
                Enabled = FinishEnabled;
                Image = Approve;
                InFooterBar = true;

                trigger OnAction()
                var
                    AssistedSetupAdl: Record "Assisted Setup-adl";
                    AssistedCompanySetup: Codeunit "Assisted Company Setup";
                begin
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
        TypeSelectionEnabled := PackageImported();
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
        TempBlob: Record TempBlob temporary;
        MediaRepositoryStandard: Record "Media Repository";
        TempSavedBankAccount: Record "Bank Account" temporary;
        TempBankAccount: Record "Bank Account" temporary;
        BankAccount: Record "Bank Account";
        TempOnlineBankAccLink: Record "Online Bank Acc. Link" temporary;
        MediaRepositoryDone: Record "Media Repository";
        MediaResourcesStandard: Record "Media Resources";
        MediaResourcesDone: Record "Media Resources";
        InventorySetup: Record "Inventory Setup";
        TempBlobUncompressed: Record TempBlob;
        ClientTypeManagement: Codeunit ClientTypeManagement;
        WizardMgmt: Codeunit "Wizard Management-adl";
        XMLDOMManagement: Codeunit "XML DOM Management";
        CompanyData: Option "Evaluation Data","Standard Data","None","Extended Data","Full No Data";
        TypeStandard: Boolean;
        TypeExtended: Boolean;
        TypeEvaluation: Boolean;
        Step: Option Intro,Sync,"Select Type","Core Setup","Company Details","Communication Details",SelectBankAccont,"Payment Details","Package Import",Done;
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
        PackageImportDetailesVIsible: Boolean;
        DoneVisible: Boolean;
        TypeSelectionEnabled: Boolean;
        ExtendedVisible: Boolean;
        NotSetUpQst: Label 'The application has not been set up. Setup could be run again from role center notification.\\Are you sure that you want to exit?';
        NoSetupTypeSelectedQst: Label 'You have not selected any setup type. If you proceed, the application will not be fully functional, until you set it up manually.\\Do you want to continue?';
        HelpLbl: Label 'Learn more about setting up your company';
        HelpLinkTxt: Label 'http://go.microsoft.com/fwlink/?LinkId=746160', Locked = true;
        BankStatementConfirmationVisible: Boolean;
        BankAccountInformationUpdated: Boolean;
        SelectBankAccountVisible: Boolean;
        LogoPositionOnDocumentsShown: Boolean;
        ShowBankAccountCreationWarning: Boolean;
        InvalidPhoneNumberErr: Label 'The phone number is invalid.';
        CostMethodeLbl: Label 'Learn more';
        CostMethodUrlTxt: Label 'https://go.microsoft.com/fwlink/?linkid=858295', Locked = true;
        PrivacyNoticeTxt: Label 'Privacy Notice';
        AgreePrivacy: Boolean;
        PrivacyNoticeUrlTxt: Label 'https://privacy.microsoft.com/en-us/privacystatement#mainnoticetoendusersmodule', Locked = true;
        ApplyVisible: Boolean;
        ConfigVisible: Boolean;
        PackageIsAlreadyAppliedErr: Label 'A package has already been selected and applied.';
        SelectPackageAndApplyTxt: Label 'Select a package to run the Apply Package function.';
        PackageFileName: Text;
        PackageDownloadBasicLbl: Label 'Click here to download BASIC DATA package';
        PackageDownloadMasterLbl: Label 'Click here to download MASTER DATA package';

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
                    NextEnabled := "ADL Enabled-Adl";
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
                if not ShowSelectBankAccountStep() then
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
            Step::"Package Import":
                if not TypeSelectionEnabled then
                    NextStep(Backwards)
                else
                    ShowPackageImportStep;
            Step::Done:
                ShowDoneStep;
        end;
        CurrPage.UPDATE(true);
    end;

    local procedure ShowIntroStep()
    begin
        IntroVisible := true;
        BackEnabled := false;
        if AgreePrivacy then
            NextEnabled := true
        else NextEnabled := false;
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
        if TypeSelectionEnabled then
            BackEnabled := false;
    end;

    local procedure ShowPackageImportStep()
    begin
        PackageImportDetailesVIsible := true;
    end;

    local procedure ShowDoneStep()
    begin
        DoneVisible := true;
        NextEnabled := false;
        FinishEnabled := true;
        if TypeEvaluation then
            BackEnabled := false;
    end;

    local procedure ResetWizardControls()
    begin
        CompanyData := CompanyData::None;

        BackEnabled := true;
        NextEnabled := true;
        FinishEnabled := false;
        ApplyVisible := false;
        ConfigVisible := false;

        IntroVisible := false;
        SelectTypeVisible := false;
        CompanyDetailsVisible := false;
        CommunicationDetailsVisible := false;
        BankStatementConfirmationVisible := false;
        SelectBankAccountVisible := false;
        PaymentDetailsVisible := false;
        DoneVisible := false;
        CoreSetupDetailsVisible := false;
        PackageImportDetailesVIsible := false
    end;

    local procedure InitializeRecord()
    var
        CompanyInformation: Record "Company Information";
        CoreSetup: Record "CoreSetup-Adl";
        TrimmedCompanyName: Text[50];
    begin
        Init();

        //TODO: find a way to avoid hardcoding string lengths
        TrimmedCompanyName := CopyStr(CompanyName(), 1, MaxStrLen(TrimmedCompanyName));

        if CompanyInformation.Get() then begin
            TRANSFERFIELDS(CompanyInformation);
            if Name = '' then
                Name := TrimmedCompanyName;
        end else
            Name := TrimmedCompanyName;

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
        "ADL Enabled-Adl" := CoreSetup."ADL Enabled";
        "BST Enabled-Adl" := CoreSetup."BST Enabled";
        "FAS Enabled-Adl" := CoreSetup."FAS Enabled";
        "KRD Enabled-Adl" := CoreSetup."KRD Enabled";
        "Unpaid Receivables Enabled-Adl" := CoreSetup."Unpaid Receivables Enabled";
        "VAT Enabled-Adl" := CoreSetup."VAT Enabled";
        "VIES Enabled-Adl" := CoreSetup."VIES Enabled";
    end;

    local procedure StartConfigPackageImport(PackageType: Option "Basic","Master")
    begin
        if not TypeSelectionEnabled then
            exit;
        CalcCompanyData();
        if CompanyData in [CompanyData::"Extended Data"] then
            WizardMgmt.ReadFromHttp(Rec, PackageType);
    end;

    local procedure PackageImported(): Boolean
    begin
        //TODO:: Additional checks
        exit(true);
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