; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define AppName "pandoc-plot"
#define AppEXEName "pandoc-plot.exe"
#define AppPublisher "Laurent P. René de Cotret"
#define AppURL "https://github.com/LaurentRDC/pandoc-plot"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{4AD298C3-6FD5-49B2-9E4A-8FEB19C63640}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
DefaultDirName={pf}\{#AppName}
DisableProgramGroupPage=yes
ChangesEnvironment=true
LicenseFile=..\LICENSE
OutputDir=.\setup-{#AppVersion}
OutputBaseFilename={#AppName}-wininst-{#AppVersion}
Compression=lzma2/ultra64
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: ".\pandoc-plot.exe"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Tasks]
Name: "modifypath"; Description: "Add pandoc-pyplot executable to path"; Flags: checkedonce

[Run]
Filename: "{app}\{#AppEXEName}"; Description: "{cm:LaunchProgram,{#StringChange(AppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
const 
    ModPathName = 'modifypath'; 
    ModPathType = 'user'; 

function ModPathDir(): TArrayOfString; 
begin 
    setArrayLength(Result, 1) 
    Result[0] := ExpandConstant('{app}'); 
end; 
#include "modpath.iss"