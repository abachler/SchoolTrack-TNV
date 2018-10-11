//%attributes = {}
  // BBLci_CambiaEstadoSuspensión()
  // Por: Alberto Bachler K.: 22-05-14, 18:29:19
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_DATE:C307($d_fechaSuspension)
C_LONGINT:C283($1;$2;$l_diasSuspension;$l_recNumLector)

$l_recNumLector:=$1
$l_diasSuspension:=$2

$d_fechaSuspension:=Current date:C33(*)+$l_diasSuspension
If ($d_fechaSuspension>[BBL_Lectores:72]Fecha_Suspención:45)
	KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;True:C214)
	[BBL_Lectores:72]Fecha_Suspención:45:=$d_fechaSuspension
	
	WDW_OpenFormWindow (->[BBL_Lectores:72];"Suspension";-1;Movable form dialog box:K39:8;__ ("Suspensión del lector por devolución tardía"))
	DIALOG:C40([BBL_Lectores:72];"Suspension")
	CLOSE WINDOW:C154
	SAVE RECORD:C53([BBL_Lectores:72])
	
	Case of 
		: (OK=1)
			$t_glosa:=__ ("Lector suspendido hasta el ^0 por devolución tardía")
			$t_glosa:=Replace string:C233($t_glosa;"^0";String:C10([BBL_Lectores:72]Fecha_Suspención:45;Internal date short special:K1:4))
			BBLci_registroEnLog (Suspension_lector;Record number:C243([BBL_Lectores:72]);Record number:C243([BBL_Registros:66]);Record number:C243([BBL_Items:61]);$t_glosa)
			
		: (OK=0)
			$t_glosa:=__ ("Suspensión no aplicada")
			BBLci_registroEnLog (Suspension_lector;Record number:C243([BBL_Lectores:72]);Record number:C243([BBL_Registros:66]);Record number:C243([BBL_Items:61]);$t_glosa)
			
	End case 
	
End if 

