//%attributes = {}
  // 0xDev_DetectaDuplicados()
  // Por: Alberto Bachler K.: 20-12-13, 15:18:25
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_BOOLEAN:C305($2)

C_BOOLEAN:C305($b_seleccionarTodo)
C_LONGINT:C283($l_tipoCampo)
C_POINTER:C301($y_Campo;$y_tabla)
C_TEXT:C284($t_ultimoLlave;$t_valorCampo)


If (False:C215)
	C_POINTER:C301(0xDev_DetectaDuplicados ;$1)
	C_BOOLEAN:C305(0xDev_DetectaDuplicados ;$2)
End if 


Case of 
	: (Count parameters:C259=0)
		$y_Campo:=0xDev_SeleccionCampo 
		If (Not:C34(Is nil pointer:C315($y_Campo)))
			$y_tabla:=Table:C252(Table:C252($y_Campo))
		End if 
		$b_seleccionarTodo:=True:C214
		
	: (Count parameters:C259=1)
		$y_tabla:=Table:C252(Table:C252($1))
		$y_Campo:=$1
		$b_seleccionarTodo:=True:C214
		OK:=1
		
	: (Count parameters:C259=2)
		$y_tabla:=Table:C252(Table:C252($1))
		$y_Campo:=$1
		$b_seleccionarTodo:=$2
		OK:=1
End case 
If (ok=1)
	$l_tipoCampo:=Type:C295($y_Campo->)
	
	If ($b_seleccionarTodo)
		ALL RECORDS:C47($y_tabla->)
	End if 
	ORDER BY:C49($y_tabla->;$y_Campo->)
	CREATE EMPTY SET:C140($y_tabla->;"duplis")
	$t_ultimoLlave:=""
	While (Not:C34(End selection:C36($y_tabla->)))
		If (($l_tipoCampo#0) & ($l_tipoCampo#2))
			$t_valorCampo:=String:C10($y_Campo->)
		Else 
			$t_valorCampo:=$y_Campo->
		End if 
		If ($t_valorCampo=$t_ultimoLlave)
			ADD TO SET:C119($y_tabla->;"duplis")
			PREVIOUS RECORD:C110($y_tabla->)
			ADD TO SET:C119($y_tabla->;"duplis")
			NEXT RECORD:C51($y_tabla->)
		End if 
		If (($l_tipoCampo#0) & ($l_tipoCampo#2))
			$t_ultimoLlave:=String:C10($y_Campo->)
		Else 
			$t_ultimoLlave:=$y_Campo->
		End if 
		NEXT RECORD:C51($y_tabla->)
	End while 
	USE SET:C118("Duplis")
	CLEAR SET:C117("duplis")
End if 

