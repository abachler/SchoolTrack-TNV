//%attributes = {}
C_POINTER:C301($y_Nil)
  //TMT_AsistImport_Open
  //$l_refVentana:=Open form window("TMT_AsistenteImportacion";Plain form window;Horizontally centered;At the top)
  //SET WINDOW TITLE(__ ("Importador de Horarios");$l_refVentana)
  //DIALOG("TMT_AsistenteImportacion")
  //CLOSE WINDOW
  //Open window
WDW_OpenFormWindow ($y_Nil;"TMT_AsistenteImportacion";-1;8;__ ("Importador de Horarios"))
DIALOG:C40("TMT_AsistenteImportacion")
CLOSE WINDOW:C154