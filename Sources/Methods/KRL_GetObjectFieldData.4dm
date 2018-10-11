//%attributes = {}
  // KRL_GetObjectFieldData()
  //
  //
  // creado por: Alberto Bachler Klein: 18-12-15, 10:50:14
  // -----------------------------------------------------------
C_OBJECT:C1216($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_BOOLEAN:C305($b_empilaRegistro)
C_LONGINT:C283($l_recNum)
C_POINTER:C301($y_CampoData;$y_CampoLlave;$y_tabla;$y_Valor)


If (False:C215)
	C_OBJECT:C1216(KRL_GetObjectFieldData ;$0)
	C_POINTER:C301(KRL_GetObjectFieldData ;$1)
	C_POINTER:C301(KRL_GetObjectFieldData ;$2)
	C_POINTER:C301(KRL_GetObjectFieldData ;$3)
End if 

$b_empilaRegistro:=False:C215

$y_CampoLlave:=$1
$y_Valor:=$2
$y_CampoData:=$3
$y_tabla:=Table:C252(Table:C252($y_CampoLlave))

$l_recNum:=Find in field:C653($y_CampoLlave->;$y_Valor->)

If ($l_recNum>=0)
	If ($l_recNum#Record number:C243($y_tabla->))
		$b_empilaRegistro:=False:C215
		If ((Record number:C243($y_tabla->)>=0) & (Trigger level:C398=0))  //si hay un registro cargado para la misma tabla lo pongo en la pila para reestablecerlo al salir
			PUSH RECORD:C176($y_tabla->)
			$b_empilaRegistro:=True:C214
		End if 
		
		If ($l_recNum>=0)
			KRL_GotoRecord ($y_tabla;$l_recNum)
			If (OK=1)
				$0:=$y_CampoData->
			End if 
		End if 
		
		If ($b_empilaRegistro)  //saco el record de la pila reestableciéndolo como registro corriente
			POP RECORD:C177($y_tabla->)
		End if 
		
	Else 
		If ($y_Valor->#$y_CampoLlave->)  //JHB 20110727 work around para cuando $l_recNum=Record number($y_tabla->) pero el registro no esta cargado... raro, raro, raro!!!
			UNLOAD RECORD:C212($y_tabla->)
			KRL_GotoRecord ($y_tabla;$l_recNum)
		End if 
		$0:=$y_CampoData->
	End if 
End if 