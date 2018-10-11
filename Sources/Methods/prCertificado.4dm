//%attributes = {}
  // prCertificado()
  //
  //
  // creado por: Alberto Bachler Klein: 28-03-16, 20:13:48
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($x_recnumAlumnos)
C_LONGINT:C283($i;$l_idProceso;$l_resultado)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento;$t_formulario)

ARRAY LONGINT:C221($al_recNums;0)



If (False:C215)
	C_TEXT:C284(prCertificado ;$1)
	C_TEXT:C284(prCertificado ;$2)
End if 

C_LONGINT:C283(<>icrtfYear)
C_TEXT:C284(vCert1;vCert2;vCert3;vCert4;vCert5;vCert6)
C_TEXT:C284(vFont1;vFont2;vFont3;vFont4;vFont5;vFont6;vFont7)
C_LONGINT:C283(vSize1;vSize2;vSize3;vSize4;vSize5;vSize6;vStyle1;vStyle2;vStyle3;vStyle4;vStyle5;vStyle6;vStyle7)
MESSAGES ON:C181

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_formulaNombreDocumento:=$2
End if 

If (<>icrtfYear<=0)
	CD_Dlog (0;__ ("No hay registros histórico para imprimir un certificado de años anteriores."))
Else 
	
	READ ONLY:C145([xxSTR_Niveles:6])
	READ ONLY:C145([Cursos:3])
	READ ONLY:C145([Asignaturas:18])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([Profesores:4])
	READ ONLY:C145([Alumnos_Calificaciones:208])
	
	READ ONLY:C145([Colegio:31])
	ALL RECORDS:C47([Colegio:31])
	FIRST RECORD:C50([Colegio:31])
	
	  //USE NAMED SELECTION("<>Editions")
	
	If (<>icrtfYear=<>gYear)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"En Trámite";*)
		QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]Status:50#"Oyente";*)
		QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]nivel_numero:29>=1)
	Else 
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29>=1)
	End if 
	
	ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
	Case of 
		: (vt_PLConfigMessage="carta")
			$t_formulario:="rep_CL_Certificado_carta"
			QR_AjustesImpresion (Letter_Portrait)
			
		: (vt_PLConfigMessage="oficio")
			$t_formulario:="rep_CL_Certificado_oficio"
			QR_AjustesImpresion (Legal_Portrait)
			
	End case 
	  //PRINT SETTINGS
	
	
	If (ok=1)
		vb_usarSignosSeparadores:=False:C215
		If (Macintosh option down:C545 | Windows Alt down:C563)
			$l_resultado:=CD_Dlog (0;__ ("En el certificado además de la nota numérica se imprime su conversión en letras\rPuede usar la palabra \"coma\" o el signo de puntuación\",\".\r\r¿Qué forma desea imprimir?");"";"Usar \"coma\"";"Usar \",\"")
			If ($l_resultado=1)
				vb_usarSignosSeparadores:=False:C215
			Else 
				vb_usarSignosSeparadores:=True:C214
			End if 
		End if 
		
		
		LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_recNums)
		VARIABLE TO BLOB:C532($al_recNums;$x_recnumAlumnos)
		
		vb_Error:=False:C215
		vb_AsignaSituacionFinal:=False:C215
		If (Not:C34(<>vb_BloquearModifSituacionFinal))
			If (Application type:C494=4D Remote mode:K5:5)
				<>vb_CalculandoSitFinal:=True:C214
				vb_CalculandoSitFinal:=True:C214
				If (<>icrtfYear=<>gYear)
					$l_idProceso:=Execute on server:C373("dbu_CalculaSituacionFinal";Pila_256K;"Calculos de situación Final";$x_recnumAlumnos)
					Repeat 
						GET PROCESS VARIABLE:C371(-1;<>vb_CalculandoSitFinal;vb_CalculandoSitFinal)
						If (vb_CalculandoSitFinal)
							DELAY PROCESS:C323(Current process:C322;15)
						End if 
					Until (vb_CalculandoSitFinal=False:C215)
				End if 
			Else 
				If (<>icrtfYear=<>gYear)
					dbu_CalculaSituacionFinal ($x_recnumAlumnos;False:C215)
				End if 
			End if 
		End if 
		OK:=1
		
		<>stopExec:=False:C215
		For ($i;1;Size of array:C274($al_recNums))
			GOTO RECORD:C242([Alumnos:2];$al_recNums{$i})
			QR_ImprimeFormularioRegistro (->[Alumnos:2];$t_formulario;$t_destinoImpresion;$t_formulaNombreDocumento)
			
			<>icrtfYear:=<>gYear
			If (<>stopExec)
				$i:=Size of array:C274($al_recNums)
			End if 
		End for 
		
	End if 
End if 







