//%attributes = {}
  // AL_CertificadoAñoAnterior()
  // Por: Alberto Bachler K.: 28-02-14, 15:28:55
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_EstiloEvaluacionOficial)
C_BOOLEAN:C305($b_configuracionEsValida;$b_usarNuevoModelo)
C_LONGINT:C283($i_filas;$l_año;$l_ErrorPLP;$l_filasSinCalificacion;$l_idAlumno;$l_IdEstiloEvaluacionHistorico;$l_idxSector;$l_idxSimbolo;$l_largoRUT)
C_LONGINT:C283($l_limitePlanComun;$l_numeroLineasPie;$l_pieDesde;$l_posicionEnActas)
C_TEXT:C284($t_llaveNivelHistorico;$t_RUN;$t_ultimoSectorAprendizaje;$t_digitoVerificadorRUT;$t_pieColumna2;$t_pieColumna3;$t_pieColumna4)

ARRAY BOOLEAN:C223($ab_esElectiva;0)
ARRAY BOOLEAN:C223($ab_esOptativa;0)
ARRAY BOOLEAN:C223($ab_incideEnPromedio;0)
ARRAY BOOLEAN:C223($ab_incluidaEnActas;0)
ARRAY LONGINT:C221($al_recNumAsignatura;0)
ARRAY TEXT:C222($at_EvaluacionEnPalabras;0)
ARRAY TEXT:C222($at_EvaluacionEnSimbolos;0)
ARRAY TEXT:C222($at_nombreAsignatura;0)
ARRAY TEXT:C222($at_notaLiteral;0)




C_TEXT:C284(vCert1;vCert2;vCert3;vCert4;vCert5;vCert6)
C_TEXT:C284(vFont1;vFont2;vFont3;vFont4;vFont5;vFont6)
C_LONGINT:C283(vSize1;vSize2;vSize3;vSize4;vSize5;vSize6;vStyle1;vStyle2;vStyle3;vStyle4;vStyle5;vStyle6)


$l_año:=<>iCrtfYear



C_LONGINT:C283($recNumSintesis)

ARRAY TEXT:C222(atActas_CertNotas_Cifras;0)
ARRAY TEXT:C222(atActas_NotasCertif_Letras;0)
ARRAY TEXT:C222(atActas_Sectores;0)
$l_idAlumno:=[Alumnos:2]numero:1*-1

QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;$l_idAlumno;*)
QUERY:C277([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]Año:2=$l_año)
sAst:=String:C10(Round:C94([Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;0);"##0")
$recNumSintesis:=Record number:C243([Alumnos_SintesisAnual:210])


  //Cargo la configuración del modelo de actas
ACTAS_LeeConfiguracion ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Curso:7;$l_año)
GOTO RECORD:C242([Alumnos_SintesisAnual:210];$recNumSintesis)  //195834 //despues de leer la configuración quedaban cvargados sintesis  anuales

  // MOD Ticket N° 215809 Patricio Aliaga 20180906 Asignacion de estilo electivo (cursiva)
ARRAY BOOLEAN:C223($ab_esElectivaFinal;Size of array:C274(atActas_SubsectoresCertif))

  // Modificado por: Alexis Bustamante (15-06-2017)
  //para no repetir Relegion arriba y abajo.
ARRAY LONGINT:C221(DA_RETURN;0)
atActas_SubsectoresCertif{0}:="Religion"
AT_SearchArray (->atActas_SubsectoresCertif;"=";->DA_RETURN)
If (Size of array:C274(DA_RETURN)>1)
	AT_Delete (DA_RETURN{1};1;->alActas_ColumnNumber;->atActas_Subsectores;->atActas_SubsectoresCertif;->$ab_esElectivaFinal)
End if 



