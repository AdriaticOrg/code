codeunit 13062814 "Adl Core Subscriber-Adl"
{
    var
        ADLCoreNotification: Codeunit "Adl Core Notification-Adl";

    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnRegisterAssistedSetup', '', false, false)]
    local procedure HandleOnRegisterAggregatedSetup(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" temporary)
    var
        ADLAssistedSetup: Record "ADL Assisted Setup-Adl";
    begin
        ADLAssistedSetup.Initialize();

        ADLAssistedSetup.SetRange(Visible, true);
        ADLAssistedSetup.SetFilter("Assisted Setup Page ID", '%1', Page::"ADL Setup Wizard-Adl");

        CLEAR(TempAggregatedAssistedSetup);
        TempAggregatedAssistedSetup.TransferFields(ADLAssistedSetup, TRUE);
        TempAggregatedAssistedSetup."External Assisted Setup" := FALSE;
        TempAggregatedAssistedSetup."Record ID" := ADLAssistedSetup.RecordId();
        TempAggregatedAssistedSetup.Insert();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Assisted ADL Setup Wizard-Adl", 'OnOpenPageEvent', '', false, false)]
    local procedure HandleOnPageEventADLWizard()
    var
        ADLAssistedSetup: Record "ADL Assisted Setup-Adl";
    begin
        If not ADLAssistedSetup.GET(Page::"ADL Setup Wizard-Adl") then
            ADLAssistedSetup.Initialize();
    end;

    [EventSubscriber(ObjectType::Page, page::"My Notifications", 'OnInitializingNotificationWithDefaultState', '', false, false)]
    procedure OnInitializingNotificationWithDefaultStat();
    var
        MyNotifications: Record "My Notifications";
        AdlCoreNotification: Codeunit "Adl Core Notification-Adl";
        SetupADLTxt: Label 'Ask to setup Adriatic Localization.';
        SetupADLDescriptionTxt: Label 'If you have installed Adriatic Localization but don''t want to use it, switch off receiving the notification.';
    begin
        MyNotifications.InsertDefault(AdlCoreNotification.GetCoreSetupNotificationId(),
             CopyStr(SetupADLTxt, 1, 128),
             SetupADLDescriptionTxt,
             true
        );
    end;

    [EventSubscriber(ObjectType::Page, Page::"Headline RC Business Manager", 'OnOpenPageEvent', '', false, false)]
    local procedure OnRCBusinessManagerOpen(rec: Record "Headline RC Business Manager")
    begin
        ADLCoreNotification.ShowSetupNotification();
    end;

    [EventSubscriber(ObjectType::Page, page::"SO Processor Activities", 'OnOpenPageEvent', '', false, false)]
    procedure OnSOProcessorActivitiesOpen()
    begin
        ADLCoreNotification.ShowSetupNotification();
    end;

}