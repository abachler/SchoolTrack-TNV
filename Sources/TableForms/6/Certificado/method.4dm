$event:=Form event:C388
Case of 
	: ($event=On Load:K2:1)
		
		ARRAY LONGINT:C221(AL_ORDEN;0)
		  //ARRAY LONGINT(AL_ORDEN;0)
		
		  // Modificado por: Alexis Bustamante (16/08/2017)
		  //se debe leer la configuracion antes de mostrar el formulario.
		  // 184745 
		<>aYears:=Size of array:C274(<>aYears)
		C_LONGINT:C283($l_año)
		$l_año:=<>aYears{<>aYears}
		Case of 
			: ((Records in selection:C76([Cursos:3])=1) & ([Cursos:3]ActaEspecificaAlCurso:35) & ($l_año=<>gYear))
				$l_recNumNivel:=Record number:C243([Cursos:3])
				$y_blob:=->[Cursos:3]Acta:34
				ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1;$l_año)
				
			: ((Records in selection:C76([Cursos:3])=1) & ([Cursos:3]ActaEspecificaAlCurso:35) & ($l_año<<>gYear))
				QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=[Cursos:3]Curso:1;*)
				QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Año:2=$l_año)
				$l_recNumNivel:=Record number:C243([Cursos_SintesisAnual:63])
				$y_blob:=->[Cursos_SintesisAnual:63]Actas_y_Certificados:11
				ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1;$l_año)
				
			: (($l_año<<>gyear) & (Records in selection:C76([xxSTR_HistoricoNiveles:191])>0))
				QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3=[xxSTR_Niveles:6]NoNivel:5;*)
				QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]Año:2=$l_año)
				$l_recNumNivel:=Record number:C243([xxSTR_HistoricoNiveles:191])
				$y_blob:=->[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10
				ACTAS_LeeConfiguracion ([xxSTR_HistoricoNiveles:191]NumeroNivel:3;"";$l_año)
				
			: (($l_año=<>gyear) & (Records in selection:C76([xxSTR_Niveles:6])>0))
				$l_recNumNivel:=Record number:C243([xxSTR_Niveles:6])
				$y_blob:=->[xxSTR_Niveles:6]Actas_y_Certificados:43
				ACTAS_LeeConfiguracion ([xxSTR_Niveles:6]NoNivel:5;"";$l_año)
				
		End case 
		
		ACTAS_ConfiguraFormCertificado 
		
		If (vtSTR_TextoPromocion#"")
			sFinalsit:=vtSTR_TextoPromocion
		Else 
			vtSTR_TextoPromocion:=sFinalsit
		End if 
		
	: ($event=On Data Change:K2:15)
		
	: ($event=On Unload:K2:2)
		
		
	: ($event=On Close Box:K2:21)
		C_LONGINT:C283($l_recNumNivel;$l_año)
		C_POINTER:C301($y_blob)
		$y_imprimirProfesorJefe:=OBJECT Get pointer:C1124(Object named:K67:5;"cert.ImprimirProfesorJefe")
		$y_imprimirObservaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"cert.imprimirObservaciones")
		$y_imprimirSoloEvaluadas:=OBJECT Get pointer:C1124(Object named:K67:5;"cert.soloEvaluadas")
		vi_PrintHeadName:=$y_imprimirProfesorJefe->
		vi_ImprimeObsActas:=$y_imprimirObservaciones->
		vi_PrintEvaluadas:=$y_imprimirSoloEvaluadas->
		
		
		  // Modificado por: Alexis Bustamante (16-05-2017)
		  //Ticket 181701 
		  //Para Historicos No se Guarda en el objeto opcion "solo evlauadas,nombreprofesorjefe,imprimirobservacionenelacta.
		  //Para Año Actual funciona correctamente.
		  // agrego estas validaciones para que se guarden de forma correcta los objectos
		
		
		  //agrego linea de lectura del acta cuando se cierra la ventana para que cargue los arreglos del año actual del nivel.
		  //ACTAS_leeconfiguracion.ABC192542
		  //tambien se carga el estilo de la lista de asignaturas.
		$l_año:=<>aYears{<>aYears}
		Case of 
			: ((Records in selection:C76([Cursos:3])=1) & ([Cursos:3]ActaEspecificaAlCurso:35) & ($l_año=<>gYear))
				READ WRITE:C146([Cursos:3])
				$l_recNumNivel:=Record number:C243([Cursos:3])
				$y_blob:=->[Cursos:3]Acta:34
				ACTAS_GuardaObjeto ($y_Blob;$l_recNumNivel)
				KRL_UnloadReadOnly (->[Cursos:3])
				
			: ((Records in selection:C76([Cursos:3])=1) & ([Cursos:3]ActaEspecificaAlCurso:35) & ($l_año<<>gYear))
				READ WRITE:C146([Cursos_SintesisAnual:63])
				QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5=[Cursos:3]Curso:1;*)
				QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Año:2=$l_año)
				$l_recNumNivel:=Record number:C243([Cursos_SintesisAnual:63])
				$y_blob:=->[Cursos_SintesisAnual:63]Actas_y_Certificados:11
				ACTAS_GuardaObjeto ($y_Blob;$l_recNumNivel)
				KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])
				
			: (($l_año<<>gyear) & (Records in selection:C76([xxSTR_HistoricoNiveles:191])>0))
				READ WRITE:C146([xxSTR_HistoricoNiveles:191])
				QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroNivel:3=[xxSTR_Niveles:6]NoNivel:5;*)
				QUERY:C277([xxSTR_HistoricoNiveles:191]; & ;[xxSTR_HistoricoNiveles:191]Año:2=$l_año)
				$l_recNumNivel:=Record number:C243([xxSTR_HistoricoNiveles:191])
				$y_blob:=->[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10
				ACTAS_GuardaObjeto ($y_Blob;$l_recNumNivel)
				KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])
				
			: (($l_año=<>gyear) & (Records in selection:C76([xxSTR_Niveles:6])>0))
				$b_soloLectura:=Read only state:C362([xxSTR_Niveles:6])  //ASM 20171107 Ticket 192123 
				$y_blob:=->[xxSTR_Niveles:6]Actas_y_Certificados:43
				$l_recNumNivel:=Record number:C243([xxSTR_Niveles:6])
				ACTAS_GuardaObjeto ($y_Blob;$l_recNumNivel)
				If ($b_soloLectura)
					KRL_UnloadReadOnly (->[xxSTR_Niveles:6])
				Else 
					KRL_ReloadInReadWriteMode (->[xxSTR_Niveles:6])
				End if 
		End case 
		
		ACTAS_EstiloFilasConfiguracion 
		
		CANCEL:C270
End case 
