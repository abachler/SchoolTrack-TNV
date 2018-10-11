//%attributes = {}
  // AL_CertificadoAñoActual()
  //
  //
  // creado por: Alberto Bachler Klein: 29-03-16, 11:22:57
  // -----------------------------------------------------------
C_LONGINT:C283($i;$i_sectores;$i_subsectores;$l_asignaturasNoEvaluadas;$l_error;$l_filaAsistencia;$l_filaOptativa;$l_filaPromedio;$l_filaSituacionFinal;$l_filasPie)
C_LONGINT:C283($l_inicioPie;$l_inicioPlanElectivo;$l_modoImpresionActa;$l_nivelAlumno;$l_posicion;$l_posicionSubsector;$l_posicionSimbol)
C_REAL:C285($r_porcentajeAsistencia)
C_TEXT:C284($t_llave;$t_pieColumna2;$t_pieColumna3;$t_pieColumna4;$t_porcentajeAsistencia;$t_rut;$t_situacionFinal;$t_ultimoSector)
C_BOOLEAN:C305($b_Modelo2002)
C_LONGINT:C283($l_recnum)
ARRAY BOOLEAN:C223($ab_enActas;0)
ARRAY BOOLEAN:C223($ab_esElectiva;0)
ARRAY BOOLEAN:C223($ab_esOptativa;0)
ARRAY BOOLEAN:C223($ab_incideEnPromedio;0)
ARRAY DATE:C224($ad_fechaEximicion;0)
ARRAY LONGINT:C221($al_estiloEvaluacion;0)
ARRAY REAL:C219($ar_notaReal;0)
ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_EvaluacionEnPalabras;0)
ARRAY TEXT:C222($at_Nota;0)

C_PICTURE:C286(vCertConfig;theBundle)
C_TEXT:C284(vCert1;vCert2;vCert3;vCert4;vCert5;vCert6)
C_TEXT:C284(vFont1;vFont2;vFont3;vFont4;vFont5;vFont6;vFont7)
C_LONGINT:C283(vSize1;vSize2;vSize3;vSize4;vSize5;vSize6;vStyle1;vStyle2;vStyle3;vStyle4;vStyle5;vStyle6;vStyle7)


ARRAY TEXT:C222(atActas_Sectores;0)
ARRAY TEXT:C222(atActas_Subsectores;0)
ARRAY TEXT:C222(atActas_CertNotas_Cifras;0)
ARRAY TEXT:C222(atActas_NotasCertif_Letras;0)


  // Modificado por: Alexis Bustamante (05/08/2017)
  //TICKET185668
  //Agrego KRL_GotoRecord ya que depsues de Leer la configuración del acta 
  //quedan en seleccion todos los alumnos del curso.
$l_recnum:=Record number:C243([Alumnos:2])
ACTAS_LeeConfiguracion ([Alumnos:2]nivel_numero:29;[Alumnos:2]curso:20;<>gYear)

KRL_GotoRecord (->[Alumnos:2];$l_recnum)
  //AOQ 02012018 Ticket 195171
  // Se agrega busqueda de curso dado que al seleccionar varios alumnos de diferentes cursos solo hace relacion a uno 
QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)

$t_llave:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
$l_nivelAlumno:=[Alumnos:2]nivel_numero:29
$t_situacionFinal:=""
$r_porcentajeAsistencia:=0
AL_LeeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]SituacionFinal:8;->$t_situacionFinal)
AL_LeeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;->$r_porcentajeAsistencia)
$t_porcentajeAsistencia:=String:C10(Round:C94($r_porcentajeAsistencia;0);"##0")

ARRAY TEXT:C222(atActas_CertNotas_Cifras;Size of array:C274(atActas_Subsectores))
ARRAY TEXT:C222(atActas_NotasCertif_Letras;Size of array:C274(atActas_Subsectores))
ARRAY TEXT:C222(atActas_Sectores;Size of array:C274(atActas_Subsectores))
$t_ultimoSector:=""


