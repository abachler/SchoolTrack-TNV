//%attributes = {}
  // IN_LoadNiveles()
  // Por: Alberto Bachler K.: 24-07-15, 13:37:36
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($k;$l_procesoID;$l_recNum;$r)
C_TEXT:C284($t_rutaArchivo)

If (Application type:C494=4D Remote mode:K5:5)
	$l_procesoID:=Execute on server:C373(Current method name:C684;Pila_256K;Current method name:C684)
Else 
	$t_rutaArchivo:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+<>vtXS_CountryCode+Folder separator:K24:12+"Niveles_"+<>vtXS_CountryCode+".txt"
	SET CHANNEL:C77(10;$t_rutaArchivo)
	If (ok=1)
		$l_procesoID:=IT_UThermometer (1;0;__ ("Cargando el archivo de niveles por defecto…"))
		READ WRITE:C146([xxSTR_Niveles:6])
		RECEIVE VARIABLE:C81(nbRecords)
		For ($k;1;nbrecords)
			RECEIVE RECORD:C79([xxSTR_Niveles:6])
			$l_recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;[xxSTR_Niveles:6]NoNivel:5)
			If ($l_recNum<0)  //los nuevos niveles importados deben tener estos campos vacios ya que son particulares de cada colegio JHB 11/3/2008
				[xxSTR_Niveles:6]Director:13:=""
				[xxSTR_Niveles:6]Titulo firmante:8:=""
				SET BLOB SIZE:C606([xxSTR_Niveles:6]Actas_y_Certificados:43;0)
				[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38:=0
				[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39:=0
				[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41:=0
				[xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40:=0
				[xxSTR_Niveles:6]EvStyle_interno:33:=-5
				[xxSTR_Niveles:6]EvStyle_oficial:23:=-5
				[xxSTR_Niveles:6]AttendanceMode:3:=1
				[xxSTR_Niveles:6]Lates_Mode:16:=1
				[xxSTR_Niveles:6]AutoPromo_inasistencia:32:=True:C214
				[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44:=-1
				[xxSTR_Niveles:6]Auto_UUID:51:=Generate UUID:C1066  //20140123 RCH
				SAVE RECORD:C53([xxSTR_Niveles:6])
				LOG_RegisterEvt ("Nivel "+[xxSTR_Niveles:6]Nivel:1+" agregado a la base de datos.")
			Else 
				GOTO RECORD:C242([xxSTR_Niveles:6];$l_recNum)
				If ([xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44=0)
					[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44:=-1
				End if 
				PERIODOS_LoadData ([xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
				[xxSTR_Niveles:6]FechaInicio:29:=vdSTR_Periodos_InicioEjercicio
				[xxSTR_Niveles:6]FechaTermino:34:=vdSTR_Periodos_FinEjercicio
				[xxSTR_Niveles:6]Dias_habiles:20:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;[xxSTR_Niveles:6]FechaTermino:34)
				Case of 
					: (<>vtXS_CountryCode#"cl")
						SET BLOB SIZE:C606([xxSTR_Niveles:6]Actas_y_Certificados:43;0)
						[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38:=0
						[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39:=0
						[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41:=0
						[xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40:=0
				End case 
				SAVE RECORD:C53([xxSTR_Niveles:6])
			End if 
		End for 
		SET CHANNEL:C77(11)
		READ ONLY:C145([xxSTR_Niveles:6])
		IT_UThermometer (-2;$l_procesoID)
	Else 
		$r:=CD_Dlog (1;__ ("El archivo que contiene los niveles no pudo ser cargado."))
	End if 
End if 