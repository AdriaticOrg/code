table 13062812 "Assisted Setup-Adl"
{
    Caption = 'Assisted Setup ADL';

    fields
    {
        field(1; "Page ID"; Integer)
        {
            Caption = 'Page ID';
            DataClassification = SystemMetadata;
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(3; "Order"; Integer)
        {
            Caption = 'Order';
            DataClassification = SystemMetadata;
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Not Completed,Completed,Not Started,Seen,Watched,Read, ';
            OptionMembers = "Not Completed",Completed,"Not Started",Seen,Watched,Read," ";
            DataClassification = SystemMetadata;
        }
        field(5; Visible; Boolean)
        {
            Caption = 'Visible';
            DataClassification = SystemMetadata;
        }
        field(6; Parent; Integer)
        {
            Caption = 'Parent';
            DataClassification = SystemMetadata;
        }
        field(7; "Video Url"; Text[250])
        {
            Caption = 'Video Url';
            DataClassification = SystemMetadata;
        }
        field(8; Icon; Media)
        {
            Caption = 'Icon';
            DataClassification = SystemMetadata;
        }
        field(9; "Item Type"; Option)
        {
            Caption = 'Item Type';
            initValue = "Setup and Help";
            OptionCaption = ' ,Group,Setup and Help';
            OptionMembers = " ",Group,"Setup and Help";
            DataClassification = SystemMetadata;
        }
        field(10; Featured; Boolean)
        {
            Caption = 'Featured';
            DataClassification = SystemMetadata;
        }
        field(11; "Help Url"; Text[250])
        {
            Caption = 'Help Url';
            DataClassification = SystemMetadata;
        }
        field(12; "Assisted Setup Page ID"; Integer)
        {
            Caption = 'Assisted Setup Page ID';
            DataClassification = SystemMetadata;
        }
        field(13; "Tour Id"; Integer)
        {
            Caption = 'Tour Id';
            DataClassification = SystemMetadata;
        }
        field(14; "Video Status"; Boolean)
        {
            Caption = 'Video Status';
            DataClassification = SystemMetadata;
        }
        field(15; "Help Status"; Boolean)
        {
            Caption = 'Help Status';
            DataClassification = SystemMetadata;
        }
        field(16; "Tour Status"; Boolean)
        {
            Caption = 'Tour Status';
            DataClassification = SystemMetadata;
        }
        /*field(17; "Package Imported"; Boolean)
        {
            Caption = 'Package Imported';
            DataClassification = SystemMetadata;
        }
        field(18; "Import Failed"; Boolean)
        {
            Caption = ' Import Failed';
            DataClassification = SystemMetadata;
        }*/

    }

    keys
    {
        key(Key1; "Page ID")
        {
        }
        key(Key2; "Order", Visible)
        {
        }
    }

    fieldgroups
    {
    }

    var
        DocumentUrlADLTxt: Label '', Locked = true;
        ADLBasicIntroTxt: Label 'Set up basic Adriatic Localization',;
        ADLAdvIntroTxt: Label 'Set up advanced Adriatic Localization',;

    procedure initialize()
    var
        LastId: Integer;
        GroupId: Integer;
        SortingOrder: Integer;
        ADLIntroTxtCopy: Text[250];
        DocumentUrlADLTxtCopy: Text[250];
    begin
        SortingOrder := 1;
        LastId := 200000;

        ADLIntroTxtCopy := CopyStr(ADLBasicIntroTxt, 1, MaxStrLen(ADLIntroTxtCopy));
        DocumentUrlADLTxtCopy := CopyStr(DocumentUrlADLTxt, 1, MaxStrLen(DocumentUrlADLTxtCopy));
        AddSetupAssistant(Page::"Basic Assist. Setup Wizard-Adl", ADLIntroTxtCopy, SortingOrder, true,
            GroupId, false, "Item Type"::"Setup and Help");
        AddSetupAssistantResources(Page::"Basic Assist. Setup Wizard-Adl", '', DocumentUrlADLTxtCopy, 0, Page::"Basic Assist. Setup Wizard-Adl", '');
        UpdateSetUpPageVisibility(Page::"Basic Assist. Setup Wizard-Adl");
        LastId += 1;
        SortingOrder += 1;

        GroupId := Page::"Basic Assist. Setup Wizard-Adl";
        ADLIntroTxtCopy := CopyStr(ADLAdvIntroTxt, 1, MaxStrLen(ADLIntroTxtCopy));
        AddSetupAssistant(Page::"Adv. Assist. Setup Wizard-Adl", ADLIntroTxtCopy, SortingOrder, true,
            GroupId, false, "Item Type"::"Setup and Help");
        AddSetupAssistantResources(Page::"Adv. Assist. Setup Wizard-Adl", '', DocumentUrlADLTxtCopy, 0, Page::"Adv. Assist. Setup Wizard-Adl", '');
        UpdateSetUpPageVisibility(Page::"Adv. Assist. Setup Wizard-Adl");
        LastId += 1;
        SortingOrder += 1;
    end;

    local procedure AddSetupAssistant(EnteryNo: Integer; AssistantName: Text[250]; SortingOrder: Integer; AssistantVisible: Boolean; ParentId: Integer; IsFeatured: Boolean; EnteryType: Option)
    begin
        if not Get(EnteryNo) then begin
            init();
            "Page ID" := EnteryNo;
            Visible := AssistantVisible;
            if EnteryType = "Item Type"::Group then
                Status := Status::" ";
            Insert(true);
        end;

        "Page ID" := EnteryNo;
        Name := AssistantName;
        Order := SortingOrder;
        "Item Type" := EnteryType;
        Featured := IsFeatured;
        Parent := ParentId;
        Modify(true);
    end;

    local procedure UpdateSetUpPageVisibility(PageId: Integer)
    var
        ADLAssistedSetup: Record "Assisted Setup-adl";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ADLAssistedSetup.GET(PageId) then begin
            ADLAssistedSetup.Visible := not ApplicationAreaMgmtFacade.IsBasicOnlyEnabled();
            ADLAssistedSetup.Modify();
        end;
    end;

    local procedure AddSetupAssistantResources(EnteryNo: Integer; videoLink: Text[250]; HelpLink: Text[250]; TourId: Integer; AssistedPageId: Integer; IconCode: Code[50])
    begin
        if not GET(EnteryNo) then
            exit;

        "Video Url" := videoLink;
        "Help Url" := HelpLink;
        "Tour Id" := TourId;
        "Assisted Setup Page ID" := AssistedPageId;
        Modify(true);
        if not Icon.HasValue() then
            ImportIcon(IconCode);
    end;

    procedure SetStatus(EnteryId: Integer; ItemStatus: Option)
    var
        ADLAssistedSetup: Record "Assisted Setup-adl";
    begin
        ADLAssistedSetup.GET(EnteryId);
        ADLAssistedSetup.Status := ItemStatus;
        ADLAssistedSetup.Modify();

        if
           (ADLAssistedSetup.Status = ADLAssistedSetup.Status::Completed) and
           (ADLAssistedSetup."Assisted Setup Page ID" <> 0)
        then
            OnADLAssistedSetupCompleted(EnteryId);
    end;

    local procedure ImportIcon(IconCode: Code[50])
    var
        AssistedSetupIcons: Record "Assisted Setup Icons";
        MediaResources: Record "Media Resources";
    begin
        if not AssistedSetupIcons.GET(IconCode) then
            exit;

        if not MediaResources.GET(AssistedSetupIcons."Media Resources Ref") then
            exit;

        if not MediaResources."Media Reference".HasValue() then
            exit;

        Icon := MediaResources."Media Reference";
        Modify(true);
    end;

    procedure GetStatus(WizardPageID: Integer): Integer
    var
        ADLAssistedSetup: Record "Assisted Setup-adl";
    begin

        ADLAssistedSetup.SETRANGE("Assisted Setup Page ID", WizardPageID);
        IF ADLAssistedSetup.FindFirst() THEN
            exit(ADLAssistedSetup.Status)
        else
            exit(ADLAssistedSetup.Status::" ");

    end;

    [IntegrationEvent(false, false)]
    procedure OnADLAssistedSetupCompleted(PageId: Integer)
    begin
    end;

}