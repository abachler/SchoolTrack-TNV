//%attributes = {}
  // prActa()
  // Por: Alberto Bachler K.: 28-02-14, 17:04:01
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_enUnaTarea;$b_tareaImpresionIniciada)
C_LONGINT:C283($i_registros;$i_curso_registros;$l_anchoMaximo;$l_IdProgreso;$l_ignorado;$l_resultado)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_configuracionEspecial;$t_destinoImpresion;$t_expresionNombreArchivo;$t_formularioPagina1;$t_formularioPagina2;$t_nombreFormulario;$t_nombreInforme;$t_rutaPDF)

ARRAY LONGINT:C221($al_recNumAlumnos;0)
ARRAY LONGINT:C221($al_RecNums;0)

If (False:C215)
	C_TEXT:C284(prActa ;$1)
	C_TEXT:C284(prActa ;$2)
End if 

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_expresionNombreArchivo:=$2
End if 

$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
$t_nombreFormulario:=[xShell_Reports:54]FormName:17
$t_nombreInforme:=[xShell_Reports:54]FormName:17
$t_configuracionEspecial:=[xShell_Reports:54]SpecialParameter:18

EVS_LoadStyles 

  //prActa
ARRAY INTEGER:C220(alActas_ColumnNumber;0)
ARRAY TEXT:C222(atActas_Subsectores;0)
C_LONGINT:C283(vi_columns;vi_PCStart;vi_PCEnd;vi_PEStart;vi_PEEnd)
C_TEXT:C284(vs_ActaTitle;vs_ActaSubTitle;vt_Menciones;vRespName;theText;vs_PromoAnticipada)

MESSAGES ON:C181
READ ONLY:C145([xxSTR_Niveles:6])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Profesores:4])
READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([Colegio:31])


BRING TO FRONT:C326(Current process:C322)


If (<>shift)
	ORDER BY:C49([Cursos:3])
Else 
	ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
End if 


Case of 
	: ((SYS_IsWindows ) & ($t_configuracionEspecial="carta"))
		$t_formularioPagina1:="rep_CL_Acta1_carta"
		$t_formularioPagina2:="rep_CL_Acta2_carta"
		$l_anchoMaximo:=Int:C8(540/vi_columns)-3
	: ((SYS_IsWindows ) & ($t_configuracionEspecial="oficio"))
		$t_formularioPagina1:="rep_CL_Acta1_oficio"
		$t_formularioPagina2:="rep_CL_Acta2_oficio"
		$l_anchoMaximo:=Int:C8(390/vi_columns)-3
	: ((SYS_IsMacintosh ) & ($t_configuracionEspecial="carta"))
		$t_formularioPagina1:="rep_CL_Acta1_carta"
		$t_formularioPagina2:="rep_CL_Acta2_carta"
		$l_anchoMaximo:=Int:C8(540/vi_columns)-3
	: ((SYS_IsMacintosh ) & ($t_configuracionEspecial="oficio"))
		$t_formularioPagina1:="rep_CL_Acta1_oficio"
		$t_formularioPagina2:="rep_CL_Acta2_oficio"
		$l_anchoMaximo:=Int:C8(390/vi_columns)-3
End case 


QR_AjustesImpresion (0;->[Cursos:3];$t_formularioPagina1)
If (ok=1)
	BRING TO FRONT:C326(Current process:C322)
	
	LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_RecNums;"")
	<>stopExec:=False:C215
	For ($i_registros;1;Size of array:C274($al_RecNums))
		GOTO RECORD:C242([Cursos:3];$al_RecNums{$i_registros})
		  //verificación de promedios
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		SELECTION TO ARRAY:C260([Alumnos:2];$al_recNumAlumnos)
		VARIABLE TO BLOB:C532($al_recNumAlumnos;$x_blob)
		
		vb_Error:=False:C215
		vb_AsignaSituacionFinal:=False:C215
		If (Not:C34(<>vb_BloquearModifSituacionFinal))
			If (Application type:C494=4D Remote mode:K5:5)
				<>vb_CalculandoSitFinal:=True:C214
				vb_CalculandoSitFinal:=True:C214
				$l_ignorado:=Execute on server:C373("dbu_CalculaSituacionFinal";64000;"Calculos de situación Final";$x_blob)
				$l_IdProgreso:=IT_UThermometer (1;0;__ ("Calculando situación final de los alumnos del curso."))
				Repeat 
					GET PROCESS VARIABLE:C371(-1;<>vb_CalculandoSitFinal;vb_CalculandoSitFinal)
					If (vb_CalculandoSitFinal)
						DELAY PROCESS:C323(Current process:C322;15)
					End if 
				Until (vb_CalculandoSitFinal=False:C215)
				IT_UThermometer (-2;$l_IdProgreso)
			Else 
				dbu_CalculaSituacionFinal ($x_blob;False:C215)
			End if 
		End if 
		$l_resultado:=dbu_VerificaPromediosActa ($x_blob;False:C215)
		
		GOTO RECORD:C242([Cursos:3];$al_RecNums{$i_registros})
		ACTAS_InitVars (0)
		ACTAS_LeeConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1;<>gYear)
		GOTO RECORD:C242([Cursos:3];$al_RecNums{$i_registros})
		
		ACTAS_InitVars (0)
		ACTAS_setUnivers 
		ACTAS_Encabezados 
		ACTAS_Page1 
		ACTAS_Page2 
		
		OK:=1
		
		
		If ($t_destinoImpresion="pdf")
			If ($t_expresionNombreArchivo="")
				$t_rutaPDF:=vt_rutaCarpetaPDF+QR_EvaluaNombreDocumento ($t_expresionNombreArchivo;$t_destinoImpresion)
			End if 
			SET PRINT OPTION:C733(Destination option:K47:7;3;$t_rutaPdf)
			SET PRINT OPTION:C733(Hide printing progress option:K47:12;1)
			OPEN PRINTING JOB:C995
			$b_tareaImpresionIniciada:=True:C214
		End if 
		
		$b_enUnaTarea:=True:C214
		QR_ImprimeFormularioRegistro ($y_tabla;$t_formularioPagina1;$t_destinoImpresion;$t_expresionNombreArchivo;$b_enUnaTarea)
		
		If (OK=1)
			$b_enUnaTarea:=True:C214
			QR_ImprimeFormularioRegistro ($y_tabla;$t_formularioPagina2;$t_destinoImpresion;$t_expresionNombreArchivo;$b_enUnaTarea)
		Else 
			$i_curso_registros:=Size of array:C274($al_RecNums)
		End if 
		
		If ($b_tareaImpresionIniciada)
			PAGE BREAK:C6
			CLOSE PRINTING JOB:C996
		End if 
		
		If (<>stopExec)
			$i_registros:=Size of array:C274($al_recNums)
		End if 
		
		
	End for 
	
	
	ACTAS_InitVars (0)
	ARRAY TEXT:C222(aSign;0)
	ARRAY TEXT:C222(aSignAut;0)
	ARRAY TEXT:C222(aSignAsg;0)
	ARRAY TEXT:C222(aSignProf;0)
	
End if 


