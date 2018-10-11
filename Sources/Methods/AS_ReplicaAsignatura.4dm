//%attributes = {}
  //AS_ReplicaAsignatura


  // Método modificado por ABK 20110827
  // reemplazo de acceso a subtablas de consolidación (via [Asignaturas]Consolidantes por acceso estandar a tabla [Asignaturas_Consolidantes]
  //--------------------------------




C_LONGINT:C283($numeroCurso;$3;$1;$recNumAReplicar;$l_cantidadMadres)
C_TEXT:C284($curso;$2)
C_OBJECT:C1216($ob_configuracion;$ob_opciones)
$recNumAReplicar:=$1
$curso:=$2
$numeroCurso:=$3

KRL_GotoRecord (->[Asignaturas:18];$recNumAReplicar)
$asignatura:=[Asignaturas:18]Asignatura:3
$nivelOrigen:=[Asignaturas:18]Numero_del_Nivel:6
$configVariable:=[Asignaturas:18]Consolidacion_PorPeriodo:58
$estiloEval:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
$configExamenes:=[Asignaturas:18]OpcionesControles_y_Examenes:106
$Asignatura_No_Oficial:=[Asignaturas:18]Asignatura_No_Oficial:71
$AutoEvaluada:=[Asignaturas:18]AutoEvaluada:108
$CHILE_CodigoMineduc:=[Asignaturas:18]CHILE_CodigoMineduc:41
$Coefficientes_o_Porcentajes:=[Asignaturas:18]Consolidacion_TipoPonderacion:50
$ConObjetivosEspecificos:=[Asignaturas:18]ConObjetivosEspecificos:62
$ConsDec:=[Asignaturas:18]Consolidacion_Metodo:55
$Consolida_en:=[Asignaturas:18]Consolidacion_Madre_nombre:8
$ID_Consolidante:=[Asignaturas:18]Consolidacion_Madre_Id:7
$En_InformesInternos:=[Asignaturas:18]En_InformesInternos:14
$l_publicarEnSchoolnet:=[Asignaturas:18]Publicar_en_SchoolNet:60
$Es_Consolidante:=[Asignaturas:18]Consolidacion_EsConsolidante:35
$b_conSubasignaturas:=[Asignaturas:18]Consolidacion_ConSubasignaturas:31
$Electiva:=[Asignaturas:18]Electiva:11
$Es_Optativa:=[Asignaturas:18]Es_Optativa:70
$EVAPR_EsArea:=[Asignaturas:18]EVAPR_EsArea:93
$EVAPR_IdMatriz:=[Asignaturas:18]EVAPR_IdMatriz:91
$EVAPR_ModoCalculoArea:=[Asignaturas:18]EVAPR_ModoCalculoArea:94
$Eximible:=[Asignaturas:18]Eximible:28
$GrupoEstadistico:=[Asignaturas:18]GrupoEstadistico:89
$Horas_Anuales:=[Asignaturas:18]Horas_Anuales:68
$Horas_Semanales:=[Asignaturas:18]Horas_Semanales:51
$ID_Objetivo:=[Asignaturas:18]ID_Objetivos:43
$IncideEnPromedioInterno:=[Asignaturas:18]IncideEnPromedioInterno:64
$Incide_en_Asistencia:=[Asignaturas:18]Incide_en_Asistencia:45
$Incide_en_promedio:=[Asignaturas:18]Incide_en_promedio:27
$Incluida_en_Actas:=[Asignaturas:18]Incluida_en_Actas:44
$Ingresa_Esfuerzo:=[Asignaturas:18]Ingresa_Esfuerzo:40
$Nivel_Jerarquico:=[Asignaturas:18]nivel_jerarquico:107
$OrdenGeneral:=[Asignaturas:18]ordenGeneral:105
$PonderacionEnPromedioINT:=[Asignaturas:18]PonderacionEnPromedioINT:110
$PonderacionEnPromedioOF:=[Asignaturas:18]PonderacionEnPromedioOF:109
$Pondera_Esfuerzo:=[Asignaturas:18]Pondera_Esfuerzo:61
$Posición_en_Informes_de_Notas:=[Asignaturas:18]posicion_en_informes_de_notas:36
$Resultado_no_calculado:=[Asignaturas:18]Resultado_no_calculado:47
$Sector:=[Asignaturas:18]Sector:9
$Seleccion:=[Asignaturas:18]Seleccion:17
$Selección_por_sexo:=[Asignaturas:18]Seleccion_por_sexo:24
$ob_configuracion:=[Asignaturas:18]Configuracion:63
$ob_opciones:=[Asignaturas:18]Opciones:57

