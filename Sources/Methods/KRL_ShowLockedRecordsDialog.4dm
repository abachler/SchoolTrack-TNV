//%attributes = {}
  //KRL_ShowLockedRecordsDialog

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : mu_LockCtrlMsg
	  //Autor: Alberto Bachler
	  //Creada el 25/6/96 a 11:09 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
  //WDW_OpenFormWindow (->[xShell_Dialogs];"LockedToApply";0;1984;"Registros Ocupados")
  //DIALOG([xShell_Dialogs];"LockedToApply")
  //CLOSE WINDOW
  //$0:=OK

  //Modificado el 14/4/2008 por JHB
$r:=CD_Dlog (0;__ ("Algunos de los registros que deben ser actualizados están siendo utilizados por otros usuarios.\r¿Desea Ud. esperar hasta que sean liberados o cancelar la modificación?");__ ("");__ ("Esperar que se liberen");__ ("Cancelar"))
If ($r=1)
	$0:=1
Else 
	$0:=0
End if 