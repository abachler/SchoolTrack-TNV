//%attributes = {}
  // MƒTODO: AL_CalculaPromediosGenerales
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creaci—n: 28/02/12, 11:44:33
  // ----------------------------------------------------
  // DESCRIPCIîN
  //
  //
  // PARçMETROS
  // AL_CalculaPromediosGenerales()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_POINTER:C301($y_Arreglofactores)
C_BOOLEAN:C305($b_success;$b_hayNotas)
C_LONGINT:C283($l_estiloEvaluacionInterno;$l_estiloEvaluacionOficial;$l_evaluaciones;$l_idAlumno;$l_modoImpresionOficial;$l_modoPromedioInterno;$l_nivel;$l_recNumAlumno;$l_truncarPromedios;$l_modoCalculo)
C_LONGINT:C283($l_modoImpresionInterno;$l_modoPromedioOficial;$r_promedioNumerico)
C_REAL:C285($r_minimoInterno;$r_mediaNota;$r_mediaPuntos;$r_mediaReal;$r_minimoOficial;$r_real)
C_TEXT:C284($t_llave;$t_MediaLiteral;$t_mediaLiteralInterno;$t_mediaLiteral;$t_mediaSimbolos;$t_promedioAnual;$t_promedioGeneralInterno;$t_promedioGeneralOficial)

ARRAY BOOLEAN:C223($aIncidePromedioInterno;0)
ARRAY BOOLEAN:C223($aIncidePromedioOficial;0)
ARRAY LONGINT:C221($idAsig;0)
ARRAY REAL:C219($aFactorInterno;0)
ARRAY REAL:C219($aFactorOficial;0)
ARRAY INTEGER:C220($ai_Horas;0)
ARRAY REAL:C219($aNota1;0)
ARRAY REAL:C219($aNota2;0)
ARRAY REAL:C219($aNota3;0)
ARRAY REAL:C219($aNota4;0)
ARRAY REAL:C219($aNota5;0)
ARRAY REAL:C219($aPuntos1;0)
ARRAY REAL:C219($aPuntos2;0)
ARRAY REAL:C219($aPuntos3;0)
ARRAY REAL:C219($aPuntos4;0)
ARRAY REAL:C219($aPuntos5;0)
ARRAY REAL:C219($aReal1;0)
ARRAY REAL:C219($aReal2;0)
ARRAY REAL:C219($aReal3;0)
ARRAY REAL:C219($aReal4;0)
ARRAY REAL:C219($aReal5;0)
ARRAY REAL:C219($aRealAnual;0)
ARRAY REAL:C219($aRealAnualNotas;0)
ARRAY REAL:C219($aRealAnualPuntos;0)
ARRAY REAL:C219($aRealFinal;0)
ARRAY REAL:C219($aRealFinalNotas;0)
ARRAY REAL:C219($aRealFinalPuntos;0)
ARRAY REAL:C219($aRealNotasOficial;0)
ARRAY REAL:C219($aRealOficial;0)
ARRAY REAL:C219($aRealPuntosOficial;0)
ARRAY REAL:C219($ar_copiaEvaluaciones;0)

If (False:C215)
	C_BOOLEAN:C305(AL_CalculaPromediosGenerales ;$0)
	C_LONGINT:C283(AL_CalculaPromediosGenerales ;$1)
	C_LONGINT:C283(AL_CalculaPromediosGenerales ;$2)
End if 

  // DECLARACIONES E INICIALIZACIONES

  // CODIGO PRINCIPAL

$b_success:=False:C215
$l_idAlumno:=$1

If (Count parameters:C259=2)
	$l_nivel:=$2
Else 
	$l_nivel:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]nivel_numero:29)
End if 