ARRAY TEXT:C222(atActas_CertNotas_Cifras;Size of array:C274(atActas_SubsectoresCertif))
ARRAY TEXT:C222(atActas_NotasCertif_Letras;Size of array:C274(atActas_SubsectoresCertif))
ARRAY TEXT:C222(atActas_Sectores;Size of array:C274(atActas_SubsectoresCertif))
$t_ultimoSectorAprendizaje:=""
For ($i_filas;1;Size of array:C274(atActas_SubsectoresCertif))
	If (atActas_SubsectoresCertif{$i_filas}#"")
		$l_idxSimbolo:=Find in array:C230(<>aAsign;atActas_SubsectoresCertif{$i_filas})
		If ($l_idxSimbolo>0)
			If (<>aAsignSector{$l_idxSimbolo}#$t_ultimoSectorAprendizaje)
				atActas_Sectores{$i_filas}:=<>aAsignSector{$l_idxSimbolo}
				$t_ultimoSectorAprendizaje:=<>aAsignSector{$l_idxSimbolo}
			End if 
		End if 
	End if 
	atActas_CertNotas_Cifras{$i_filas}:="-"
	atActas_NotasCertif_Letras{$i_filas}:="-"
End for 

If ([Alumnos:2]Sexo:49="F")
	sTitulo:="Doña"
	sSex:="alumna de"
Else 
	sTitulo:="Don"
	sSex:="alumno de"
End if 
sStudent:=[Alumnos:2]Nombres:2+" "+[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4

If (Num:C11(Substring:C12([Alumnos:2]RUT:5;1;1))>0)
	$t_digitoVerificadorRUT:=[Alumnos:2]RUT:5[[Length:C16([Alumnos:2]RUT:5)]]
	$t_RUN:=Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1)
	$l_largoRUT:=Length:C16($t_RUN)
	Case of 
		: ($l_largoRUT=7)
			$t_RUN:=Substring:C12($t_RUN;1;1)+"."+Substring:C12($t_RUN;2;3)+"."+Substring:C12($t_RUN;5;3)
		: ($l_largoRUT=8)
			$t_RUN:=Substring:C12($t_RUN;1;2)+"."+Substring:C12($t_RUN;3;3)+"."+Substring:C12($t_RUN;6;3)
		: ($l_largoRUT=9)
			$t_RUN:=Substring:C12($t_RUN;1;3)+"."+Substring:C12($t_RUN;4;3)+"."+Substring:C12($t_RUN;7;3)
	End case 
	$t_RUN:="RUN: "+$t_RUN+"-"+$t_digitoVerificadorRUT
Else 
	If ([Alumnos:2]Nacionalidad:8#"Chilen@")
		$t_RUN:="RUN en trámite (extranjero)"
	Else 
		$t_RUN:=""
	End if 
End if 


Case of 
	: ($l_año>=2002)
		sClass:=$t_RUN+" de "+GetGrado ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Curso:7)+", "
		vcert5:=sclass+vCert5
	: ((([Alumnos_SintesisAnual:210]NumeroNivel:6<=7) | ([Alumnos_SintesisAnual:210]NumeroNivel:6=9) | ([Alumnos_SintesisAnual:210]NumeroNivel:6=10) | ([Alumnos_SintesisAnual:210]NumeroNivel:6=11)) & ($l_año>=2001))
		sClass:=$t_RUN+" de "+GetGrado ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Curso:7)+", "
		vcert5:=sclass+vCert5
	: ((([Alumnos_SintesisAnual:210]NumeroNivel:6<=6) | ([Alumnos_SintesisAnual:210]NumeroNivel:6=9) | ([Alumnos_SintesisAnual:210]NumeroNivel:6=10)) & ($l_año>=2000))
		sClass:=$t_RUN+" de "+GetGrado ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Curso:7)+", "
		vcert5:=sclass+vCert5
	: ((([Alumnos_SintesisAnual:210]NumeroNivel:6<=5) | ([Alumnos_SintesisAnual:210]NumeroNivel:6=9)) & ($l_año>=1999))
		sClass:=$t_RUN+" de "+GetGrado ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Curso:7)+", "
		vcert5:=sclass+vCert5
	Else 
		sClass:=GetGrado ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Curso:7)+", "
End case 

sObs:="Observaciones: "
sFinalSit:=""
vMenElect:=""
vCertDate:=<>gComuna+", "+DT_SpecialDate2String (Current date:C33)


SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
EV2_RegistrosDelAlumno ($l_idAlumno;[Alumnos_SintesisAnual:210]NumeroNivel:6;$l_año)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;$at_notaLiteral;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35;$at_EvaluacionEnSimbolos;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492;$at_EvaluacionEnPalabras;[Asignaturas_Historico:84]Asignatura:2;$at_nombreAsignatura;[Asignaturas_Historico:84]Promediable:6;$ab_incideEnPromedio;[Asignaturas_Historico:84]Incluida_En_Actas:7;$ab_incluidaEnActas;[Asignaturas_Historico:84]Electiva:10;$ab_esElectiva;[Asignaturas_Historico:84]Optativa:24;$ab_esOptativa;[Asignaturas_Historico:84];$al_recNumAsignatura)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
SORT ARRAY:C229($at_nombreAsignatura;$at_notaLiteral;$ab_incideEnPromedio;$ab_incluidaEnActas;$ab_esElectiva;$ab_esOptativa;$at_EvaluacionEnPalabras;$at_EvaluacionEnSimbolos;$al_recNumAsignatura;>)

