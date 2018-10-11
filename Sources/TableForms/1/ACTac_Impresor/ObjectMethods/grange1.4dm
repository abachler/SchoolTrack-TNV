  //20131104 ASM Ticket 126613 , Se quita validación de Sender.
  //If (SYS_IsWindows )
  //  //If (Application version>="13@")
  //  //  //If (Find in array(atACT_SystemPrinters;"PDFCreator@")#-1)
  //  //OBJECT SET ENABLED(bHidePrintSettings;False)
  //  //  //$mailLic:=DL_IsModuleLicensed (1;CommTrack Light)
  //  //  //OBJECT SET ENABLED(bPDF2Mail;$mailLic)
  //  //OBJECT SET ENABLED(bPDF2Mail;True)
  //  //  //Else 
  //  //  //b1:=1
  //  //  //b2:=0
  //  //  //OBJECT SET ENABLED(bHidePrintSettings;True)
  //  //  //OBJECT SET ENABLED(*;"pdf@";False)
  //  //  //CD_Dlog (0;__ ("En este equipo debe tener instalada la impresora PDFCreator."))
  //  //  //End if 
  //  //Else 
  //OBJECT SET ENABLED(bHidePrintSettings;False)
  //  //$mailLic:=DL_IsModuleLicensed (1;CommTrack Light)
  //  //OBJECT SET ENABLED(bPDF2Mail;$mailLic)
  //OBJECT SET ENABLED(bPDF2Mail;True)
  //  //End if 
  //Else 
  //OBJECT SET ENABLED(bHidePrintSettings;False)
  //  //$mailLic:=DL_IsModuleLicensed (1;CommTrack Light)
  //  //OBJECT SET ENABLED(bPDF2Mail;$mailLic)
  //OBJECT SET ENABLED(bPDF2Mail;True)
  //End if 
OBJECT SET ENABLED:C1123(bHidePrintSettings;False:C215)
OBJECT SET ENABLED:C1123(bPDF2Mail;True:C214)