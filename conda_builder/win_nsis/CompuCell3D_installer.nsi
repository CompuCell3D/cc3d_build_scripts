############################################################################################
#      NSIS Installation Script created by NSIS Quick Setup Script Generator v1.09.18
#               Entirely Edited with NullSoft Scriptable Installation System
#              by Vlasis K. Barkas aka Red Wine red_wine@freemail.gr Sep 2006
############################################################################################

; uncomment section below and set CC3D_VERSION and BUILD_NUMBER when building manually
; command to use is:
; "C:/Program Files (x86)/NSIS/makensis.exe" /V1 d:\CC3D_FILES_SVN\binaries\4.3.2\CompuCell3D_installer.nsi

; !define CC3D_VERSION "4.3.2"
; !define CC3D_BUILD_NUMBER "1"

!define VERSION "${CC3D_VERSION}.${CC3D_BUILD_NUMBER}"
!define INSTALLATION_SOURCE_DIR "D:\install_projects\${VERSION}"
!define INSTALLER_NAME "D:\CC3D_FILES_SVN\binaries\${VERSION}\windows\CompuCell3D-setup-${VERSION}.exe"

!define APP_NAME "CompuCell3D"
!define TWEDIT_APP_NAME "Twedit++"
!define COMP_NAME "Biocomplexity Institute"
!define WEB_SITE "http://www.compucell3d.org"

!define COPYRIGHT "Biocomplexity Institute � 2008"
!define DESCRIPTION "Application"
!define MAIN_APP_EXE "compucell3d.bat"
!define INSTALL_TYPE "SetShellVarContext all"
!define REG_ROOT "HKLM"
!define REG_APP_NAME "compucell3d_py3"
!define REG_APP_PATH "Software\Microsoft\Windows\CurrentVersion\App Paths\${REG_APP_NAME}"
!define UNINSTALL_PATH "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"

!define REG_START_MENU "Start Menu Folder"
### CUSTOM MODIFICATION
!include "FileFunc.nsh"
!define TWEDIT_EXE "twedit++.bat"


!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\cc3d_128x128_logo_setup.ico"

Var PYTHON_PATH27         ; holding the python path
Var numpyErrorCode        ; holding error code for numpy import attempt
Var win32guiErrorCode        ; holding error code for win32gui import attempt


Var CURRENT_UNINSTALLER         ; name of the current uninstaller

InstallDir ""

Function .onInit
; ${GetRoot} "$PROGRAMFILES" $SUGGESTED_INSTALL_PATH
    ${GetRoot} "$PROGRAMFILES" $R0
    ; MessageBox MB_OK " Installation dir $R0"
    ; strcpy $SUGGESTED_INSTALL_PATH $R0

    StrCpy $InstDir "$R0\CompuCell3D"
    ;StrCpy $InstDir "$R0\CC3D"

FunctionEnd
### END OF CUSTOM MODIFICATION

var SM_Folder

######################################################################

VIProductVersion  "${VERSION}"
VIAddVersionKey "ProductName"  "${APP_NAME}"
VIAddVersionKey "CompanyName"  "${COMP_NAME}"
VIAddVersionKey "LegalCopyright"  "${COPYRIGHT}"
VIAddVersionKey "FileDescription"  "${DESCRIPTION}"
VIAddVersionKey "FileVersion"  "${VERSION}"

######################################################################

SetCompressor ZLIB
Name "${APP_NAME}"
Caption "${APP_NAME}"
OutFile "${INSTALLER_NAME}"
BrandingText "${APP_NAME}"
XPStyle on
InstallDirRegKey "${REG_ROOT}" "${REG_APP_PATH}" ""
InstallDir "$PROGRAMFILES\CompuCell3D-py3-64bit"

######################################################################

!include "MUI.nsh"

!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING

!insertmacro MUI_PAGE_WELCOME

!ifdef LICENSE_TXT
!insertmacro MUI_PAGE_LICENSE "${LICENSE_TXT}"
!endif

!insertmacro MUI_PAGE_DIRECTORY

!ifdef REG_START_MENU
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "CompuCell3D"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${REG_ROOT}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${UNINSTALL_PATH}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${REG_START_MENU}"
!insertmacro MUI_PAGE_STARTMENU Application $SM_Folder
!endif

