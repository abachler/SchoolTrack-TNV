//%attributes = {}
  //PP_DeleteSelection
C_LONGINT:C283($relateds;$l_go)
ARRAY TEXT:C222($at_log;0)
$0:=0
If (USR_checkRights ("D";->[Personas:7]))
	$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar toda la información de todas las personas seleccionadas");__ ("");__ ("No");__ ("Eliminar"))
	If ($r=2)
		$r:=CD_Dlog (2;__ ("¿La eliminación es irreversible?\r¿Eliminar a todas las personas seleccionadas?");__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			$relateds:=0
			CREATE SET:C116([Personas:7];"toDelete")
			SELECTION TO ARRAY:C260([Personas:7];$aRecNums)
			READ ONLY:C145([Familia:78])
			READ ONLY:C145([Alumnos:2])
			For ($i;1;Size of array:C274($aRecNums))
				GOTO RECORD:C242([Personas:7];$aRecNums{$i})
				SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
				QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Personas:7]No:1;*)
				QUERY:C277([Familia:78]; | [Familia:78]Madre_Número:6=[Personas:7]No:1)
				If ($records>0)
					REMOVE FROM SET:C561([Personas:7];"toDelete")
					$relateds:=$relateds+1
				Else 
					QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1;*)
					QUERY:C277([Alumnos:2]; | [Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
					If ($records>0)
						REMOVE FROM SET:C561([Personas:7];"toDelete")
						$relateds:=$relateds+1
					Else 
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
						If ($records>0)
							REMOVE FROM SET:C561([Personas:7];"toDelete")
							$relateds:=$relateds+1
						Else 
							QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
							If ($records>0)
								REMOVE FROM SET:C561([Personas:7];"toDelete")
								$relateds:=$relateds+1
							End if 
						End if 
					End if 
				End if 
			End for 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			USE SET:C118("toDelete")
			SET_ClearSets ("$todelete")
			
			
			  // MOD Ticket N° 213024 Patricio Aliaga 20180730
			  // Se realiza el control de registros lockeados con varible longint
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aRecNums;"")
			For ($i;1;Size of array:C274($aRecNums))
				READ WRITE:C146([Personas:7])
				GOTO RECORD:C242([Personas:7];$aRecNums{$i})
				$l_go:=0
				START TRANSACTION:C239
				If (Not:C34(Locked:C147([Personas:7])))
					READ WRITE:C146([Familia:78])
					QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Personas:7]No:1)
					If (Records in selection:C76([Familia:78])>0)
						While (Not:C34(End selection:C36([Familia:78])))
							If (Not:C34(Locked:C147([Familia:78])))
								[Familia:78]Padre_Número:5:=0
								[Familia:78]Padre_Nombre:15:=""
								[Familia:78]Nombres_padres:22:=ST_GetLine ([Familia:78]Nombres_padres:22;1)+"\r"
								SAVE RECORD:C53([Familia:78])
								NEXT RECORD:C51([Familia:78])
							Else 
								$l_go:=$l_go+1
							End if 
						End while 
						UNLOAD RECORD:C212([Familia:78])
					Else 
						QUERY:C277([Familia:78];[Familia:78]Madre_Número:6=[Personas:7]No:1)
						If (Records in selection:C76([Familia:78])>0)
							While (Not:C34(End selection:C36([Familia:78])))
								If (Not:C34(Locked:C147([Familia:78])))
									[Familia:78]Madre_Número:6:=0
									[Familia:78]Madre_Nombre:16:=""
									[Familia:78]Nombres_padres:22:=""+"\r"+ST_GetLine ([Familia:78]Nombres_padres:22;2)
									SAVE RECORD:C53([Familia:78])
									NEXT RECORD:C51([Familia:78])
								Else 
									$l_go:=$l_go+1
								End if 
							End while 
							UNLOAD RECORD:C212([Familia:78])
						End if 
					End if 
					READ ONLY:C145([Familia:78])
					If ($l_go=0)
						READ WRITE:C146([Familia_RelacionesFamiliares:77])
						QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
						If (Records in selection:C76([Familia_RelacionesFamiliares:77])>0)
							DELETE SELECTION:C66([Familia_RelacionesFamiliares:77])
							If (Records in set:C195("LockedSet")>0)
								$l_go:=$l_go+1
							End if 
						End if 
						READ ONLY:C145([Familia_RelacionesFamiliares:77])
					End if 
					If ($l_go=0)
						READ WRITE:C146([Alumnos:2])
						QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1)
						APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27:=0)
						If (Records in set:C195("LockedSet")>0)
							$l_go:=$l_go+1
						End if 
					End if 
					If ($l_go=0)
						QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
						APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28:=0)
						If (Records in set:C195("LockedSet")>0)
							$l_go:=$l_go+1
						End if 
					End if 
					UNLOAD RECORD:C212([Alumnos:2])
					READ ONLY:C145([Alumnos:2])
					If ($l_go=0)
						READ WRITE:C146([Profesores:4])
						QUERY:C277([Profesores:4];[Profesores:4]ID_Persona:65=[Personas:7]No:1)
						If (Not:C34(Locked:C147([Profesores:4])))
							[Profesores:4]ID_Persona:65:=0
							[Profesores:4]ConAlumnosRelacionados:64:=False:C215
							SAVE RECORD:C53([Profesores:4])
							KRL_ReloadAsReadOnly (->[Profesores:4])
						Else 
							$l_go:=$l_go+1
						End if 
					End if 
					If ($l_go=0)
						  //20140611 RCH borrar educacion anterior
						ARRAY LONGINT:C221($aIDs;0)
						APPEND TO ARRAY:C911($aIDs;[Personas:7]No:1)
						ADTcdd_DeleteEducacionAnterior (->$aIDs;"pe")
					End if 
					If ($l_go=0)
						READ WRITE:C146([Personas:7])
						GOTO RECORD:C242([Personas:7];$aRecNums{$i})
						If (Not:C34(Locked:C147([Personas:7])))
							DELETE RECORD:C58([Personas:7])
						Else 
							$l_go:=$l_go+1
						End if 
					End if 
				Else 
					$l_go:=1
				End if 
				If ($l_go=0)
					VALIDATE TRANSACTION:C240
				Else 
					CANCEL TRANSACTION:C241
					GOTO RECORD:C242([Personas:7];$aRecNums{$i})
					APPEND TO ARRAY:C911($at_log;[Personas:7]Apellidos_y_nombres:30)
				End if 
			End for 
			If (Size of array:C274($aRecNums)>0)
				$0:=1
			End if 
			
			If ($relateds>0)
				CD_Dlog (0;String:C10($relateds)+__ (" registros no pudieron ser eliminados ya que son padres o madres de alguna  familia o apoderados de algún alumno o poseen información asociada a AccountTrack."))
			End if 
			
			If ($l_go>0)
				CD_Dlog (0;__ ("Existen registros que no fueron eliminados ya que están siendo utilizados. El detalle de los registros lo encontrara en el Registro de Actividades."))
				LOG_RegisterEvt (__ ("Las siguientes Relaciones Familiares no fueron eliminadas debido a que están siendo utilizadas: ")+AT_array2text (->$at_log;" - "))
			End if 
			
		End if 
	End if 
End if 