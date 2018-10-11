//%attributes = {}
  //BBLus_Delete

C_LONGINT:C283($r;$i;$0)
If (USR_checkRights ("D";->[BBL_Lectores:72]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar el registro ")+[BBL_Lectores:72]NombreCompleto:3+__ ("?");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1)
		QUERY SELECTION:C341([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
		If (Records in selection:C76([BBL_Prestamos:60])=0)
			ARRAY LONGINT:C221($al_rn_ptmo;0)
			QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1)
			
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Registrando al usuario eliminado en sus préstamos..."))
			LONGINT ARRAY FROM SELECTION:C647([BBL_Prestamos:60];$al_rn_ptmo;"")
			For ($i;1;Size of array:C274($al_rn_ptmo))
				READ WRITE:C146([BBL_Prestamos:60])
				GOTO RECORD:C242([BBL_Prestamos:60];$al_rn_ptmo{$i})
				[BBL_Prestamos:60]Lector_Eliminado:16:=[BBL_Lectores:72]NombreCompleto:3
				[BBL_Prestamos:60]Tipo_Eliminado:17:=[BBL_Lectores:72]Grupo:2
				SAVE RECORD:C53([BBL_Prestamos:60])
				KRL_UnloadReadOnly (->[BBL_Prestamos:60])
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_rn_ptmo))
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			$0:=OK
			
			If (ok=1)
				DELETE RECORD:C58([BBL_Lectores:72])
				$0:=OK
			End if 
			  //OK:=KRL_DeleteSelection (->[BBL_Préstamos])
			  //If (OK=1)
			  //QUERY([BBL_Transacciones];[BBL_Transacciones]ID_User=[BBL_Lectores]ID)
			  //OK:=KRL_DeleteSelection (->[BBL_Préstamos])
			  // 
			  //End if 
			
		Else 
			CD_Dlog (0;__ ("El lector tiene préstamos vigentes, no puede ser eliminado."))
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 