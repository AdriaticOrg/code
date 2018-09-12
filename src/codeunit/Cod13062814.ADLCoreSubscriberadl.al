codeunit 13062814 "Adl Core Subscriber-adl"
{
    var
        ADLCoreNotification: Codeunit "Adl Core Notification-adl";

    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnRegisterAssistedSetup', '', false, false)]
    local procedure HandleOnRegisterAggregatedSetup(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" temporary)
    var
        ADLAssistedSetup: Record "ADL Assisted Setup-adl";
    begin
        ADLAssistedSetup.Initialize();

        ADLAssistedSetup.SetRange(Visible, true);
        ADLAssistedSetup.SetFilter("Assisted Setup Page ID", '%1', Page::"ADL Setup Wizard-adl");

        CLEAR(TempAggregatedAssistedSetup);
        TempAggregatedAssistedSetup.TransferFields(ADLAssistedSetup, TRUE);
        TempAggregatedAssistedSetup."External Assisted Setup" := FALSE;
        TempAggregatedAssistedSetup."Record ID" := ADLAssistedSetup.RecordId();
        TempAggregatedAssistedSetup.Insert();
    end;

    [EventSubscriber(ObjectType::Page, Page::"ADL Setup Wizard-adl", 'OnOpenPageEvent', '', false, false)]
    local procedure HandleOnPageEventADLWizard()
    var
        ADLAssistedSetup: Record "ADL Assisted Setup-adl";
    begin
        If not ADLAssistedSetup.GET(Page::"ADL Setup Wizard-adl") then
            ADLAssistedSetup.Initialize();
    end;

    [EventSubscriber(ObjectType::Page, page::"My Notifications", 'OnInitializingNotificationWithDefaultState', '', false, false)]
    procedure OnInitializingNotificationWithDefaultStat();
    var
        MyNotifications: Record "My Notifications";
        AdlCoreNotification: Codeunit "Adl Core Notification-adl";
        SetupADLTxt: Label 'Ask to setup Adriatic Localization.';
        SetupADLDescriptionTxt: Label 'If you have installed Adriatic Localization but don''t want to use it, switch off receiving the notification.';
    begin
        MyNotifications.InsertDefault(AdlCoreNotification.GetCoreSetupNotificationId(),
             SetupADLTxt,
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