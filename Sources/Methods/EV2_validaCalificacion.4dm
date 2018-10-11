//%attributes = {}
  // MÉTODO: EV2_validaCalificacion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 29/03/12, 12:14:37
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_validaCalificacion()
  // ----------------------------------------------------
C_BOOLEAN:C305($0;$b_calificacionAceptada)
C_POINTER:C301($2;$y_CalificacionLiteral;$3;$y_CalificacionReal)
C_TEXT:C284($1;$t_calificacionLiteral)
C_REAL:C285($r_minimoEscala;$r_maximoEscala;$l_numeroDecimales;$r_calificacionReal;$r_intervalo)
C_TEXT:C284($t_calificacionLiteral)
C_LONGINT:C283($l_modoEvaluacion;$length;vi_lastGradeView;$l_dec)



  // CODIGO PRINCIPAL
$t_calificacionLiteral:=EV2_Literal_Sistema ($1)
$y_CalificacionLiteral:=$2
$y_CalificacionReal:=$3



$b_calificacionAceptada:=True:C214
$l_modoEvaluacion:=iEvaluationMode


If (iEvaluationMode=4)  //símbolos
	Case of 
		: ($t_calificacionLiteral="")
			$r_calificacionReal:=-10
		: ($t_calificacionLiteral="*")
			$r_calificacionReal:=-4
		: ($t_calificacionLiteral="P")
			$r_calificacionReal:=-2
		: ($t_calificacionLiteral="X")
			$r_calificacionReal:=-3
			
		Else 
			$el:=Find in array:C230(aSymbol;$t_calificacionLiteral)
			If ($el<0)
				$r_calificacionReal:=-10
				CD_Dlog (0;__ ("Símbolo no definido. No puede ser aceptado como indicador."))
				$b_calificacionAceptada:=False:C215
			Else 
				$r_calificacionReal:=aSymbPctEqu{$el}
				$r_calificacionReal:=Round:C94($r_calificacionReal;12)
			End if 
	End case 
	
