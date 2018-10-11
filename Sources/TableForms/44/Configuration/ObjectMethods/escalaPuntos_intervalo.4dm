  // [xxSTR_EstilosEvaluacion].Configuration.escalaPuntos_intervalo()
  //
  //
  // creado por: Alberto Bachler Klein: 11-07-16, 12:47:29
  // -----------------------------------------------------------
C_LONGINT:C283($l_decimales;$l_largoDecimales;$l_enteroIntervalo;$l_error;$l_evaluaciones)
C_REAL:C285($r_intervalo)
C_TEXT:C284($t_cadenaIntervalo;$t_mensaje)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		$l_evaluaciones:=(OBJECT Get pointer:C1124(Object named:K67:5;"usoEvaluaciones"))->
		$t_mensaje:=__ ("El intervalo aplicará sólo cuando se registren nuevas calificaciones y no afecta los calculos de promedios (siempre calculados con el numero de decimales establecido).")
		OBJECT SET HELP TIP:C1181(*;OBJECT Get name:C1087(Object current:K67:2);$t_mensaje)
		
		
	: (Form event:C388=On Data Change:K2:15)
		$l_error:=0
		Case of 
			: (Dec:C9(1/Self:C308->)>0)
				OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rEl resultado de la división 1/intervalo debe ser entero."))
				Case of 
					: (iPointsDec=0)
						Self:C308->:=1
						$l_error:=-1
					: (iPointsDec=1)
						Self:C308->:=0.1
						$l_error:=-1
					: (iPointsDec=2)
						Self:C308->:=0.01
						$l_error:=-1
					: (iPointsDec=3)
						Self:C308->:=0.001
						$l_error:=-1
				End case 
			Else 
				
				$l_decimales:=iPointsDec
				$r_intervalo:=rPointsInterval
				
				If ($l_decimales>0)
					$l_enteroIntervalo:=Int:C8($r_intervalo)
					$t_cadenaIntervalo:=Substring:C12(String:C10(Dec:C9($r_intervalo));3)
					If (Length:C16($t_cadenaIntervalo)>$l_decimales)
						$r_intervalo:=Num:C11(String:C10($l_enteroIntervalo)+<>tXS_RS_DecimalSeparator+Substring:C12($t_cadenaIntervalo;1;$l_decimales))
						BEEP:C151
					End if 
				Else 
					If ($r_intervalo<1)
						$r_intervalo:=1
						BEEP:C151
					End if 
				End if 
				rPointsInterval:=$r_intervalo
				
				Case of 
					: (iPointsDec=0)
						Case of 
							: (Self:C308->>rGradesTo)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rNo puede ser superior a la evaluación máxima"))
								Self:C308->:=1
								$l_error:=-1
							: (Self:C308-><iPointsDec)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rNo puede ser inferior a la evaluación mínima"))
								Self:C308->:=1
								$l_error:=-1
						End case 
					: (iPointsDec=1)
						$l_largoDecimales:=Length:C16(Replace string:C233(String:C10(Dec:C9(Self:C308->));"0,";""))
						Case of 
							: (Self:C308->>1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rNo puede ser superior a 1"))
								$l_error:=-1
								Self:C308->:=0.1
							: (Self:C308->=1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rDebe ser inferior a 1"))
								$l_error:=-1
								Self:C308->:=0.1
							: ($l_largoDecimales>iPointsDec)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rEl número de decimales del intervalo no puede ser superior al número de decimales utilizados para la evaluación."))
								Self:C308->:=0.1
								$l_error:=-1
						End case 
					: (iPointsDec=2)
						$l_largoDecimales:=Length:C16(Replace string:C233(String:C10(Dec:C9(Self:C308->);"##0,00");"0,";""))
						Case of 
							: (Self:C308->>1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rNo puede ser superior a 1"))
								Self:C308->:=0.01
								$l_error:=-1
							: (Self:C308->=1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rDebe ser inferior a 1"))
								Self:C308->:=0.01
								$l_error:=-1
							: ($l_largoDecimales>iPointsDec)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rEl número de decimales del intervalo no puede ser superior al número de decimales utilizados para la evaluación."))
								Self:C308->:=0.01
								$l_error:=-1
							: ($l_largoDecimales<iPointsDec)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rEl número de decimales del intervalo no debe ser igual al número de decimales utilizados para la evaluación."))
								Self:C308->:=0.01
								$l_error:=-1
						End case 
					: (iPointsDec=3)
						$l_largoDecimales:=Length:C16(Replace string:C233(String:C10(Dec:C9(Self:C308->);"##0,000");"0,";""))
						Case of 
							: (Self:C308->>1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rNo puede ser superior a 1"))
								Self:C308->:=0.001
								$l_error:=-1
							: (Self:C308->=1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rDebe ser inferior a 1"))
								Self:C308->:=0.001
								$l_error:=-1
							: ($l_largoDecimales>iPointsDec)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rEl número de decimales del intervalo no puede ser superior al número de decimales utilizados para la evaluación."))
								Self:C308->:=0.001
								$l_error:=-1
						End case 
				End case 
		End case 
		
		If ($l_error=-1)
			GOTO OBJECT:C206(Self:C308->)
		Else 
			If (aEvMode=Puntos)
				  //AT_ResizeArrays (->arEVS_ConvGrades;0)
				  //AT_ResizeArrays (->arEVS_ConvGradesPercent;0)
				  //AT_ResizeArrays (->arEVS_ConvPoints;0)
				  //AT_ResizeArrays (->arEVS_ConvPointsPercent;0)
				  //AT_ResizeArrays (->arEVS_ConvGradesOfficial;0)
			End if 
		End if 
End case 