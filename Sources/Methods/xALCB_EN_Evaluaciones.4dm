//%attributes = {}
  // MÉTODO: xALCB_EN_Evaluaciones
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 13/03/12, 19:49:51
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // xALCB_EN_Evaluaciones()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_evitarCelda)
C_DATE:C307($d_fechaCierrePeriodo)
C_LONGINT:C283($i;$l_errorALP;$l_metodoDeEntrada;$l_orden1;$l_orden2;$l_positionEnCopia;$l_primeraColumnaParciales;$l_respuestaUsuario)
C_POINTER:C301($y_arregloColumnaActiva;$y_arregloCopiaColumnaActiva)
C_TEXT:C284($t_valorCeldaActiva)

ARRAY INTEGER:C220($al_arregloD2Celdas;2;0)
ARRAY TEXT:C222($at_ArrayNames;0)
If (False:C215)
	C_LONGINT:C283(xALCB_EN_Evaluaciones ;$1)
	C_LONGINT:C283(xALCB_EN_Evaluaciones ;$2)
	C_LONGINT:C283(xALCB_EN_Evaluaciones ;$3)
End if 

C_LONGINT:C283(vCol;vRow)




  // CODIGO PRINCIPAL
$l_metodoDeEntrada:=$2

AL_GetCurrCell (xALP_ASNotas;vCol;vRow)

