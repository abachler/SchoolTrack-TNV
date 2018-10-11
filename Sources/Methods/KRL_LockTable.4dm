//%attributes = {}
  // KRL_LockTable()
  //
  //
  // creado por: Alberto Bachler Klein: 18-11-16, 09:11:29
  // -----------------------------------------------------------
C_POINTER:C301($1)

C_BOOLEAN:C305($b_indexado;$b_unico)
C_LONGINT:C283($l_error;$l_largo;$l_tipo)
C_POINTER:C301($y_PrimaryKey;$y_tabla)
C_TEXT:C284($t_nombreTabla)
C_OBJECT:C1216($ob_Resultado)

ARRAY OBJECT:C1221($ao_registrosBloqueados;0)



If (False:C215)
	C_POINTER:C301(KRL_LockTable ;$1)
End if 

If (In transaction:C397)
	$y_tabla:=$1
	$t_nombreTabla:=Table name:C256($y_tabla)
	$ob_Resultado:=Get locked records info:C1316($y_tabla->)
	OB GET ARRAY:C1229($ob_Resultado;"records";$ao_registrosBloqueados)
	
	If (Size of array:C274($ao_registrosBloqueados)=0)
		$y_PrimaryKey:=KRL_GetPrimaryKey ($y_tabla)
		If (Not:C34(Is nil pointer:C315($y_PrimaryKey)))
			GET FIELD PROPERTIES:C258($y_PrimaryKey;$l_tipo;$l_largo;$b_indexado;$b_unico)
			Case of 
				: (($l_tipo=Is alpha field:K8:1) & ($l_largo=0))  // formato uuid
					SET QUERY AND LOCK:C661(True:C214)
					QUERY:C277($y_tabla->;$y_PrimaryKey->#"")
				: ($l_tipo=Is longint:K8:6)
					SET QUERY AND LOCK:C661(True:C214)
					QUERY:C277($y_tabla->;$y_PrimaryKey->#0)
				Else 
					$l_error:=-4  // No es posible bloquear la tabla
			End case 
		Else 
			$l_error:=-2
		End if 
		
	Else 
		$l_error:=-1  // Hay registros bloqueados, no es posible bloquear la tabla ahora
	End if 
	
Else 
	$l_error:=-3  // No es posible bloquear una tabla fuera de una transacción
End if 