!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM

!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

######################################################################
### CUSTOM MODIFICATION
Section -Uninstaller

    strcpy $CURRENT_UNINSTALLER ""
    ReadRegStr $CURRENT_UNINSTALLER ${REG_ROOT} "${UNINSTALL_PATH}\" "UninstallString"
    strcmp $CURRENT_UNINSTALLER "" "" foundUninstaller
    goto notfoundUninstaller
    foundUninstaller:
        ;MessageBox MB_OK "Exsisting copy of CompuCell3D will be uninstalled now.$\nPLEASE make sure to backup existing simulation"
        MessageBox MB_YESNO "Found existing CompuCell3D installation.$\nWould you like unistall it now (recommended)?$\n Before uninstalling PLEASE backup existing simulations" /SD IDYES IDNO NoUninstall

        ; ExecWait "$CURRENT_UNINSTALLER"
        ExecWait '"$CURRENT_UNINSTALLER" _?=$INSTDIR'
        MessageBox MB_OK " Uninstall Succesful "
        goto uninstallSectionComplete
        NoUninstall:
            MessageBox MB_OK " No uninstallation performed "
            goto uninstallSectionComplete

    notfoundUninstaller:
    uninstallSectionComplete:

SectionEnd


Section -Prerequisites

  SetOutPath "$INSTDIR"
    File "${INSTALLATION_SOURCE_DIR}\Demos.zip"

  SetOutPath "$INSTDIR\Prerequisites"
    File "${INSTALLATION_SOURCE_DIR}\Prerequisites\Miniconda3-py37_4.10.3-Windows-x86_64.exe"    
    ExecWait "$INSTDIR\Prerequisites\Miniconda3-py37_4.10.3-Windows-x86_64.exe /InstallationType=JustMe /RegisterPython=0 /S /D=$INSTDIR\Miniconda3"
    ;using python to decompress demos
    ExecWait "$INSTDIR\Miniconda3\python -m zipfile -e $INSTDIR\Demos.zip $INSTDIR\Demos"

    File "${INSTALLATION_SOURCE_DIR}\Prerequisites\cc3d-install.bat"
    ExecWait "$INSTDIR\Prerequisites\cc3d-install.bat ${CC3D_VERSION} & pause"

SectionEnd


### CUSTOM MODIFICATION
######################################################################


Section -MainProgram
${INSTALL_TYPE}
SetOverwrite ifnewer
SetOutPath "$INSTDIR"
File "${INSTALLATION_SOURCE_DIR}\cc3d.bat"
File "${INSTALLATION_SOURCE_DIR}\compucell3d.bat"
File "${INSTALLATION_SOURCE_DIR}\conda-shell.bat"
File "${INSTALLATION_SOURCE_DIR}\runScript.bat"
File "${INSTALLATION_SOURCE_DIR}\paramScan.bat"
File "${INSTALLATION_SOURCE_DIR}\twedit++.bat"
SetOutPath "$INSTDIR\Prerequisites"
File "${INSTALLATION_SOURCE_DIR}\Prerequisites\Miniconda3-py37_4.10.3-Windows-x86_64.exe"
File "${INSTALLATION_SOURCE_DIR}\Prerequisites\cc3d-install.bat"
File "${INSTALLATION_SOURCE_DIR}\Prerequisites\cc3d-uninstall.bat"
SetOutPath "$INSTDIR\icons"
File "${INSTALLATION_SOURCE_DIR}\icons\cc3d_128x128_logo.ico"
File "${INSTALLATION_SOURCE_DIR}\icons\cc3d_256x256_logo.ico"
File "${INSTALLATION_SOURCE_DIR}\icons\cc3d_64x64_logo.ico"
File "${INSTALLATION_SOURCE_DIR}\icons\twedit-icon.ico"

### CUSTOM MODIFICATION
DetailPrint "Postinstallation ..."
 #removing unnecessary files
 Delete "$INSTDIR\Prerequisites\Miniconda3-py37_4.10.3-Windows-x86_64.exe"
 Delete "$INSTDIR\Demos.zip"

### END OF CUSTOM MODIFICATION
SectionEnd

######################################################################
### CUSTOM MODIFICATION - Make sure to change uninstall.exe to uninstall-cc3d.exe everywhere in the installer script
Section -Icons_Reg


