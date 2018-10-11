//%attributes = {}
  //TGR_Cursos

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				
				[Cursos:3]LLaveSintesisAnual:4:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->[Cursos:3]Nivel_Numero:7;->[Cursos:3]Curso:1;->[Cursos:3]Numero_del_curso:6)  //MONO 184433
				
				If ([Cursos:3]Numero_del_curso:6=0)
					[Cursos:3]Numero_del_curso:6:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6)
				End if 
				[Cursos:3]cl_RolBaseDatos:20:=<>gRolBD
				READ ONLY:C145([xxSTR_Niveles:6])
				QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
				[Cursos:3]cl_CodigoDecretoEvaluacion:24:=[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38
				[Cursos:3]cl_CodigoDecretoPlanEstudios:22:=[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39
				[Cursos:3]cl_CodigoEspecialidadTP:29:=0
				[Cursos:3]cl_CodigoPlanEstudios:23:=[xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40
				[Cursos:3]cl_CodigoTipoEnseñanza:21:=[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41
				If ([Cursos:3]cl_CodigoTipoEnseñanza:21>0)
					$hl_TipoEnseñanza:=Load list:C383("CL_CodigosEnseñanza")
					SELECT LIST ITEMS BY REFERENCE:C630($hl_TipoEnseñanza;[Cursos:3]cl_CodigoTipoEnseñanza:21)
					GET LIST ITEM:C378($hl_TipoEnseñanza;Selected list items:C379($hl_TipoEnseñanza);$ref;$text)
					[Cursos:3]cl_TipoEnseñanza:25:=$text
				Else 
					[Cursos:3]cl_TipoEnseñanza:25:=""
				End if 
				If ([Cursos:3]cl_CodigoEspecialidadTP:29>0)
					$hl_Especialidades:=Load list:C383("cl_CodigosEspecialidadTP")
					HL_ExpandAll ($hl_Especialidades)
					SELECT LIST ITEMS BY REFERENCE:C630($hl_Especialidades;[Cursos:3]cl_CodigoEspecialidadTP:29)
					GET LIST ITEM:C378($hl_Especialidades;Selected list items:C379($hl_Especialidades);$ref;$text)
					[Cursos:3]cl_EspecialidadTP:28:=$text
					$parent:=List item parent:C633($hl_Especialidades;$ref)
					SELECT LIST ITEMS BY REFERENCE:C630($hl_Especialidades;$parent)
					GET LIST ITEM:C378($hl_Especialidades;Selected list items:C379($hl_Especialidades);$ref;$text)
					[Cursos:3]cl_SectorEconomicoTP:27:=$text
					$parent:=List item parent:C633($hl_Especialidades;$ref)
					SELECT LIST ITEMS BY REFERENCE:C630($hl_Especialidades;$parent)
					GET LIST ITEM:C378($hl_Especialidades;Selected list items:C379($hl_Especialidades);$ref;$text)
					[Cursos:3]cl_RamaTP:26:=$text
				End if 
				[Cursos:3]Capacidad:30:=45
				[Cursos:3]Vacantes:31:=45
				
				  //Para guardar la sede 20170318 ASM Ticket 176769
				READ WRITE:C146([Cursos_SintesisAnual:63])
				QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=[Cursos:3]Curso:1)
				QUERY SELECTION:C341([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2=<>gyear)
				[Cursos_SintesisAnual:63]Sede:53:=[Cursos:3]Sede:19
				SAVE RECORD:C53([Cursos_SintesisAnual:63])
				KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				
				[Cursos:3]LLaveSintesisAnual:4:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->[Cursos:3]Nivel_Numero:7;->[Cursos:3]Curso:1;->[Cursos:3]Numero_del_curso:6)  //MONO 184433
				
				If ([Cursos:3]Capacidad:30=0)
					[Cursos:3]Capacidad:30:=[Cursos:3]Numero_de_Alumnos:11
				End if 
				[Cursos:3]Vacantes:31:=[Cursos:3]Capacidad:30-[Cursos:3]Numero_de_Alumnos:11
				Case of 
					: (<>vs_AppDecimalSeparator=",")
						$badSeparator:="."
					: (<>vs_AppDecimalSeparator=".")
						$badSeparator:=","
				End case 
				[Cursos:3]Promedio_P1:37:=Replace string:C233([Cursos:3]Promedio_P1:37;$badSeparator;<>vs_AppDecimalSeparator)
				[Cursos:3]Promedio_P2:38:=Replace string:C233([Cursos:3]Promedio_P2:38;$badSeparator;<>vs_AppDecimalSeparator)
				[Cursos:3]Promedio_P3:39:=Replace string:C233([Cursos:3]Promedio_P3:39;$badSeparator;<>vs_AppDecimalSeparator)
				[Cursos:3]Promedio_P4:40:=Replace string:C233([Cursos:3]Promedio_P4:40;$badSeparator;<>vs_AppDecimalSeparator)
				[Cursos:3]Promedio_PF:43:=Replace string:C233([Cursos:3]Promedio_PF:43;$badSeparator;<>vs_AppDecimalSeparator)
				[Cursos:3]Promedio_NF:44:=Replace string:C233([Cursos:3]Promedio_NF:44;$badSeparator;<>vs_AppDecimalSeparator)
				
				If ([Cursos:3]Numero_del_curso:6>0)
				End if 
				
				  //Para guardar la sede 20170318 ASM Ticket 176769
				READ WRITE:C146([Cursos_SintesisAnual:63])
				QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=[Cursos:3]Curso:1)
				QUERY SELECTION:C341([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2=<>gyear)
				[Cursos_SintesisAnual:63]Sede:53:=[Cursos:3]Sede:19
				SAVE RECORD:C53([Cursos_SintesisAnual:63])
				KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
		CMT_RegistrosMarcados ("CMT_MarcaRegistros";->[Cursos:3])
	End if 
	SN3_MarcarRegistros (SN3_DTi_Cursos)
End if 