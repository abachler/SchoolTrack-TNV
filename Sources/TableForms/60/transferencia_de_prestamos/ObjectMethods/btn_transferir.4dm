
vl_id_usr:=al_id_usr_sys{at_nom_usr_sys}
vt_usr_name:=at_nom_usr_sys{at_nom_usr_sys}

If (vl_id_usr<0)
	
	ARRAY LONGINT:C221($DA_Return;0)
	ab_transferir{0}:=True:C214
	AT_SearchArray (->ab_transferir;"=";->$DA_Return)
	
	If (Size of array:C274($DA_Return)>0)
		vb_modificacion_de_registros:=True:C214
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Reasignando los préstamos a ")+vt_usr_name)
		For ($i;1;Size of array:C274($DA_Return))
			READ WRITE:C146([BBL_Prestamos:60])
			GOTO RECORD:C242([BBL_Prestamos:60];al_recnum_ptm{$DA_Return{$i}})
			$id_usr:=[BBL_Prestamos:60]Número_de_lector:2
			[BBL_Prestamos:60]Número_de_lector:2:=vl_id_usr
			SAVE RECORD:C53([BBL_Prestamos:60])
			LOG_RegisterEvt ("El préstamo id "+String:C10([BBL_Prestamos:60]Número_de_Transacción:8)+" fue reasignado del usuario "+String:C10($id_usr)+" - "+at_usuario_original{$DA_Return{$i}}+" al usuario "+at_nom_usr_sys{choiceidx})
			KRL_UnloadReadOnly (->[BBL_Prestamos:60])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(al_recnum_ptm))
		End for 
		
		For ($i;Size of array:C274($DA_Return);1;-1)
			DELETE FROM ARRAY:C228(al_recnum_ptm;$DA_Return{$i};1)
			DELETE FROM ARRAY:C228(ad_fecha_hasta;$DA_Return{$i};1)
			DELETE FROM ARRAY:C228(at_usuario_original;$DA_Return{$i};1)
			DELETE FROM ARRAY:C228(at_titulo;$DA_Return{$i};1)
			DELETE FROM ARRAY:C228(al_numregistro;$DA_Return{$i};1)
			DELETE FROM ARRAY:C228(ab_transferir;$DA_Return{$i};1)
		End for 
		
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
	Else 
		CD_Dlog (0;__ ("Debe seleccionar préstamos para transferir al usuario ")+vt_usr_name)
	End if 
	
Else 
	CD_Dlog (0;__ ("Debe seleccionar un usuario de sistema para transferir los préstamos"))
End if 

