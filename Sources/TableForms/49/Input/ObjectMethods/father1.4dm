  // [ADT_Candidatos].Input.father1()
  // Por: Alberto Bachler K.: 07-12-13, 16:42:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Self:C308->:=ST_Format (Self:C308;->[Personas:7]Apellido_paterno:3)
vbSpell_StopChecking:=True:C214
C_LONGINT:C283($r1)
If (Form event:C388=On Data Change:K2:15)
	Case of 
		: ((viPST_FATHERRecNum>0) & (Self:C308->=""))
			ok:=CD_Dlog (0;__ ("¿Desea Ud. realmente eliminar la relación de esta persona con la familia?");__ ("");__ ("Sí");__ ("No"))
			If (ok=1)
				C_BOOLEAN:C305($eliminarPadre)
				$eliminarPadre:=False:C215
				  //desvinculo el candidato con el id de la persona
				[ADT_Candidatos:49]Padre_numero:31:=0
				[ADT_Candidatos:49]Padre_nombre:33:=""
				
				GOTO RECORD:C242([Personas:7];viPST_FATHERRecNum)
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
				  // si no estan completos los datos de las personas se elimina el registro de la madre creado
				If (False:C215)
					If ((vsPST_aMaternoFATHER="") | (vsPST_NombresFATHER=""))
						
						  //verificar si la persona esta asociada a otra familia
						QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Personas:7]No:1)
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
								$eliminarPadre:=False:C215
							Else 
								$eliminarPadre:=True:C214
						End case 
					End if 
					If ($eliminarPadre=True:C214)
						GOTO RECORD:C242([Personas:7];viPST_FATHERRecNum)
						KRL_ReloadInReadWriteMode (->[Personas:7])
						DELETE SELECTION:C66([Personas:7])
						SAVE RECORD:C53([Personas:7])
						KRL_UnloadReadOnly (->[Personas:7])
					End if 
				End if 
				  // ***** 20131207 - Codigo desactivado por Alberto Bachler  ***** //
				
				
				viPST_FATHERRecNum:=0
				vsPST_aMaternoFATHER:=""
				vsPST_NombresFATHER:=""
				vdPST_fNacFATHER:=!00-00-00!
				vsPST_ProfesionFATHER:=""
				vsPST_TelPersFATHER:=""
				vsPST_TelProFATHER:=""
				viPST_exFATHER:=0
				vsPST_RUTFATHER:=""
				$change:=False:C215
				GOTO RECORD:C242([Familia:78];vlPST_LinkedFamilyRec)
				[Familia:78]Padre_Número:5:=0
				[Familia:78]Padre_Nombre:15:=""
				SAVE RECORD:C53([Familia:78])
			Else 
				$change:=False:C215
				GOTO RECORD:C242([Personas:7];viPST_FATHERRecNum)
				vsPST_aPaternoFATHER:=[Personas:7]Apellido_paterno:3
			End if 
		: ((viPST_FATHERRecNum>0) & (Self:C308->#""))
			ok:=CD_Dlog (0;__ ("Usted modificó el apellido paterno del padre.\r¿Desea usted modificar el apellido o cambiar el padre en la familia ?");__ ("");__ ("Cambiar padre");__ ("Modificar apellido");__ ("Cancelar"))
			  //ok:=CD_Dlog (0;":21403,35";"";":21102,19";":21102,17";":21102,4")
			Case of 
				: (ok=1)
					vsPST_aMaternoFATHER:=""
					vsPST_NombresFATHER:=""
					vdPST_fNacFATHER:=!00-00-00!
					vsPST_ProfesionFATHER:=""
					vsPST_TelPersFATHER:=""
					vsPST_TelProFATHER:=""
					viPST_exFATHER:=0
					vsPST_RUTFATHER:=""
					$change:=True:C214
				: (ok=2)
					$change:=False:C215
					READ WRITE:C146([Personas:7])
					GOTO RECORD:C242([Personas:7];viPST_FATHERRecNum)
					[Personas:7]Apellido_paterno:3:=vsPST_aPaternoFATHER
					SAVE RECORD:C53([Personas:7])
					KRL_ReloadAsReadOnly (->[Personas:7])
				: (ok=3)
					$change:=False:C215
					GOTO RECORD:C242([Personas:7];viPST_FATHERRecNum)
					vsPST_aPaternoFATHER:=[Personas:7]Apellido_paterno:3
			End case 
			
		Else 
			$change:=True:C214
	End case 
	
	If ($change)
		
		  //primero desvincular a la mama que estaba ante vinculada a la familia
		If (viPST_FATHERRecNum>0)
			GOTO RECORD:C242([Personas:7];viPST_FATHERRecNum)
			READ WRITE:C146([Familia_RelacionesFamiliares:77])
			QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1;*)
			QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
			DELETE SELECTION:C66([Familia_RelacionesFamiliares:77])
			SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
			KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
			
			
			
			GOTO RECORD:C242([Personas:7];viPST_FATHERRecNum)
			  // ***** 20131207 - Codigo desactivado por Alberto Bachler  *****
			  // Se está cambiando la madre en el registro de un candidato ADT
			  // el registro de la  madre NO DEBE SE ELIMINADO en ningún caso
			  // aun cuando no tenga movimiento en ACT
			  // solo debe eliminarse la relación familiar con la familia
			If (False:C215)
				If ((vsPST_aMaternoFATHER="") | (vsPST_NombresFATHER=""))
					QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Personas:7]No:1)
					  //verifica info act
					C_LONGINT:C283($vl_records;$vl_records2)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records2)
					QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					
					If ((Records in selection:C76([Familia:78])>=2) | ($vl_records#0) | ($vl_records2#0))
						  //no se elimina registro
						$eliminarPadre:=False:C215
					Else 
						  //se elimina para evitar duplicación de resgistros
						GOTO RECORD:C242([Personas:7];viPST_FATHERRecNum)
						KRL_ReloadInReadWriteMode (->[Personas:7])
						DELETE SELECTION:C66([Personas:7])
						SAVE RECORD:C53([Personas:7])
						KRL_UnloadReadOnly (->[Personas:7])
					End if 
				End if 
			End if 
			  // ***** 20131207 - Codigo desactivado por Alberto Bachler  *****//
			
			
			
			[ADT_Candidatos:49]Padre_numero:31:=0
			viPST_FATHERRecNum:=0
		End if 
		
		QUERY:C277([Personas:7];[Personas:7]Apellidos_y_nombres:30=(Self:C308->+"@"))
		
		Case of 
			: (Records in selection:C76([Personas:7])=0)
				OK:=CD_Dlog (0;__ ("El apellido ingresado no corresponde a ninguna persona registrada en la base de datos.\r¿Desea crear el registro de la persona y asociarlo como padre de la familia?");__ ("");__ ("Sí");__ ("No"))
				  //OK:=CD_Dlog (0;RP_GetIdxString (21403;4);"";RP_GetIdxString (21102;1);RP_GetIdxString (21102;2))
				If (ok=1)
					CREATE RECORD:C68([Personas:7])
					[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
					[Personas:7]Sexo:8:="M"
					SAVE RECORD:C53([Personas:7])
					viPST_FATHERRecNum:=Record number:C243([Personas:7])
					vsPST_aMaternoFATHER:=""
					vsPST_NombresFATHER:=""
					vdPST_fNacFATHER:=!00-00-00!
					vsPST_ProfesionFATHER:=""
					vsPST_TelPersFATHER:=""
					vsPST_TelProFATHER:=""
					viPST_exFATHER:=0
					vsPST_RUTFATHER:=""
					READ WRITE:C146([Familia:78])
					GOTO RECORD:C242([Familia:78];vlPST_LinkedFamilyRec)
				Else 
					If (viPST_FATHERRecNum>0)
						GOTO RECORD:C242([Personas:7];viPST_FATHERRecNum)
						vsPST_aPaternoFATHER:=[Personas:7]Apellido_paterno:3
						vsPST_aMaternoFATHER:=[Personas:7]Apellido_materno:4
						vsPST_NombresFATHER:=[Personas:7]Nombres:2
						vdPST_fNacFATHER:=[Personas:7]Fecha_de_nacimiento:5
						vsPST_ProfesionFATHER:=[Personas:7]Profesion:13
						vsPST_TelPersFATHER:=[Personas:7]Telefono_domicilio:19
						vsPST_TelProFATHER:=[Personas:7]Telefono_profesional:29
						viPST_exFATHER:=Num:C11([Personas:7]Es_ExAlumno:12)
						vsPST_RUTFATHER:=[Personas:7]RUT:6
					Else 
						REDUCE SELECTION:C351([Personas:7];0)
					End if 
					
				End if 
			: (Records in selection:C76([Personas:7])>=1)
				vsPST_Parent:="Father"
				READ ONLY:C145([Familia:78])
				ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
				SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;aParentNames;[Personas:7];aParentRecNo)
				WDW_OpenFormWindow (->[Alumnos:2];"SetParents";6;4;__ ("Relaciones Familiares"))
				DIALOG:C40([Alumnos:2];"SetParents")
				CLOSE WINDOW:C154
				If (OK=1)
					viPST_FATHERRecNum:=Record number:C243([Personas:7])
					vsPST_aPaternoFATHER:=[Personas:7]Apellido_paterno:3
					vsPST_aMaternoFATHER:=[Personas:7]Apellido_materno:4
					vsPST_NombresFATHER:=[Personas:7]Nombres:2
					vdPST_fNacFATHER:=[Personas:7]Fecha_de_nacimiento:5
					vsPST_ProfesionFATHER:=[Personas:7]Profesion:13
					vsPST_TelPersFATHER:=[Personas:7]Telefono_domicilio:19
					vsPST_TelProFATHER:=[Personas:7]Telefono_profesional:29
					viPST_exFATHER:=Num:C11([Personas:7]Es_ExAlumno:12)
					vsPST_RUTFATHER:=[Personas:7]RUT:6
				Else 
					If (viPST_FATHERRecNum>0)
						GOTO RECORD:C242([Personas:7];viPST_FATHERRecNum)
					Else 
						REDUCE SELECTION:C351([Personas:7];0)
					End if 
					vsPST_aPaternoFATHER:=[Personas:7]Apellido_paterno:3
					vsPST_aMaternoFATHER:=[Personas:7]Apellido_materno:4
					vsPST_NombresFATHER:=[Personas:7]Nombres:2
					vdPST_fNacFATHER:=[Personas:7]Fecha_de_nacimiento:5
					vsPST_ProfesionFATHER:=[Personas:7]Profesion:13
					vsPST_TelPersFATHER:=[Personas:7]Telefono_domicilio:19
					vsPST_TelProFATHER:=[Personas:7]Telefono_profesional:29
					viPST_exFATHER:=Num:C11([Personas:7]Es_ExAlumno:12)
					vsPST_RUTFATHER:=[Personas:7]RUT:6
				End if 
		End case 
		PST_UpdateParents ("Father")
	End if 
	IT_SetButtonState ((viPST_FATHERRecNum>0);->viPST_exFATHER;->bDetailFATHER)
End if 
vbSpell_StopChecking:=True:C214