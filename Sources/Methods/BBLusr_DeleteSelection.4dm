//%attributes = {}
  //BBLusr_DeleteSelection

C_LONGINT:C283($r;$0)
If (USR_checkRights ("D";->[BBL_Lectores:72]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar toda la información de todos los lectores seleccionados");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		$r:=CD_Dlog (2;__ ("¿La eliminación es irreversible?\r¿Eliminar a todos los lectores seleccionados?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			$pID:=IT_UThermometer (1;0;__ ("Eliminando los lectores seleccionados..."))
			START TRANSACTION:C239
			KRL_RelateSelection (->[BBL_Prestamos:60]Número_de_lector:2;->[BBL_Lectores:72]ID:1)
			CREATE SET:C116([BBL_Lectores:72];"Tlec")
			QUERY SELECTION:C341([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
			If (Records in selection:C76([BBL_Prestamos:60])>0)
				KRL_RelateSelection (->[BBL_Lectores:72]ID:1;->[BBL_Prestamos:60]Número_de_lector:2;"")
				CREATE SET:C116([BBL_Lectores:72];"Plec")
				CD_Dlog (0;__ ("Existen lectores en la selección que actualmente tienen préstamos vigentes y no serán eliminados."))
				DIFFERENCE:C122("Tlec";"Plec";"Tlec")
				USE SET:C118("Tlec")
				KRL_RelateSelection (->[BBL_Prestamos:60]Número_de_lector:2;->[BBL_Lectores:72]ID:1)
			Else 
				KRL_RelateSelection (->[BBL_Prestamos:60]Número_de_lector:2;->[BBL_Lectores:72]ID:1)
			End if 
			ARRAY LONGINT:C221($al_rn_ptmos;0)
			LONGINT ARRAY FROM SELECTION:C647([BBL_Prestamos:60];$al_rn_ptmos;"")
			
			For ($i;1;Size of array:C274($al_rn_ptmos))
				READ WRITE:C146([BBL_Prestamos:60])
				GOTO RECORD:C242([BBL_Prestamos:60];$al_rn_ptmos{$i})
				USE SET:C118("Tlec")
				QUERY SELECTION:C341([BBL_Lectores:72];[BBL_Lectores:72]ID:1=[BBL_Prestamos:60]Número_de_lector:2)
				[BBL_Prestamos:60]Lector_Eliminado:16:=[BBL_Lectores:72]NombreCompleto:3
				[BBL_Prestamos:60]Tipo_Eliminado:17:=[BBL_Lectores:72]Grupo:2
				SAVE RECORD:C53([BBL_Prestamos:60])
				KRL_UnloadReadOnly (->[BBL_Prestamos:60])
			End for 
			SET_ClearSets ("Tlec";"Plec")
			
			
			  //OK:=KRL_DeleteSelection (->[BBL_Préstamos];False)
			
			If (OK=1)
				KRL_RelateSelection (->[BBL_Transacciones:59]ID_User:4;->[BBL_Lectores:72]ID:1)
				OK:=KRL_DeleteSelection (->[BBL_Transacciones:59];False:C215)
			End if 
			
			If (OK=1)
				KRL_RelateSelection (->[BBL_Reservas:115]ID_User:3;->[BBL_Lectores:72]ID:1)
				OK:=KRL_DeleteSelection (->[BBL_Reservas:115];False:C215)
			End if 
			
			If (OK=1)
				OK:=KRL_DeleteSelection (->[BBL_Lectores:72])
			End if 
			If (ok=1)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
			End if 
			$0:=OK
		End if 
		$pID:=IT_UThermometer (-2;$pID)
	End if 
Else 
	USR_ALERT_UserHasNoRights (3;2)
End if 