  // [ADT_Candidatos].Input.mother1()
  // Por: Alberto Bachler K.: 07-12-13, 16:42:12
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Self:C308->:=ST_Format (Self:C308;->[Personas:7]Apellido_paterno:3)
vbSpell_StopChecking:=True:C214
C_LONGINT:C283($r1)
If (Form event:C388=On Data Change:K2:15)
	Case of 
		: ((viPST_MOTHERRecNum>0) & (Self:C308->=""))
			ok:=CD_Dlog (0;__ ("¿Desea Ud. realmente eliminar la relación de esta persona con la familia?");__ ("");__ ("Sí");__ ("No"))
			If (ok=1)
				C_BOOLEAN:C305($eliminarMadre)
				$eliminarMadre:=False:C215
				  //desvinculo el candidato con el id de la persona
				[ADT_Candidatos:49]Madre_numero:32:=0
				[ADT_Candidatos:49]Madre_nombre:34:=""
				
				GOTO RECORD:C242([Personas:7];viPST_MOTHERRecNum)
				READ WRITE:C146([Familia_RelacionesFamiliares:77])
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1;*)
				QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
				DELETE SELECTION:C66([Familia_RelacionesFamiliares:77])
				SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
				KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
				
				
				  // ***** 20131207 - Codigo desactivado por Alberto Bachler  *****
				  // Se está cambiando la madre en el registro de un candidato ADT
				  // el registro de la  madre NO DEBE SE ELIMINADO en ningún caso
				  // aun cuando no tenga movimiento en ACT
				  // solo debe eliminarse la relación familiar con la familia
				If (False:C215)
					  //`si no estan colpletos los datos de las personas se elimina el registro de la madre creado
					If ((vsPST_aMaternoMOTHER="") | (vsPST_NombresMOTHER=""))
						GOTO RECORD:C242([Personas:7];viPST_MOTHERRecNum)
						  //verificar si la persona esta asociada a otra familia
						QUERY:C277([Familia:78];[Familia:78]Madre_Número:6=[Personas:7]No:1)
						  //verifica info act
						C_LONGINT:C283($vl_records;$vl_records2)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records2)
						QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						Case of 
							: (($vl_records#0) | ($vl_records2#0))
								$eliminarMadre:=False:C215
							: (Records in selection:C76([Familia:78])>=2)
								$eliminarMadre:=False:C215
							Else 
								$eliminarMadre:=True:C214
						End case 
					End if 
					If ($eliminarMadre=True:C214)
						GOTO RECORD:C242([Personas:7];viPST_MOTHERRecNum)
						KRL_ReloadInReadWriteMode (->[Personas:7])
						DELETE SELECTION:C66([Personas:7])
						SAVE RECORD:C53([Personas:7])
						KRL_UnloadReadOnly (->[Personas:7])
					End if 
				End if 
				  // ***** 20131207 - Codigo desactivado por Alberto Bachler  *****//
				
				
				
				
				
				viPST_MOTHERRecNum:=0
				vsPST_aMaternoMOTHER:=""
				vsPST_NombresMOTHER:=""
				vdPST_fNacMOTHER:=!00-00-00!
				vsPST_ProfesionMOTHER:=""
				vsPST_TelPersMOTHER:=""
				vsPST_TelProMOTHER:=""
				viPST_exMOTHER:=0
				vsPST_RUTMOTHER:=""
				$change:=False:C215
				GOTO RECORD:C242([Familia:78];vlPST_LinkedFamilyRec)
				[Familia:78]Madre_Número:6:=0
				[Familia:78]Madre_Nombre:16:=""
				SAVE RECORD:C53([Familia:78])
			Else 
				$change:=False:C215
				GOTO RECORD:C242([Personas:7];viPST_MOTHERRecNum)
				vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
			End if 
		: ((viPST_MOTHERRecNum>0) & (Self:C308->#""))
			ok:=CD_Dlog (0;__ ("Usted modificó el apellido paterno de la madre.\r¿Desea usted modificar el apellido o cambiar la madre en la familia ?");__ ("");__ ("Cambiar madre");__ ("Modificar apellido");__ ("Cancelar"))
			Case of 
				: (ok=1)
					vsPST_aMaternoMOTHER:=""
					vsPST_NombresMOTHER:=""
					vdPST_fNacMOTHER:=!00-00-00!
					vsPST_ProfesionMOTHER:=""
					vsPST_TelPersMOTHER:=""
					vsPST_TelProMOTHER:=""
					viPST_exMOTHER:=0
					vsPST_RUTMOTHER:=""
					$change:=True:C214
				: (ok=2)
					$change:=False:C215
					READ WRITE:C146([Personas:7])
					GOTO RECORD:C242([Personas:7];viPST_MOTHERRecNum)
					[Personas:7]Apellido_paterno:3:=vsPST_aPaternoMOTHER
					SAVE RECORD:C53([Personas:7])
					KRL_ReloadAsReadOnly (->[Personas:7])
				: (ok=3)
					$change:=False:C215
					GOTO RECORD:C242([Personas:7];viPST_MOTHERRecNum)
					vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
			End case 
			
		Else 
			$change:=True:C214
	End case 
	
	If ($change)
		
		  //primero desvincular a la mama que estaba ante vinculada a la familia
		If (viPST_MOTHERRecNum>0)
			GOTO RECORD:C242([Personas:7];viPST_MOTHERRecNum)
			READ WRITE:C146([Familia_RelacionesFamiliares:77])
			QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1;*)
			QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
			DELETE SELECTION:C66([Familia_RelacionesFamiliares:77])
			SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
			KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
			
			GOTO RECORD:C242([Personas:7];viPST_MOTHERRecNum)
			
			
			  // ***** 20131207 - Codigo desactivado por Alberto Bachler  *****
			  // Se está cambiando la madre en el registro de un candidato ADT
			  // el registro de la  madre NO DEBE SE ELIMINADO en ningún caso
			  // aun cuando no tenga movimiento en ACT
			  // solo debe eliminarse la relación familiar con la familia
			If (False:C215)
				If ((vsPST_aMaternoMOTHER="") | (vsPST_NombresMOTHER=""))
					QUERY:C277([Familia:78];[Familia:78]Madre_Número:6=[Personas:7]No:1)
					  //verifica info act
					C_LONGINT:C283($vl_records;$vl_records2)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records2)
					QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ((Records in selection:C76([Familia:78])>=2) | ($vl_records#0) | ($vl_records2#0))
						  //no se elimina registro
						$eliminarMadre:=False:C215
					Else 
						  //se elimina para evitar duplicación de resgistros
						GOTO RECORD:C242([Personas:7];viPST_MOTHERRecNum)
						KRL_ReloadInReadWriteMode (->[Personas:7])
						DELETE SELECTION:C66([Personas:7])
						SAVE RECORD:C53([Personas:7])
						KRL_UnloadReadOnly (->[Personas:7])
					End if 
				End if 
			End if 
			  // ***** 20131207 - Codigo desactivado por Alberto Bachler  ***** //
			
			
			
			[ADT_Candidatos:49]Madre_numero:32:=0
			viPST_MOTHERRecNum:=0
		End if 
		
		QUERY:C277([Personas:7];[Personas:7]Apellidos_y_nombres:30=(Self:C308->+"@"))
		
		Case of 
			: (Records in selection:C76([Personas:7])=0)
				OK:=CD_Dlog (0;__ ("El apellido ingresado no corresponde a ninguna persona registrada en la base de datos.\r¿Desea crear el registro de la persona y asociarlo como madre de la familia?");__ ("");__ ("Sí");__ ("No"))
				If (ok=1)
					CREATE RECORD:C68([Personas:7])
					[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
					[Personas:7]Sexo:8:="F"
					SAVE RECORD:C53([Personas:7])
					viPST_MotherRecNum:=Record number:C243([Personas:7])
					vsPST_aMaternoMOTHER:=""
					vsPST_NombresMOTHER:=""
					vdPST_fNacMOTHER:=!00-00-00!
					vsPST_ProfesionMOTHER:=""
					vsPST_TelPersMOTHER:=""
					vsPST_TelProMOTHER:=""
					viPST_exMOTHER:=0
					vsPST_RUTMOTHER:=""
					READ WRITE:C146([Familia:78])
					GOTO RECORD:C242([Familia:78];vlPST_LinkedFamilyRec)
				Else 
					If (viPST_MotherRecNum>0)
						GOTO RECORD:C242([Personas:7];viPST_MotherRecNum)
						vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
						vsPST_aMaternoMOTHER:=[Personas:7]Apellido_materno:4
						vsPST_NombresMOTHER:=[Personas:7]Nombres:2
						vdPST_fNacMOTHER:=[Personas:7]Fecha_de_nacimiento:5
						vsPST_ProfesionMOTHER:=[Personas:7]Profesion:13
						vsPST_TelPersMOTHER:=[Personas:7]Telefono_domicilio:19
						vsPST_TelProMOTHER:=[Personas:7]Telefono_profesional:29
						viPST_exMOTHER:=Num:C11([Personas:7]Es_ExAlumno:12)
						vsPST_RUTMOTHER:=[Personas:7]RUT:6
					Else 
						REDUCE SELECTION:C351([Personas:7];0)
					End if 
					
				End if 
			: (Records in selection:C76([Personas:7])>=1)
				vsPST_Parent:="Mother"
				READ ONLY:C145([Familia:78])
				ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
				SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;aParentNames;[Personas:7];aParentRecNo)
				WDW_OpenFormWindow (->[Alumnos:2];"SetParents";6;4;__ ("Relaciones Familiares"))
				DIALOG:C40([Alumnos:2];"SetParents")
				CLOSE WINDOW:C154
				If (OK=1)
					viPST_MotherRecNum:=Record number:C243([Personas:7])
					vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
					vsPST_aMaternoMOTHER:=[Personas:7]Apellido_materno:4
					vsPST_NombresMOTHER:=[Personas:7]Nombres:2
					vdPST_fNacMOTHER:=[Personas:7]Fecha_de_nacimiento:5
					vsPST_ProfesionMOTHER:=[Personas:7]Profesion:13
					vsPST_TelPersMOTHER:=[Personas:7]Telefono_domicilio:19
					vsPST_TelProMOTHER:=[Personas:7]Telefono_profesional:29
					viPST_exMOTHER:=Num:C11([Personas:7]Es_ExAlumno:12)
					vsPST_RUTMOTHER:=[Personas:7]RUT:6
				Else 
					If (viPST_MotherRecNum>0)
						GOTO RECORD:C242([Personas:7];viPST_MotherRecNum)
					Else 
						REDUCE SELECTION:C351([Personas:7];0)
					End if 
					vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
					vsPST_aMaternoMOTHER:=[Personas:7]Apellido_materno:4
					vsPST_NombresMOTHER:=[Personas:7]Nombres:2
					vdPST_fNacMOTHER:=[Personas:7]Fecha_de_nacimiento:5
					vsPST_ProfesionMOTHER:=[Personas:7]Profesion:13
					vsPST_TelPersMOTHER:=[Personas:7]Telefono_domicilio:19
					vsPST_TelProMOTHER:=[Personas:7]Telefono_profesional:29
					viPST_exMOTHER:=Num:C11([Personas:7]Es_ExAlumno:12)
					vsPST_RUTMOTHER:=[Personas:7]RUT:6
				End if 
		End case 
		PST_UpdateParents ("Mother")
	End if 
	IT_SetButtonState ((viPST_MOTHERRecNum>0);->viPST_exMOTHER;->bDetailMOTHER)
End if 
vbSpell_StopChecking:=True:C214