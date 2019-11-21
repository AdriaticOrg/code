page 13062812 "Adv. Assist. Setup Wizard-Adl"
{
    Caption = 'Adl Advanced Setup Wizard';
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
                Visible = TopBannerVisible and NOT FinishActionEnabled;
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
                Visible = TopBannerVisible and FinishActionEnabled;
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }

            group(StepIntro)
            {
                Visible = StepIntroVisible;
                group("Welcome to Adriatic Localization advanced feature setup")
                {
                    Caption = 'Welcome to Adriatic Localization advanced feature setup';
                    Visible = StepIntroVisible;
                    group(Group18)
                    {
                        ShowCaption = false;
                        InstructionalText = 'With this wizard you can enable advanced feature of Adriatic Localization.';
                    }
                }
                group("Let's go!")
                {
                    Caption = 'Let''s go!';
                    group(Group22)
                    {
                        ShowCaption = false;
                        InstructionalText = 'Choose Next so you can specify advanced Adriatic Localization features for specific country.';
                    }
                }
            }

            group(StepFeature)
            {
                ShowCaption = false;
                Visible = StepFeatureVisible;

                group(CountryCode)
                {
                    ShowCaption = false;
                    InstructionalText = 'Choose your localization country:';
                    field(AdlCountryFeatureSI; AdlCountryFeature)
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        ToolTip = 'Specifies ADL country';

                        trigger OnDrillDown()
                        begin
                            Case StrMenu(AdlCountryFeatureTxt, 1, AdlCountryFeatureInstruTxt) of
                                1:
                                    begin
                                        AdlCountryFeature := AdlCountryFeature::SI;
                                        validate("Country/Region Code", GetCountryRegionCode(AdlCountryFeature));
                                        CurrPage.Update(true);
                                    end;
                                2:
                                    begin
                                        AdlCountryFeature := AdlCountryFeature::RS;
                                        validate("Country/Region Code", GetCountryRegionCode(AdlCountryFeature));
                                        CurrPage.Update(true);
                                    end;
                                3:
                                    begin
                                        AdlCountryFeature := AdlCountryFeature::HR;
                                        validate("Country/Region Code", GetCountryRegionCode(AdlCountryFeature));
                                        CurrPage.Update(true);
                                    end;
                                else
                                    "Country/Region Code" := '';
                            end;

                            if (AdlCountryFeature <> 0) then
                                NextActionEnabled := true
                            else NextActionEnabled := false;
                        end;

                        trigger OnValidate()
                        begin
                            if (AdlCountryFeature <> 0) then begin
                                NextActionEnabled := true;
                                GetCountryRegionCode(AdlCountryFeature);
                            end
                            else NextActionEnabled := false;
                        end;
                    }
                }
                group(FeatureOptionsGrid)
                {
                    ShowCaption = false;
                    InstructionalText = 'Choose your advanced localization features:';


                    group(FeatureOptionsSI)
                    {
                        Caption = 'SI - features';
                        Visible = AdlCountryFeature = AdlCountryFeature::SI;
                        field("VIES Enabled-Adl"; "VIES Enabled-Adl")
                        {
                            Enabled = (AdlCountryFeature = AdlCountryFeature::SI) or (AdlCountryFeature = AdlCountryFeature::HR);
                            ApplicationArea = All;
                            ToolTip = 'Specifies if VIES is enabled';
                        }
                        field("PDO Enabled-Adl"; "PDO Enabled-Adl")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies if PDO is enabled';
                            Enabled = AdlCountryFeature = AdlCountryFeature::SI;
                        }

                        field("FAS Enabled-Adl"; "FAS Enabled-Adl")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies if FAS is enabled';
                            Enabled = AdlCountryFeature = AdlCountryFeature::SI;
                        }

                        field("KRD Enabled-Adl"; "KRD Enabled-Adl")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies if KRD is enabled';
                            Enabled = AdlCountryFeature = AdlCountryFeature::SI;
                        }

                        field("BST Enabled-Si-Adl"; "BST Enabled-Adl")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies if BST is enabled';
                            Enabled = AdlCountryFeature = AdlCountryFeature::SI;
                        }
                    }

                    group(FeatureOptionsHR)
                    {
                        Caption = 'HR - features';
                        Visible = AdlCountryFeature = AdlCountryFeature::HR;
                        field("VIES Enabled-Hr-Adl"; "VIES Enabled-Adl")
                        {
                            Enabled = (AdlCountryFeature = AdlCountryFeature::SI) or (AdlCountryFeature = AdlCountryFeature::HR);
                            ApplicationArea = All;
                            ToolTip = 'Specifies if VIES is enabled';
                        }
                        field("Unpaid Receivables Enabled-Adl"; "Unpaid Receivables Enabled-Adl")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies if Unpaid-Receivaables is enabled';
                            Enabled = AdlCountryFeature = AdlCountryFeature::HR;
                        }

                        field("Fiscal. Active-Adl"; "Fiscal. Active-Adl")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies if fiscalization is active';
                            Enabled = AdlCountryFeature = AdlCountryFeature::HR;
                        }
                    }
                }
            }

            group(CompanyInfo)
            {
                Visible = StepCompanyInfoVisible;
                Caption = 'Specify your company''s address information and logo.';
                group(CompanyInfoInstru)
                {
                    ShowCaption = false;
                    InstructionalText = 'This is used in invoices and other documents where general information about your company is printed.';
                    field(Name; Name)
                    {
                        ApplicationArea = All;
                        Caption = 'Company Name';
                        NotBlank = true;
                        ShowMandatory = true;
                        ToolTip = 'Specifies company name';
                    }
                    field(Address; Address)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies address';
                    }
                    field("Address 2"; "Address 2")
                    {
                        ApplicationArea = Advanced;
                        Visible = false;
                        ToolTip = 'Specifies address 2';
                    }
                    field("Post Code"; "Post Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies post code';
                    }
                    field(City; City)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies city';
                    }
                    field("Country/Region Code"; "Country/Region Code")
                    {
                        Editable = false;
                        ApplicationArea = All;
                        TableRelation = "Country/Region".Code;
                        ToolTip = 'Specifies country';

                    }
                    field("VAT Registration No."; "VAT Registration No.")
                    {
                        ApplicationArea = Advanced;
                        Visible = false;
                        ToolTip = 'Specifies VAT registration no.';
                    }

                    field(Picture; Picture)
                    {
                        ApplicationArea = All;
                        Caption = 'Company Logo';
                        ToolTip = 'Specifies company logo';

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

            group(stepVIES)
            {
                ShowCaption = false;
                Visible = StepVIESVisible and "VIES Enabled-Adl";

                Group(VIESInstru)
                {
                    Caption = 'VIES';
                    InstructionalText = 'Specify your properties for VIES feature.';
                    field("Default VIES Country"; "Default VIES Country-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies Default VIES Country';
                        ShowMandatory = true;
                    }
                    field("Default VIES Type"; "Default VIES Type-Adl")
                    {
                        ApplicationArea = All;
                        Editable = "Default VIES Country-Adl" = "Default VIES Country-Adl"::Croatia;
                        ToolTip = 'Specifies Default VIES Type';
                        ShowMandatory = true;
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

            group(stepFiscal)
            {
                Visible = StepFiscalVisible And "Fiscal. Active-Adl";
                ShowCaption = true;
                group(FiscalInstru)
                {
                    Caption = 'Fiscalization';
                    InstructionalText = 'Specify your properties for Fiscalization feature.';
                    field("Fiscal. Start Date-Adl"; "Fiscal. Start Date-Adl")
                    {
                        Caption = 'Start Date';
                        ToolTip = 'Specifies start date';
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field("Fiscal. End Date-Adl"; "Fiscal. End Date-Adl")
                    {
                        Caption = 'End Date';
                        ToolTip = 'Specifies end date';
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field("Fiscal. Default Fiscalization Location-Adl"; "Fiscal. Def. Fis. Location-Adl")
                    {
                        Caption = 'Default Location';
                        ToolTip = 'Specifies default location';
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field("Fiscal. Default Fiscalization Terminal-Adl"; "Fiscal. Def. Fis. Terminal-Adl")
                    {
                        Caption = 'Default Terminal';
                        ToolTip = 'Specifies default terminal';
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                }
            }

            group(stepUnpaidRec)
            {
                Visible = StepUnpaidRecVisible and "Unpaid Receivables Enabled-Adl";
                ShowCaption = false;
                group(UnpaidIntru)
                {
                    Caption = 'Unpaid Receivables';
                    InstructionalText = 'Specify your properties for Unpaid Receivables feature.';
                    field("UP Ext. Data Start Bal. Date-Adl"; "UP Ext. Data St. Bal. Date-Adl")
                    {
                        Caption = 'Data Start Balance Date';
                        ToolTip = 'Specifies data start balance date';
                        ApplicationArea = All;
                    }
                }
            }

            group(stepBST)
            {
                Visible = StepBSTVisible and "BST Enabled-Adl";
                ShowCaption = false;
                group(BST)
                {
                    Caption = 'BST';
                    InstructionalText = 'Specify your properties for BST feature.';
                    field("BST Report No. Series-Adl"; "BST Report No. Series-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies BST Report No. Series';
                        ShowMandatory = true;
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

            group(stepKRD)
            {
                Visible = StepKRDVisible and "KRD Enabled-Adl";
                ShowCaption = false;
                group(KRD)
                {
                    Caption = 'KRD';
                    InstructionalText = 'Specify your properties for KRD feature.';
                    field("KRD Report No. Series"; "KRD Report No. Series-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies KRD Report No. Series';
                        ShowMandatory = true;
                    }
                    field("KRD Resp. User ID"; "KRD Resp. User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies KRD Resp. User ID';
                        ShowMandatory = true;
                    }
                    field("KRD Prep. By User ID"; "KRD Prep. By User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies KRD Prep. By User ID';
                    }
                    field("Default KRD Affiliation Type"; "Default KRD Aff. Type-Adl")
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
            group(stepFAS)
            {
                Visible = StepFASVisible and "FAS Enabled-Adl";
                ShowCaption = false;
                group(FAS)
                {
                    Caption = 'FAS';
                    InstructionalText = 'Specify your properties for FAS feature.';
                    field("FAS Report No. Series"; "FAS Report No. Series-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies FAS Report No. Series';
                        ShowMandatory = true;
                    }
                    field("FAS Resp. User ID"; "FAS Resp. User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies FAS Resp. User ID';
                        ShowMandatory = true;
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
            group(stepPDO)
            {
                Visible = StepPDOVisible and "PDO Enabled-Adl";
                ShowCaption = false;
                group(PDO)
                {
                    Caption = 'PDO';
                    InstructionalText = 'Specify your properties for PDO feature.';
                    field("PDO Report No. Series"; "PDO Report No. Series-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies PDO Report No. Series';
                        ShowMandatory = true;
                    }
                    field("PDO Prep. By User ID"; "PDO Prep. By User ID-Adl")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies PDO Prep. By User ID';
                        ShowMandatory = true;
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
            group(StepPackageImport)
            {
                ShowCaption = false;
                Visible = StepPackageImportVisible;
                group(CompanyDataType)
                {
                    Caption = 'Rapidstart data import';
                    InstructionalText = 'Here you can choose package data to import';
                    field(NewCompanyData; NewCompanyData)
                    {
                        Caption = 'Select type of data';
                        ToolTip = 'Specifies selected type of data';
                        ApplicationArea = All;

                        trigger OnValidate()
                        var
                            WebRequestHelper: Codeunit "Web Request Helper";
                        begin
                            case NewCompanyData of
                                NewCompanyData::"Standard Data":
                                    PackageUrl := StrSubstNo(GitHubSetaupBaseUrlLbl, StrSubstNo(StdPackageUrlNameLbl, SpaceLbl, "Country/Region Code"));
                                NewCompanyData::"Evaluation Data":
                                    PackageUrl := StrSubstNo(GitHubSetaupBaseUrlLbl, StrSubstNo(EvalPackageUrlNameLbl, SpaceLbl, "Country/Region Code"));
                                else
                                    PackageUrl := '';
                            end;
                            if PackageUrl <> '' then
                                WebRequestHelper.IsValidUri(PackageUrl);
                        end;
                    }
                }
                group(CompanyDataPackageImport)
                {
                    ShowCaption = false;
                    Visible = StepPackageImportVisible and (NewCompanyData <> 0);
                    field(PackageUrl; PackageUrl)
                    {
                        Caption = 'Package url address';
                        ToolTip = 'Specify valid package url address';
                        ApplicationArea = All;
                    }

                    field(PackageDownloadLbl; PackageDownloadLbl)
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        ToolTip = 'Click here to download rapidstart package';

                        trigger OnDrillDown()
                        begin
                            StartConfigPackageImport(PackageUrl);
                        end;
                    }
                    field(PackageFileName; PackageFileName)
                    {
                        ApplicationArea = All;
                        Caption = 'Select the configuration package you want to load:';
                        ToolTip = 'Specifies the name of the configuration package that you have created.';
                        Editable = false;

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
                        Editable = false;
                    }
                    field("Package Name"; "Package Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the name of the package that contains the configuration information.';
                        Editable = false;
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
                Visible = StepFinishVisible;
                group(Group23)
                {
                    ShowCaption = false;
                    InstructionalText = 'You''ve succesfully completed configuration of Adriatic Localization';
                }
                group("That's it!")
                {
                    Caption = 'That''s it!';
                    group(Group25)
                    {
                        ShowCaption = false;
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
                    ValidateActionNext();
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

    trigger OnAfterGetRecord()
    begin
        LogoPositionOnDocumentsShown := Picture.HasValue();
    end;

    trigger OnInit();
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage();
    begin
        InitializeRecord();

        Step := Step::Intro;
        EnableControls(false);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        AssistedSetupAdl: Record "Assisted Setup-adl";
    begin
        if CloseAction = ACTION::OK then
            IF AssistedSetupAdl.GetStatus(PAGE::"Adv. Assist. Setup Wizard-Adl") = AssistedSetupAdl.Status::"Not Completed" THEN
                IF NOT Confirm(NotSetUpQst, FALSE) THEN
                    Error('');
    end;

    local procedure GetCountryRegionCode(CountryCode: Integer): Code[10]
    begin
        case CountryCode of
            AdlCountryFeature::SI:
                exit('SI');
            AdlCountryFeature::HR:
                exit('HR');
            AdlCountryFeature::RS:
                exit('RS');
            else
                exit('');
        end;
    end;

    var
        MediaRepositoryStandard: Record "Media Repository";
        MediaRepositoryDone: Record "Media Repository";
        MediaResourcesStandard: Record "Media Resources";
        MediaResourcesDone: Record "Media Resources";
        WizardMgmt: Codeunit "Wizard Management-adl";
        Step: Option Intro,Feature,CompanyInfo,VIES,Fiscalization,UnpaidRec,BST,KRD,FAS,PDO,PackageImport,Finish;
        NewCompanyData: Option ,"Evaluation Data","Standard Data";
        TopBannerVisible: Boolean;
        StepIntroVisible: Boolean;
        StepFeatureVisible: Boolean;
        StepFinishVisible: Boolean;
        FinishActionEnabled: Boolean;
        BackActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        AdlCountryFeature: Option ,,SI,RS,HR;
        AdlCountryFeatureTxt: Label 'SI,RS,HR';
        LogoPositionOnDocumentsShown: Boolean;
        StepCompanyInfoVisible: Boolean;
        StepVATOutDAteVisible: Boolean;
        StepForceDebitCreditVisible: Boolean;
        StepVIESVisible: Boolean;
        StepFiscalVisible: Boolean;
        StepUnpaidRecVisible: Boolean;
        StepBSTVisible: Boolean;
        StepKRDVisible: Boolean;
        StepFASVisible: Boolean;
        StepPDOVisible: Boolean;
        StepPackageImportVisible: Boolean;
        ApplyVisible: Boolean;
        ConfigVisible: Boolean;
        PackageUrl: Text;
        PackageFileName: Text;
        SpaceLbl: Label '%20', Locked = true;
        StdPackageUrlNameLbl: Label 'APP%1SETUP_%2.rapidstart', Locked = true;
        EvalPackageUrlNameLbl: Label 'MASTER%1DATA_%2.rapidstart', Locked = true;
        GitHubSetaupBaseUrlLbl: Label 'https://github.com/AdriaticOrg/setup/blob/master/%1', Locked = true;
        PackageDownloadLbl: Label 'Download package';
        NotSetUpQst: Label 'The application has not been set up. Setup could be run again from assisted setup.\\Are you sure that you want to exit?';
        PackageIsAlreadyAppliedErr: Label 'A package has already been selected and applied.';
        CompanyCountryCodeSelectedQst: Label 'You cannot change your choice of setup after you choose Next.\\Do you want to continue?';
        AdlCountryFeatureInstruTxt: Label 'Choose your localization country code:';
        CompanyNameQst: Label 'To continue you need to enter company name.';

    local procedure EnableControls(Backwards: Boolean);
    begin
        ResetControls();

        CASE Step OF
            Step::Intro:
                ShowIntroStep();
            Step::Feature:
                begin
                    NextActionEnabled := AdlCountryFeature <> 0;
                    ShowFeatureStep();
                End;
            Step::CompanyInfo:
                begin
                    if AdlCountryFeature <> 0 then
                        BackActionEnabled := false;
                    ShowCompanyInfoStep();
                end;
            Step::VIES:
                If "VIES Enabled-Adl" then
                    ShowVIESStep()
                else
                    NextStep(Backwards);
            Step::Fiscalization:
                If "Fiscal. Active-Adl" then
                    ShowFiscalStep()
                else
                    NextStep(Backwards);
            Step::UnpaidRec:
                if "Unpaid Receivables Enabled-Adl" then
                    ShowUnpaidRecStep()
                else
                    NextStep(Backwards);
            Step::BST:
                if "BST Enabled-Adl" then
                    ShowBSTStep()
                else
                    NextStep(Backwards);
            Step::KRD:
                if "KRD Enabled-Adl" then
                    ShowKRDStep()
                else
                    NextStep(Backwards);
            Step::FAS:
                if "FAS Enabled-Adl" then
                    ShowFASStep()
                else
                    NextStep(Backwards);
            Step::PDO:
                if "PDO Enabled-Adl" then
                    ShowPDOStep()
                else
                    NextStep(Backwards);
            Step::PackageImport:
                ShowPackageImportStep();
            Step::Finish:
                ShowFinishStep();
        END;
    end;

    local procedure StoreSetupData()
    var
        CompanyInfo: Record "Company Information";
        CoreSetup: Record "CoreSetup-Adl";
        ExtendedSetup: Record "Extended Setup-Adl";
        VIESSetup: Record "VIES Setup-Adl";
        PDOSetup: Record "PDO Setup-Adl";
        FASSetup: Record "FAS Setup-Adl";
        KRDSetup: Record "KRD Setup-Adl";
        BSTSetup: Record "BST Setup-Adl";
        FiscalSetup: Record "Fiscalization Setup-Adl";
    begin
        CoreSetup.EnableOrDisableFeature("ADLFeatures-Adl"::VIES, "VIES Enabled-Adl");
        CoreSetup.EnableOrDisableFeature("ADLFeatures-Adl"::FISC, "Fiscal. Active-Adl");
        CoreSetup.EnableOrDisableFeature("ADLFeatures-Adl"::BST, "BST Enabled-Adl");
        CoreSetup.EnableOrDisableFeature("ADLFeatures-Adl"::KRD, "KRD Enabled-Adl");
        CoreSetup.EnableOrDisableFeature("ADLFeatures-Adl"::FAS, "FAS Enabled-Adl");
        CoreSetup.EnableOrDisableFeature("ADLFeatures-Adl"::PDO, "PDO Enabled-Adl");
        CoreSetup.EnableOrDisableFeature("ADLFeatures-Adl"::UnpaidReceivables, "Unpaid Receivables Enabled-Adl");

        if not CompanyInfo.Get() then begin
            CompanyInfo.Init();
            CompanyInfo.Insert();
        end;
        CompanyInfo.Name := Name;
        CompanyInfo.Address := Address;
        CompanyInfo."Address 2" := "Address 2";
        CompanyInfo."Post Code" := "Post Code";
        CompanyInfo.City := City;
        CompanyInfo."Country/Region Code" := "Country/Region Code";
        CompanyInfo."VAT Registration No." := "VAT Registration No.";
        CompanyInfo.Modify(true);

        IF "Unpaid Receivables Enabled-Adl" then begin
            If not ExtendedSetup.Get() then begin
                ExtendedSetup.Init();
                ExtendedSetup.Insert();
            end;
            ExtendedSetup."Unpaid Receivables Enabled" := "Unpaid Receivables Enabled-Adl";
            ExtendedSetup."Ext. Data Start Bal. Date" := "UP Ext. Data St. Bal. Date-Adl";
            ExtendedSetup.Modify(true);
        end;

        if "VIES Enabled-Adl" then begin
            if not VIESSetup.get() then
                VIESSetup.Insert(true);
            VIESSetup."Default VIES Country" := "Default VIES Country-Adl";
            VIESSetup."Default VIES Type" := "Default VIES Type-Adl";
            VIESSetup."VIES Company Branch Code" := "VIES Company Branch Code-Adl";
            VIESSetup."VIES Prep. By User ID" := "VIES Prep. By User ID-Adl";
            VIESSetup."VIES Report No. Series" := "VIES Report No. Series-Adl";
            VIESSetup."VIES Resp. User ID" := "VIES Resp. User ID-Adl";
            VIESSetup.Modify(true);
        end;

        if "PDO Enabled-Adl" then begin
            if not PDOSetup.get() then
                PDOSetup.Insert(true);
            PDOSetup."PDO Prep. By User ID" := "PDO Prep. By User ID-Adl";
            PDOSetup."PDO Report No. Series" := "PDO Report No. Series-Adl";
            PDOSetup."PDO Resp. User ID" := "PDO Resp. User ID-Adl";
            PDOSetup."PDO VAT Ident. Filter Code" := "PDO VAT Ident. Filter Code-Adl";
            PDOSetup.Modify(true);
        end;

        if "FAS Enabled-Adl" then begin
            if not FASSetup.get() then
                FASSetup.Insert(true);
            FASSetup."FAS Prep. By User ID" := "FAS Prep. By User ID-Adl";
            FASSetup."FAS Report No. Series" := "FAS Report No. Series-Adl";
            FASSetup."FAS Resp. User ID" := "FAS Resp. User ID-Adl";
            FASSetup."Budget User Code" := "FAS Budget User Code-Adl";
            FASSetup."Company Sector Code" := "FAS Company Sector Code-Adl";
            FASSetup."FAS Director User ID" := "FAS Director User ID-Adl";
            FASSetup.Modify(true);
        end;

        if "KRD Enabled-Adl" then begin
            if not KRDSetup.get() then
                KRDSetup.Insert(true);
            KRDSetup."KRD Prep. By User ID" := "KRD Prep. By User ID-Adl";
            KRDSetup."KRD Report No. Series" := "KRD Report No. Series-Adl";
            KRDSetup."KRD Resp. User ID" := "KRD Resp. User ID-Adl";
            KRDSetup."Default KRD Affiliation Type" := "Default KRD Aff. Type-Adl";
            KRDSetup."KRD Blank LCY Code" := "KRD Blank LCY Code-Adl";
            KRDSetup."KRD Blank LCY Num." := "KRD Blank LCY Num.-Adl";
            KRDSetup.Modify(true);
        end;

        if "BST Enabled-Adl" then begin
            if not BSTSetup.get() then
                BSTSetup.Insert(true);
            BSTSetup."BST Prep. By User ID" := "BST Prep. By User ID-Adl";
            BSTSetup."BST Report No. Series" := "BST Report No. Series-Adl";
            BSTSetup."BST Resp. User ID" := "BST Resp. User ID-Adl";
            BSTSetup.Modify(true);
        end;

        if "Fiscal. Active-Adl" then begin
            if not FiscalSetup.get() then
                FiscalSetup.Insert(true);
            FiscalSetup.ActiveX := "Fiscal. Active-Adl";
            FiscalSetup."Default Fiscalization Location" := "Fiscal. Def. Fis. Location-Adl";
            FiscalSetup."Default Fiscalization Terminal" := "Fiscal. Def. Fis. Terminal-Adl";
            FiscalSetup."Start Date" := "Fiscal. Start Date-Adl";
            FiscalSetup."End Date" := "Fiscal. End Date-Adl";
            FiscalSetup.Modify(true);
        end;
    end;

    local procedure FinishAction();
    var
        AssistedSetupAdl: Record "Assisted Setup-adl";
    begin
        StoreSetupData();

        AssistedSetupAdl.SetStatus(PAGE::"Adv. Assist. Setup Wizard-Adl", AssistedSetupAdl.Status::Completed);
        CurrPage.Close();
    end;

    local procedure NextStep(Backwards: Boolean);
    begin
        if Backwards then
            Step := Step - 1
        ELSE
            Step := Step + 1;

        EnableControls(Backwards);
    end;

    local procedure ShowIntroStep();
    begin
        StepIntroVisible := true;

        FinishActionEnabled := false;
        BackActionEnabled := false;
    end;

    local procedure ShowFeatureStep();
    begin
        StepFeatureVisible := true;
    end;

    local procedure ShowFinishStep();
    begin
        StepFinishVisible := true;

        NextActionEnabled := false;
        FinishActionEnabled := true;
    end;

    local procedure ShowCompanyInfoStep();
    begin
        StepCompanyInfoVisible := true;
        if "Country/Region Code" <> '' then
            BackActionEnabled := false;
    end;

    local procedure ShowVATOutDateStep();
    begin
        StepVATOutDAteVisible := true;
    end;

    local procedure ShowForceDebitCreditStep();
    begin
        StepForceDebitCreditVisible := true;
    end;

    local procedure ShowUnpaidRecStep();
    begin
        StepUnpaidRecVisible := true;
    end;

    local procedure ShowFiscalStep();
    begin
        StepFiscalVisible := true;
    end;

    local procedure ShowVIESStep();
    begin
        StepVIESVisible := true;
    end;

    local procedure ShowBSTStep();
    begin
        StepBSTVisible := true;
    end;

    local procedure ShowKRDStep();
    begin
        StepKRDVisible := true;
    end;

    local procedure ShowFASStep();
    begin
        StepFASVisible := true;
    end;

    local procedure ShowPDOStep();
    begin
        StepPDOVisible := true;
    end;

    local procedure ShowPackageImportStep();
    begin
        StepPackageImportVisible := true;
    end;

    local procedure ResetControls();
    begin
        FinishActionEnabled := false;
        BackActionEnabled := true;
        NextActionEnabled := true;

        StepIntroVisible := false;
        StepFeatureVisible := false;
        StepCompanyInfoVisible := false;
        StepVATOutDAteVisible := false;
        StepForceDebitCreditVisible := false;
        StepFiscalVisible := false;
        StepUnpaidRecVisible := false;
        StepVIESVisible := false;
        StepBSTVisible := false;
        StepKRDVisible := false;
        StepFASVisible := false;
        StepPDOVisible := false;
        StepPackageImportVisible := false;
        StepFinishVisible := false;
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', FORMAT(CURRENTCLIENTTYPE())) and
           MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png', FORMAT(CURRENTCLIENTTYPE()))
        then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
               MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
            then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue();
    end;

    local procedure StartConfigPackageImport(Url: Text)
    begin
        WizardMgmt.ReadFromHttp(Url);
    end;

    local procedure InitializeRecord()
    var
        ExtSetup: Record "Extended Setup-Adl";
        CompanyInfo: Record "Company Information";
        TrimmedCompanyName: Text[50];
    begin
        init();

        TrimmedCompanyName := CopyStr(CompanyName(), 1, MaxStrLen(TrimmedCompanyName));
        if CompanyInfo.Get() then begin
            TransferfieldsFromCompanyInfo(CompanyInfo);
            if Name = '' then
                Name := TrimmedCompanyName;
        end else
            Name := TrimmedCompanyName;

        if ExtSetup.Get() then
            TransferfieldsFromDataSetup(ExtSetup);
        insert();
    end;

    local procedure TransferfieldsFromDataSetup(ExtSetup: Record "Extended Setup-Adl")
    var
        CoreSetup: Record "CoreSetup-Adl";
        VIESSetup: Record "VIES Setup-Adl";
        BSTSetup: Record "BST Setup-Adl";
        KRDSetup: Record "KRD Setup-Adl";
        FASSetup: Record "FAS Setup-Adl";
        PDOSetup: Record "PDO Setup-Adl";
        FiscalSetup: Record "Fiscalization Setup-Adl";
    begin
        if CoreSetup.Get() then;
        "ADL Enabled-Adl" := CoreSetup."ADL Enabled";

        "VAT Enabled-Adl" := ExtSetup."VAT Enabled";
        "Use VAT Output Date" := ExtSetup."Use VAT Output Date";
        "Forced Cred./Deb. Enabled-Adl" := ExtSetup."Forced Credit/Debit Enabled";
        "UP Ext. Data St. Bal. Date-Adl" := ExtSetup."Ext. Data Start Bal. Date";
        "Unpaid Receivables Enabled-Adl" := ExtSetup."Unpaid Receivables Enabled";

        if "Unpaid Receivables Enabled-Adl" then
            "UP Ext. Data St. Bal. Date-Adl" := ExtSetup."Ext. Data Start Bal. Date";

        if CoreSetup."BST Enabled" then begin
            "BST Enabled-Adl" := CoreSetup."BST Enabled";
            if BSTSetup.Get() then;
            "BST Prep. By User ID-Adl" := BSTSetup."BST Prep. By User ID";
            "BST Report No. Series-Adl" := BSTSetup."BST Report No. Series";
            "BST Resp. User ID-Adl" := BSTSetup."BST Resp. User ID";
        end;
        if CoreSetup."KRD Enabled" then begin
            "KRD Enabled-Adl" := CoreSetup."KRD Enabled";
            if KRDSetup.Get() then;
            "KRD Prep. By User ID-Adl" := KRDSetup."KRD Prep. By User ID";
            "KRD Report No. Series-Adl" := KRDSetup."KRD Report No. Series";
            "KRD Resp. User ID-Adl" := KRDSetup."KRD Resp. User ID";
            "Default KRD Aff. Type-Adl" := KRDSetup."Default KRD Affiliation Type";
            "KRD Blank LCY Code-Adl" := KRDSetup."KRD Blank LCY Code";
            "KRD Blank LCY Num.-Adl" := KRDSetup."KRD Blank LCY Num.";
        end;

        if CoreSetup."FAS Enabled" then begin
            "FAS Enabled-Adl" := CoreSetup."FAS Enabled";
            if FASSetup.Get() then;
            "FAS Prep. By User ID-Adl" := FASSetup."FAS Prep. By User ID";
            "FAS Report No. Series-Adl" := FASSetup."FAS Report No. Series";
            "FAS Resp. User ID-Adl" := FASSetup."FAS Resp. User ID";
            "FAS Budget User Code-Adl" := FASSetup."Budget User Code";
            "FAS Company Sector Code-Adl" := FASSetup."Company Sector Code";
            "FAS Director User ID-Adl" := FASSetup."FAS Director User ID";
        end;

        if CoreSetup."PDO Enabled" then begin
            "PDO Enabled-Adl" := CoreSetup."PDO Enabled";
            if PDOSetup.Get() then;
            "PDO Prep. By User ID-Adl" := PDOSetup."PDO Prep. By User ID";
            "PDO Report No. Series-Adl" := PDOSetup."PDO Report No. Series";
            "PDO Resp. User ID-Adl" := PDOSetup."PDO Resp. User ID";
            "PDO VAT Ident. Filter Code-Adl" := PDOSetup."PDO VAT Ident. Filter Code";
        end;

        if CoreSetup."VIES Enabled" then begin
            "VIES Enabled-Adl" := CoreSetup."VIES Enabled";
            if VIESSetup.Get() then;
            "Default VIES Country-Adl" := VIESSetup."Default VIES Country";
            "Default VIES Type-Adl" := VIESSetup."Default VIES Type";
            "VIES Company Branch Code-Adl" := VIESSetup."VIES Company Branch Code";
            "VIES Prep. By User ID-Adl" := VIESSetup."VIES Prep. By User ID";
            "VIES Report No. Series-Adl" := VIESSetup."VIES Report No. Series";
            "VIES Resp. User ID-Adl" := VIESSetup."VIES Resp. User ID";
        end;

        IF CoreSetup."FISC Enabled" then begin
            "Fiscal. Active-Adl" := CoreSetup."FISC Enabled";
            if FiscalSetup.get() then;
            "Fiscal. Active-Adl" := FiscalSetup.ActiveX;
            "Fiscal. Def. Fis. Location-Adl" := FiscalSetup."Default Fiscalization Location";
            "Fiscal. Def. Fis. Terminal-Adl" := FiscalSetup."Default Fiscalization Terminal";
            "Fiscal. Start Date-Adl" := FiscalSetup."Start Date";
            "Fiscal. End Date-Adl" := FiscalSetup."End Date";
        end;

    end;

    local procedure TransferfieldsFromCompanyInfo(CompanyInfo: Record "Company Information")
    begin
        Name := CompanyInfo.Name;
        Address := CompanyInfo.Address;
        "Address 2" := CompanyInfo."Address 2";
        "Post Code" := CompanyInfo."Post Code";
        City := CompanyInfo.City;
        "Country/Region Code" := CompanyInfo."Country/Region Code";
        case "Country/Region Code" of
            'SI':
                AdlCountryFeature := AdlCountryFeature::SI;
            'HR':
                AdlCountryFeature := AdlCountryFeature::HR;
            'RS':
                AdlCountryFeature := AdlCountryFeature::RS;
        end;
    end;

    local procedure DisableFeatures(CountryFeature: Integer)
    begin
        if CountryFeature = AdlCountryFeature::HR then begin
            "PDO Enabled-Adl" := false;
            "KRD Enabled-Adl" := false;
            "FAS Enabled-Adl" := false;
            "BST Enabled-Adl" := false;
        end;
        if CountryFeature = AdlCountryFeature::SI then begin
            "Fiscal. Active-Adl" := false;
            "Unpaid Receivables Enabled-Adl" := false;
        end;
    end;

    local procedure ValidateActionNext()
    begin
        //Features checks
        if (Step = Step::Feature) then
            if (AdlCountryFeature <> 0) then
                if not CONFIRM(CompanyCountryCodeSelectedQst, false) then
                    Error('');

        //CompanyInfo checks
        if (Step = Step::CompanyInfo) then
            if (Name = '') then begin
                Message(CompanyNameQst);
                Error('');
            end;

        //PDO cheks
        if (Step = Step::PDO) then;

        //KRD cheks
        if (Step = Step::KRD) then;

        //BST cheks
        if (Step = Step::BST) then;

        //FAS cheks
        if (Step = Step::FAS) then;

        //VIES cheks
        if (Step = Step::VIES) then;

        if (Step = step::Fiscalization) then;
    end;
}
