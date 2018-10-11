//%attributes = {}
  //MINEDUC_GeneraBoletin

$tipo:=$1

Case of 
	: ($tipo="Etiquetas")
		For ($I;1;369)
			aCampoNO{$I}:=$I
		End for 
		aCampoBoletin{1}:="Numero proceso"
		aCampoBoletin{2}:="Nombre Establecimiento"
		aCampoBoletin{3}:="Letra Establecimiento"
		aCampoBoletin{4}:="Numero Establecimiento"
		aCampoBoletin{5}:="Region"
		aCampoBoletin{6}:="Código Provincia"
		aCampoBoletin{7}:="Direccion provincial"
		aCampoBoletin{8}:="Codigo Comuna"
		aCampoBoletin{9}:="Folio"
		aCampoBoletin{10}:="Fecha Ingreso"
		aCampoBoletin{11}:="Elimina"
		aCampoBoletin{12}:="che_inte"
		aCampoBoletin{13}:="Ind_reza"
		aCampoBoletin{14}:="Mes asistencia"
		aCampoBoletin{15}:="Año asistencia"
		aCampoBoletin{16}:="Rol Base de datos"
		aCampoBoletin{17}:="Digito verificador Rol Base de Datos"
		aCampoBoletin{18}:="Codigo Enseñanza"
		aCampoBoletin{19}:="Indice boletin"
		aCampoBoletin{20}:="mat_subv"
		aCampoBoletin{21}:="mat_int"
		aCampoBoletin{22}:="asi_inte"
		aCampoBoletin{23}:="dia_trab"
		aCampoBoletin{24}:="cur_comb"
		aCampoBoletin{25}:="Derechos escolares"
		$last:=25
		For ($niveles;1;8)
			aCampoBoletin{$last+1}:="Numero de cursos"
			aCampoBoletin{$last+2}:="Matricula en "+aNivel{$niveles}
			aCampoBoletin{$last+3}:="Altas en "+aNivel{$niveles}
			aCampoBoletin{$last+4}:="Bajas en "+aNivel{$niveles}
			aCampoBoletin{$last+5}:="Asistencia en "+aNivel{$niveles}
			aCampoBoletin{$last+6}:="Dias trabajados"
			aCampoBoletin{$last+7}:="che_asi "+aNivel{$niveles}
			aCampoBoletin{$last+8}:="Asistencia del mes en"+aNivel{$niveles}
			$last:=$last+8
			For ($i;1;31)
				aCampoBoletin{$last+$i}:="Asistencia dia "+String:C10($i)+" en "+aNivel{$niveles}
			End for 
			$last:=$last+31
		End for 
		aCampoBoletin{$last+1}:="Total inasistencias"
		$last:=$last+1
		For ($i;1;31)
			aCampoBoletin{$last+$i}:="Total Asistencia dia "+String:C10($i)
		End for 
	: ($tipo="Valores")
		READ ONLY:C145([MINEDUC_Documentos:171])
		QUERY:C277([MINEDUC_Documentos:171];[MINEDUC_Documentos:171]Tipo_documento:1="Boletin Subvenciones")
		ORDER BY:C49([MINEDUC_Documentos:171];[MINEDUC_Documentos:171]No_BoletinInasistencias:7;<)
		$nextNum:=[MINEDUC_Documentos:171]No_BoletinInasistencias:7+1
		READ ONLY:C145([xxSTR_Comunas:94])
		QUERY:C277([xxSTR_Comunas:94];[xxSTR_Comunas:94]Numero_comuna:1=<>gComuna)
		$region:=String:C10([xxSTR_Comunas:94]Numero_region:2)
		$provincia:=String:C10([xxSTR_Comunas:94]Numero_provincia:3)
		$comuna:=[xxSTR_Comunas:94]Code_comuna:4
		READ ONLY:C145([Alumnos:2])
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=1;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=8;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50="Activo")
		$matriculaTotal:=Records in selection:C76([Alumnos:2])
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Alumno_Internado:82=True:C214)
		$matriculaInternado:=Records in selection:C76([Alumnos:2])
		aValorBoletin{1}:="99"
		aValorBoletin{2}:=Substring:C12(<>gCustom;1;45)
		aValorBoletin{3}:=<>gLetraEstablecimiento
		aValorBoletin{4}:=<>gNumEstablecimiento
		aValorBoletin{5}:=$region
		aValorBoletin{6}:=$provincia
		aValorBoletin{7}:=String:C10(<>gDirProvincial)
		aValorBoletin{8}:=$comuna
		aValorBoletin{9}:=String:C10($nextNum;"000000")
		aValorBoletin{10}:=Replace string:C233(String:C10(Current date:C33(*));"/";"")
		aValorBoletin{11}:="n"
		aValorBoletin{12}:="s"
		aValorBoletin{13}:="N"
		aValorBoletin{14}:=String:C10(Month of:C24(Current date:C33(*));"00")
		aValorBoletin{15}:=String:C10(Year of:C25(Current date:C33(*));"00")
		aValorBoletin{16}:=Substring:C12(<>gRolBD;1;Length:C16(<>gRolBD)-1)
		aValorBoletin{17}:=Substring:C12(<>gRolBD;Length:C16(<>gRolBD))
		aValorBoletin{18}:=<>gCodigoEnseñanza
		aValorBoletin{19}:="1"
		aValorBoletin{20}:=String:C10($matriculaTotal)
		aValorBoletin{21}:=String:C10($matriculaInternado)
		aValorBoletin{22}:=""
		aValorBoletin{23}:=""
		aValorBoletin{24}:="N"
		aValorBoletin{25}:=String:C10(<>gDerechosEscolares)
		$last:=25
		For ($niveles;1;8)
			$el:=Find in array:C230(al_Mineduc_NivelCurso;$niveles)
			$matricula:=0
			$altas:=0
			$bajas:=0
			$asist:=0
			$cursos:=0
			$asistBoletin:=0
			For ($i;$el;Size of array:C274(al_Mineduc_NivelCurso))
				If (al_Mineduc_NivelCurso{$i}#$niveles)
					$i:=Size of array:C274(al_Mineduc_NivelCurso)
				Else 
					If (($days=0) | ($days=ai_Mineduc_Dias{$i}))
						$days:=ai_Mineduc_Dias{$i}
						$cursos:=$cursos+1
						$asistBoletin:=$asistBoletin+ai_Mineduc_AsistCursos{$i}
					End if 
					$matricula:=$matricula+ai_Mineduc_MatriculaCursos{$i}
					$altas:=$altas+ai_Mineduc_AltasCursos{$i}
					$bajas:=$bajas+ai_Mineduc_BajasCursos{$i}
					$asist:=$asist+ai_Mineduc_AsistCursos{$i}
				End if 
			End for 
			aValorBoletin{$last+1}:=String:C10($cursos;"00")
			aValorBoletin{$last+2}:=String:C10($matricula;"000")
			aValorBoletin{$last+3}:=String:C10($altas;"000")
			aValorBoletin{$last+4}:=String:C10($bajas;"000")
			aValorBoletin{$last+5}:=String:C10($asist;"0000")
			aValorBoletin{$last+6}:=String:C10($days;"00")
			aValorBoletin{$last+7}:="s"
			aValorBoletin{$last+8}:=String:C10($asist;"0000")
			$last:=$last+8
			For ($i;1;31)
				aValorBoletin{$last+$i}:="Asistencia dia "+String:C10($i)+" en "+aNivel{$niveles}
			End for 
			$last:=$last+31
		End for 
End case 