Else 
	Case of 
		: ($l_modoEvaluacion=Notas)
			$r_minimoEscala:=rGradesFrom
			$r_maximoEscala:=rGradesTo
			$l_numeroDecimales:=iGradesDec
			$r_intervalo:=rGradesInterval
		: ($l_modoEvaluacion=Puntos)
			$r_minimoEscala:=rPointsFrom
			$r_maximoEscala:=rPointsTo
			$l_numeroDecimales:=iPointsDec
			$r_intervalo:=rPointsInterval
		: ($l_modoEvaluacion=Porcentaje)
			$r_minimoEscala:=1
			$r_maximoEscala:=100
			$l_numeroDecimales:=1
			$r_intervalo:=0.1
		: ($l_modoEvaluacion=Simbolos)
			$r_minimoEscala:=0
			$r_maximoEscala:=100
			$l_numeroDecimales:=1
			$r_intervalo:=0.1
	End case 
	
	Case of 
		: ($t_calificacionLiteral="")
			$r_calificacionReal:=-10
		: ($t_calificacionLiteral="*")
			$r_calificacionReal:=-4
		: ($t_calificacionLiteral="P")
			$r_calificacionReal:=-2
		: ($t_calificacionLiteral="X")
			$r_calificacionReal:=-3
			
		Else 
			
			
			If (($r_minimoEscala>=1) & ($t_calificacionLiteral="0@"))
				$t_calificacionLiteral:=String:C10(Num:C11($t_calificacionLiteral))  //elimino eventuales 0 previos
			End if 
			
			Case of 
				: ((Position:C15(<>tXS_RS_DecimalSeparator;$t_calificacionLiteral)=0) & ($l_numeroDecimales>0) & (Num:C11($t_calificacionLiteral)<$r_maximoEscala))
					$r_calificacionReal:=Num:C11($t_calificacionLiteral)
					
				: ((Position:C15(<>tXS_RS_DecimalSeparator;$t_calificacionLiteral)=0) & ($l_numeroDecimales>0))
					$length:=Length:C16(String:C10(Int:C8($r_maximoEscala)))+$l_numeroDecimales
					$t_calificacionLiteral:=Substring:C12($t_calificacionLiteral;1;$length)
					If (Length:C16($t_calificacionLiteral)<$length)
						If ((Position:C15($t_calificacionLiteral;String:C10($r_maximoEscala))#0) | (Num:C11($t_calificacionLiteral)=$r_minimoEscala))
							$t_calificacionLiteral:=$t_calificacionLiteral
							$r_calificacionReal:=Num:C11($t_calificacionLiteral)
						Else 
							$t_calificacionLiteral:=Substring:C12($t_calificacionLiteral+("0"*5);1;$length)
						End if 
						$t_calificacionLiteral:=Insert string:C231($t_calificacionLiteral;<>tXS_RS_DecimalSeparator;$length-$l_numeroDecimales+1)
					Else 
						$t_calificacionLiteral:=Insert string:C231($t_calificacionLiteral;<>tXS_RS_DecimalSeparator;$length-$l_numeroDecimales+1)
					End if 
					
					If (Num:C11($t_calificacionLiteral)>$r_maximoEscala)
						  //$r_calificacionReal:=Num($t_calificacionLiteral)/(10^$l_numeroDecimales)
						$l_dec:=Choose:C955($l_numeroDecimales>1;$l_numeroDecimales-1;$l_numeroDecimales)  //2017025 RCH Al ingresar 55 con configuración de 2 decimales, la nota queda como 0.55 y no como 5.5 como se esperaba. Se hace cambio y se prueba ingreso.
						$r_calificacionReal:=Num:C11($t_calificacionLiteral)/(10^$l_dec)
						$t_calificacionLiteral:=String:C10($r_calificacionReal)
					End if 
					
					Case of 
						: (Position:C15(String:C10($r_maximoEscala);$t_calificacionLiteral)=1)
							$r_calificacionReal:=$r_maximoEscala
							
						: (Length:C16($t_calificacionLiteral)=$length)
							$r_parteDecimal:=Dec:C9($r_calificacionReal)
							If ($r_parteDecimal>0)
								$i:=0
								While ($r_calificacionReal>$r_maximoEscala)
									$r_calificacionReal:=Num:C11($t_calificacionLiteral)/(10^($l_numeroDecimales+$i))
									$i:=$i+1
								End while 
								$t_calificacionLiteral:=String:C10($r_calificacionReal)
							End if 
						Else 
							$r_calificacionReal:=Num:C11($t_calificacionLiteral)
							$r_parteDecimal:=Dec:C9($r_calificacionReal)
							If ($r_parteDecimal>0)
								$i:=0
								While ($r_calificacionReal>$r_maximoEscala)
									$r_calificacionReal:=Num:C11($t_calificacionLiteral)/(10^$i)
									$i:=$i+1
								End while 
							Else 
								$r_calificacionReal:=Int:C8($r_calificacionReal)
							End if 
							$t_calificacionLiteral:=String:C10($r_calificacionReal)
					End case 
				: (Length:C16($t_calificacionLiteral)=Length:C16(String:C10($r_minimoEscala)))
					$r_calificacionReal:=Num:C11($t_calificacionLiteral)
				Else 
					$r_calificacionReal:=Num:C11($t_calificacionLiteral)
			End case 
			$r_calificacionReal:=Trunc:C95($r_calificacionReal;$l_numeroDecimales)
			
			$interval:=Num:C11(Substring:C12($t_calificacionLiteral;Position:C15(<>tXS_RS_DecimalSeparator;$t_calificacionLiteral)+$l_numeroDecimales))/(10^$l_numeroDecimales)
			If (($interval<rGradesInterval) & ($interval>0))
				$r_calificacionReal:=NTA_adjustInterval ($r_calificacionReal;$l_numeroDecimales;$r_intervalo)
			End if 
			
			
			
			
			
			Case of 
				: ($r_calificacionReal<$r_minimoEscala)
					CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String:C10($r_minimoEscala)+__ (" a ")+String:C10($r_maximoEscala))
					$r_calificacionReal:=-10
					$b_calificacionAceptada:=False:C215
					
				: ($r_calificacionReal>$r_maximoEscala)
					CD_Dlog (0;__ ("La calificación debe estar en el rango de ")+String:C10($r_minimoEscala)+__ (" a ")+String:C10($r_maximoEscala))
					$r_calificacionReal:=-10
					$b_calificacionAceptada:=False:C215
					
				Else 
					$iConversionTable:=iConversionTable
					Case of 
						: ($l_modoEvaluacion=Notas)
							If (vi_lastGradeView=Puntos)  //grades to points
								If ($iConversionTable=1)
									iConversionTable:=$iConversionTable
									$r_calificacionReal:=NTA_GetPctValueFromConvTable ($r_calificacionReal;Notas)
									If ($r_calificacionReal=-10)
										CD_Dlog (0;__ ("La nota ingresada no está definida en la tabla de conversión de evaluaciones."))
										$b_calificacionAceptada:=False:C215
									End if 
								End if 
							Else 
								$r_calificacionReal:=EV2_Nota_a_Real ($r_calificacionReal)
							End if 
							
						: ($l_modoEvaluacion=Puntos)
							If (vi_lastGradeView=Notas)  //grades to points
								If ($iConversionTable=1)
									iConversionTable:=$iConversionTable
									$r_calificacionReal:=NTA_GetPctValueFromConvTable ($r_calificacionReal;Puntos)
									If ($r_calificacionReal=-10)
										CD_Dlog (0;__ ("La nota ingresada no está definida en la tabla de conversión de evaluaciones."))
										$b_calificacionAceptada:=False:C215
									End if 
								End if 
							Else 
								$r_calificacionReal:=EV2_Puntos_a_Real ($r_calificacionReal)
							End if 
							
							
							
						: ($l_modoEvaluacion=Porcentaje)
							$r_calificacionReal:=Round:C94($r_calificacionReal;1)
							
					End case 
					iConversionTable:=$iConversionTable
			End case 
			
	End case 
	
	
	
End if 


$y_CalificacionLiteral->:=$t_calificacionLiteral
$y_CalificacionReal->:=$r_calificacionReal
$0:=$b_calificacionAceptada