READ WRITE:C146([Asignaturas:18])
QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3;=;$asignatura;*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Curso:5=$curso;*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6;=;$nivelOrigen;*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]ordenGeneral:105=$OrdenGeneral)
$stop:=False:C215
Case of 
	: (Records in selection:C76([Asignaturas:18])>1)
		$result:=0
		
	: (Records in selection:C76([Asignaturas:18])=0)
		GOTO RECORD:C242([Asignaturas:18];$recNumAReplicar)
		DUPLICATE RECORD:C225([Asignaturas:18])
		[Asignaturas:18]Numero:1:=SQ_SeqNumber (->[Asignaturas:18]Numero:1)
		[Asignaturas:18]Curso:5:=$curso
		[Asignaturas:18]Numero_del_Curso:25:=$numeroCurso
		[Asignaturas:18]profesor_firmante_Nombre:34:=""
		[Asignaturas:18]profesor_firmante_numero:33:=0
		[Asignaturas:18]profesor_nombre:13:=""
		[Asignaturas:18]profesor_numero:4:=0
		[Asignaturas:18]Codigo_interno:48:=""
		[Asignaturas:18]Fecha_de_Creacion:56:=Current date:C33(*)
		[Asignaturas:18]Fecha_de_modificacion:15:=Current date:C33(*)
		[Asignaturas:18]Habilitacion_del_profesor:37:=""
		[Asignaturas:18]Horas_de_clases_efectivas:52:=0
		[Asignaturas:18]ID_BDExterna:102:=""
		[Asignaturas:18]LastNumber:54:=0
		[Asignaturas:18]Max_EX:87:=0
		[Asignaturas:18]Max_Final:88:=0
		[Asignaturas:18]Max_P1:82:=0
		[Asignaturas:18]Max_P2:83:=0
		[Asignaturas:18]Max_P3:84:=0
		[Asignaturas:18]Max_P4:85:=0
		[Asignaturas:18]Max_PF:86:=0
		[Asignaturas:18]Min_EX:80:=0
		[Asignaturas:18]Min_Final:81:=0
		[Asignaturas:18]Min_P1:75:=0
		[Asignaturas:18]Min_P2:76:=0
		[Asignaturas:18]Min_P3:77:=0
		[Asignaturas:18]Min_P4:78:=0
		[Asignaturas:18]Min_PF:79:=0
		[Asignaturas:18]PromedioFinalOficial_texto:67:=""
		[Asignaturas:18]PromedioFinal_texto:53:=""
		[Asignaturas:18]Promedio_final:20:=0
		[Asignaturas:18]Promedio_P1:23:=0
		[Asignaturas:18]Promedio_P2:22:=0
		[Asignaturas:18]Promedio_P3:21:=0
		[Asignaturas:18]Promedio_P4:59:=0
		[Asignaturas:18]Numero_de_alumnos:49:=0
		[Asignaturas:18]Numero_de_evaluaciones:38:=12
		[Asignaturas:18]UltimoIngresoDeNotas:32:=0
		[Asignaturas:18]Ultimo_archivo:72:=0
		[Asignaturas:18]auto_uuid:12:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
		QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;[Asignaturas:18]Numero:1)
		KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])
		SAVE RECORD:C53([Asignaturas:18])
		$id_asignatura:=[Asignaturas:18]Numero:1
		$recNumReplica:=Record number:C243([Asignaturas:18])
		$result:=2
		ADD TO SET:C119([Asignaturas:18];"Replicas")
		
		
	: (Records in selection:C76([Asignaturas:18])=1)
		If (cb_InicializarProfesores=1)
			[Asignaturas:18]profesor_firmante_Nombre:34:=""
			[Asignaturas:18]profesor_firmante_numero:33:=0
			[Asignaturas:18]profesor_nombre:13:=""
			[Asignaturas:18]profesor_numero:4:=0
		End if 
		[Asignaturas:18]Consolidacion_PorPeriodo:58:=$configVariable
		[Asignaturas:18]Numero_de_EstiloEvaluacion:39:=$estiloEval
		[Asignaturas:18]OpcionesControles_y_Examenes:106:=$configExamenes
		[Asignaturas:18]Asignatura_No_Oficial:71:=$Asignatura_No_Oficial
		[Asignaturas:18]AutoEvaluada:108:=$AutoEvaluada
		[Asignaturas:18]CHILE_CodigoMineduc:41:=$CHILE_CodigoMineduc
		[Asignaturas:18]Consolidacion_TipoPonderacion:50:=$Coefficientes_o_Porcentajes
		[Asignaturas:18]ConObjetivosEspecificos:62:=$ConObjetivosEspecificos
		[Asignaturas:18]Consolidacion_Metodo:55:=$ConsDec
		[Asignaturas:18]En_InformesInternos:14:=$En_InformesInternos
		[Asignaturas:18]Publicar_en_SchoolNet:60:=$l_publicarEnSchoolnet
		[Asignaturas:18]Consolidacion_EsConsolidante:35:=$Es_Consolidante
		[Asignaturas:18]Electiva:11:=$Electiva
		[Asignaturas:18]Es_Optativa:70:=$Es_Optativa
		[Asignaturas:18]EVAPR_EsArea:93:=$EVAPR_EsArea
		[Asignaturas:18]EVAPR_IdMatriz:91:=$EVAPR_IdMatriz
		[Asignaturas:18]EVAPR_ModoCalculoArea:94:=$EVAPR_ModoCalculoArea
		[Asignaturas:18]Eximible:28:=$Eximible
		[Asignaturas:18]GrupoEstadistico:89:=$GrupoEstadistico
		[Asignaturas:18]Horas_Anuales:68:=$Horas_Anuales
		[Asignaturas:18]Horas_Semanales:51:=$Horas_Semanales
		[Asignaturas:18]ID_Objetivos:43:=$ID_Objetivo
		[Asignaturas:18]IncideEnPromedioInterno:64:=$IncideEnPromedioInterno
		[Asignaturas:18]Incide_en_Asistencia:45:=$Incide_en_Asistencia
		[Asignaturas:18]Incide_en_promedio:27:=$Incide_en_promedio
		[Asignaturas:18]Incluida_en_Actas:44:=$Incluida_en_Actas
		[Asignaturas:18]Ingresa_Esfuerzo:40:=$Ingresa_Esfuerzo
		[Asignaturas:18]nivel_jerarquico:107:=$Nivel_Jerarquico
		[Asignaturas:18]ordenGeneral:105:=$OrdenGeneral
		[Asignaturas:18]PonderacionEnPromedioINT:110:=$PonderacionEnPromedioINT
		[Asignaturas:18]PonderacionEnPromedioOF:109:=$PonderacionEnPromedioOF
		[Asignaturas:18]Pondera_Esfuerzo:61:=$Pondera_Esfuerzo
		[Asignaturas:18]posicion_en_informes_de_notas:36:=$Posición_en_Informes_de_Notas
		[Asignaturas:18]Resultado_no_calculado:47:=$Resultado_no_calculado
		[Asignaturas:18]Sector:9:=$Sector
		[Asignaturas:18]Seleccion:17:=$Seleccion
		[Asignaturas:18]Seleccion_por_sexo:24:=$Selección_por_sexo
		[Asignaturas:18]Configuracion:63:=$ob_configuracion
		[Asignaturas:18]Opciones:57:=$ob_opciones
		
		QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;[Asignaturas:18]Numero:1)
		KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])
		SAVE RECORD:C53([Asignaturas:18])
		$recNumReplica:=Record number:C243([Asignaturas:18])
		$id_Asignatura:=[Asignaturas:18]Numero:1
		$result:=1
		ADD TO SET:C119([Asignaturas:18];"Replicas")
		
