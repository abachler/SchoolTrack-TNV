//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Jorge Valenzuela
  // Fecha y hora: 19/08/16, 09:36:03
  // ----------------------------------------------------
  // Método: MT_CambiaReglaitem
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_BOOLEAN:C305($b_locked)
C_LONGINT:C283($l_resp;$vl_records)
ARRAY LONGINT:C221(aQR_longint1;0)
ARRAY TEXT:C222(aQR_text1;0)


If (Application type:C494#4D Server:K5:6)
	If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
		If (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Items:61]))
			$vl_records:=BWR_SearchRecords (->[BBL_Items:61])
			If ($vl_records#-1)
				CREATE SET:C116([BBL_Items:61];"items")
				USE SET:C118("items")
				$l_resp:=CD_Dlog (0;"Se cambiará la regla de "+String:C10(Records in selection:C76([BBL_Items:61]))+" Item(s) en el explorador,"+"\r\r"+"¿Desea continuar?";"";"Si";"No")
				If ($l_resp=1)
					ALL RECORDS:C47([xxBBL_ReglasParaItems:69])
					SELECTION TO ARRAY:C260([xxBBL_ReglasParaItems:69]Nombre Regla:2;aQR_text1;[xxBBL_ReglasParaItems:69]Codigo_regla:1;aQR_text2)
					SRtbl_ShowChoiceList (0;"Seleccione Regla";2;->brepositorio;False:C215;->aQR_text1)
					
					If (CHOICEIDX>0)
						USE SET:C118("items")
						SELECTION TO ARRAY:C260([BBL_Items:61];aQR_longint100)
						START TRANSACTION:C239
						$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"")
						For (vQR_long1;1;Size of array:C274(aQR_longint100))
							READ WRITE:C146([BBL_Items:61])
							GOTO RECORD:C242([BBL_Items:61];aQR_longint100{vQR_long1})
							[BBL_Items:61]Regla:20:=aQR_text2{CHOICEIDX}
							SAVE RECORD:C53([BBL_Items:61])
							$b_locked:=Locked:C147([BBL_Items:61])
							KRL_UnloadReadOnly (->[BBL_Items:61])
							If ($b_locked)
								vQR_long2:=Size of array:C274(aQR_longint100)+1
							End if 
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;vQR_long1/Size of array:C274(aQR_longint100);"Aplicando Script...")
						End for 
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
						If ($b_locked)
							CANCEL TRANSACTION:C241
							CD_Dlog (0;"Existen registros en uso. El script no se ha ejecutado.")
						Else 
							VALIDATE TRANSACTION:C240
							CD_Dlog (0;"Script ejecutado con éxito.")
							USE SET:C118("items")
							SELECTION TO ARRAY:C260([BBL_Items:61]Titulos:5;aQR_text1)
							vQR_text100:=AT_array2text (->aQR_text1;";")
							LOG_RegisterEvt ("Se efectuo el cambio de regla para los siguientes Items: "+vQR_text100)
							POST KEY:C465(-96)
						End if 
						KRL_UnloadReadOnly (->[BBL_Items:61])
					Else 
						CD_Dlog (0;__ ("Debe seleccionar una Regla para ejecutar el script."))
						ok:=0
					End if 
					
					
				End if 
				
			Else 
				CD_Dlog (0;"Seleccione en el explorador los Items que desea cambiar la regla.")
				ok:=0
			End if 
		Else 
			CD_Dlog (0;"Ejecute el script desde la pestaña Items.")
			ok:=0
		End if 
	End if 
End if 



POST KEY:C465(-96)
