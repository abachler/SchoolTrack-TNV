  // [xxSTR_Niveles].Certificado.Variable5()
  // Por: Alberto Bachler K.: 28-02-14, 21:10:33
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_objetoActas;$x_estiloEvaluacion_Interno;$x_estiloEvaluacion_Oficial)
C_LONGINT:C283($l_año;$l_IdEstiloInterno;$l_IdEstiloOficial;$l_modoRegistroAsistencia;$l_recNumNivel)


IT_MODIFIERS 
AL_UpdateArrays (xALP_CertTplt;0)
If (Self:C308->=0)
	<>aYears:=Size of array:C274(<>aYears)
End if 

  // Modificado por: Alexis Bustamante (17/08/2017)
  //183744 
  //Todoe sto es codigo optimizado.y ordenado.
  //cuando es por curso siempre se carga el nivel por que el metodo que acrga el formulario tiene validaciones solo para nivel
  //así no se deshabilitan los botonos y recuadros de texto,

C_LONGINT:C283($l_año)
$l_año:=<>aYears{Self:C308->}
Case of 
	: ((Records in selection:C76([Cursos:3])=1) & ([Cursos:3]ActaEspecificaAlCurso:35) & ($l_año=<>gYear))
		ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1;$l_año)
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
		
	: ((Records in selection:C76([Cursos:3])=1) & ([Cursos:3]ActaEspecificaAlCurso:35) & ($l_año<<>gYear))
		
		QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=[Cursos:3]Curso:1;*)
		QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Año:2=$l_año)
		  //configuracion historica especifica al curso
		If (Records in selection:C76([Cursos_SintesisAnual:63])>0)
			ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1;$l_año)
		Else 
			  //crear asintesis para el año seleccionado si no se encuentra.
			READ WRITE:C146([Cursos_SintesisAnual:63])
			CREATE RECORD:C68([Cursos_SintesisAnual:63])
			[Cursos_SintesisAnual:63]Curso:5:=[Cursos:3]Curso:1
			[Cursos_SintesisAnual:63]Año:2:=$l_año
			[Cursos_SintesisAnual:63]NumeroNivel:3:=[Cursos:3]Nivel_Numero:7
			[Cursos_SintesisAnual:63]Actas_y_Certificados:11:=[Cursos:3]Acta:34
			SAVE RECORD:C53([Cursos_SintesisAnual:63])
			KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])
			ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1;$l_año)
		End if 
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
		
		
	: (($l_año<<>gyear) & (Records in selection:C76([xxSTR_Niveles:6])>0))
		  //leer configuracion historica del nivel
		
		QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3=[xxSTR_Niveles:6]NoNivel:5;*)
		QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]Año:2=$l_año)
		If (Records in selection:C76([xxSTR_HistoricoNiveles:191])>0)
			ACTAS_LeeConfiguracion ([xxSTR_Niveles:6]NoNivel:5;"";$l_año)
		Else 
			  //se crea registro de historico que no existe
			$x_objetoActas:=[xxSTR_Niveles:6]Actas_y_Certificados:43
			$l_IdEstiloInterno:=[xxSTR_Niveles:6]EvStyle_interno:33
			$l_IdEstiloOficial:=[xxSTR_Niveles:6]EvStyle_oficial:23
			$l_modoRegistroAsistencia:=[xxSTR_Niveles:6]AttendanceMode:3
			
			READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
			QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1=[xxSTR_Niveles:6]EvStyle_interno:33)
			$x_estiloEvaluacion_Interno:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
			QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1=[xxSTR_Niveles:6]EvStyle_oficial:23)
			$x_estiloEvaluacion_Oficial:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
			
			  ///si no Hya Historico para el año y nivel se debe crear.
			READ WRITE:C146([xxSTR_HistoricoNiveles:191])
			CREATE RECORD:C68([xxSTR_HistoricoNiveles:191])
			[xxSTR_HistoricoNiveles:191]Año:2:=$l_año
			[xxSTR_HistoricoNiveles:191]NumeroNivel:3:=[xxSTR_Niveles:6]NoNivel:5
			[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10:=$x_objetoActas
			[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=$l_IdEstiloInterno
			[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9:=$l_IdEstiloOficial
			[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=$l_modoRegistroAsistencia
			[xxSTR_HistoricoNiveles:191]ID_Institucion:1:=<>gInstitucion
			SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
			KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])
			
			ACTAS_LeeConfiguracion ([xxSTR_Niveles:6]NoNivel:5;"";$l_año)
		End if 
		
		
	: (($l_año=<>gyear) & (Records in selection:C76([xxSTR_Niveles:6])>0))
		ACTAS_LeeConfiguracion ([xxSTR_Niveles:6]NoNivel:5;"";$l_año)
		
End case 

ACTAS_ConfiguraFormCertificado 

If (vtSTR_TextoPromocion#"")
	sFinalsit:=vtSTR_TextoPromocion
Else 
	vtSTR_TextoPromocion:=sFinalsit
End if 


(OBJECT Get pointer:C1124(Object named:K67:5;"añoSeleccionado"))->:=$l_año