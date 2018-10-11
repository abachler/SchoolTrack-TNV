//%attributes = {}
  //CFG_STR_LoadConfiguration


  // DECLARACIONES
  // -------------------------------------------------------------------------------
C_TEXT:C284($message;$1)
C_LONGINT:C283($vl_pos)
  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
$message:=$1

  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
Case of 
	: ($message="Niveles")
		vb_CambiosEnPromocion:=False:C215
		
		If ([xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=0)
			[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44:=-1
		End if 
		SELECT LIST ITEMS BY REFERENCE:C630(hl_ModoPromedioInterno;[xxSTR_Niveles:6]ModoPromedioGeneralInterno:47+1)
		SELECT LIST ITEMS BY REFERENCE:C630(hl_ModoPromedioOficial;[xxSTR_Niveles:6]ModoPromedioGeneralOficial:48+1)
		PERIODOS_LoadData (0;[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
		[xxSTR_Niveles:6]FechaTermino:34:=vdSTR_Periodos_FinEjercicio
		[xxSTR_Niveles:6]FechaInicio:29:=vdSTR_Periodos_InicioEjercicio
		[xxSTR_Niveles:6]Dias_habiles:20:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;[xxSTR_Niveles:6]FechaTermino:34)
		  //SELECT LIST ITEMS BY REFERENCE(hl_Configuraciones;[xxSTR_Niveles]ID_ConfiguracionPeriodos)
		  //REDRAW LIST(hl_Configuraciones)
		  //20121004 JHB/ASM no carga la referencia cuando esta es -1. 
		SELECT LIST ITEMS BY REFERENCE:C630(hl_Configuraciones;[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
		$vl_pos:=Selected list items:C379(hl_Configuraciones)
		SELECT LIST ITEMS BY POSITION:C381(hl_Configuraciones;$vl_pos)
		
		If ([xxSTR_Niveles:6]Sección:9#"")
			$s:=Find in array:C230(<>aListSect;[xxSTR_Niveles:6]Sección:9)
			If ($s>0)
				<>aListSect:=$s
			Else 
				<>aListSect:=0
			End if 
		Else 
			<>aListSect:=0
		End if 
		If ([xxSTR_Niveles:6]Dias_habiles:20=0)
			[xxSTR_Niveles:6]Dias_habiles:20:=viSTR_Periodos_DiasAgno
		End if 
		If ([xxSTR_Niveles:6]Promoción_auto:18)
			r2:=1
			r1:=0
			IT_SetEnterable (False:C215;0;->[xxSTR_Niveles:6]Minimo_asistencia:24;->vs_minimo0;->vs_minimo1;->vs_minimo2;->vs_minimo3)
		Else 
			r1:=1
			r2:=0
			IT_SetEnterable (True:C214;0;->[xxSTR_Niveles:6]Minimo_asistencia:24;->vs_minimo0;->vs_minimo1;->vs_minimo2;->vs_minimo3)
		End if 
		ARRAY TEXT:C222(aStyleNames;0)
		COPY ARRAY:C226(aEvStyleName;aStyleNames)
		$el:=Find in array:C230(aEvStyleId;[xxSTR_Niveles:6]EvStyle_interno:33)
		If ($el>0)
			aStyleNames:=$el
		Else 
			aStyleNames:=0
		End if 
		
		If ([xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37=False:C215)
			br_UseOfficialStyle:=0
			br_UseSubjectStyle:=1
		Else 
			br_UseOfficialStyle:=1
			br_UseSubjectStyle:=0
		End if 
		$el:=Find in array:C230(aEvStyleId;[xxSTR_Niveles:6]EvStyle_oficial:23)
		If ($el>0)
			aEvStyleName:=$el
			[xxSTR_Niveles:6]EvStyle_oficial:23:=aEvStyleId{$el}
			READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
			GOTO RECORD:C242([xxSTR_EstilosEvaluacion:44];aEvStyleRecNo{$el})
			EVS_ReadStyleData 
			Case of 
				: (iEvaluationMode=Notas)
					vs_minimo0:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_0:25;Notas;iGradesDEC)
					vs_minimo1:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_1:26;Notas;iGradesDEC)
					vs_minimo2:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_2:27;Notas;iGradesDEC)
					vs_minimo3:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_3:31;Notas;iGradesDEC)
				: (iEvaluationMode=Puntos)
					vs_minimo0:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_0:25;Puntos;iPointsDEC)
					vs_minimo1:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_1:26;Puntos;iPointsDEC)
					vs_minimo2:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_2:27;Puntos;iPointsDEC)
					vs_minimo3:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_3:31;Puntos;iPointsDEC)
				: (iEvaluationMode=Porcentaje)
					vs_minimo0:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_0:25;Porcentaje;1)
					vs_minimo1:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_1:26;Porcentaje;1)
					vs_minimo2:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_2:27;Porcentaje;1)
					vs_minimo3:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_3:31;Porcentaje;1)
				: (iEvaluationMode=Simbolos)
					vs_minimo0:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_0:25;Simbolos)
					vs_minimo1:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_1:26;Simbolos)
					vs_minimo2:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_2:27;Simbolos)
					vs_minimo3:=EV2_Real_a_Literal ([xxSTR_Niveles:6]Minimo_3:31;Simbolos)
			End case 
		Else 
			aEvStyleName:=0
		End if 
		If ([xxSTR_Niveles:6]AttendanceMode:3=0)
			[xxSTR_Niveles:6]AttendanceMode:3:=1
			SAVE RECORD:C53([xxSTR_Niveles:6])
		End if 
		If ([xxSTR_Niveles:6]Lates_Mode:16=0)
			[xxSTR_Niveles:6]Lates_Mode:16:=1
			SAVE RECORD:C53([xxSTR_Niveles:6])
		End if 
		at_AttendanceMode:=[xxSTR_Niveles:6]AttendanceMode:3
		at_LatesMode:=[xxSTR_Niveles:6]Lates_Mode:16
		If ([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41=0)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoEducacion;1)
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoEducacion;[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41)
		End if 
		_O_REDRAW LIST:C382(hl_TipoEducacion)
		
		$nivelSiguiente:=[xxSTR_Niveles:6]NoNivel:5+1
		$nivelSiguienteEsActivo:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelSiguiente;->[xxSTR_Niveles:6]EsNIvelActivo:30)  //AS. 20110718. se estaba cargando la configuración del nivel superior al seleccionado.
		  //$nivel:=[xxSTR_Niveles]NoNivel
		  //$nivelSiguienteEsActivo:=KRL_GetBooleanFieldData (->[xxSTR_Niveles]NoNivel;->$nivel;->[xxSTR_Niveles]EsNIvelActivo)
		If ($nivelSiguienteEsActivo)
			PERIODOS_LoadData ($nivelSiguiente)
			  //PERIODOS_LoadData ($nivel)
			$fechaInicioSiguiente:=vdSTR_Periodos_InicioEjercicio
			$fechaTerminoSiguiente:=vdSTR_Periodos_FinEjercicio
			PERIODOS_LoadData ([xxSTR_Niveles:6]NoNivel:5)
			If (vdSTR_Periodos_FinEjercicio>$fechaInicioSiguiente)
				OBJECT SET VISIBLE:C603(*;"ConflictoFechasPeriodos";True:C214)
				OBJECT SET ENTERABLE:C238(*;"NivelSubanual";False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*;"ConflictoFechasPeriodos";False:C215)
				OBJECT SET ENTERABLE:C238(*;"NivelSubanual";True:C214)
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*;"ConflictoFechasPeriodos";True:C214)
			OBJECT SET ENTERABLE:C238(*;"NivelSubanual";False:C215)
		End if 
		
		  //If (USR_GetUserID <0)
		  //NIV_CiclosEscolares 
		  //End if 
		
		ALP_RemoveAllArrays (xALP_MetaDatos)
		MData_Edit (->[xxSTR_Niveles:6]NoNivel:5;<>gYear;False:C215)
		
		STR_ResponsableNiveles ("init")
		
	: ($message="Evaluacion")
		EVS_initialize 
		ARRAY TEXT:C222(aTerms;3)
		ARRAY TEXT:C222(aEvMode;0)
		ARRAY TEXT:C222(aEvViewMode;0)
		ARRAY TEXT:C222(aEvPrintMode;0)
		ARRAY TEXT:C222(aEvStoreMode;0)
		ARRAY TEXT:C222(aEvActas;0)
		ARRAY TEXT:C222(aEvRangos;0)
		COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvStoreMode)
		COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvMode)
		COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvPrintMode)
		COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvViewMode)
		COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvActas)
		COPY ARRAY:C226(<>atSTR_ModosEvaluacion;aEvRangos)
		COPY ARRAY:C226(<>atSTR_ModoConversionSimbolos;aEvEquMethod)
		DELETE FROM ARRAY:C228(aEvRangos;4;1)
		aEvRangos:=Notas
		
		EVS_LoadStyles 
		AT_Initialize (->aSymbol;->aSymbDesc;->aSymbFrom;->aSymbTo;->aSymbGradeFrom;->aSymbGradeTo;->aSymbPointsFrom;->aSymbPointsTo;->aSymbPctFrom;->aSymbPctTo)
		AT_Initialize (->aIndEsfuerzo;->aDescEsfuerzo;->aFactorEsfuerzo;->aSTWAColorRGB;->aSTWAColorHexa)  //ASM 20180714 Ticket 211218
		OBJECT SET VISIBLE:C603(*;"DescEsfuerzo";(cb_EvaluaEsfuerzo=1))
		
	: ($message="Subsectores")
		xALSet_STR_Materias 
		<>aAsign:=0
		IT_SetButtonState (False:C215;->b_Editar;->b_Eliminar)
		ALL RECORDS:C47([xxSTR_Materias:20])
		AL_UpdateFields (xALP_Materias;2)
		ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Orden interno:9;>)
		AL_SetSort (xALP_Materias;1)
		AL_SetLine (xALP_Materias;0)
		r1:=1
		
	: ($message="Colegio")
		If (([Colegio:31]Pais:21="") | ([Colegio:31]Codigo_Pais:31=""))
			[Colegio:31]Pais:21:="Chile"
			[Colegio:31]Codigo_Pais:31:="cl"
			<>gPais:="Chile"
		End if 
		
		$element:=HL_FindElement (hl_Pais;[Colegio:31]Codigo_Pais:31+":@")
		SELECT LIST ITEMS BY POSITION:C381(hl_Pais;$element)
		If (([Colegio:31]MINEDUC_CodigoEnsenanza:32="") | ([Colegio:31]MINEDUC_CodigoEnsenanza:32="1"))
			[Colegio:31]MINEDUC_CodigoEnsenanza:32:=""
			SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoEstablecimiento;1)
			OBJECT SET VISIBLE:C603([Colegio:31]MINEDUC_CodigoEnsenanza:32;False:C215)
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoEstablecimiento;Num:C11([Colegio:31]MINEDUC_CodigoEnsenanza:32))
			OBJECT SET VISIBLE:C603([Colegio:31]MINEDUC_CodigoEnsenanza:32;True:C214)
		End if 
		
		ALP_RemoveAllArrays (xALP_MetaDatos)
		MData_Edit (->[Colegio:31]ID_Colegio:57;<>gYear;False:C215)
		
		
End case 
XS_SetConfigInterface 