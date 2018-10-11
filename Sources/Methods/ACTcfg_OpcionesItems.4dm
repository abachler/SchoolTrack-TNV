//%attributes = {}
  //ACTcfg_OpcionesItems
  // ----------------------------------------------------
  // Nombre usuario (OS): roberto
  // Fecha y hora: 30-07-10, 17:14:25
  // ----------------------------------------------------
  // Método: ACTcfg_OpcionesItems
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------
C_TEXT:C284($vt_accion;$1)
C_POINTER:C301($ptr1)
C_POINTER:C301(${2})
C_LONGINT:C283($month)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="ColoreaMeses")
		For ($i;1;12)
			ACTcfg_OpcionesItems ("ColoreaMes";->$i)
		End for 
		
	: ($vt_accion="ColoreaMes")
		$buttonPointer:=Get pointer:C304("bMes"+String:C10($ptr1->))
		If ([xxACT_Items:179]Meses_de_cargo:9 ?? $ptr1->)
			$buttonPointer->:=1
			OBJECT SET COLOR:C271(*;"mes"+String:C10($ptr1->);-9)
		Else 
			$buttonPointer->:=0
			OBJECT SET COLOR:C271(*;"mes"+String:C10($ptr1->);-3)
		End if 
		
	: ($vt_accion="AsignaMes")
		$month:=$ptr1->
		If ([xxACT_Items:179]Meses_de_cargo:9 ?? $month)
			[xxACT_Items:179]Meses_de_cargo:9:=[xxACT_Items:179]Meses_de_cargo:9 ?- $month
		Else 
			[xxACT_Items:179]Meses_de_cargo:9:=[xxACT_Items:179]Meses_de_cargo:9 ?+ $month
		End if 
		ACTcfg_OpcionesItems ("ColoreaMes";->$month)
		
	: ($vt_accion="MuestraAlerta")
		CD_Dlog (0;__ ("Los ítems de venta directa no utilizan la configuración de meses."))
		
End case 