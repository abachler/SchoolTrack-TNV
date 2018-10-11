  // [xxSTR_Niveles].Certificado.Variable2530()
  // Por: Alberto Bachler K.: 28-02-14, 21:14:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_objetoActas;$x_estiloEvaluacion_Interno;$x_estiloEvaluacion_Oficial)
C_LONGINT:C283($l_año;$l_IdEstiloInterno;$l_IdEstiloOficial;$l_modoRegistroAsistencia;$l_opcionUsuario)

$l_opcionUsuario:=CD_Dlog (0;__ ("Se creará un modelo de certificado para el año ")+String:C10(<>aYears{1}-1)+__ (".");__ ("");__ ("Aceptar");__ ("Cancelar"))
If ($l_opcionUsuario=1)
	$l_año:=<>aYears{1}-1
	AL_UpdateArrays (xALP_CertTplt;0)
	ACTAS_GuardaConfiguracion ([xxSTR_Niveles:6]NoNivel:5;"";<>aYears{lastYear})
	Case of 
		: (Find in array:C230(<>aYears;$l_año)>0)
			CD_Dlog (0;__ ("El modelo de certificado ya existe."))
		: ($l_año><>gYear)
			CD_Dlog (0;__ ("No es posible crear modelos de certificados para años anteriores al año actual."))
		: ((<>aYears{1}-$l_año)>1)
			CD_Dlog (0;__ ("No es posible crear modelos de certificados para años no consecutivos."))
		Else 
			QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1=$l_año)
			If (Records in selection:C76([xxSTR_DatosDeCierre:24])=0)
				QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1;=;$l_año+1)
				If (Records in selection:C76([xxSTR_DatosDeCierre:24])>0)
					DUPLICATE RECORD:C225([xxSTR_DatosDeCierre:24])
					[xxSTR_DatosDeCierre:24]Auto_UUID:10:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
				Else 
					CREATE RECORD:C68([xxSTR_DatosDeCierre:24])
				End if 
				[xxSTR_DatosDeCierre:24]Year:1:=$l_año
				SAVE RECORD:C53([xxSTR_DatosDeCierre:24])
				ARRAY INTEGER:C220(<>aYears;0)
				ALL RECORDS:C47([xxSTR_DatosDeCierre:24])
				SELECTION TO ARRAY:C260([xxSTR_DatosDeCierre:24]Year:1;<>aYears)
				SORT ARRAY:C229(<>aYears;>)
				INSERT IN ARRAY:C227(<>aYears;Size of array:C274(<>aYears)+1;1)
				<>aYears{Size of array:C274(<>aYears)}:=<>gYear
			End if 
			STR_ReadGlobals 
			READ WRITE:C146([xxSTR_Niveles:6])
			LOAD RECORD:C52([xxSTR_Niveles:6])
			QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3=[xxSTR_Niveles:6]NoNivel:5;*)
			QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]Año:2=$l_año)
			
			If (($l_año+1)<<>gYear)
				QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3=[xxSTR_Niveles:6]NoNivel:5;*)
				QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]Año:2;=;$l_año+1)
				$x_estiloEvaluacion_Interno:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8;->[xxSTR_HistoricoEstilosEval:88]xData:6)
				$x_estiloEvaluacion_Oficial:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9;->[xxSTR_HistoricoEstilosEval:88]xData:6)
				$l_IdEstiloInterno:=[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8
				$l_IdEstiloOficial:=[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9
				$x_objetoActas:=[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10
				$l_modoRegistroAsistencia:=[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23
				
			Else 
				$x_objetoActas:=[xxSTR_Niveles:6]Actas_y_Certificados:43
				$l_IdEstiloInterno:=[xxSTR_Niveles:6]EvStyle_interno:33
				$l_IdEstiloOficial:=[xxSTR_Niveles:6]EvStyle_oficial:23
				$l_modoRegistroAsistencia:=[xxSTR_Niveles:6]AttendanceMode:3
				READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
				QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1=[xxSTR_Niveles:6]EvStyle_interno:33)
				$x_estiloEvaluacion_Interno:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
				QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1=[xxSTR_Niveles:6]EvStyle_oficial:23)
				$x_estiloEvaluacion_Oficial:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
				
			End if 
			
			QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3=[xxSTR_Niveles:6]NoNivel:5;*)
			QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]Año:2=$l_año)
			If (Records in selection:C76([xxSTR_HistoricoNiveles:191])=0)
				CREATE RECORD:C68([xxSTR_HistoricoNiveles:191])
				[xxSTR_HistoricoNiveles:191]Año:2:=$l_año
				[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10:=$x_objetoActas
				[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=$l_IdEstiloInterno
				[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9:=$l_IdEstiloOficial
				[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=$l_modoRegistroAsistencia
				[xxSTR_HistoricoNiveles:191]ID_Institucion:1:=<>gInstitucion
				SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
			End if 
			KRL_ReloadAsReadOnly (->[xxSTR_HistoricoNiveles:191])
			KRL_ReloadAsReadOnly (->[xxSTR_Niveles:6])
			
			<>aYears:=Find in array:C230(<>aYears;$l_año)
			ACTAS_LeeConfiguracion ([xxSTR_Niveles:6]NoNivel:5;[Cursos:3]Curso:1;$l_año)
			ACTAS_ConfiguraFormCertificado 
			(OBJECT Get pointer:C1124(Object named:K67:5;"añoSeleccionado"))->:=$l_año
			
	End case 
End if 