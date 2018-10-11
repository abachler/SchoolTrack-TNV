//%attributes = {}
  //CAE_CreaHistoricoNiveles

C_LONGINT:C283($recNum;$OTref_Periodos)
C_BLOB:C604($blob)

READ ONLY:C145([xxSTR_Niveles:6])
READ WRITE:C146([xxSTR_HistoricoNiveles:191])
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)

  //vl_ultimoAño:=2009
  //QUERY SELECTION([xxSTR_Niveles];[xxSTR_Niveles]NoNivel=10)

ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([xxSTR_Niveles:6])
	GOTO RECORD:C242([xxSTR_Niveles:6];$aRecNums{$i})
	$key:=String:C10(<>gInstitucion)+"."+String:C10([xxSTR_Niveles:6]NoNivel:5)+"."+String:C10(vl_UltimoAño)
	$recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$key)
	If ($recNum<0)
		CREATE RECORD:C68([xxSTR_HistoricoNiveles:191])
		[xxSTR_HistoricoNiveles:191]ID_Institucion:1:=<>gInstitucion
		[xxSTR_HistoricoNiveles:191]NumeroNivel:3:=[xxSTR_Niveles:6]NoNivel:5
		[xxSTR_HistoricoNiveles:191]Año:2:=vl_UltimoAño
		SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
	End if 
	[xxSTR_HistoricoNiveles:191]NombreInterno:5:=[xxSTR_Niveles:6]Nivel:1
	[xxSTR_HistoricoNiveles:191]NombreOficial:6:=[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21
	[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10:=[xxSTR_Niveles:6]Actas_y_Certificados:43
	[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Interna:12:=[xxSTR_Niveles:6]Abreviatura:19
	[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Oficial:13:=[xxSTR_Niveles:6]Abreviatura_Oficial:35
	[xxSTR_HistoricoNiveles:191]DirectorResponsable:15:=[xxSTR_Niveles:6]Director:13
	[xxSTR_HistoricoNiveles:191]EsNivel_SubAnual:19:=[xxSTR_Niveles:6]Es_Nivel_SubAnual:50
	  //ABK - 2012.07.12 Nuevos campos en el histórico para almacenar información sobre el calculo de promedios generales
	  //                 Permite recalcular promedios históricos con todas las opciones existentes en el año actual   
	[xxSTR_HistoricoNiveles:191]PromediosGeneralesTruncados:20:=[xxSTR_Niveles:6]PromediosGeneralesTruncados:11
	[xxSTR_HistoricoNiveles:191]ModoPromedioGeneralInterno:21:=[xxSTR_Niveles:6]ModoPromedioGeneralInterno:47
	[xxSTR_HistoricoNiveles:191]ModoPromedioGeneralOficial:22:=[xxSTR_Niveles:6]ModoPromedioGeneralOficial:48
	  //20121031 ASM se agrega nuevo campo
	[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=[xxSTR_Niveles:6]AttendanceMode:3
	
	READ ONLY:C145([xxSTR_HistoricoEstilosEval:88])
	QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4=[xxSTR_Niveles:6]EvStyle_interno:33;*)
	QUERY:C277([xxSTR_HistoricoEstilosEval:88]; & ;[xxSTR_HistoricoEstilosEval:88]Año:2=vl_UltimoAño)
	[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
	READ ONLY:C145([xxSTR_HistoricoEstilosEval:88])
	QUERY:C277([xxSTR_HistoricoEstilosEval:88];[xxSTR_HistoricoEstilosEval:88]ID_EstiloOriginal:4=[xxSTR_Niveles:6]EvStyle_oficial:23;*)
	QUERY:C277([xxSTR_HistoricoEstilosEval:88]; & ;[xxSTR_HistoricoEstilosEval:88]Año:2=vl_UltimoAño)
	[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9:=[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3
	PERIODOS_LoadData (0;[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
	  //20120113 RCH Se setea campo para que no se elimine el blob con los periodos en el trigger
	[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=Size of array:C274(aiSTR_Periodos_Numero)
	$OTref_Periodos:=OT New 
	OT PutArray ($OTref_Periodos;"aiSTR_Periodos_Numero";aiSTR_Periodos_Numero)
	OT PutArray ($OTref_Periodos;"atSTR_Periodos_Nombre";atSTR_Periodos_Nombre)
	OT PutArray ($OTref_Periodos;"adSTR_Periodos_Desde";adSTR_Periodos_Desde)
	OT PutArray ($OTref_Periodos;"adSTR_Periodos_Hasta";adSTR_Periodos_Hasta)
	OT PutArray ($OTref_Periodos;"adSTR_Periodos_Cierre";adSTR_Periodos_Cierre)
	OT PutArray ($OTref_Periodos;"aiSTR_Periodos_Dias";aiSTR_Periodos_Dias)
	$blob:=OT ObjectToNewBLOB ($OTref_Periodos)
	OT Clear ($OTref_Periodos)  //2015/08/13
	[xxSTR_HistoricoNiveles:191]xConfiguracionPeriodos:7:=$blob
	SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
End for 