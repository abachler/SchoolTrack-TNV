//%attributes = {}
  // KRL_DeleteRecord()
  // Por: Alberto Bachler: 25/06/13, 17:29:21
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_SoloLectura)
C_LONGINT:C283($l_recNum)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_MetodoGestionErrorActual)

If (False:C215)
	C_LONGINT:C283(KRL_DeleteRecord ;$0)
	C_POINTER:C301(KRL_DeleteRecord ;$1)
	C_LONGINT:C283(KRL_DeleteRecord ;$2)
End if 
$y_tabla:=$1

If (Count parameters:C259=2)
	$l_recNum:=$2
Else 
	$l_recNum:=Record number:C243($y_tabla->)
End if 

  //CUERPO
$b_SoloLectura:=Read only state:C362($y_tabla->)
KRL_GotoRecord ($y_tabla;$l_recNum;True:C214)
If (OK=1)
	error:=0
	$t_MetodoGestionErrorActual:=Method called on error:C704
	ON ERR CALL:C155("ERR_GenericOnError")  //llamo la rutina de interrupcion de error en caso que el trigger devuelva algun error
	DELETE RECORD:C58($y_tabla->)
	ON ERR CALL:C155($t_MetodoGestionErrorActual)
	
	If ($b_SoloLectura)
		READ ONLY:C145($y_tabla->)
	End if 
	
	If (Error#0)
		OK:=0
	End if 
End if 

$0:=OK
