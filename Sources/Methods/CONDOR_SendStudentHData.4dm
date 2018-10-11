//%attributes = {}
C_TIME:C306($1;$refXMLDoc)
ARRAY LONGINT:C221($al_historicos;0)
ARRAY TEXT:C222($at_tipocalificacion;5)
C_POINTER:C301($fieldPtr)

$at_tipocalificacion{1}:="_real"
$at_tipocalificacion{2}:="_nota"
$at_tipocalificacion{3}:="_puntos"
$at_tipocalificacion{4}:="_simbolo"
$at_tipocalificacion{5}:="_literal"

$refXMLDoc:=$1

QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_SintesisAnual:210]; | ;[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]Año:2#0)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6;>;-1003;*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6<=1000)
ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;<;[Alumnos_SintesisAnual:210]NumeroNivel:6;<)
If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$al_historicos)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"ciclos")
	For ($w;1;Size of array:C274($al_historicos))
		KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$al_historicos{$w})
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"ciclo")
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Auto_UUID:276);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"year";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Año:2);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"curso";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Curso:7);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_nivel";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]NumeroNivel:6);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"situacion_final";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]SituacionFinal:8);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"observaciones_actas_cl";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9);True:C214;False:C215)
		For ($x;1;5)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$promedioanualinterno"+$at_tipocalificacion{$x})
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"promedioanualinterno"+$at_tipocalificacion{$x};True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$promedioanualoficial"+$at_tipocalificacion{$x})
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"promedioanualoficial"+$at_tipocalificacion{$x};True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$promediofinalinterno"+$at_tipocalificacion{$x})
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"promediofinalinterno"+$at_tipocalificacion{$x};True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$promediofinaloficial"+$at_tipocalificacion{$x})
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"promediofinaloficial"+$at_tipocalificacion{$x};True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			If ($at_tipocalificacion{$x}#"_simbolo")
				$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$promedioint_noaprox"+$at_tipocalificacion{$x})
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"promediointnoaprox"+$at_tipocalificacion{$x};True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
				$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$promedioof_noaprox"+$at_tipocalificacion{$x})
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"promedioofnoaprox"+$at_tipocalificacion{$x};True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			End if 
		End for 
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"inasistencias_dias";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Inasistencias_Dias:30);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"inasistencias_horas";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Inasistencias_Horas:31);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"horasefectivas";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]HorasEfectivas:32);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"asistencia";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"anotaciones_positivas";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"anotaciones_neutras";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Anotaciones_Neutras:35);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"anotaciones_negativas";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"puntaje_conductual_positivo";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]PuntajeConductual_Positivo:37);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"puntaje_conductual_negativo";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]PuntajeConductual_Negativo:38);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"puntaje_conductual_balance";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]PuntajeConductual_Balance:39);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"atrasos_jornada";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Atrasos_Jornada:40);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"atrasos_sesion";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"premios";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Premios:42);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"castigos";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Castigos:43);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"suspensiones";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Suspensiones:44);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"faltas_retardo_jornada";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Faltas_x_RetardoJornada:45);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"faltas_retardo_sesiones";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Faltas_x_RetardoSesiones:46);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"observaciones_academicas";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Observaciones_Academicas:47);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"observaciones_actitud";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Observaciones_Actitud:48);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"inasistencias_justificadas_dias";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]InasistenciasJustif_Dias:49);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"inasistencias_injustificadas_dias";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]InasistenciasInjustif_Dias:50);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"atrasos_minutosacumulados";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Atrasos_MinutosAcumulados:51);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"puntaje_negativo_acumulado";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]PuntajeNegativoAcumulado:52);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"puntaje_positivo_acumulado";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]PuntajePositivoAcumulado:53);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"condicionalidad_activada";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Condicionalidad_Activada:57);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"condicionalidad_hasta";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Condicionalidad_Hasta:58);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"condicionalidad_motivo";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Condicionalidad_Motivo:59);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"totaldiashabiles";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]TotalDiasHabiles:60);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"sitfinal_ingresadamanual";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"comentario_sitfinal";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"promovido";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]Promovido:91);False:C215;False:C215)
		For ($x;1;5)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_inasistencias_dias")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_inasistencias_dias";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_inasistencias_horas")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_inasistencias_horas";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_horasefectivas")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_horasefectivas";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_porcentajeasistencia")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_porcentajeasistencia";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_anotaciones_positivas")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_anotaciones_positivas";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_anotaciones_negativas")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_anotaciones_negativas";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_anotaciones_neutras")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_anotaciones_neutras";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_puntajeconductual_positivo")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_puntajeconductual_positivo";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_puntajeconductual_negativo")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_puntajeconductual_negativo";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_puntajeconductual_balance")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_puntajeconductual_balance";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_atrasos_jornada")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_atrasos_jornada";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_atrasos_sesiones")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_atrasos_sesiones";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_premios")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_premios";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_castigos")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_castigos";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_suspensiones")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_suspensiones";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_faltas_x_retardojornada")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_faltas_x_retardojornada";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_faltas_x_retardosesiones")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_faltas_x_retardosesiones";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_observaciones_academicas")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_observaciones_academicas";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);True:C214;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_observaciones_actitud")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_observaciones_actitud";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);True:C214;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_inasistenciasjustif_dias")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_inasistenciasJustif_Dias";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_inasistenciasinjustif_dias")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_inasistenciasInJustif_Dias";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_diashabiles")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_diashabiles";True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			For ($y;1;5)
				$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_promediointerno"+$at_tipocalificacion{$y})
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_promediointerno"+$at_tipocalificacion{$y};True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
				$fieldPtr:=OB Get:C1224(<>ob_fields;"alumnos_sintesisanual$p0"+String:C10($x)+"_promediooficial"+$at_tipocalificacion{$y})
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"P0"+String:C10($x)+"_promediooficial"+$at_tipocalificacion{$y};True:C214;CONDOR_ExportDataTransformer ($fieldPtr);False:C215;False:C215)
			End for 
		End for 
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"promedio";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"asistencia";True:C214;CONDOR_ExportDataTransformer (->[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33);False:C215;False:C215)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	End for 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
End if 