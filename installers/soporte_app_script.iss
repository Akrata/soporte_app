; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Soporte_App"
#define MyAppVersion "1.0"
#define MyAppPublisher "Pablo Feijo"
#define MyAppExeName "soporte_app.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{FE042C84-6B01-451F-8FED-DE69DA9AB339}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=C:\Users\Pablo\Documents\Dev\Flutter\soporte_app\installers
OutputBaseFilename=Soporte_App_V1.0
SetupIconFile=C:\Users\Pablo\Documents\Dev\Flutter\soporte_app\installers\apoyo-tecnico.ico
Password=piedra00
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\Pablo\Documents\Dev\Flutter\soporte_app\build\windows\runner\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Pablo\Documents\Dev\Flutter\soporte_app\build\windows\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Pablo\Documents\Dev\Flutter\soporte_app\build\windows\runner\Release\pdfium.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Pablo\Documents\Dev\Flutter\soporte_app\build\windows\runner\Release\printing_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Pablo\Documents\Dev\Flutter\soporte_app\build\windows\runner\Release\screen_retriever_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Pablo\Documents\Dev\Flutter\soporte_app\build\windows\runner\Release\url_launcher_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Pablo\Documents\Dev\Flutter\soporte_app\build\windows\runner\Release\window_manager_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Pablo\Documents\Dev\Flutter\soporte_app\build\windows\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