End case 


If ($result>0)
	  //leo las propiedades de evaluación de las 
	  //GOTO RECORD([Asignaturas];$recNumAReplicar)
	  //If ([Asignaturas]Consolidacion_PorPeriodo)
	  //$fatObjectName:="Blob_ConfigNotas/"+String([Asignaturas]Numero)+"/@"
	  //Else 
	  //$fatObjectName:="Blob_ConfigNotas/"+String([Asignaturas]Numero)
	  //End if 
	  //QUERY([XShell_FatObjects];[XShell_FatObjects]FatObjectName=$fatObjectName)
	  //ARRAY LONGINT($aRecNums;0)
	  //LONGINT ARRAY FROM SELECTION([XShell_FatObjects];$aRecNums;"")
	  //For ($iPropiedades;1;Size of array($aRecNums))
	  //READ WRITE([XShell_FatObjects])
	  //GOTO RECORD([XShell_FatObjects];$aRecNums{$iPropiedades})
	  //$blob:=[XShell_FatObjects]BlobObject
	  //$newFatObjectName:=Replace string([XShell_FatObjects]FatObjectName;"Blob_ConfigNotas/"+String([Asignaturas]Numero);"Blob_ConfigNotas/"+String($id_Asignatura))
	
	
	  //$recNUM:=Find in field([XShell_FatObjects]FatObjectName;$newFatObjectName)
	  //If ($recNUM>=0)
	  //READ WRITE([XShell_FatObjects])
	  //GOTO RECORD([XShell_FatObjects];$recNum)
	  //[XShell_FatObjects]BlobObject:=$blob
	  //SAVE RECORD([XShell_FatObjects])
	  //Else 
	  //GOTO RECORD([XShell_FatObjects];$aRecNums{$iPropiedades})
	  //DUPLICATE RECORD([XShell_FatObjects])
	  //[XShell_FatObjects]FatObjectName:=$newFatObjectName
	  //[XShell_FatObjects]Auto_UUID:=Generate UUID  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
	  //SAVE RECORD([XShell_FatObjects])
	  //End if 
	  //APPEND TO ARRAY(at_PropiedadesEvalReplicadas;$newFatObjectName)
	
	  //AS_PropEval_Lectura ([XShell_FatObjects]FatObjectName)
	
	  //End for 
	
	
	GOTO RECORD:C242([Asignaturas:18];$recNumReplica)
	vl_uThermProcessID:=IT_UThermometer (0;vl_uThermProcessID;__ ("Replicando Asignaturas...\r")+[Asignaturas:18]Asignatura:3+__ (" en ")+[Asignaturas:18]Curso:5)
	If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
		$idMadre:=[Asignaturas:18]Numero:1
		$nombreMadre:=[Asignaturas:18]denominacion_interna:16
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		For ($Periodos;1;Size of array:C274(atSTR_Periodos_Nombre))
			GOTO RECORD:C242([Asignaturas:18];$recNumReplica)
			atSTR_Periodos_Nombre:=$Periodos
			  //$fatObjectName:="Blob_ConfigNotas/"+String([Asignaturas]Numero)+"/P"+String($Periodos)
			AS_PropEval_Lectura ("P"+String:C10($Periodos))
			COPY ARRAY:C226(atAS_EvalPropSourceName;$aEvalSourceName)  //destination name
			COPY ARRAY:C226(atAS_EvalPropClassName;$atAS_EvalPropClassName)  //destination class
			COPY ARRAY:C226(alAS_EvalPropSourceID;$aEvalSourceID)  //id destination
			COPY ARRAY:C226(aiAS_EvalPropEnterable;$aiAS_EvalPropEnterable)  //method
			COPY ARRAY:C226(arAS_EvalPropPercent;$arAS_EvalPropPercent)  //grade weight
			COPY ARRAY:C226(arAS_EvalPropCoefficient;$arAS_EvalPropCoefficient)  //coefficient
			COPY ARRAY:C226(abAS_EvalPropPrintDetail;$abAS_EvalPropPrintDetail)  //print on reports
			COPY ARRAY:C226(atAS_EvalPropPrintName;$atAS_EvalPropPrintName)  //print as
			COPY ARRAY:C226(atAS_EvalPropDescription;$atAS_EvalPropDescription)  //description
			COPY ARRAY:C226(adAS_EvalPropDueDate;$adAS_EvalPropDueDate)  //due date  
			COPY ARRAY:C226(arAS_EvalPropPonderacion;$arAS_EvalPropPonderacion)
			$arAS_EvalPropPonderacion:=vi_DecimalesPonderacion
			$vi_PonderacionTruncada:=vi_PonderacionTruncada
			$vi_ConsolidaExamenFinal:=vi_ConsolidaExamenFinal
			$vi_ConsolidaNotasFinales:=vi_ConsolidaNotasFinales
			$vlAS_CalcMethod:=vlAS_CalcMethod
			
			For ($iColumnas;1;Size of array:C274($aEvalSourceID))
				Case of 
					: ($aEvalSourceID{$iColumnas}<0)  //subasignaturas
						$referencia:=String:C10($idMadre)+"."+String:C10($periodos)+"."+String:C10($iColumnas)
						CREATE RECORD:C68([xxSTR_Subasignaturas:83])
						[xxSTR_Subasignaturas:83]LongID:7:=$idMadre
						[xxSTR_Subasignaturas:83]Name:2:=$aEvalSourceName{$iColumnas}
						[xxSTR_Subasignaturas:83]ID_Mother:6:=$idMadre
						[xxSTR_Subasignaturas:83]Periodo:12:=$Periodos
						[xxSTR_Subasignaturas:83]Columna:13:=$iColumnas
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
						$aEvalSourceID{$iColumnas}:=[xxSTR_Subasignaturas:83]LongID:7
						$aEvalSourceName{$iColumnas}:=[xxSTR_Subasignaturas:83]Name:2
						
						
					: ($aEvalSourceID{$iColumnas}>0)  //asignaturas hijas
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3;=;$asignatura;*)
						QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Curso:5=$curso;*)
						QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6;=;$nivelOrigen)
						
						$idHija:=$aEvalSourceID{$iColumnas}
						$recNum:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$idHija)
						If ($recNum>=0)
							$result:=AS_ReplicaAsignatura ($recNum;$curso;$numeroCurso)
							If ($result>0)
								$aEvalSourceID{$iColumnas}:=[Asignaturas:18]Numero:1
								$aEvalSourceName{$iColumnas}:=[Asignaturas:18]denominacion_interna:16
								$atAS_EvalPropClassName{$iColumnas}:=[Asignaturas:18]Curso:5
								[Asignaturas:18]Consolidacion_Madre_Id:7:=-1
								[Asignaturas:18]Consolidacion_Madre_nombre:8:="Varía según período"
								CREATE RECORD:C68([Asignaturas_Consolidantes:231])
								[Asignaturas_Consolidantes:231]ID_ParentRecord:5:=$aEvalSourceID{$iColumnas}
								[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1:=$idMadre
								[Asignaturas_Consolidantes:231]Name:2:=$nombreMadre
								[Asignaturas_Consolidantes:231]Periodo:3:=String:C10($Periodos)
								SAVE RECORD:C53([Asignaturas_Consolidantes:231])
								  //SAVE RECORD([Asignaturas])
								GOTO RECORD:C242([Asignaturas:18];$recNumReplica)
								
							End if 
						End if 
				End case 
			End for 
			
			GOTO RECORD:C242([Asignaturas:18];$recNumReplica)
			  //$fatObjectName:="Blob_ConfigNotas/"+String([Asignaturas]Numero)+"/P"+String($Periodos)
			AS_PropEval_Lectura ("P"+String:C10($Periodos))
			COPY ARRAY:C226($aEvalSourceName;atAS_EvalPropSourceName)  //destination name
			COPY ARRAY:C226($atAS_EvalPropClassName;atAS_EvalPropClassName)  //destination class
			COPY ARRAY:C226($aEvalSourceID;alAS_EvalPropSourceID)  //id destination
			COPY ARRAY:C226($aiAS_EvalPropEnterable;aiAS_EvalPropEnterable)  //method
			COPY ARRAY:C226($arAS_EvalPropPercent;arAS_EvalPropPercent)  //grade weight
			COPY ARRAY:C226($arAS_EvalPropCoefficient;arAS_EvalPropCoefficient)  //coefficient
			COPY ARRAY:C226($abAS_EvalPropPrintDetail;abAS_EvalPropPrintDetail)  //print on reports
			COPY ARRAY:C226($atAS_EvalPropPrintName;atAS_EvalPropPrintName)  //print as
			COPY ARRAY:C226($atAS_EvalPropDescription;atAS_EvalPropDescription)  //description
			COPY ARRAY:C226($adAS_EvalPropDueDate;adAS_EvalPropDueDate)  //due date  
			COPY ARRAY:C226($arAS_EvalPropPonderacion;arAS_EvalPropPonderacion)
			vi_DecimalesPonderacion:=$arAS_EvalPropPonderacion
			vi_PonderacionTruncada:=$vi_PonderacionTruncada
			vi_ConsolidaExamenFinal:=$vi_ConsolidaExamenFinal
			vi_ConsolidaNotasFinales:=$vi_ConsolidaNotasFinales
			vlAS_CalcMethod:=$vlAS_CalcMethod
			AS_PropEval_Escritura ($Periodos)  //MONO CAMBIO AS_PropEval_Escritura
		End for 
		
		
		
	Else 
		$idMadre:=[Asignaturas:18]Numero:1
		$nombreMadre:=[Asignaturas:18]denominacion_interna:16
		  //$fatObjectName:="Blob_ConfigNotas/"+String([Asignaturas]Numero)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		AS_PropEval_Lectura ("Anual")
		COPY ARRAY:C226(atAS_EvalPropSourceName;$aEvalSourceName)  //destination name
		COPY ARRAY:C226(atAS_EvalPropClassName;$atAS_EvalPropClassName)  //destination class
		COPY ARRAY:C226(alAS_EvalPropSourceID;$aEvalSourceID)  //id destination
		COPY ARRAY:C226(aiAS_EvalPropEnterable;$aiAS_EvalPropEnterable)  //method
		COPY ARRAY:C226(arAS_EvalPropPercent;$arAS_EvalPropPercent)  //grade weight
		COPY ARRAY:C226(arAS_EvalPropCoefficient;$arAS_EvalPropCoefficient)  //coefficient
		COPY ARRAY:C226(abAS_EvalPropPrintDetail;$abAS_EvalPropPrintDetail)  //print on reports
		COPY ARRAY:C226(atAS_EvalPropPrintName;$atAS_EvalPropPrintName)  //print as
		COPY ARRAY:C226(atAS_EvalPropDescription;$atAS_EvalPropDescription)  //description
		COPY ARRAY:C226(adAS_EvalPropDueDate;$adAS_EvalPropDueDate)  //due date  
		COPY ARRAY:C226(arAS_EvalPropPonderacion;$arAS_EvalPropPonderacion)
		$arAS_EvalPropPonderacion:=vi_DecimalesPonderacion
		$vi_PonderacionTruncada:=vi_PonderacionTruncada
		$vi_ConsolidaExamenFinal:=vi_ConsolidaExamenFinal
		$vi_ConsolidaNotasFinales:=vi_ConsolidaNotasFinales
		$vlAS_CalcMethod:=vlAS_CalcMethod
		
		For ($iColumnas;1;Size of array:C274($aEvalSourceID))
			Case of 
				: ($aEvalSourceID{$iColumnas}<0)  //subasignaturas
					For ($Periodos;1;Size of array:C274(atSTR_Periodos_Nombre))
						$referencia:=String:C10($idMadre)+"."+String:C10($periodos)+"."+String:C10($iColumnas)
						CREATE RECORD:C68([xxSTR_Subasignaturas:83])
						[xxSTR_Subasignaturas:83]LongID:7:=$idMadre
						[xxSTR_Subasignaturas:83]Name:2:=$aEvalSourceName{$iColumnas}
						[xxSTR_Subasignaturas:83]ID_Mother:6:=$idMadre
						[xxSTR_Subasignaturas:83]Periodo:12:=$Periodos
						[xxSTR_Subasignaturas:83]Columna:13:=$iColumnas
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
						$aEvalSourceID{$iColumnas}:=[xxSTR_Subasignaturas:83]LongID:7
						$aEvalSourceName{$iColumnas}:=[xxSTR_Subasignaturas:83]Name:2
					End for 
				: ($aEvalSourceID{$iColumnas}>0)  //asignaturas hijas
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3;=;$asignatura;*)
					QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Curso:5=$curso;*)
					QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6;=;$nivelOrigen)
					
					$idHija:=$aEvalSourceID{$iColumnas}
					$recNum:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$idHija)
					If ($recNum>=0)
						$result:=AS_ReplicaAsignatura ($recNum;$curso;$numeroCurso)
						If ($result>0)
							$aEvalSourceID{$iColumnas}:=[Asignaturas:18]Numero:1
							$aEvalSourceName{$iColumnas}:=[Asignaturas:18]denominacion_interna:16
							$atAS_EvalPropClassName{$iColumnas}:=[Asignaturas:18]Curso:5
							  //[Asignaturas]Consolidacion_Madre_Id:=-1
							  //[Asignaturas]Consolidacion_Madre_nombre:="Varía según período"
							CREATE RECORD:C68([Asignaturas_Consolidantes:231])
							[Asignaturas_Consolidantes:231]ID_ParentRecord:5:=$aEvalSourceID{$iColumnas}
							[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1:=$idMadre
							[Asignaturas_Consolidantes:231]Name:2:=$nombreMadre
							  //[Asignaturas_Consolidantes]Periodo:=String($Periodos)
							SAVE RECORD:C53([Asignaturas_Consolidantes:231])
							  //Mono Ticket 182941
							SET QUERY DESTINATION:C396(Into variable:K19:4;$l_cantidadMadres)
							QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5=$aEvalSourceID{$iColumnas})
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							Case of 
								: ($l_cantidadMadres>1)
									[Asignaturas:18]Consolidacion_Madre_Id:7:=-1
									[Asignaturas:18]Consolidacion_Madre_nombre:8:="Varía según período"
									SAVE RECORD:C53([Asignaturas:18])
								: ($l_cantidadMadres=1)
									[Asignaturas:18]Consolidacion_Madre_Id:7:=$idMadre
									[Asignaturas:18]Consolidacion_Madre_nombre:8:=$nombreMadre
									SAVE RECORD:C53([Asignaturas:18])
							End case 
							
						End if 
					End if 
			End case 
			
		End for 
		
		GOTO RECORD:C242([Asignaturas:18];$recNumReplica)
		AS_PropEval_Lectura ("Anual")
		COPY ARRAY:C226($aEvalSourceName;atAS_EvalPropSourceName)  //destination name
		COPY ARRAY:C226($atAS_EvalPropClassName;atAS_EvalPropClassName)  //destination class
		COPY ARRAY:C226($aEvalSourceID;alAS_EvalPropSourceID)  //id destination
		COPY ARRAY:C226($aiAS_EvalPropEnterable;aiAS_EvalPropEnterable)  //method
		COPY ARRAY:C226($arAS_EvalPropPercent;arAS_EvalPropPercent)  //grade weight
		COPY ARRAY:C226($arAS_EvalPropCoefficient;arAS_EvalPropCoefficient)  //coefficient
		COPY ARRAY:C226($abAS_EvalPropPrintDetail;abAS_EvalPropPrintDetail)  //print on reports
		COPY ARRAY:C226($atAS_EvalPropPrintName;atAS_EvalPropPrintName)  //print as
		COPY ARRAY:C226($atAS_EvalPropDescription;atAS_EvalPropDescription)  //description
		COPY ARRAY:C226($adAS_EvalPropDueDate;adAS_EvalPropDueDate)  //due date  
		COPY ARRAY:C226($arAS_EvalPropPonderacion;arAS_EvalPropPonderacion)
		vi_DecimalesPonderacion:=$arAS_EvalPropPonderacion
		vi_PonderacionTruncada:=$vi_PonderacionTruncada
		vi_ConsolidaExamenFinal:=$vi_ConsolidaExamenFinal
		vi_ConsolidaNotasFinales:=$vi_ConsolidaNotasFinales
		vlAS_CalcMethod:=$vlAS_CalcMethod
		AS_PropEval_Escritura (0)  //MONO CAMBIO AS_PropEval_Escritura
	End if 
	
Else 
	
	
End if 
$0:=$result

Case of 
	: ($result=2)
		APPEND TO ARRAY:C911(aLogEvents;$asignatura+" creada en el curso "+$curso+". La configuración de la asignatura original ("+vt_CursoOrigen+") es replicada en esta nueva asignatur"+"a.")
		
	: ($result=1)
		APPEND TO ARRAY:C911(aLogEvents;$asignatura+" ya existe en el curso "+$curso+". La configuración de la asignatura original ("+vt_CursoOrigen+") es replicada en esta asignatura.")
		
	: ($result=0)
		APPEND TO ARRAY:C911(aLogEvents;"ERROR: Se encontró más de una asignatura con el nombre "+$asignatura+" en el curso "+$curso+". La configuración de la asignatura no puede ser replicada.")
		
End case 