If (Not:C34(<>vb_BloquearModifSituacionFinal))
	  //CUERPO
	$l_recNumAlumno:=KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$l_idAlumno;True:C214)  //29/02/2008, 17:46:55 - Bœsqueda en el index y carga del registro en escritura
	
	PERIODOS_LoadData ($l_nivel)
	
	If ($l_recNumAlumno>=0)
		  //INICIALIZACION DE LOS PROMEDIOS EN LOS REGISTRO DE SINTESIS ANUAL
		$t_llave:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($l_nivel)+"."+String:C10($l_idAlumno)
		  //promedio anual
		$r_mediaReal:=-10
		$r_mediaNota:=-10
		$r_mediaPuntos:=-10
		$t_mediaSimbolos:=""
		$t_mediaLiteralInterno:=""
		$t_mediaLiteral:=""
		
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Nota:93;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Puntos:94;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Simbolo:95;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96;->$t_mediaLiteralInterno;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Real:237;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Nota:238;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Puntos:239;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Simbolo:240;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241;->$t_mediaLiteralInterno;False:C215)
		
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Nota:122;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Puntos:123;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Simbolo:124;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125;->$t_mediaLiteralInterno;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Real:242;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Nota:243;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Puntos:244;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Simbolo:245;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246;->$t_mediaLiteralInterno;False:C215)
		
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Nota:151;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Puntos:152;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Simbolo:153;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154;->$t_mediaLiteralInterno;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Real:247;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Nota:248;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Puntos:249;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Simbolo:250;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251;->$t_mediaLiteralInterno;False:C215)
		
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Nota:180;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Puntos:181;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Simbolo:182;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183;->$t_mediaLiteralInterno;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Real:252;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Nota:253;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Puntos:254;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Simbolo:255;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256;->$t_mediaLiteralInterno;False:C215)
		
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Nota:209;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Puntos:210;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Simbolo:211;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212;->$t_mediaLiteralInterno;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Real:257;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Nota:258;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Puntos:259;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Simbolo:260;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261;->$t_mediaLiteralInterno;False:C215)
		
		  //promedio anual
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualOficial_Real:15;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualOficial_Nota:16;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualOficial_Puntos:17;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualOficial_Simbolo:18;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19;->$t_mediaLiteralInterno;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Nota:11;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Puntos:12;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Simbolo:13;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14;->$t_mediaLiteralInterno;False:C215)
		
		  //promedio final INTERNO
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Simbolo:23;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24;->$t_mediaLiteralInterno;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Nota:273;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Puntos:274;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Literal:275;->$t_mediaLiteral;False:C215)
		
		  //promedio final OFICIAL
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Puntos:27;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Simbolo:28;->$t_mediaSimbolos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29;->$t_mediaLiteral;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268;->$r_mediaReal;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Nota:269;->$r_mediaNota;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Puntos:270;->$r_mediaPuntos;False:C215)
		AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Literal:271;->$t_mediaLiteral;False:C215)
		  //AL_EscribeSintesisAnual
		
		SAVE RECORD:C53([Alumnos_SintesisAnual:210])
		$b_success:=True:C214
		
		If (($b_success) & (Records in selection:C76([Alumnos:2])=1))
			
			  //conservo los promedios actuales en variables para compararlos con los nuevos resultados y decidir si es necesario recalcular la situaci—n final
			$t_promedioGeneralInterno:=[Alumnos:2]Promedio_General_Interno:88
			$t_promedioGeneralOficial:=[Alumnos:2]Promedio_General_Oficial:32
			$t_promedioAnual:=[Alumnos:2]Promedio_Anual:63
			$r_promedioNumerico:=[Alumnos:2]Promedio_General_Numerico:57
			
			READ ONLY:C145([Asignaturas:18])
			
			EV2_InitArrays 
			
			$l_truncarPromedios:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
			$l_estiloEvaluacionInterno:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]EvStyle_interno:33)
			$l_modoPromedioInterno:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]ModoPromedioGeneralInterno:47)
			$l_modoPromedioOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]ModoPromedioGeneralOficial:48)
			$l_estiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]EvStyle_oficial:23)
			
			EVS_ReadStyleData ($l_estiloEvaluacionInterno)  //lectura del estilo interno
			$l_modoImpresionInterno:=iPrintMode
			$r_minimoInterno:=vrNTA_MinimoEscalaReferencia
			  //If ($l_estiloEvaluacionInterno=0)
			EVS_ReadStyleData ($l_estiloEvaluacionOficial)  //lectura del estilo oficial
			$l_modoImpresionOficial:=iPrintActa
			$r_minimoOficial:=vrNTA_MinimoEscalaReferencia
			  //End if 
			If (($l_estiloEvaluacionOficial=0) & ($l_estiloEvaluacionInterno=0))
				  //no hay estilo oficial o interno asignado al nivel. No es posible calcular los promedios
			Else 
				READ ONLY:C145([Alumnos_Calificaciones:208])
				
				EV2_RegistrosDelAlumno ($l_idAlumno;$l_nivel)
				If ($r_minimoInterno=0)
					$l_modoCalculo:=3
				Else 
					$l_modoCalculo:=1
				End if 
				
				$l_truncarPromedios:=Num:C11(KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]PromediosGeneralesTruncados:11))
				$l_evaluaciones:=Records in selection:C76([Alumnos_Calificaciones:208])
				If ($l_evaluaciones>0)
					
					$t_llave:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($l_nivel)+"."+String:C10($l_idAlumno)
					CREATE SET:C116([Alumnos_Calificaciones:208];"Calificaciones")
					
					  //CALCULO DE PROMEDIOS INTERNOS
					EVS_ReadStyleData ($l_estiloEvaluacionInterno)  //Êlectura del estilo interno
					
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					USE SET:C118("Calificaciones")
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]IncideEnPromedioInterno:64=True:C214)
					
					If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
						ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]ordenGeneral:105;>)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;$aReal1;[Alumnos_Calificaciones:208]P02_Final_Real:187;$aReal2;[Alumnos_Calificaciones:208]P03_Final_Real:262;$aReal3;[Alumnos_Calificaciones:208]P04_Final_Real:337;$aReal4;[Alumnos_Calificaciones:208]P05_Final_Real:412;$aReal5;*)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Nota:113;$aNota1;[Alumnos_Calificaciones:208]P02_Final_Nota:188;$aNota2;[Alumnos_Calificaciones:208]P03_Final_Nota:263;$aNota3;[Alumnos_Calificaciones:208]P04_Final_Nota:338;$aNota4;[Alumnos_Calificaciones:208]P05_Final_Nota:413;$aNota5;*)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Puntos:114;$aPuntos1;[Alumnos_Calificaciones:208]P02_Final_Puntos:189;$aPuntos2;[Alumnos_Calificaciones:208]P03_Final_Puntos:264;$aPuntos3;[Alumnos_Calificaciones:208]P04_Final_Puntos:339;$aPuntos4;[Alumnos_Calificaciones:208]P05_Final_Puntos:414;$aPuntos5;*)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Real:11;$aRealAnual;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$aRealFinal;[Alumnos_Calificaciones:208]Anual_Nota:12;$aRealAnualNotas;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;$aRealFinalNotas;[Alumnos_Calificaciones:208]Anual_Puntos:13;$aRealAnualPuntos;[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;$aRealFinalPuntos;*)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$aRealOficial;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$aRealNotasOficial;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;$aRealPuntosOficial;*)
						SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$at_asignatura;[Asignaturas:18]Incide_en_promedio:27;$aIncidePromedioOficial;[Asignaturas:18]IncideEnPromedioInterno:64;$aIncidePromedioInterno;[Asignaturas:18]Horas_Semanales:51;$ai_Horas;[Asignaturas:18]PonderacionEnPromedioINT:110;$aFactorInterno;[Asignaturas:18]PonderacionEnPromedioOF:109;$aFactorOficial;*)
						SELECTION TO ARRAY:C260([Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_idEstiloEvaluacion)
						SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
						
						
						Case of 
							: ($l_modoPromedioInterno=Ponderado por factor)
								$y_Arreglofactores:=->$aFactorInterno
							: ($l_modoPromedioInterno=Ponderado por Int Horaria)
								$y_Arreglofactores:=->$ai_Horas
							: ($l_modoPromedioInterno=Sin ponderaciones)
								  // nil
						End case 
						
						
						
						  //periodo 1
						$aReal1{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aReal1;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionInterno-1;->$aNota1;->$aPuntos1;->$aReal1;->$aReal1)
							AL_RetornaPromedios ($l_estiloEvaluacionInterno;$l_modoImpresionInterno;$l_modoPromedioInterno;"PP";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Nota:93;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Puntos:94;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Simbolo:95;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96;->$t_mediaLiteral;False:C215)
						End if 
						
						  //periodo 2
						$aReal2{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aReal2;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionInterno-1;->$aNota2;->$aPuntos2;->$aReal2;->$aReal2)
							AL_RetornaPromedios ($l_estiloEvaluacionInterno;$l_modoImpresionInterno;$l_modoPromedioInterno;"PP";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Nota:122;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Puntos:123;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Simbolo:124;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125;->$t_mediaLiteral;False:C215)
						End if 
						
						  //periodo 3
						$aReal3{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aReal3;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionInterno-1;->$aNota3;->$aPuntos3;->$aReal3;->$aReal3)
							AL_RetornaPromedios ($l_estiloEvaluacionInterno;$l_modoImpresionInterno;$l_modoPromedioInterno;"PP";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Nota:151;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Puntos:152;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Simbolo:153;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154;->$t_mediaLiteral;False:C215)
						End if 
						
						  //periodo 4
						$aReal4{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aReal4;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionInterno-1;->$aNota4;->$aPuntos4;->$aReal4;->$aReal4)
							AL_RetornaPromedios ($l_estiloEvaluacionInterno;$l_modoImpresionInterno;$l_modoPromedioInterno;"PP";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Nota:180;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Puntos:181;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Simbolo:182;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183;->$t_mediaLiteral;False:C215)
						End if 
						
						  //periodo 5
						$aReal5{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aReal5;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionInterno-1;->$aNota5;->$aPuntos5;->$aReal5;->$aReal5)
							AL_RetornaPromedios ($l_estiloEvaluacionInterno;$l_modoImpresionInterno;$l_modoPromedioInterno;"PP";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Nota:209;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Puntos:210;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Simbolo:211;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212;->$t_mediaLiteral;False:C215)
						End if 
						
						  //promedio Anual INTERNO
						$aRealAnual{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aRealAnual;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionInterno-1;->$aRealAnualNotas;->$aRealAnualPuntos;->$aRealAnual;->$aRealAnual)
							AL_RetornaPromedios ($l_estiloEvaluacionInterno;$l_modoImpresionInterno;$l_modoPromedioInterno;"PF";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Nota:11;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Puntos:12;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Simbolo:13;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14;->$t_mediaLiteral;False:C215)
						End if 
						
						  //promedio final INTERNO
						$aRealFinal{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aRealFinal;">=")>0)
						If ($b_hayNotas)
							  //$y_reales:=Choose($l_modoImpresionOficial-1;->$aRealNotasOficial;->$aRealPuntosOficial;->$aRealOficial;->$aRealOficial)
							$y_reales:=Choose:C955($l_modoImpresionInterno-1;->$aRealAnualNotas;->$aRealAnualPuntos;->$aRealAnual;->$aRealAnual)  // MONO 204361
							COPY ARRAY:C226($y_reales->;$ar_copiaEvaluaciones)
							AL_RetornaPromedios ($l_estiloEvaluacionInterno;$l_modoImpresionInterno;$l_modoPromedioInterno;"";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Nota:273;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Puntos:274;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Literal:275;->$t_MediaLiteral;False:C215)
							
							  // Calculo del promedio final interno APROXIMADO
							$y_reales:=->$ar_copiaEvaluaciones
							AL_RetornaPromedios ($l_estiloEvaluacionInterno;$l_modoImpresionInterno;$l_modoPromedioInterno;"NF";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Simbolo:23;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24;->$t_mediaLiteral;False:C215)
						End if 
						AL_EscribeSintesisAnual   //llamada sin argumentos, se escribe en disco el registro en memoria
					End if 
					
					
					$b_convertir_a_EstiloOficial:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37)
					EVS_ReadStyleData ($l_estiloEvaluacionOficial)  //Êlectura del estilo oficial
					
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					USE SET:C118("Calificaciones")
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incide_en_promedio:27=True:C214)
					
					If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
						ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]ordenGeneral:105;>)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Real:112;$aReal1;[Alumnos_Calificaciones:208]P02_Final_Real:187;$aReal2;[Alumnos_Calificaciones:208]P03_Final_Real:262;$aReal3;[Alumnos_Calificaciones:208]P04_Final_Real:337;$aReal4;[Alumnos_Calificaciones:208]P05_Final_Real:412;$aReal5;*)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Nota:113;$aNota1;[Alumnos_Calificaciones:208]P02_Final_Nota:188;$aNota2;[Alumnos_Calificaciones:208]P03_Final_Nota:263;$aNota3;[Alumnos_Calificaciones:208]P04_Final_Nota:338;$aNota4;[Alumnos_Calificaciones:208]P05_Final_Nota:413;$aNota5;*)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]P01_Final_Puntos:114;$aPuntos1;[Alumnos_Calificaciones:208]P02_Final_Puntos:189;$aPuntos2;[Alumnos_Calificaciones:208]P03_Final_Puntos:264;$aPuntos3;[Alumnos_Calificaciones:208]P04_Final_Puntos:339;$aPuntos4;[Alumnos_Calificaciones:208]P05_Final_Puntos:414;$aPuntos5;*)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Real:11;$aRealAnual;[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;$aRealFinal;[Alumnos_Calificaciones:208]Anual_Nota:12;$aRealAnualNotas;[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;$aRealFinalNotas;[Alumnos_Calificaciones:208]Anual_Puntos:13;$aRealAnualPuntos;[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;$aRealFinalPuntos;*)
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;$aRealOficial;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;$aRealNotasOficial;[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;$aRealPuntosOficial;[Asignaturas:18]Incide_en_promedio:27;$aIncidePromedioOficial;[Asignaturas:18]IncideEnPromedioInterno:64;$aIncidePromedioInterno;[Asignaturas:18]Horas_Semanales:51;$ai_Horas;[Asignaturas:18]PonderacionEnPromedioOF:109;$aFactorOficial;*)
						SELECTION TO ARRAY:C260([Asignaturas:18]Numero_de_EstiloEvaluacion:39;$al_idEstiloEvaluacion;[Asignaturas:18]NotaOficial_conEstiloAsignatura:95;$ab_NOf_conEstiloAsignatura)
						SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
						Case of 
							: ($l_modoPromedioOficial=Ponderado por factor)
								$y_Arreglofactores:=->$aFactorOficial
							: ($l_modoPromedioOficial=Ponderado por Int Horaria)
								$y_Arreglofactores:=->$ai_Horas
							: ($l_modoPromedioOficial=Sin ponderaciones)
								  // nil
						End case 
						
						If ($b_convertir_a_EstiloOficial)
							For ($i;1;Size of array:C274($ab_NOf_conEstiloAsignatura))
								$ab_NOf_conEstiloAsignatura{$i}:=Choose:C955($ab_NOf_conEstiloAsignatura{$i};$ab_NOf_conEstiloAsignatura{$i};False:C215)
							End for 
						End if 
						
						
						
						  //periodo 1
						$aReal1{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aReal1;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionOficial-1;->$aNota1;->$aPuntos1;->$aReal1;->$aReal1)
							AL_RetornaPromedios ($l_estiloEvaluacionOficial;$l_modoImpresionOficial;$l_modoPromedioOficial;"NO";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Real:237;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Nota:238;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Puntos:239;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Simbolo:240;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241;->$t_mediaLiteral;False:C215)
						End if 
						
						  //periodo 2
						$aReal2{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aReal2;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionOficial-1;->$aNota2;->$aPuntos2;->$aReal2;->$aReal2)
							AL_RetornaPromedios ($l_estiloEvaluacionOficial;$l_modoImpresionOficial;$l_modoPromedioOficial;"NO";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Real:242;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Nota:243;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Puntos:244;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Simbolo:245;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246;->$t_mediaLiteral;False:C215)
						End if 
						
						  //periodo 3
						$aReal3{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aReal3;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionOficial-1;->$aNota3;->$aPuntos3;->$aReal3;->$aReal3)
							AL_RetornaPromedios ($l_estiloEvaluacionOficial;$l_modoImpresionOficial;$l_modoPromedioOficial;"NO";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Real:247;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Nota:248;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Puntos:249;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Simbolo:250;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251;->$t_mediaLiteral;False:C215)
						End if 
						
						  //periodo 4
						$aReal4{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aReal4;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionOficial-1;->$aNota4;->$aPuntos4;->$aReal4;->$aReal4)
							AL_RetornaPromedios ($l_estiloEvaluacionOficial;$l_modoImpresionOficial;$l_modoPromedioOficial;"NO";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Real:252;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Nota:253;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Puntos:254;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Simbolo:255;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256;->$t_mediaLiteral;False:C215)
						End if 
						
						  //periodo 5
						$aReal5{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aReal5;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionOficial-1;->$aNota5;->$aPuntos5;->$aReal5;->$aReal5)
							AL_RetornaPromedios ($l_estiloEvaluacionOficial;$l_modoImpresionOficial;$l_modoPromedioOficial;"NO";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Real:257;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Nota:258;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Puntos:259;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Simbolo:260;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261;->$t_mediaLiteral;False:C215)
						End if 
						
						  //promedio anual OFICIAL
						$aRealAnual{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aRealAnual;">=")>0)
						If ($b_hayNotas)
							$y_reales:=Choose:C955($l_modoImpresionOficial-1;->$aRealAnualNotas;->$aRealAnualPuntos;->$aRealAnual;->$aRealAnual)
							AL_RetornaPromedios ($l_estiloEvaluacionOficial;$l_modoImpresionOficial;$l_modoPromedioOficial;"NO";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualOficial_Real:15;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualOficial_Nota:16;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualOficial_Puntos:17;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualOficial_Simbolo:18;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19;->$t_mediaLiteral;False:C215)
						End if 
						
						  //promedio final OFICIAL
						$aRealOficial{0}:=vrNTA_MinimoEscalaReferencia
						$b_hayNotas:=(AT_SearchArray (->$aRealOficial;">=")>0)
						If ($b_hayNotas)
							  // Calculo del promedio oficial NO aproximado
							$y_reales:=Choose:C955($l_modoImpresionOficial-1;->$aRealNotasOficial;->$aRealPuntosOficial;->$aRealOficial;->$aRealOficial)
							COPY ARRAY:C226($y_reales->;$ar_copiaEvaluaciones)
							AL_RetornaPromedios ($l_estiloEvaluacionOficial;$l_modoImpresionOficial;$l_modoPromedioOficial;"";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Real:268;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Nota:269;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Puntos:270;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioOf_NoAprox_Literal:271;->$t_MediaLiteral;False:C215)
							
							  //Calculo del promedio oficial APROXIMADO
							$y_reales:=->$ar_copiaEvaluaciones
							AL_RetornaPromedios ($l_estiloEvaluacionOficial;$l_modoImpresionOficial;$l_modoPromedioOficial;"NO";$l_truncarPromedios;$y_reales;$y_Arreglofactores;->$r_mediaReal;->$r_MediaNota;->$r_MediaPuntos;->$t_MediaLiteral;->$t_MediaSimbolos;->$al_idEstiloEvaluacion;->$ab_NOf_conEstiloAsignatura)
							
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25;->$r_mediaReal;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26;->$r_mediaNota;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Puntos:27;->$r_mediaPuntos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Simbolo:28;->$t_mediaSimbolos;False:C215)
							AL_EscribeSintesisAnual ($t_llave;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29;->$t_mediaLiteral;False:C215)
						End if 
						AL_EscribeSintesisAnual   //llamada sin argumentos, se escribe en disco el registro en memoria
						
						KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
						
						[Alumnos:2]Promedio_General_Interno:88:=[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24
						[Alumnos:2]Promedio_General_Oficial:32:=[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
						[Alumnos:2]Promedio_Anual:63:=[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19
						
						If ([Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272>=$r_minimoOficial)
							Case of 
								: ($l_modoImpresionOficial=Notas)
									[Alumnos:2]Promedio_General_Numerico:57:=Round:C94([Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Nota:273;10)
								: ($l_modoImpresionOficial=Puntos)
									[Alumnos:2]Promedio_General_Numerico:57:=Round:C94([Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Puntos:274;10)
								: ($l_modoImpresionOficial=Porcentaje)
									[Alumnos:2]Promedio_General_Numerico:57:=Round:C94([Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272;10)
								: ($l_modoImpresionOficial=Simbolos)
									[Alumnos:2]Promedio_General_Numerico:57:=Round:C94([Alumnos_SintesisAnual:210]PromedioInt_NoAprox_Real:272;10)
							End case 
						End if 
						
						SAVE RECORD:C53([Alumnos:2])
						
						If (<>vtXS_CountryCode="cl")
							If ($l_nivel=12)
								[Alumnos:2]Chile_PromedioEMedia:73:=AL_PromedioUChile_cl 
							End if 
							SAVE RECORD:C53([Alumnos:2])
						End if 
						
						KRL_ReloadAsReadOnly (->[Alumnos:2])
					End if 
					
					CLEAR SET:C117("Calificaciones")
				End if 
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				
				If (<>vtXS_CountryCode="cl")
					KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;True:C214)
					If ($l_nivel=12)
						[Alumnos:2]Chile_PromedioEMedia:73:=AL_PromedioUChile_cl 
					End if 
					SAVE RECORD:C53([Alumnos:2])
				End if 
				
				KRL_ReloadAsReadOnly (->[Alumnos:2])
				EV2_InitArrays 
			End if 
		End if 
	End if 
	$0:=$b_success
	
Else 
	$0:=True:C214
End if 

