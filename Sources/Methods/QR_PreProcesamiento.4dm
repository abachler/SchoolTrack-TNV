//%attributes = {}
  // QR_PreProcesamiento()
  // Por: Alberto Bachler K.: 24-08-15, 14:25:27
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_POINTER:C301($1)
C_LONGINT:C283($2)
C_BLOB:C604($x_blob)
C_LONGINT:C283($l_error;$l_recNumInforme;$l_refArea;$l_scriptEjecutado)
ARRAY LONGINT:C221($al_recnums;0)

If (False:C215)
	C_POINTER:C301(QR_PreProcesamiento ;$1)
	C_LONGINT:C283(QR_PreProcesamiento ;$2)
End if 

$y_tabla:=$1
$l_recNumInforme:=$2
If (Count parameters:C259=3)
	$y_recnums:=$3
Else 
	$y_recnums:=->$al_recnums
End if 

If (Record number:C243([xShell_Reports:54])#$l_recNumInforme)
	KRL_GotoRecord (->[xShell_Reports:54];$l_recNumInforme;False:C215)
End if 


dhQR_PrePrintInstructions 
ok:=1
If (([xShell_Reports:54]RelatedTable:14#0) & (Table:C252(->[xShell_Reports:54]RelatedTable:14)#Table:C252($y_tabla)))
	$y_Tabla:=Table:C252([xShell_Reports:54]RelatedTable:14)
	If ([xShell_Reports:54]SourceField:13#0)
		vyQR_StartField:=Field:C253([xShell_Reports:54]MainTable:3;[xShell_Reports:54]SourceField:13)
	End if 
	If ([xShell_Reports:54]RelatedField:15#0)
		vyQR_EndField:=Field:C253([xShell_Reports:54]RelatedTable:14;[xShell_Reports:54]RelatedField:15)
	End if 
Else 
	$y_Tabla:=Table:C252(Abs:C99([xShell_Reports:54]MainTable:3))
End if 
OK:=QR_SetUnivers (Abs:C99([xShell_Reports:54]MainTable:3);[xShell_Reports:54]RelatedTable:14)

If ((OK=1) & ([xShell_Reports:54]ExecuteBeforePrinting:4#""))
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	EXE_Execute ([xShell_Reports:54]ExecuteBeforePrinting:4)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
End if 

If (OK=1)
	If ([xShell_Reports:54]isOneRecordReport:11)
		SELECTION TO ARRAY:C260($y_Tabla->;$y_recNums->)
		If (Size of array:C274($y_recNums->)>0)  //186282 ABC
			GOTO RECORD:C242($y_Tabla->;$y_recNums->{1})
		End if 
	Else 
		APPEND TO ARRAY:C911($y_recNums->;-100)  //MONO 205131 para entrar al for que está en QR_imprimeinformeSRP pero el goto record se hace sólo cuando el informe es un documento por registro.
	End if 
End if 