$l_errorALP:=AL_GetArrayNames (xALP_ASNotas;$at_ArrayNames)
$b_evitarCelda:=(($at_ArrayNames{vCol}="aNtaF") & (AS_PromediosSonCalculados ))
If ($b_evitarCelda & ($l_metodoDeEntrada#1))
	  //la celda esta en estado ingresable aunque los promedios son calculados es porque se ha configurado examen reprobatorio
	  //pero si se entra a la celda con un modo distinto de dobleclic se rechaza la entrada para evitar digitación de examen recuperatorio por error
	AL_ExitCell (xALP_ASNotas)
Else 
	
	$l_primeraColumnaParciales:=vi_PrimeraColumnaParciales
	If (vb_AvisaSiOrdenModificado)
		vb_AvisaSiOrdenModificado:=False:C215
		AL_GetSort (xALP_ASNotas;$l_orden1;$l_orden2)
		Case of 
			: (<>gOrdenNta=0)
				If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
					If (($l_orden1#3) | ($l_orden2#2))
						$l_respuestaUsuario:=CD_Dlog (0;"¡Atención!\rUsted modificó el orden de los alumnos en la planilla.\r\r¿Desea reestab"+"l"+"ecer el orden por defecto (curso y alfabético)?";"";"Si";"No")
					End if 
				Else 
					If ($l_orden1#2)
						$l_respuestaUsuario:=CD_Dlog (0;"¡Atención!\rUsted modificó el orden de los alumnos en la planilla.\r\r¿Desea reestab"+"l"+"ecer el orden por defecto (alfabético)?";"";"Si";"No")
					End if 
				End if 
			: (<>gOrdenNta=1)
				If ($l_orden1#1)
					$l_respuestaUsuario:=CD_Dlog (0;"¡Atención!\rUsted modificó el orden de los alumnos en la planilla.\r\r¿Desea reestab"+"l"+"ecer el orden por defecto (Nº de lista)?";"";"Si";"No")
				End if 
			: (<>gOrdenNta=2)
				If ($l_orden1#2)
					$l_respuestaUsuario:=CD_Dlog (0;"¡Atención!\rUsted modificó el orden de los alumnos en la planilla.\r\r¿Desea reestab"+"l"+"ecer el orden por defecto (alfabético)?";"";"Si";"No")
				End if 
		End case 
		If ($l_respuestaUsuario=1)
			Case of 
				: (<>gOrdenNta=0)
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						AL_SetSort (xALP_ASNotas;3;2)
					Else 
						AL_SetSort (xALP_ASNotas;2)
					End if 
				: (<>gOrdenNta=1)
					AL_SetSort (xALP_ASNotas;1)
				: (<>gOrdenNta=2)
					AL_SetSort (xALP_ASNotas;2)
			End case 
			AL_ExitCell (xALP_ASNotas)
		Else 
			LOG_RegisterEvt ("Ingreso de notas en planilla en orden no estándar: "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5)
			If ([Asignaturas:18]Resultado_no_calculado:47)
				Case of 
					: ($at_ArrayNames{vCol}="aNtaP1")
						$d_fechaCierrePeriodo:=adSTR_Periodos_Cierre{1}
						
					: ($at_ArrayNames{vCol}="aNtaP2")
						$d_fechaCierrePeriodo:=adSTR_Periodos_Cierre{2}
						
					: ($at_ArrayNames{vCol}="aNtaP3")
						$d_fechaCierrePeriodo:=adSTR_Periodos_Cierre{3}
						
					: ($at_ArrayNames{vCol}="aNtaP4")
						$d_fechaCierrePeriodo:=adSTR_Periodos_Cierre{4}
						
					: ($at_ArrayNames{vCol}="aNtaP5")
						$d_fechaCierrePeriodo:=adSTR_Periodos_Cierre{5}
						
					Else 
						$d_fechaCierrePeriodo:=!00-00-00!
				End case 
				If ((Current date:C33(*)>$d_fechaCierrePeriodo) & ($d_fechaCierrePeriodo>!00-00-00!) & (Not:C34(USR_checkRights ("M";->[Alumnos_Calificaciones:208]))))
					AL_ExitCell (xALP_ASNotas)
					CD_Dlog (0;"Usted no está autorizado(a) a registrar calificaciones finales en este período después del "+String:C10($d_fechaCierrePeriodo))
				End if 
			End if 
		End if 
	Else 
		If ([Asignaturas:18]Resultado_no_calculado:47)
			Case of 
				: ($at_ArrayNames{vCol}="aNtaP1")
					$d_fechaCierrePeriodo:=adSTR_Periodos_Cierre{1}
					
				: ($at_ArrayNames{vCol}="aNtaP2")
					$d_fechaCierrePeriodo:=adSTR_Periodos_Cierre{2}
					
				: ($at_ArrayNames{vCol}="aNtaP3")
					$d_fechaCierrePeriodo:=adSTR_Periodos_Cierre{3}
					
				: ($at_ArrayNames{vCol}="aNtaP4")
					$d_fechaCierrePeriodo:=adSTR_Periodos_Cierre{4}
					
				: ($at_ArrayNames{vCol}="aNtaP5")
					$d_fechaCierrePeriodo:=adSTR_Periodos_Cierre{5}
					
				Else 
					$d_fechaCierrePeriodo:=!00-00-00!
			End case 
			If ((Current date:C33(*)>$d_fechaCierrePeriodo) & ($d_fechaCierrePeriodo>!00-00-00!) & (Not:C34(USR_checkRights ("M";->[Alumnos_Calificaciones:208]))))
				AL_ExitCell (xALP_ASNotas)
				CD_Dlog (0;"Usted no está autorizado(a) a registrar calificaciones finales en este período después del "+String:C10($d_fechaCierrePeriodo))
			End if 
		End if 
	End if 
	
	If (vb_AvisaSiCambioPeriodo)
		$l_respuestaUsuario:=CD_Dlog (0;"¡Atención!\rEl período en el que usted se dispone a ingresar evaluaciones no es el"+" per"+"íodo actual.")
		vb_AvisaSiCambioPeriodo:=False:C215
	End if 
	
	$l_errorALP:=AL_GetArrayNames (xALP_ASNotas;$at_ArrayNames)
	
	If ((<>viSTR_NoModificarNotas=1) & (Not:C34(USR_checkRights ("M";->[Alumnos_Calificaciones:208]))))
		If ((vCol>2) & (vRow>0))
			$l_positionEnCopia:=Find in array:C230(aCpyIDAlumno;aNtaIDAlumno{vRow})
			$y_arregloColumnaActiva:=Get pointer:C304($at_ArrayNames{vCol})
			$y_arregloCopiaColumnaActiva:=Get pointer:C304("aCpy"+Substring:C12($at_ArrayNames{vCol};2))
			If ($l_positionEnCopia>0)
				$t_valorCeldaActiva:=$y_arregloCopiaColumnaActiva->{$l_positionEnCopia}
			Else 
				$t_valorCeldaActiva:=""
			End if 
		End if 
		If (($t_valorCeldaActiva#"") & ($t_valorCeldaActiva#"P") & ($t_valorCeldaActiva#"*"))
			CD_Dlog (0;"Ud. no está autorizado para modificar esta nota.")
			AL_ExitCell (xALP_ASNotas)
		End if 
	End if 
	
	If ((aNtaStatus{vRow}="Retirado@") | (aNtaRegEximicion{vRow}#0) | (aNtaStatus{vRow}="Promovido@"))
		Case of 
			: (aNtaStatus{vRow}="Retirado@")
				IT_MuestraTip (aNtaStdNme{vRow}+__ (" tiene el estatus de ")+aNtaStatus{vRow}+".";20;True:C214)
			: (aNtaStatus{vRow}="Promovido@")
				IT_MuestraTip (aNtaStdNme{vRow}+__ (" tiene el estatus de ")+aNtaStatus{vRow}+".";20;True:C214)
			: (aNtaRegEximicion{vRow}#0)
				IT_MuestraTip (aNtaStdNme{vRow}+__ (" ha sido eximido.");20;True:C214)
		End case 
		AL_SkipCell (xALP_ASNotas)
		AL_UpdateArrays (xALP_ASNotas;-1)
	Else 
		AL_SetCellStyle (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;5)
		AL_UpdateArrays (xALP_ASNotas;-1)
	End if 
	
	
	AS_ReadEvalProperties   //20140908 ASM Ticket 136372
	ASev2_propiedadesCalificacion 
	
	
	If ($at_ArrayNames{vCol}="aNtaEXX")
		If (aNtaEX{vRow}="")
			If ($l_metodoDeEntrada=1)
				AL_ExitCell (xALP_ASNotas)
				AL_SetCellStyle (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;0)
				CD_Dlog (0;"No puede registrar una calificación para el examen extraordinario sin haber regis"+"trado previamente la calificación obtenida en el examen de fin de ciclo.")
			Else 
				AL_SetCellStyle (xALP_ASNotas;1;vRow;2;vRow;$al_arregloD2Celdas;0)
				AL_ExitCell (xALP_ASNotas)
				For ($i;vRow;Size of array:C274(aNtaRecNum))
					If (aNtaEX{$i}="")
						AL_SkipCell (xALP_ASNotas)
						AL_SetCellStyle (xALP_ASNotas;1;$i;2;$i;$al_arregloD2Celdas;0)
					Else 
						AL_SetCellStyle (xALP_ASNotas;1;$i;2;$i;$al_arregloD2Celdas;5)
						$i:=Size of array:C274(aNtaRecNum)
					End if 
				End for 
				AL_UpdateArrays (xALP_ASNotas;-1)
			End if 
		End if 
	End if 
End if 

