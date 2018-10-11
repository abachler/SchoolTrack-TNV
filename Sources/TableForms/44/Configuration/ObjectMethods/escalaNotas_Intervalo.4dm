  // [xxSTR_EstilosEvaluacion].Configuration.escalaNotas_Intervalo()
  //
  //
  // creado por: Alberto Bachler Klein: 11-07-16, 12:44:17
  // -----------------------------------------------------------
C_LONGINT:C283($l_error;$l_evaluaciones)
C_TEXT:C284($t_mensaje)


Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		$l_evaluaciones:=(OBJECT Get pointer:C1124(Object named:K67:5;"usoEvaluaciones"))->
		$t_mensaje:=__ ("El intervalo aplicará sólo cuando se registren nuevas calificaciones y no afecta los calculos de promedios (siempre calculados con el numero de decimales establecido).")
		OBJECT SET HELP TIP:C1181(*;OBJECT Get name:C1087(Object current:K67:2);$t_mensaje)
		
		
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: (Dec:C9(1/Self:C308->)>0)
				OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rEl resultado de la división 1/intervalo debe ser entero."))
				Case of 
					: (iGradesDec=0)
						Self:C308->:=1
						$l_error:=-1
					: (iGradesDec=1)
						Self:C308->:=0.1
						$l_error:=-1
					: (iGradesDec=2)
						Self:C308->:=0.01
						$l_error:=-1
					: (iGradesDec=3)
						Self:C308->:=0.001
						$l_error:=-1
				End case 
			Else 
				
				$l_decimales:=iGradesDec
				$r_intervalo:=rGradesInterval
				
				If ($l_decimales>0)
					$int:=Int:C8($r_intervalo)
					$decString:=Substring:C12(String:C10(Dec:C9($r_intervalo));3)
					If (Length:C16($decString)>$l_decimales)
						$r_intervalo:=Num:C11(String:C10($int)+<>tXS_RS_DecimalSeparator+Substring:C12($decString;1;$l_decimales))
						BEEP:C151
					End if 
				Else 
					If ($r_intervalo<1)
						$r_intervalo:=1
						BEEP:C151
					End if 
				End if 
				rGradesInterval:=$r_intervalo
				
				
				
				Case of 
					: (iGradesDec=0)
						Case of 
							: (Self:C308->>rGradesTo)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rNo puede ser superior a la evaluación máxima"))
								Self:C308->:=1
								$l_error:=-1
							: (Self:C308-><iGradesDec)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rNo puede ser inferior a la evaluación mínima"))
								Self:C308->:=1
								$l_error:=-1
						End case 
					: (iGradesDec=1)
						$decLength:=Length:C16(Replace string:C233(String:C10(Dec:C9(Self:C308->));"0"+<>tXS_RS_DecimalSeparator;""))
						Case of 
							: (Self:C308->>1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rNo puede ser superior a 1"))
								$l_error:=-1
								Self:C308->:=0.1
							: (Self:C308->=1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rDebe ser inferior a 1"))
								$l_error:=-1
								Self:C308->:=0.1
							: ($decLength>iGradesDec)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rEl número de decimales del intervalo no puede ser superior al número de decimales utilizados para la evaluación."))
								Self:C308->:=0.1
								$l_error:=-1
						End case 
					: (iGradesDec=2)
						$decLength:=Length:C16(Replace string:C233(String:C10(Dec:C9(Self:C308->);"##0"+<>tXS_RS_DecimalSeparator+"00");"0"+<>tXS_RS_DecimalSeparator;""))
						Case of 
							: (Self:C308->>1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rNo puede ser superior a 1"))
								Self:C308->:=0.01
								$l_error:=-1
							: (Self:C308->=1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rDebe ser inferior a 1"))
								Self:C308->:=0.01
								$l_error:=-1
							: ($decLength>iGradesDec)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rEl número de decimales del intervalo no puede ser superior al número de decimales utilizados para la evaluación."))
								Self:C308->:=0.01
								$l_error:=-1
							: ($decLength<iGradesDec)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rEl número de decimales del intervalo no debe ser igual al número de decimales utilizados para la evaluación."))
								Self:C308->:=0.01
								$l_error:=-1
						End case 
					: (iGradesDec=3)
						$decLength:=Length:C16(Replace string:C233(String:C10(Dec:C9(Self:C308->);"##0"+<>tXS_RS_DecimalSeparator+"000");"0"+<>tXS_RS_DecimalSeparator;""))
						Case of 
							: (Self:C308->>1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rNo puede ser superior a 1"))
								Self:C308->:=0.001
								$l_error:=-1
							: (Self:C308->=1)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rDebe ser inferior a 1"))
								Self:C308->:=0.001
								$l_error:=-1
							: ($decLength>iGradesDec)
								OK:=CD_Dlog (0;__ ("El intervalo ingresado no es válido.\r\rEl número de decimales del intervalo no puede ser superior al número de decimales utilizados para la evaluación."))
								Self:C308->:=0.001
								$l_error:=-1
							Else 
								
						End case 
				End case 
		End case 
		
		
		If ($l_error=-1)
			GOTO OBJECT:C206(Self:C308->)
		End if 
End case 