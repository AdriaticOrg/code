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
                    ToolTip = 'Media';
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
                    ToolTip = 'Media';
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
                        ToolTip = 'Select to set up company with Adriactic Localization';

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

            group(CoreStep)
            {
                Caption = 'Adriatic Localization core features';
                InstructionalText = 'With this setup you can choose which features you want to enable for Adriatic Localization';
                Visible = CoreSetupDetailsVisible;

                group(Core)
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
                    field("Use VAT Output Date-Adl"; "Use VAT Output Date-Adl")
                    {
                        Visible = "ADL Enabled-Adl";
                        ApplicationArea = All;
                        ToolTip = 'Specifies use of VAT output date';
                    }
                }

                group(ForceDebitCredit)
                {
                    Caption = 'Force Debit/Credit';
                    field("Forced Credit/Debit Enabled-Adl"; "Forced Credit/Debit Enabled-Adl")
                    {
                        Visible = "ADL Enabled-Adl";
                        ApplicationArea = All;
                        ToolTip = 'Specifies use of force debit/credit';
                    }
                }
            }
            /* group(General)
            {
                ShowCaption = false;
                Visible = GeneralDetailsVisible;
         
            } */
            group(stepVIES)
            {
                ShowCaption = false;
                Visible = VIESDetailsVisible;
                group(VIES)
                {
                    Caption = 'VIES';
                    field("Default VIES Country"; "Default VIES Country-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies Default VIES Country';
                    }
                    field("Default VIES Type"; "Default VIES Type-Adl")
                    {
                        ApplicationArea = All;
                        Editable = "Default VIES Country-Adl" = "Default VIES Country-Adl"::Croatia;
                        ToolTip = 'Specifies Default VIES Type';
                    }
                    field("VIES Company Branch Code"; "VIES Company Branch Code-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies VIES Company Branch Code';
                    }
                    field("VIES Report No. Series"; "VIES Report No. Series-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies VIES Report No. Series';
                    }
                    field("VIES Prep. By User ID"; "VIES Prep. By User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies VIES Prep. By User ID';
                    }
                    field("VIES Resp. User ID"; "VIES Resp. User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies VIES Resp. User ID';
                    }
                }
            }

            group(stepPDO)
            {
                ShowCaption = false;
                Visible = PDODetailsVisible;
                group(PDO)
                {
                    Caption = 'PDO';
                    field("PDO Report No. Series"; "PDO Report No. Series-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies PDO Report No. Series';
                    }
                    field("PDO Prep. By User ID"; "PDO Prep. By User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies PDO Prep. By User ID';
                    }
                    field("PDO Resp. User ID"; "PDO Resp. User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies PDO Resp. User ID';
                    }
                    field("PDO VAT Ident. Filter Code "; "PDO VAT Ident. Filter Code-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies PDO VAT Ident. Filter Code';
                    }
                }
            }

            group(stepFAS)
            {
                ShowCaption = false;
                Visible = FASDetailsVisible;
                group(FAS)
                {
                    Caption = 'FAS';
                    field("FAS Report No. Series"; "FAS Report No. Series-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies FAS Report No. Series';
                    }
                    field("FAS Resp. User ID"; "FAS Resp. User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies FAS Resp. User ID';
                    }
                    field("FAS Prep. By User ID"; "FAS Prep. By User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies FAS Prep. By User ID';
                    }
                    field("FAS Director User ID"; "FAS Director User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies FAS Director User ID';
                    }
                    field("Budget User Code"; "Fas Budget User Code-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies Budget User Code';
                    }
                    field("Company Sector Code"; "Fas Company Sector Code-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies Company Sector Code';
                    }
                }
            }

            group(stepKRD)
            {
                ShowCaption = false;
                Visible = KRDDetailsVisible;
                group(KRD)
                {
                    Caption = 'KRD';
                    field("KRD Report No. Series"; "KRD Report No. Series-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies KRD Report No. Series';
                    }
                    field("KRD Resp. User ID"; "KRD Resp. User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies KRD Resp. User ID';
                    }
                    field("KRD Prep. By User ID"; "KRD Prep. By User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies KRD Prep. By User ID';
                    }
                    field("Default KRD Affiliation Type"; "Default KRD Affiliation Type-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies Default KRD Affiliation Type';
                    }
                    field("KRD Blank LCY Code"; "KRD Blank LCY Code-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies KRD Blank LCY Code';
                    }
                    field("KRD Blank LCY Num."; "KRD Blank LCY Num.-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies KRD Blank LCY Num.';
                    }
                }
            }

            group(stepBST)
            {
                ShowCaption = false;
                Visible = BSTDetailsVisible;
                group(BST)
                {
                    Caption = 'BST';
                    field("BST Report No. Series-Adl"; "BST Report No. Series-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies BST Report No. Series';
                    }
                    field("BST Prep. By User ID"; "BST Prep. By User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies BST Prep. By User ID';
                    }
                    field("BST Resp. User ID"; "BST Resp. User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies BST Resp. User ID';
                    }
                }
            }

            group(stepFiscal)
            {
                ShowCaption = false;
                Visible = FiscalDetailsVisible;
                group(Fiscal)
                {
                    Caption = 'Fiscalization';
                    field("Fiscal. Active-Adl"; "Fiscal. Active-Adl")
                    {
                        ApplicationArea = All;
                    }
                    field("Fiscal. Start Date-Adl"; "Fiscal. Start Date-Adl")
                    {
                        ApplicationArea = All;
                    }
                    field("Fiscal. End Date-Adl"; "Fiscal. End Date-Adl")
                    {
                        ApplicationArea = All;
                    }
                    field("Fiscal. Default Fiscalization Location-Adl"; "Fiscal. Default Fiscalization Location-Adl")
                    {
                        ApplicationArea = All;
                    }
                    field("Fiscal. Default Fiscalization Terminal-Adl"; "Fiscal. Default Fiscalization Terminal-Adl")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            /*       group(VAT)
                  {
                      Caption = 'VAT';
                      field("VAT Enabled"; "VAT Enabled-Adl")
                      {
                          ApplicationArea = All;

                          trigger OnValidate()
                          var
                              ApplicatonAreaMgmtAdl: Codeunit "Application Area Mgmt-Adl";
                          begin
                              ApplicatonAreaMgmtAdl.EnableAdlCoreApplicationArea(Rec, false);
                          end;
                      }
                      field("Unpaid Receivables Enabled"; "Unpaid Receivables Enabled-Adl")
                      {
                          ApplicationArea = All;

                          trigger OnValidate()
                          var
                              ApplicatonAreaMgmtAdl: Codeunit "Application Area Mgmt-Adl";
                          begin
                              if ("Unpaid Receivables Enabled-Adl") and (ApplicatonAreaMgmtAdl.IsUnpaidReceivablesApplicationAreaEnabled()) then
                                  exit
                              else
                                  ApplicatonAreaMgmtAdl.EnableUnpaidReceivableApplicationArea(true);

                              if not ("Unpaid Receivables Enabled-Adl") then
                                  ApplicatonAreaMgmtAdl.EnableUnpaidReceivableApplicationArea(false);
                          end;
                      }

                  } */

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
                        ToolTip = 'Enter company name';
                    }
                    field(Address; Address)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter address';

                    }
                    field("Address 2"; "Address 2")
                    {
                        ApplicationArea = Advanced;
                        Visible = false;
                        ToolTip = 'Enter address 2';

                    }
                    field("Post Code"; "Post Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter post code';

                    }
                    field(City; City)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter city';

                    }
                    field("Country/Region Code"; "Country/Region Code")
                    {
                        ApplicationArea = All;
                        TableRelation = "Country/Region".Code;
                        ToolTip = 'Enter country';

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

                    field(PackageUrl; PackageUrl)
                    {
                        Caption = 'Package url address';
                        ToolTip = 'Enter valid package url address';
                        ApplicationArea = All;
                    }

                    /*  field(PackageDownloadBasicLbl; PackageDownloadBasicLbl)
                     {
                         ApplicationArea = All;
                         ShowCaption = false;

                         trigger OnDrillDown()
                         begin
                             StartConfigPackageImport(PackageUrl); //Basic setup
                         end;
                     } */

                    field(PackageDownloadLbl; PackageDownloadLbl)
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        ToolTip = 'Click here to download rapidstart package';

                        trigger OnDrillDown()
                        begin
                            StartConfigPackageImport(PackageUrl); //Master data
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
                    CopySetupData();
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
    var
        ApplicatonAreaMgmtAdl: Codeunit "Application Area Mgmt-Adl";
    begin
        ResetWizardControls();
        ShowIntroStep();
        TypeSelectionEnabled := PackageImported();
        ApplicatonAreaMgmtAdl.EnableDisableAdlCoreApplicationArea();
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
        //UNUSED//InventorySetup: Record "Inventory Setup";
        //UNUSED//TempBlobUncompressed: Record TempBlob;
        ClientTypeManagement: Codeunit ClientTypeManagement;
        WizardMgmt: Codeunit "Wizard Management-adl";
        //UNUSED//XMLDOMManagement: Codeunit "XML DOM Management";
        //UNUSED//ApplicatonAreaMgmt: Codeunit "Application Area Mgmt.";
        CompanyData: Option "Evaluation Data","Standard Data","None","Extended Data","Full No Data";
        TypeStandard: Boolean;
        TypeExtended: Boolean;
        TypeEvaluation: Boolean;
        Step: Option Intro,Sync,"Select Type",CoreSetup,VIES,PDO,FAS,KRD,BST,Fiscal,"Company Details","Communication Details",SelectBankAccont,"Payment Details","Package Import",Done;
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
        FiscalDetailsVisible: Boolean;
        BSTDetailsVisible: Boolean;
        KRDDetailsVisible: Boolean;
        FASDetailsVisible: Boolean;
        PDODetailsVisible: Boolean;
        VIESDetailsVisible: Boolean;
        PackageImportDetailesVIsible: Boolean;
        DoneVisible: Boolean;
        TypeSelectionEnabled: Boolean;
        //UNUSED//ExtendedVisible: Boolean;
        NotSetUpQst: Label 'The application has not been set up. Setup could be run again from role center notification.\\Are you sure that you want to exit?';
        NoSetupTypeSelectedQst: Label 'You have not selected any setup type. If you proceed, the application will not be fully functional, until you set it up manually.\\Do you want to continue?';
        HelpLbl: Label 'Learn more about setting up your company';
        HelpLinkTxt: Label 'https://adriaticorg.github.io/help', Locked = true;
        BankStatementConfirmationVisible: Boolean;
        BankAccountInformationUpdated: Boolean;
        SelectBankAccountVisible: Boolean;
        LogoPositionOnDocumentsShown: Boolean;
        ShowBankAccountCreationWarning: Boolean;
        InvalidPhoneNumberErr: Label 'The phone number is invalid.';
        //UNUSED//CostMethodeLbl: Label 'Learn more';
        //UNUSED//CostMethodUrlTxt: Label 'https://go.microsoft.com/fwlink/?linkid=858295', Locked = true;
        PrivacyNoticeTxt: Label 'Privacy Notice';
        AgreePrivacy: Boolean;
        PrivacyNoticeUrlTxt: Label 'https://privacy.microsoft.com/en-us/privacystatement#mainnoticetoendusersmodule', Locked = true;
        ApplyVisible: Boolean;
        ConfigVisible: Boolean;
        PackageIsAlreadyAppliedErr: Label 'A package has already been selected and applied.';
        SelectPackageAndApplyTxt: Label 'Select a package to run the Apply Package function.';
        PackageFileName: Text;
        PackageUrl: Text;
        //UNUSED//PackageDownloadBasicLbl: Label 'Click here to download BASIC DATA package';
        //UNUSED//PackageDownloadMasterLbl: Label 'Click here to download MASTER DATA package';
        PackageDownloadLbl: Label 'Download package';

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
            step::CoreSetup:
                if TypeEvaluation then begin
                    Step := Step::Done;
                    ShowDoneStep;
                end else begin
                    ShowCoreSetupDetailsStep();
                    NextEnabled := "ADL Enabled-Adl";
                end;
            step::VIES:
                if TypeEvaluation then begin
                    Step := Step::Done;
                    ShowDoneStep;
                end else
                    ShowVIESSetupDetailsStep();
            step::PDO:
                if TypeEvaluation then begin
                    Step := Step::Done;
                    ShowDoneStep;
                end else
                    ShowPDOSetupDetailsStep();
            step::FAS:
                if TypeEvaluation then begin
                    Step := Step::Done;
                    ShowDoneStep;
                end else
                    ShowFASSetupDetailsStep();
            step::KRD:
                if TypeEvaluation then begin
                    Step := Step::Done;
                    ShowDoneStep;
                end else
                    ShowKRDSetupDetailsStep();
            step::BST:
                if TypeEvaluation then begin
                    Step := Step::Done;
                    ShowDoneStep;
                end else
                    ShowBSTSetupDetailsStep();
            step::Fiscal:
                if TypeEvaluation then begin
                    Step := Step::Done;
                    ShowDoneStep;
                end else
                    ShowFiscalSetupDetailsStep();
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

    local procedure ShowCoreSetupDetailsStep()
    begin
        CoreSetupDetailsVisible := true;
        if TypeSelectionEnabled then
            BackEnabled := false;
    end;

    local procedure ShowVIESSetupDetailsStep()
    begin
        VIESDetailsVisible := true;
    end;

    local procedure ShowCompanyDetailsStep()
    begin
        CompanyDetailsVisible := true;
    end;

    local procedure ShowPDOSetupDetailsStep()
    begin
        PDODetailsVisible := true;
    end;

    local procedure ShowFASSetupDetailsStep()
    begin
        FASDetailsVisible := true;
    end;

    local procedure ShowKRDSetupDetailsStep()
    begin
        KRDDetailsVisible := true;
    end;

    local procedure ShowBSTSetupDetailsStep()
    begin
        BSTDetailsVisible := true;
    end;

    local procedure ShowCommunicationDetailsStep()
    begin
        CommunicationDetailsVisible := true;
    end;

    local procedure ShowFiscalSetupDetailsStep()
    begin
        FiscalDetailsVisible := true;
    end;

    local procedure ShowPaymentDetailsStep()
    begin
        PaymentDetailsVisible := true;
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
        FiscalDetailsVisible := false;
        BSTDetailsVisible := false;
        KRDDetailsVisible := false;
        FASDetailsVisible := false;
        PDODetailsVisible := false;
        VIESDetailsVisible := false;
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
        TrimmedCompanyName := CopyStr(CompanyName(), 1, MaxStrLen(TrimmedCompanyName));

        if CompanyInformation.Get() then begin
            TRANSFERFIELDS(CompanyInformation);
            if Name = '' then
                Name := TrimmedCompanyName;
        end else
            Name := TrimmedCompanyName;

        If CoreSetup.Get() then
            TransferfieldsFromDataSetup(CoreSetup);
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

    local procedure TransferfieldsFromDataSetup(var CoreSetup: Record "CoreSetup-Adl")
    var
        BSTSetup: Record "BST Setup-Adl";
        KRDSetup: Record "KRD Setup-Adl";
        FASSetup: Record "FAS Setup-Adl";
        PDOSetup: Record "PDO Setup-Adl";
        VIESSetup: Record "VIES Setup-Adl";
        VATSetup: Record "VAT Setup-Adl";
        UnpaidRecSetup: Record "Unpaid Receivables Setup-Adl";
        FiscalSetup: Record "Fiscalization Setup-Adl";
    begin
        if CoreSetup."BST Enabled" then begin
            if BSTSetup.Get() then;
            "BST Prep. By User ID-Adl" := BSTSetup."BST Prep. By User ID";
            "BST Report No. Series-Adl" := BSTSetup."BST Report No. Series";
            "BST Resp. User ID-Adl" := BSTSetup."BST Resp. User ID";
        end;
        if CoreSetup."KRD Enabled" then begin
            if KRDSetup.Get() then;
            "KRD Prep. By User ID-Adl" := KRDSetup."KRD Prep. By User ID";
            "KRD Report No. Series-Adl" := KRDSetup."KRD Report No. Series";
            "KRD Resp. User ID-Adl" := KRDSetup."KRD Resp. User ID";
            "Default KRD Affiliation Type-Adl" := KRDSetup."Default KRD Affiliation Type";
            "KRD Blank LCY Code-Adl" := KRDSetup."KRD Blank LCY Code";
            "KRD Blank LCY Num.-Adl" := KRDSetup."KRD Blank LCY Num.";
        end;

        if CoreSetup."FAS Enabled" then begin
            if FASSetup.Get() then;
            "FAS Prep. By User ID-Adl" := FASSetup."FAS Prep. By User ID";
            "FAS Report No. Series-Adl" := FASSetup."FAS Report No. Series";
            "FAS Resp. User ID-Adl" := FASSetup."FAS Resp. User ID";
            "FAS Budget User Code-Adl" := FASSetup."Budget User Code";
            "FAS Company Sector Code-Adl" := FASSetup."Company Sector Code";
            "FAS Director User ID-Adl" := FASSetup."FAS Director User ID";
        end;

        if CoreSetup."PDO Enabled" then begin
            if PDOSetup.Get() then;
            "PDO Prep. By User ID-Adl" := PDOSetup."PDO Prep. By User ID";
            "PDO Report No. Series-Adl" := PDOSetup."PDO Report No. Series";
            "PDO Resp. User ID-Adl" := PDOSetup."PDO Resp. User ID";
            "PDO VAT Ident. Filter Code-Adl" := PDOSetup."PDO VAT Ident. Filter Code";
        end;

        if CoreSetup."VIes Enabled" then begin
            if VIESSetup.Get() then;
            "Default VIES Country-Adl" := VIESSetup."Default VIES Country";
            "Default VIES Type-Adl" := VIESSetup."Default VIES Type";
            "VIES Company Branch Code-Adl" := VIESSetup."VIES Company Branch Code";
            "VIES Prep. By User ID-Adl" := VIESSetup."VIES Prep. By User ID";
            "VIES Report No. Series-Adl" := VIESSetup."VIES Report No. Series";
            "VIES Resp. User ID-Adl" := VIESSetup."VIES Resp. User ID";
        end;

        if CoreSetup."VAt Enabled" then begin
            if VATSetup.Get() then;
            "Use VAT Output Date-Adl" := VATSetup."Use VAT Output Date-Adl";
        end;

        if CoreSetup."Unpaid Receivables Enabled" then
            "UP Ext. Data Start Bal. Date-Adl" := UnpaidRecSetup."Ext. Data Start Bal. Date-Adl";
        if CoreSetup."Forced Credit/Debit Enabled" then
            "Forced Credit/Debit Enabled-Adl" := CoreSetup."Forced Credit/Debit Enabled";

        if FiscalSetup.get() then;
        "Fiscal. Active-Adl" := FiscalSetup.Active;
        "Fiscal. Default Fiscalization Location-Adl" := FiscalSetup."Default Fiscalization Location";
        "Fiscal. Default Fiscalization Terminal-Adl" := FiscalSetup."Default Fiscalization Terminal";
        "Fiscal. Start Date-Adl" := FiscalSetup."Start Date";
        "Fiscal. End Date-Adl" := FiscalSetup."End Date";
    end;

    local procedure StartConfigPackageImport(Url: Text)
    begin
        if not TypeSelectionEnabled then
            exit;
        CalcCompanyData();
        if CompanyData in [CompanyData::"Extended Data"] then
            WizardMgmt.ReadFromHttp(Url);
    end;

    local procedure StartConfigPackage(PackageType: Option "Basic","Master")
    begin
        if not TypeSelectionEnabled then
            exit;
        CalcCompanyData();
        if CompanyData in [CompanyData::"Extended Data"] then
            WizardMgmt.ReadFromHttp(Rec, PackageType);
    end;

    local procedure PackageImported(): Boolean
    begin

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