SetOutPath "$INSTDIR"
WriteUninstaller "$INSTDIR\uninstall-cc3d.exe"

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
CreateDirectory "$SMPROGRAMS\$SM_Folder"
CreateShortCut "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}" "" "$INSTDIR\icons\cc3d_128x128_logo.ico"
CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}" "" "$INSTDIR\icons\cc3d_128x128_logo.ico"
CreateShortCut "$SMPROGRAMS\$SM_Folder\Twedit++.lnk" "$INSTDIR\${TWEDIT_EXE}" "" "$INSTDIR\icons\twedit-icon.ico"
CreateShortCut "$DESKTOP\${TWEDIT_APP_NAME}.lnk" "$INSTDIR\${TWEDIT_EXE}" "" "$INSTDIR\icons\twedit-icon.ico"
CreateShortCut "$SMPROGRAMS\$SM_Folder\Uninstall ${APP_NAME}.lnk" "$INSTDIR\uninstall-cc3d.exe"

!ifdef WEB_SITE

WriteIniStr "$INSTDIR\${APP_NAME} website.url" "InternetShortcut" "URL" "${WEB_SITE}"
CreateShortCut "$SMPROGRAMS\$SM_Folder\${APP_NAME} Website.lnk" "$INSTDIR\${APP_NAME} website.url" "Website logo" "$INSTDIR\icons\cc3d_64x64_logo_www.ico"


!endif
!insertmacro MUI_STARTMENU_WRITE_END
!endif
WriteRegStr ${REG_ROOT} "${REG_APP_PATH}" "" "$INSTDIR\${MAIN_APP_EXE}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayName" "${APP_NAME}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "UninstallString" "$INSTDIR\uninstall-cc3d.exe"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayIcon" "$INSTDIR\${MAIN_APP_EXE}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayVersion" "${VERSION}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "Publisher" "${COMP_NAME}"

!ifdef WEB_SITE
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "URLInfoAbout" "${WEB_SITE}"
!endif
SectionEnd
### END OF CUSTOM MODIFICATION
######################################################################

Section Uninstall
${INSTALL_TYPE}
ExecWait "$INSTDIR\Prerequisites\cc3d-uninstall.bat"

Delete "$INSTDIR\cc3d.bat"
Delete "$INSTDIR\compucell3d.bat"
Delete "$INSTDIR\conda-shell.bat"
Delete "$INSTDIR\runScript.bat"
Delete "$INSTDIR\paramScan.bat"
Delete "$INSTDIR\twedit++.bat"
Delete "$INSTDIR\Prerequisites\cc3d-install.bat"
Delete "$INSTDIR\Prerequisites\cc3d-uninstall.bat"


Delete "$INSTDIR\icons\cc3d_128x128_logo.ico"
Delete "$INSTDIR\icons\cc3d_256x256_logo.ico"
Delete "$INSTDIR\icons\cc3d_64x64_logo.ico"
Delete "$INSTDIR\icons\twedit-icon.ico"


RmDir "$INSTDIR\Prerequisites\"
RmDir "$INSTDIR\icons\"
RmDir "$INSTDIR\"

######################################################################
### CUSTOM MODIFICATION
Delete "$INSTDIR\uninstall-cc3d.exe"
!ifdef WEB_SITE
Delete "$INSTDIR\${APP_NAME} website.url"

!endif

RmDir "$INSTDIR"

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_GETFOLDER "Application" $SM_Folder
Delete "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk"
Delete "$SMPROGRAMS\$SM_Folder\Uninstall ${APP_NAME}.lnk"
Delete "$SMPROGRAMS\$SM_Folder\Twedit++.lnk"
!ifdef WEB_SITE
Delete "$SMPROGRAMS\$SM_Folder\${APP_NAME} Website.lnk"

!endif
Delete "$DESKTOP\${APP_NAME}.lnk"
Delete "$DESKTOP\${TWEDIT_APP_NAME}.lnk"

RmDir "$SMPROGRAMS\$SM_Folder"
!endif

DeleteRegKey ${REG_ROOT} "${REG_APP_PATH}"
DeleteRegKey ${REG_ROOT} "${UNINSTALL_PATH}"

SectionEnd

### END OF CUSTOM MODIFICATION
######################################################################