For ($i;1;Size of array:C274(atActas_Subsectores))
	If (atActas_Subsectores{$i}#"")
		$l_posicion:=Find in array:C230(<>aAsign;atActas_Subsectores{$i})
		If ($l_posicion>0)
			If (<>aAsignSector{$l_posicion}#$t_ultimoSector)
				atActas_Sectores{$i}:=<>aAsignSector{$l_posicion}
				$t_ultimoSector:=<>aAsignSector{$l_posicion}
			End if 
		End if 
	End if 
	atActas_CertNotas_Cifras{$i}:="-"
	atActas_NotasCertif_Letras{$i}:="-"
End for 



If ([Alumnos:2]Sexo:49="F")
	sTitulo:="Doña"
	sSex:="alumna de"
Else 
	sTitulo:="Don"
	sSex:="alumno de"
End if 
sStudent:=[Alumnos:2]Nombres:2+" "+[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4

If ([Alumnos:2]numero:1=0)
	$t_rut:="RUN Nº                       "
Else 
	If (CTRY_CL_VerifRUT ([Alumnos:2]RUT:5;False:C215)#"")
		  //$t_rut:=ST_FormatRUT_Chile ([Alumnos]RUT)
		$t_rut:="RUN: "+ST_FormatRUT_Chile ([Alumnos:2]RUT:5)  //20171013 RCH 
	Else 
		If ([Alumnos:2]Nacionalidad:8#"Chilen@")
			$t_rut:="RUN en trámite (extranjero)"
		Else 
			$t_rut:="RUN inválido"
		End if 
	End if 
End if 


Case of 
	: (<>icrtfYear>=2002)
		sClass:=$t_rut+" de "+GetGrado ([Alumnos:2]nivel_numero:29;[Cursos:3]Nombre_Oficial_Nivel:14;[Cursos:3]Letra_Oficial_del_Curso:18)+", "
		vcert5:=sclass+vCert5
	: ((($l_nivelAlumno<=7) | ($l_nivelAlumno=9) | ($l_nivelAlumno=10) | ($l_nivelAlumno=11)) & (<>icrtfYear>=2001))
		sClass:=$t_rut+" de "+GetGrado ([Alumnos:2]nivel_numero:29;[Cursos:3]Nombre_Oficial_Nivel:14;[Cursos:3]Letra_Oficial_del_Curso:18)+", "
		vcert5:=sclass+vCert5
	: ((($l_nivelAlumno<=6) | ($l_nivelAlumno=10) | ($l_nivelAlumno=11)) & (<>icrtfYear>=2000))
		sClass:=$t_rut+" de "+GetGrado ([Alumnos:2]nivel_numero:29;[Cursos:3]Nombre_Oficial_Nivel:14;[Cursos:3]Letra_Oficial_del_Curso:18)+", "
		vcert5:=sclass+vCert5
	: ((($l_nivelAlumno<=5) | ($l_nivelAlumno=9)) & (<>icrtfYear>=1999))
		sClass:=$t_rut+" de "+GetGrado ([Alumnos:2]nivel_numero:29;[Cursos:3]Nombre_Oficial_Nivel:14;[Cursos:3]Letra_Oficial_del_Curso:18)+", "
		vcert5:=sclass+vCert5
	Else 
		sClass:=GetGrado ([Alumnos:2]nivel_numero:29;[Cursos:3]Nombre_Oficial_Nivel:14;[Cursos:3]Letra_Oficial_del_Curso:18)+", "
End case 


sObs:="Observaciones: "
sFinalSit:=""
vMenElect:=""



$l_inicioPie:=Find in array:C230(atActas_Subsectores;"Promedio General")
If ($l_inicioPie=-1)
	$l_inicioPie:=Find in array:C230(atActas_Subsectores;"Promedio Final")
End if 

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$at_Nota;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492;$at_EvaluacionEnPalabras;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$ar_notaReal;[Alumnos_ComplementoEvaluacion:209]Eximicion_Fecha:7;$ad_fechaEximicion;[Asignaturas:18]Asignatura:3;$at_asignaturas;[Asignaturas:18]Incide_en_promedio:27;$ab_incideEnPromedio;[Asignaturas:18]Incluida_en_Actas:44;$ab_enActas;[Asignaturas:18]Electiva:11;$ab_esElectiva;[Asignaturas:18]Es_Optativa:70;$ab_esOptativa;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_estiloEvaluacion)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
SORT ARRAY:C229($at_asignaturas;$ab_incideEnPromedio;$ab_enActas;$ar_notaReal;$ab_esOptativa;$ab_esElectiva;$al_estiloEvaluacion;$ad_fechaEximicion;$at_Nota;$at_EvaluacionEnPalabras;>)

vlEVS_CurrentEvStyleID:=0
For ($i;1;Size of array:C274($ar_notaReal))
	If ($ab_enActas{$i})
		EVS_ReadStyleData ($al_estiloEvaluacion{$i})
		$l_modoImpresionActa:=iPrintActa
		$l_posicion:=Find in array:C230(atActas_Subsectores;$at_asignaturas{$i})
		If ($l_posicion>0)
			If ($ab_esElectiva{$i})
				vMenElect:="("+vs_PEText+" en cursivas)"
			End if 
			If ($ab_esOptativa{$i})
				atActas_CertNotas_Cifras{$l_posicion}:=vs_AbrNoreligion
				atActas_NotasCertif_Letras{$l_posicion}:=vs_noReligion
				atActas_CertNotas_Cifras{$l_posicion}:="EX"
				atActas_NotasCertif_Letras{$l_posicion}:="Eximido"
			End if 
			Case of 
				: ((($ar_notaReal{$i}=-10) | ($ar_notaReal=-1)) & ($ad_fechaEximicion{$i}#!00-00-00!))
					atActas_CertNotas_Cifras{$l_posicion}:="EX"
					atActas_NotasCertif_Letras{$l_posicion}:="Eximido"
				: ((($ar_notaReal{$i}=-10) | ($ar_notaReal{$i}=-1)) & ($ab_esOptativa{$i}))
					atActas_CertNotas_Cifras{$l_posicion}:=vs_AbrNoreligion
					atActas_NotasCertif_Letras{$l_posicion}:=vs_noReligion
				: (($ar_notaReal{$i}=-10) | ($ar_notaReal{$i}=-1))
					atActas_CertNotas_Cifras{$l_posicion}:="-"
					atActas_NotasCertif_Letras{$l_posicion}:="---"
				: ($ar_notaReal{$i}=-3)
					atActas_CertNotas_Cifras{$l_posicion}:="EX"
					atActas_NotasCertif_Letras{$l_posicion}:="Eximido"
				: ($ar_notaReal{$i}=-2)
					atActas_CertNotas_Cifras{$l_posicion}:="P"
					atActas_NotasCertif_Letras{$l_posicion}:="PENDIENTE !!"
				Else 
					EVS_ReadStyleData ([xxSTR_Niveles:6]EvStyle_oficial:23)
					If ($at_Nota{$i}="0")
						atActas_CertNotas_Cifras{$l_posicion}:="-"
						atActas_NotasCertif_Letras{$l_posicion}:="---"
					Else 
						atActas_CertNotas_Cifras{$l_posicion}:=$at_Nota{$i}
						Case of 
							: ($l_modoImpresionActa=Simbolos)
								If (Not:C34([xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37))
									EVS_ReadStyleData ($al_estiloEvaluacion{$i})
									  // Modificado por: Alexis Bustamante (13-06-2017)
									  //TICKET 181701 
									  //se estaba reutilizando variable $l_posicion, agrego $l_posicionSimbol
									$l_posicionSimbol:=Find in array:C230(aSymbol;atActas_CertNotas_Cifras{$l_posicion})
									If ($l_posicionSimbol>0)
										atActas_NotasCertif_Letras{$l_posicion}:=aSymbDesc{$l_posicionSimbol}
									Else 
										atActas_NotasCertif_Letras{$l_posicion}:="Símbolo no definido"
									End if 
									EVS_ReadStyleData ([xxSTR_Niveles:6]EvStyle_oficial:23)
								Else 
									$l_posicionSimbol:=Find in array:C230(aSymbol;atActas_CertNotas_Cifras{$l_posicion})
									If ($l_posicionSimbol>0)
										atActas_NotasCertif_Letras{$l_posicion}:=aSymbDesc{$l_posicionSimbol}
									Else 
										atActas_NotasCertif_Letras{$l_posicion}:="Símbolo no definido"
									End if 
								End if 
							Else 
								If (atActas_CertNotas_Cifras{$l_posicion}#"")
									atActas_NotasCertif_Letras{$l_posicion}:=Uppercase:C13($at_EvaluacionEnPalabras{$i}[[1]];*)+Substring:C12($at_EvaluacionEnPalabras{$i};2;Length:C16($at_EvaluacionEnPalabras{$i}))  //$at_EvaluacionEnPalabras{$i}  // ST_Num2Text (Num(atActas_CertNotas_Cifras{$l_posicion});True;vb_usarSignosSeparadores)
									If (vb_usarSignosSeparadores)
										atActas_NotasCertif_Letras{$l_posicion}:=Replace string:C233(atActas_NotasCertif_Letras{$l_posicion};" coma ";<>tXS_RS_DecimalSeparator+" ")
									End if 
								Else 
									atActas_NotasCertif_Letras{$l_posicion}:="---"
									atActas_CertNotas_Cifras{$l_posicion}:="-"
								End if 
						End case 
					End if 
			End case 
		End if 
	End if 
End for 

Case of 
	: ([Alumnos_SintesisAnual:210]SituacionFinal:8="P")
		If (vtSTR_TextoPromocion="")
			If ($l_nivelAlumno=12)
				sFinalSit:="obtiene Licencia de Educación Media."
			Else 
				If ([Alumnos:2]Sexo:49="F")
					sFinalSit:="es promovida a "+GetGrado ($l_nivelAlumno+1)+"."
				Else 
					sFinalSit:="es promovido a "+GetGrado ($l_nivelAlumno+1)+"."
				End if 
			End if 
			sFinalSit:="En consecuencia: "+sFinalSit
		Else 
			sFinalSit:=vtSTR_TextoPromocion
		End if 
	: ([Alumnos_SintesisAnual:210]SituacionFinal:8="R")
		If (vtSTR_TextoRepitencia="")
			sFinalSit:="En consecuencia: debe repetir curso."
		Else 
			sFinalSit:=vtSTR_TextoRepitencia
		End if 
	Else 
		sFinalSit:=""
End case 

For ($i_subsectores;Size of array:C274(atActas_Subsectores);1;-1)
	If (atActas_Subsectores{$i_subsectores}="")
		AT_Delete ($i_subsectores;1;->atActas_Subsectores;->atActas_CertNotas_Cifras;->atActas_NotasCertif_Letras;->atActas_Sectores)
	Else 
		$i_subsectores:=0
	End if 
End for 

$l_filaOptativa:=Find in array:C230(atActas_Subsectores;"Religion@")
If ($l_filaOptativa>0)
	If (atActas_CertNotas_Cifras{$l_filaOptativa}="-")
		atActas_CertNotas_Cifras{$l_filaOptativa}:=vs_AbrNoreligion
		atActas_NotasCertif_Letras{$l_filaOptativa}:=vs_noReligion
	End if 
End if 

$l_filaPromedio:=Find in array:C230(atActas_Subsectores;"Promedio General")
If ($l_filaPromedio=-1)
	$l_filaPromedio:=Find in array:C230(atActas_Subsectores;"Promedio Final")
	If ($l_filaPromedio>0)
		atActas_Subsectores{$l_filaPromedio}:="Promedio General"
	End if 
End if 

EVS_ReadStyleData ([xxSTR_Niveles:6]EvStyle_oficial:23)

If ($l_posicion=-1)
	CD_Dlog (0;__ ("No se encontraron Subsectores asociados."))
Else 
	
	
	atActas_CertNotas_Cifras{$l_filaPromedio}:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
	  //atActas_CertNotas_Cifras{$l_posicion}:=_ConvierteEvaluacion ([Alumnos_SintesisAnual]PromedioFinalOficial_Real;[xxSTR_Niveles]EvStyle_oficial;Notas)
	If (Num:C11(atActas_CertNotas_Cifras{$l_filaPromedio})>0)
		atActas_NotasCertif_Letras{$l_filaPromedio}:=ST_Num2Text (Num:C11(atActas_CertNotas_Cifras{$l_filaPromedio});True:C214;vb_usarSignosSeparadores)
	Else 
		atActas_NotasCertif_Letras{$l_filaPromedio}:=""
	End if 
	
	$l_filaAsistencia:=Find in array:C230(atActas_Subsectores;"Porcentaje de asistencia")
	If ($l_filaAsistencia>0)
		atActas_CertNotas_Cifras{$l_filaAsistencia}:=$t_porcentajeAsistencia
		atActas_NotasCertif_Letras{$l_filaAsistencia}:=ST_Num2Text (Num:C11($t_porcentajeAsistencia);False:C215;vb_usarSignosSeparadores)
	End if 
	
	$l_filaSituacionFinal:=Find in array:C230(atActas_Subsectores;"Situación Final")
	If ($l_filaSituacionFinal>0)
		AT_Delete ($l_filaSituacionFinal;1;->atActas_Subsectores;->atActas_CertNotas_Cifras;->atActas_NotasCertif_Letras;->atActas_Sectores)
	End if 
	
	
	
	If ([Alumnos:2]numero:1=0)
		For ($i_subsectores;1;Size of array:C274(atActas_Subsectores))
			atActas_CertNotas_Cifras{$i_subsectores}:=" "
			atActas_NotasCertif_Letras{$i_subsectores}:=" "
		End for 
	End if 
	
	$t_pieColumna2:=""
	$t_pieColumna3:=""
	$t_pieColumna4:=""
	$l_filasPie:=0
	For ($i;$l_inicioPie;Size of array:C274(atActas_Subsectores))
		$t_pieColumna2:=$t_pieColumna2+atActas_Subsectores{$i}+"\r"
		$t_pieColumna3:=$t_pieColumna3+atActas_CertNotas_Cifras{$i}+"\r"
		$t_pieColumna4:=$t_pieColumna4+atActas_NotasCertif_Letras{$i}+"\r"
		$l_filasPie:=$l_filasPie+1
	End for 
	$l_filasPie:=$l_filasPie+1
	
	For ($i_subsectores;Size of array:C274(atActas_Subsectores);$l_inicioPie;-1)
		AT_Delete ($i_subsectores;1;->atActas_Subsectores;->atActas_CertNotas_Cifras;->atActas_NotasCertif_Letras;->atActas_Sectores)
	End for 
	
	Case of 
		: (<>icrtfYear>=2002)
			$b_Modelo2002:=True:C214
		: ((($l_nivelAlumno<=7) | ($l_nivelAlumno=9) | ($l_nivelAlumno=10) | ($l_nivelAlumno=11)) & (<>icrtfYear>=2001))
			$b_Modelo2002:=True:C214
		: ((($l_nivelAlumno<=6) | ($l_nivelAlumno=9) | ($l_nivelAlumno=10) | ($l_nivelAlumno=11)) & (<>icrtfYear>=2000))
			$b_Modelo2002:=True:C214
		: ((($l_nivelAlumno<=5) | ($l_nivelAlumno=9)) & (<>icrtfYear>=1999))
			$b_Modelo2002:=True:C214
		Else 
			$b_Modelo2002:=False:C215
	End case 
	
	
	
	  // Modificado por: Alexis Bustamante (13-06-2017)
	  //TICKET 181701 
	  //cambio arreglo para que busque en arreglo de notas atActas_CertNotas_Cifras
	$l_asignaturasNoEvaluadas:=Count in array:C907(atActas_CertNotas_Cifras;"-")
	
	$l_inicioPlanElectivo:=0
	
	If ($l_asignaturasNoEvaluadas>0)
		If (vi_PrintEvaluadas=1)
			For ($i_subsectores;Size of array:C274(atActas_Subsectores);1;-1)
				If (atActas_CertNotas_Cifras{$i_subsectores}="-")
					AT_Delete ($i_subsectores;1;->atActas_Subsectores;->atActas_CertNotas_Cifras;->atActas_NotasCertif_Letras;->atActas_Sectores)
					  //PS 30-11-2011 se agrega un contador de las asignaturas de plan comun eliminadas para ajustar el for que le da formato cursiva a las asignaturas de plan electivo
					If ($i_subsectores<vi_PEStart)
						$l_inicioPlanElectivo:=$l_inicioPlanElectivo+1
					End if 
				End if 
			End for 
			
			For ($i_subsectores;1;Size of array:C274(atActas_Subsectores))
				$l_posicion:=Find in array:C230(<>aAsign;atActas_Subsectores{$i_subsectores})
				If ($l_posicion>0)
					If (<>aAsignSector{$l_posicion}#$t_ultimoSector)
						atActas_Sectores{$i_subsectores}:=<>aAsignSector{$l_posicion}
						$t_ultimoSector:=<>aAsignSector{$l_posicion}
					End if 
				End if 
			End for 
			
		End if 
	End if 
	
	
	If ($b_Modelo2002)
		  //$l_error:=PL_SetArrays (pl_CertTplt;1;4;atActas_Sectores;atActas_Subsectores;atActas_CertNotas_Cifras;atActas_NotasCertif_Letras)
		$l_error:=PL_SetArraysNam (pl_CertTplt;1;4;"atActas_Sectores";"atActas_Subsectores";"atActas_CertNotas_Cifras";"atActas_NotasCertif_Letras")
		PL_SetWidths (pl_CertTplt;1;4;131;221;51;138)
		PL_SetFormat (pl_CertTplt;3;"";2;2)
		PL_SetBrkText (pl_CertTplt;0;1;$t_pieColumna2;1;0)
		PL_SetBrkText (pl_CertTplt;0;3;$t_pieColumna3;0;0)
		PL_SetBrkText (pl_CertTplt;0;4;$t_pieColumna4;0;0)
		PL_SetBrkHeight (pl_CertTplt;0;$l_filasPie;2)
		PL_SetBrkStyle (pl_CertTplt;0;0;"Arial";9;0)
		PL_SetBrkColOpt (pl_CertTplt;0;1;0;4;"Black";"Black")
		PL_SetBrkColOpt (pl_CertTplt;0;2;1;4;"Black";"Black")
		PL_SetBrkColOpt (pl_CertTplt;0;3;1;4;"Black";"Black")
		PL_SetBrkColOpt (pl_CertTplt;0;4;1;4;"Black";"Black")
	Else 
		  //$l_error:=PL_SetArrays (pl_CertTplt;1;3;atActas_Subsectores;atActas_CertNotas_Cifras;atActas_NotasCertif_Letras)
		$l_error:=PL_SetArraysNam (pl_CertTplt;1;3;"atActas_Subsectores";"atActas_CertNotas_Cifras";"atActas_NotasCertif_Letras")
		PL_SetWidths (pl_CertTplt;1;3;352;50;138)
		PL_SetFormat (pl_CertTplt;2;"";2;2)
		PL_SetBrkText (pl_CertTplt;0;1;$t_pieColumna2;0;0)
		PL_SetBrkText (pl_CertTplt;0;2;$t_pieColumna3;0;0)
		PL_SetBrkText (pl_CertTplt;0;3;$t_pieColumna4;0;0)
		PL_SetBrkHeight (pl_CertTplt;0;$l_filasPie;2)
		PL_SetBrkStyle (pl_CertTplt;0;0;"Arial";9;0)
		PL_SetBrkColOpt (pl_CertTplt;0;1;1;4;"Black";"Black")
		PL_SetBrkColOpt (pl_CertTplt;0;2;1;4;"Black";"Black")
		PL_SetBrkColOpt (pl_CertTplt;0;3;1;4;"Black";"Black")
	End if 
	
	PL_SetHeight (pl_certTplt;0;0;0;0)
	PL_SetColOpts (pl_certTplt;0;0)
	PL_SetHdrOpts (pl_CertTplt;0;0)
	PL_SetStyle (pl_CertTplt;0;"Arial";9;0)
	PL_SetFrame (pl_certTplt;1;"Black";"Black";0;0.25;"Gray";"Black";0)
	PL_SetDividers (pl_certTplt;1;"Black";"Black";0;0.25;"Gray";"Black";0)
	
	If (vi_PEStart>0)
		For ($i_subsectores;vi_PEStart-$l_inicioPlanElectivo;vi_PEEnd)
			PL_SetRowStyle (pl_certTplt;$i_subsectores;2)
		End for 
	End if 
	
End if 