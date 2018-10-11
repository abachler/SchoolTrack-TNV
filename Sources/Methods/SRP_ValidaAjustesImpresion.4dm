//%attributes = {}
  // SRP_ValidaAjustesImpresion()
  // Por: Alberto Bachler K.: 24-08-15, 13:32:22
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_BLOB:C604($0)  //Modificado por: Saúl Ponce (06-07-2017) Ticket 182634, declaración del retorno

C_BLOB:C604($x_blob)
C_LONGINT:C283($l_error;$l_recNumInforme;$l_refArea)


If (False:C215)
	C_LONGINT:C283(SRP_ValidaAjustesImpresion ;$1)
End if 

$l_recNumInforme:=$1

If (Record number:C243([xShell_Reports:54])#$l_recNumInforme)
	KRL_GotoRecord (->[xShell_Reports:54];$l_recNumInforme;False:C215)
End if 

$l_error:=SR_NewReportBLOB ($l_refArea;[xShell_Reports:54]xReportData_:29)

If (Macintosh option down:C545 | Windows Alt down:C563)
	$l_error:=SR_PrintSettings ($l_refArea;SRP_Print_ValidatePageSetup)
	$l_error:=SR_PrintSettings ($l_refArea;SRP_Print_AskJobSetup)  // MOD Ticket N° 209532 PA 20180616
Else 
	$l_error:=SR_PrintSettings ($l_refArea;SRP_Print_DefaultPageSetup | SRP_Print_SimplePageSetup)
End if 

  //20180925 ASM Ticket 215453
$l_error:=SR Get Area ($l_refArea;$x_blob)
If (BLOB_CompareBlobs (->[xShell_Reports:54]xReportData_:29;->$x_blob)=0)
	KRL_GotoRecord (->[xShell_Reports:54];$l_recNumInforme;True:C214)
	[xShell_Reports:54]xReportData_:29:=$x_blob
End if 

SR_DeleteReport ($l_refArea)


  // Modificado por: Saúl Ponce (06-07-2017) Ticket 182634, retorna el blob que contiene el reporte
$0:=[xShell_Reports:54]xReportData_:29