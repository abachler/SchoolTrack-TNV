//%attributes = {}
  // MÉTODO: CIM_GotoPage_FTP
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/06/11, 16:35:55
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // CIM_GotoPage_FTP()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL
HL_ClearList (hlCIM_FTPDirectories;vl_CurrentBrowserHList)
ARRAY TEXT:C222(atFTP_ObjectNames;0)
ARRAY LONGINT:C221(alFTP_ObjectSize;0)
ARRAY LONGINT:C221(alFTP_ObjectTime;0)
ARRAY DATE:C224(adFTP_ObjectDate;0)
ARRAY INTEGER:C220(aiFTP_ObjectKInd;0)
ARRAY TEXT:C222(atFTP_ObjectSize;0)
ARRAY PICTURE:C279(apFTP_ObjectIcon;0)
CIM_FTP_OpenConnexion 
CIM_FTP_ExploradorLocal 
GOTO OBJECT:C206(hlCIM_LocalBrowser_FTP)