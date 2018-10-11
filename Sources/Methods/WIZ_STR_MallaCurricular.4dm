//%attributes = {}
  //WIZ_STR_MallaCurricular

C_BOOLEAN:C305(vb_FirstInstall)
C_BLOB:C604(xBlob)
ARRAY INTEGER:C220(aOrder;0)
ARRAY TEXT:C222(aSubject;0)
ARRAY TEXT:C222(aSubjectType;0)
ARRAY TEXT:C222(aSex;0)
ARRAY TEXT:C222(aNumber;0)
ARRAY BOOLEAN:C223(aIncide;0)
ARRAY TEXT:C222(aStyle;0)

If (Size of array:C274(<>al_NumeroNivelesOficiales)>0)
	<>al_NumeroNivelesOficiales{0}:=1
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (-><>al_NumeroNivelesOficiales;">=";->$DA_Return)
	If (Size of array:C274($DA_Return)>0)
		EVS_LoadStyles 
		
		
		ARRAY TEXT:C222(aText1;4)
		aText1{1}:="Plan Común, cursos"
		aText1{2}:="Plan común, grupos"
		aText1{3}:="Plan Electivo"
		aText1{4}:="Optativo"
		
		ARRAY TEXT:C222(aText2;3)
		aText2{1}:="Ambos sexos"
		aText2{2}:="Separados por sexo"
		
		ARRAY TEXT:C222(aText3;11)
		aText3{1}:="Uno por curso"
		aText3{2}:="1"
		aText3{3}:="2"
		aText3{4}:="3"
		aText3{5}:="4"
		aText3{6}:="5"
		aText3{7}:="6"
		aText3{8}:="7"
		aText3{9}:="8"
		aText3{10}:="9"
		aText3{11}:="10"
		
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_Asistente_CreaAsignaturas";-1;4;__ ("Asistentes"))
		DIALOG:C40([xxSTR_Constants:1];"STR_Asistente_CreaAsignaturas")
		CLOSE WINDOW:C154
		
		
		If (OK=1)
			  //estimating number of objects to be created  
			$subjectsNumber:=0
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Creando planes de estudio: "))
			
			  //Ticket 168331 ASM 20160929
			  //For ($niveles;1;12)
			For ($i;1;Size of array:C274(<>al_NumeroNivelesOficiales))
				$niveles:=<>al_NumeroNivelesOficiales{$i}
				xBlob:=PREF_fGetBlob (0;"Plan"+String:C10($niveles);xBlob)
				BLOB_Blob2Vars (->xBlob;0;->aOrder;->aSubject;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
				SET QUERY DESTINATION:C396(3;$cursos)
				QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$niveles)
				SET QUERY DESTINATION:C396(0)
				$subjectsNumber:=$subjectsNumber+(Size of array:C274(aSubject)*$cursos)
			End for 
			
			$processed:=0
			
			  //Ticket 168331 ASM 20160929
			  //For ($niveles;1;12)
			For ($i;1;Size of array:C274(<>al_NumeroNivelesOficiales))
				$niveles:=<>al_NumeroNivelesOficiales{$i}
				$NombreNivel:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$niveles;->[xxSTR_Niveles:6]Nivel:1)
				xBlob:=PREF_fGetBlob (0;"Plan"+String:C10($niveles);xBlob)
				BLOB_Blob2Vars (->xBlob;0;->aOrder;->aSubject;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
				For ($subjects;1;Size of array:C274(aSubject))
					QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=aSubject{$subjects})
					If (Records in selection:C76([xxSTR_Materias:20])=0)
						CREATE RECORD:C68([xxSTR_Materias:20])
						[xxSTR_Materias:20]ID_Materia:16:=SQ_SeqNumber (->[xxSTR_Materias:20]ID_Materia:16)
						[xxSTR_Materias:20]Orden interno:9:=aOrder{$subjects}
						[xxSTR_Materias:20]Materia:2:=aSubject{$subjects}
						If (aSubjectType{$subjects}="Plan comun@")
							[xxSTR_Materias:20]Subsector_Oficial:15:=True:C214
						End if 
						SAVE RECORD:C53([xxSTR_Materias:20])
					End if 
					
					If (aNumber{$subjects}="Uno@")
						READ ONLY:C145([Cursos:3])
						QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$niveles)
						SELECTION TO ARRAY:C260([Cursos:3];$aCursosRecNum)
						For ($cursos;1;Size of array:C274($aCursosRecNum))
							$processed:=$processed+1
							GOTO RECORD:C242([Cursos:3];$aCursosRecNum{$cursos})
							QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
							QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Curso:5=[Cursos:3]Curso:1)
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$processed/$subjectsNumber;__ ("Creando ")+[xxSTR_Materias:20]Materia:2+__ (" en ")+[Cursos:3]Curso:1)
							If (Records in selection:C76([Asignaturas:18])=0)
								CREATE RECORD:C68([Asignaturas:18])
								[Asignaturas:18]Numero:1:=SQ_SeqNumber (->[Asignaturas:18]Numero:1)
								[Asignaturas:18]CHILE_CodigoMineduc:41:=[xxSTR_Materias:20]Codigo:10
								[Asignaturas:18]Asignatura:3:=[xxSTR_Materias:20]Materia:2
								[Asignaturas:18]Materia_UUID:46:=[xxSTR_Materias:20]Auto_UUID:21  //Asignatura, Materia Auto uuid
								[Asignaturas:18]denominacion_interna:16:=[Asignaturas:18]Asignatura:3
								[Asignaturas:18]Abreviación:26:=[xxSTR_Materias:20]Abreviatura:8
								[Asignaturas:18]Curso:5:=[Cursos:3]Curso:1
								[Asignaturas:18]Numero_del_Curso:25:=[Cursos:3]Numero_del_curso:6
								[Asignaturas:18]Numero_del_Nivel:6:=[Cursos:3]Nivel_Numero:7
								[Asignaturas:18]Sector:9:=[xxSTR_Materias:20]Area:12
								[Asignaturas:18]Nivel:30:=[Cursos:3]Nivel_Nombre:10
								[Asignaturas:18]Incide_en_promedio:27:=aIncide{$subjects}
								[Asignaturas:18]IncideEnPromedioInterno:64:=aIncide{$subjects}
								[Asignaturas:18]posicion_en_informes_de_notas:36:=$subjects
								[Asignaturas:18]ordenGeneral:105:=String:C10($subjects;"#00")
								[Asignaturas:18]Numero_de_evaluaciones:38:=12
								[Asignaturas:18]Incluida_en_Actas:44:=True:C214
								[Asignaturas:18]Es_Optativa:70:=(aSubjectType{$subjects}="Optativ@")
								[Asignaturas:18]Electiva:11:=(aSubjectType{$subjects}="Plan Elect@")
								[Asignaturas:18]En_InformesInternos:14:=True:C214
								[Asignaturas:18]Configuracion:63:=OB_Create 
								OB SET:C1220([Asignaturas:18]Opciones:57;"usaEvaluacionesEspeciales";False:C215)
								OB SET:C1220([Asignaturas:18]Opciones:57;"NoMostrarEnSTWA";False:C215)
								OB SET:C1220([Asignaturas:18]Opciones:57;"BloqueoPropDeEval";False:C215)
								If (aSex{$subjects}="Ambos@")
									[Asignaturas:18]Seleccion_por_sexo:24:=1
								Else 
									[Asignaturas:18]Seleccion_por_sexo:24:=2
									[Asignaturas:18]denominacion_interna:16:=[Asignaturas:18]Asignatura:3+" (Damas)"
								End if 
								$el:=Find in array:C230(aEvStyleName;aStyle{$subjects})
								If ($el>0)
									[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=aEvStyleID{$el}
								Else 
									[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=-5
								End if 
								SAVE RECORD:C53([Asignaturas:18])
								AS_CreateConfigObj ([Asignaturas:18]Numero:1)
								If ([Asignaturas:18]Seleccion_por_sexo:24>1)
									DUPLICATE RECORD:C225([Asignaturas:18])
									[Asignaturas:18]Numero:1:=SQ_SeqNumber (->[Asignaturas:18]Numero:1)
									[Asignaturas:18]Seleccion_por_sexo:24:=3
									[Asignaturas:18]denominacion_interna:16:=[Asignaturas:18]Asignatura:3+" (Varones)"
									[Asignaturas:18]auto_uuid:12:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
									SAVE RECORD:C53([Asignaturas:18])
								End if 
							End if 
						End for 
						
						
					Else 
						$number:=Num:C11(aNumber{$subjects})
						For ($grupos;1;$number)
							$processed:=$processed+1
							$grupoAbv:="G"+String:C10($number)
							$grupo:="Grupo "+String:C10($number)
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$processed/$subjectsNumber;__ ("Creando ")+[xxSTR_Materias:20]Materia:2+__ (", ")+$grupo)
							QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
							QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Curso:5=$grupo)
							If (Records in selection:C76([Asignaturas:18])=0)
								CREATE RECORD:C68([Asignaturas:18])
								[Asignaturas:18]Numero:1:=SQ_SeqNumber (->[Asignaturas:18]Numero:1)
								[Asignaturas:18]CHILE_CodigoMineduc:41:=[xxSTR_Materias:20]Codigo:10
								[Asignaturas:18]Asignatura:3:=[xxSTR_Materias:20]Materia:2
								[Asignaturas:18]Materia_UUID:46:=[xxSTR_Materias:20]Auto_UUID:21  //Asignatura, Materia Auto uuid
								[Asignaturas:18]denominacion_interna:16:=[Asignaturas:18]Asignatura:3+", "+$grupoAbv
								[Asignaturas:18]Abreviación:26:=[xxSTR_Materias:20]Abreviatura:8
								[Asignaturas:18]Curso:5:=$grupo
								[Asignaturas:18]Numero_del_Curso:25:=0
								[Asignaturas:18]Numero_del_Nivel:6:=$niveles
								[Asignaturas:18]Sector:9:=[xxSTR_Materias:20]Area:12
								[Asignaturas:18]Nivel:30:=$NombreNivel
								[Asignaturas:18]Incide_en_promedio:27:=aIncide{$subjects}
								[Asignaturas:18]posicion_en_informes_de_notas:36:=$subjects
								[Asignaturas:18]ordenGeneral:105:=String:C10($subjects;"#00")
								[Asignaturas:18]Numero_de_evaluaciones:38:=12
								[Asignaturas:18]Incluida_en_Actas:44:=True:C214
								[Asignaturas:18]Es_Optativa:70:=(aSubjectType{$subjects}="Optativ@")
								[Asignaturas:18]Electiva:11:=(aSubjectType{$subjects}="Plan Elect@")
								[Asignaturas:18]Configuracion:63:=OB_Create 
								OB SET:C1220([Asignaturas:18]Opciones:57;"usaEvaluacionesEspeciales";False:C215)
								OB SET:C1220([Asignaturas:18]Opciones:57;"NoMostrarEnSTWA";False:C215)
								OB SET:C1220([Asignaturas:18]Opciones:57;"BloqueoPropDeEval";False:C215)
								If (aSex{$subjects}="Ambos@")
									[Asignaturas:18]Seleccion_por_sexo:24:=1
								Else 
									[Asignaturas:18]Seleccion_por_sexo:24:=2
									[Asignaturas:18]denominacion_interna:16:=[Asignaturas:18]denominacion_interna:16+" (Damas)"
								End if 
								$el:=Find in array:C230(aEvStyleName;aStyle{$subjects})
								If ($el>0)
									[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=aEvStyleID{$el}
								Else 
									[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=-5
								End if 
								SAVE RECORD:C53([Asignaturas:18])
								AS_CreateConfigObj ([Asignaturas:18]Numero:1)
								If ([Asignaturas:18]Seleccion_por_sexo:24>1)
									DUPLICATE RECORD:C225([Asignaturas:18])
									[Asignaturas:18]Numero:1:=SQ_SeqNumber (->[Asignaturas:18]Numero:1)
									[Asignaturas:18]Seleccion_por_sexo:24:=3
									[Asignaturas:18]denominacion_interna:16:=[Asignaturas:18]denominacion_interna:16+" (Varones)"
									[Asignaturas:18]auto_uuid:12:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
									SAVE RECORD:C53([Asignaturas:18])
								End if 
							End if 
						End for 
					End if 
				End for 
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			SQ_SetSequences 
		End if 
	Else 
		CD_Dlog (0;__ ("No hay niveles oficiales definidos. Por favor configure los niveles en Configuración/Niveles Académicos y vuelva a intentarlo."))
	End if 
End if 