$b_configuracionEsValida:=True:C214
For ($i_filas;1;Size of array:C274($at_notaLiteral))
	If ($ab_incluidaEnActas{$i_filas})
		$l_posicionEnActas:=Find in array:C230(atActas_SubsectoresCertif;$at_nombreAsignatura{$i_filas})
		If ($l_posicionEnActas>0)
			If ($ab_esElectiva{$i_filas})
				vMenElect:="("+vs_PEText+" en cursivas)"
			End if 
			If ($ab_esOptativa{$i_filas})
				atActas_CertNotas_Cifras{$l_posicionEnActas}:=vs_AbrNoreligion
				atActas_NotasCertif_Letras{$l_posicionEnActas}:=vs_noReligion
			End if 
			If (($at_notaLiteral{$i_filas}#"") & ($at_notaLiteral{$i_filas}#"0"))
				KRL_GotoRecord (->[Asignaturas_Historico:84];$al_recNumAsignatura{$i_filas})
				If (OK=1)
					$t_llaveNivelHistorico:=String:C10(<>gInstitucion)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10($l_año)
					$l_IdEstiloEvaluacionHistorico:=KRL_GetNumericFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$t_llaveNivelHistorico;->[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9)
					$x_EstiloEvaluacionOficial:=KRL_GetBlobFieldData (->[xxSTR_HistoricoEstilosEval:88]ID_RegistroHistórico:3;->$l_IdEstiloEvaluacionHistorico;->[xxSTR_HistoricoEstilosEval:88]xData:6)
					OK:=EVS_LeeEstiloEvalHistorico ($x_EstiloEvaluacionOficial)
					If (OK=1)
						If (iPrintActa#Simbolos)
							atActas_CertNotas_Cifras{$l_posicionEnActas}:=$at_notaLiteral{$i_filas}
							atActas_NotasCertif_Letras{$l_posicionEnActas}:=$at_EvaluacionEnPalabras{$i_filas}
							If (vb_usarSignosSeparadores)
								atActas_NotasCertif_Letras{$l_posicionEnActas}:=Replace string:C233(atActas_NotasCertif_Letras{$l_posicionEnActas};" coma ";<>tXS_RS_DecimalSeparator+" ")
							End if 
						Else 
							If ($at_EvaluacionEnSimbolos{$i_filas}#"")
								atActas_CertNotas_Cifras{$l_posicionEnActas}:=$at_EvaluacionEnSimbolos{$i_filas}
							Else 
								atActas_CertNotas_Cifras{$l_posicionEnActas}:=$at_notaLiteral{$i_filas}
							End if 
							If (vb_usarSignosSeparadores)
								atActas_NotasCertif_Letras{$l_posicionEnActas}:=Replace string:C233(atActas_NotasCertif_Letras{$l_posicionEnActas};" coma ";<>tXS_RS_DecimalSeparator)
							End if 
						End if 
					Else 
						atActas_CertNotas_Cifras{$l_posicionEnActas}:=$at_notaLiteral{$i_filas}
						atActas_NotasCertif_Letras{$l_posicionEnActas}:=$at_EvaluacionEnPalabras{$i_filas}
						If (vb_usarSignosSeparadores)
							atActas_NotasCertif_Letras{$l_posicionEnActas}:=Replace string:C233(atActas_NotasCertif_Letras{$l_posicionEnActas};" coma ";<>tXS_RS_DecimalSeparator+" ")
						End if 
					End if 
				Else 
					atActas_CertNotas_Cifras{$l_posicionEnActas}:=$at_notaLiteral{$i_filas}
					atActas_NotasCertif_Letras{$l_posicionEnActas}:=$at_EvaluacionEnPalabras{$i_filas}
					If (vb_usarSignosSeparadores)
						atActas_NotasCertif_Letras{$l_posicionEnActas}:=Replace string:C233(atActas_NotasCertif_Letras{$l_posicionEnActas};" coma ";<>tXS_RS_DecimalSeparator+" ")
					End if 
				End if 
				
				If ($at_notaLiteral{$i_filas}="X")
					atActas_CertNotas_Cifras{$l_posicionEnActas}:="EX"
					atActas_NotasCertif_Letras{$l_posicionEnActas}:="Eximido"
				End if 
				
			Else 
				atActas_CertNotas_Cifras{$l_posicionEnActas}:="-"
				atActas_NotasCertif_Letras{$l_posicionEnActas}:="---"
			End if 
			
			  // MOD Ticket N° 215809 Patricio Aliaga 20180906 Asignacion de estilo electivo (cursiva)
			$ab_esElectivaFinal{$l_posicionEnActas}:=$ab_esElectiva{$i_filas}
			
		Else 
			$b_configuracionEsValida:=False:C215
		End if 
	End if 
End for 

$l_posicionEnActas:=Find in array:C230(atActas_SubsectoresCertif;"Promedio General")
If ($l_posicionEnActas=-1)
	$l_posicionEnActas:=Find in array:C230(atActas_SubsectoresCertif;"Promedio Final")
	If ($l_posicionEnActas>0)
		atActas_SubsectoresCertif{$l_posicionEnActas}:="Promedio General"
	End if 
End if 
If ((Position:C15(",";[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29)=0) & (Num:C11([Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29)>0))
	[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29+",0"
End if 
If ($l_posicionEnActas>0)
	atActas_CertNotas_Cifras{$l_posicionEnActas}:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
	atActas_NotasCertif_Letras{$l_posicionEnActas}:=ST_Num2Text2 (Num:C11([Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29);"es";vb_usarSignosSeparadores;True:C214)
Else 
	$b_configuracionEsValida:=False:C215
End if 

$l_posicionEnActas:=Find in array:C230(atActas_SubsectoresCertif;"Porcentaje de asistencia")
If ($l_posicionEnActas>0)
	atActas_CertNotas_Cifras{$l_posicionEnActas}:=sAst
	atActas_NotasCertif_Letras{$l_posicionEnActas}:=ST_Num2Text2 (Num:C11(sAst);"es")
Else 
	$b_configuracionEsValida:=False:C215
End if 


$l_posicionEnActas:=Find in array:C230(atActas_SubsectoresCertif;"Religión@")
If ($l_posicionEnActas>0)
	If ((atActas_CertNotas_Cifras{$l_posicionEnActas}="") | (atActas_CertNotas_Cifras{$l_posicionEnActas}="-"))
		atActas_CertNotas_Cifras{$l_posicionEnActas}:=vs_AbrNoreligion
		atActas_NotasCertif_Letras{$l_posicionEnActas}:=vs_noReligion
	End if 
Else 
	If (Find in array:C230($at_nombreAsignatura;"Religión@")>0)
		$b_configuracionEsValida:=False:C215
	End if 
End if 

Case of 
	: ([Alumnos_SintesisAnual:210]SituacionFinal:8="P")
		If (vtSTR_TextoPromocion="")
			If ([Alumnos_SintesisAnual:210]NumeroNivel:6=12)
				sFinalSit:="obtiene Licencia de Educación Media."
			Else 
				If ([Alumnos:2]Sexo:49="F")
					sFinalSit:="es promovida a "+GetGrado ([Alumnos_SintesisAnual:210]NumeroNivel:6+1)+"."
				Else 
					sFinalSit:="es promovido a "+GetGrado ([Alumnos_SintesisAnual:210]NumeroNivel:6+1)+"."
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


For ($i_filas;Size of array:C274(atActas_SubsectoresCertif);1;-1)
	atActas_SubsectoresCertif{$i_filas}:=ST_GetCleanString (atActas_SubsectoresCertif{$i_filas})
	If (atActas_SubsectoresCertif{$i_filas}="")
		DELETE FROM ARRAY:C228(atActas_SubsectoresCertif;$i_filas)
		DELETE FROM ARRAY:C228(atActas_CertNotas_Cifras;$i_filas)
		DELETE FROM ARRAY:C228(atActas_NotasCertif_Letras;$i_filas)
		DELETE FROM ARRAY:C228(atActas_Sectores;$i_filas)
		  // MOD Ticket N° 215809 Patricio Aliaga 20180906 Asignacion de estilo electivo (cursiva)
		DELETE FROM ARRAY:C228($ab_esElectivaFinal;$i_filas)
	Else 
		$i_filas:=0
	End if 
End for 

$l_pieDesde:=Find in array:C230(atActas_SubsectoresCertif;"Promedio General")
If ($l_pieDesde=-1)
	$l_pieDesde:=Find in array:C230(atActas_SubsectoresCertif;"Promedio Final")
	If ($l_pieDesde=-1)
		$l_pieDesde:=0
	End if 
End if 

$l_posicionEnActas:=Find in array:C230(atActas_SubsectoresCertif;"Promedio General")
If ($l_posicionEnActas=-1)
	$l_posicionEnActas:=Find in array:C230(atActas_SubsectoresCertif;"Promedio Final")
	If ($l_posicionEnActas>0)
		atActas_SubsectoresCertif{$l_posicionEnActas}:="Promedio General"
	End if 
End if 
If ($l_posicionEnActas>0)
	atActas_CertNotas_Cifras{$l_posicionEnActas}:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
	atActas_NotasCertif_Letras{$l_posicionEnActas}:=ST_Num2Text (Num:C11([Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29);True:C214;vb_usarSignosSeparadores)
Else 
	$b_configuracionEsValida:=False:C215
End if 


$l_posicionEnActas:=Find in array:C230(atActas_SubsectoresCertif;"Porcentaje de asistencia")
If ($l_posicionEnActas>0)
	atActas_CertNotas_Cifras{$l_posicionEnActas}:=sAst
	atActas_NotasCertif_Letras{$l_posicionEnActas}:=ST_Num2Text (Num:C11(sAst);False:C215)
Else 
	$b_configuracionEsValida:=False:C215
End if 


If ($b_configuracionEsValida)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$l_idAlumno)
	
	$t_pieColumna2:=""
	$t_pieColumna3:=""
	$t_pieColumna4:=""
	$l_numeroLineasPie:=0
	For ($i_filas;$l_pieDesde;Size of array:C274(atActas_SubsectoresCertif))
		$t_pieColumna2:=$t_pieColumna2+atActas_SubsectoresCertif{$i_filas}+"\r"
		$t_pieColumna3:=$t_pieColumna3+atActas_CertNotas_Cifras{$i_filas}+"\r"
		$t_pieColumna4:=$t_pieColumna4+atActas_NotasCertif_Letras{$i_filas}+"\r"
		$l_numeroLineasPie:=$l_numeroLineasPie+1
	End for 
	$l_numeroLineasPie:=$l_numeroLineasPie+1
	
	For ($i_filas;Size of array:C274(atActas_SubsectoresCertif);$l_pieDesde;-1)
		  // MOD Ticket N° 215809 Patricio Aliaga 20180906 Asignacion de estilo electivo (cursiva)
		AT_Delete ($i_filas;1;->atActas_SubsectoresCertif;->atActas_CertNotas_Cifras;->atActas_NotasCertif_Letras;->atActas_Sectores;->$ab_esElectivaFinal)
	End for 
	
	Case of 
		: ($l_año>=2002)
			$b_usarNuevoModelo:=True:C214
		: ((([Alumnos:2]nivel_numero:29<=7) | ([Alumnos:2]nivel_numero:29=9) | ([Alumnos:2]nivel_numero:29=10) | ([Alumnos:2]nivel_numero:29=11)) & (<>icrtfYear>=2001))
			$b_usarNuevoModelo:=True:C214
		: ((([Alumnos:2]nivel_numero:29<=6) | ([Alumnos:2]nivel_numero:29=9) | ([Alumnos:2]nivel_numero:29=10) | ([Alumnos:2]nivel_numero:29=11)) & (<>icrtfYear>=2000))
			$b_usarNuevoModelo:=True:C214
		: ((([Alumnos:2]nivel_numero:29<=5) | ([Alumnos:2]nivel_numero:29=9)) & (<>icrtfYear>=1999))
			$b_usarNuevoModelo:=True:C214
		Else 
			$b_usarNuevoModelo:=False:C215
	End case 
	
	For ($i_filas;1;Size of array:C274(atActas_Sectores))
		$l_idxSector:=Find in array:C230(<>aAsign;atActas_Sectores{$i_filas})
		If ($l_idxSector>0)
			If (<>aAsgLongName{$l_idxSector}#"")
				atActas_Sectores{$i_filas}:=<>aAsgLongName{$l_idxSector}
			End if 
		End if 
	End for 
	
	  // Modificado por: Alexis Bustamante (13-06-2017)
	  //cambio arreglo para que busque en arreglo de notas atActas_CertNotas_Cifras
	$l_filasSinCalificacion:=Count in array:C907(atActas_CertNotas_Cifras;"-")
	  //$l_filasSinCalificacion:=Count in array(atActas_NotasCertif_Letras;"-")
	
	$l_limitePlanComun:=0
	If ($l_filasSinCalificacion>0)
		If (vi_PrintEvaluadas=1)
			For ($i_filas;Size of array:C274(atActas_SubsectoresCertif);1;-1)
				If (atActas_CertNotas_Cifras{$i_filas}="-")
					  // MOD Ticket N° 215809 Patricio Aliaga 20180906 Asignacion de estilo electivo (cursiva)
					AT_Delete ($i_filas;1;->atActas_SubsectoresCertif;->atActas_CertNotas_Cifras;->atActas_NotasCertif_Letras;->atActas_Sectores;->$ab_esElectivaFinal)
					If ($i_filas<vi_PEStart)
						$l_limitePlanComun:=$l_limitePlanComun+1
					End if 
				End if 
			End for 
			
			For ($i_filas;1;Size of array:C274(atActas_SubsectoresCertif))
				$l_idxSimbolo:=Find in array:C230(<>aAsign;atActas_SubsectoresCertif{$i_filas})
				If ($l_idxSimbolo>0)
					If (<>aAsignSector{$l_idxSimbolo}#$t_ultimoSectorAprendizaje)
						atActas_Sectores{$i_filas}:=<>aAsignSector{$l_idxSimbolo}
						$t_ultimoSectorAprendizaje:=<>aAsignSector{$l_idxSimbolo}
					End if 
				End if 
			End for 
			
		End if 
	End if 
	
	
	If ($b_usarNuevoModelo)
		$l_ErrorPLP:=PL_SetArraysNam (pl_CertTplt;1;4;"atActas_Sectores";"atActas_SubsectoresCertif";"atActas_CertNotas_Cifras";"atActas_NotasCertif_Letras")
		PL_SetWidths (pl_CertTplt;1;4;131;221;51;138)
		PL_SetFormat (pl_CertTplt;3;"";2;2)
		PL_SetBrkText (pl_CertTplt;0;1;$t_pieColumna2;1;0)
		PL_SetBrkText (pl_CertTplt;0;3;$t_pieColumna3;0;0)
		PL_SetBrkText (pl_CertTplt;0;4;$t_pieColumna4;0;0)
		PL_SetBrkHeight (pl_CertTplt;0;$l_numeroLineasPie;2)
		PL_SetBrkStyle (pl_CertTplt;0;0;"Arial";9;0)
		PL_SetBrkColOpt (pl_CertTplt;0;1;0;4;"Black";"Black")
		PL_SetBrkColOpt (pl_CertTplt;0;2;1;4;"Black";"Black")
		PL_SetBrkColOpt (pl_CertTplt;0;3;1;4;"Black";"Black")
		PL_SetBrkColOpt (pl_CertTplt;0;4;1;4;"Black";"Black")
	Else 
		$l_ErrorPLP:=PL_SetArraysNam (pl_CertTplt;1;3;"atActas_SubsectoresCertif";"atActas_CertNotas_Cifras";"atActas_NotasCertif_Letras")
		PL_SetWidths (pl_CertTplt;1;3;352;50;138)
		PL_SetFormat (pl_CertTplt;2;"";2;2)
		PL_SetBrkText (pl_CertTplt;0;1;$t_pieColumna2;0;0)
		PL_SetBrkText (pl_CertTplt;0;2;$t_pieColumna3;0;0)
		PL_SetBrkText (pl_CertTplt;0;3;$t_pieColumna4;0;0)
		PL_SetBrkHeight (pl_CertTplt;0;$l_numeroLineasPie;2)
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
	
	  // MOD Ticket N° 215809 Patricio Aliaga 20180906 Asignacion de estilo electivo (cursiva)
	  //For ($i_filas;vi_PEStart-$l_limitePlanComun;vi_PEEnd)
	  //PL_SetRowStyle (pl_certTplt;$i_filas;1)
	  //End for 
	  //End if 
	C_LONGINT:C283($l_factor)
	For ($i;1;Size of array:C274($ab_esElectivaFinal))
		If (Not:C34($ab_esElectivaFinal{$i}))
			$l_factor:=0
		Else 
			$l_factor:=2
		End if 
		PL_SetRowStyle (pl_certTplt;$i;$l_factor)
	End for 
	
	If (vCert6="")
		vCert6:=<>gRector+"\r"+"Director(a)"
	End if 
	
End if 