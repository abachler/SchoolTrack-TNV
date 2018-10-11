  // MÉTODO: IT_ProgressIndicator
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/12/11, 09:06:23
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // IT_ProgressIndicator()
  // ----------------------------------------------------




  // CODIGO PRINCIPAL
Case of 
	: (Form event:C388=On Outside Call:K2:11)
		If (vb_ShowProgress=False:C215)
			CANCEL:C270
		Else 
			If (vl_IndicatorsToDisplay#vl_ProgressIndicators)
				$l_alturaPantalla:=Screen height:C188
				$l_anchoPantalla:=Screen width:C187
				GET WINDOW RECT:C443($l_Izquierda;$l_Arriba;$l_derecha;$l_abajo)
				FORM GET PROPERTIES:C674("IT_ProgressIndicator";$l_anchoFormulario;$l_altoFormulario)
				
				Case of 
					: (vl_IndicatorsToDisplay=3)
						$l_Izquierda:=$l_anchoPantalla-$l_anchoFormulario-20
						$l_Arriba:=$l_alturaPantalla-225-20
						$l_derecha:=$l_Izquierda+$l_anchoFormulario
						$l_abajo:=$l_Arriba+225
						SET WINDOW RECT:C444($l_Izquierda;$l_Arriba;$l_derecha;$l_abajo)
						
						vl_ProgressIndicators:=3
						
					: (vl_IndicatorsToDisplay=2)
						$l_Izquierda:=$l_anchoPantalla-$l_anchoFormulario-20
						$l_Arriba:=$l_alturaPantalla-155-20
						$l_derecha:=$l_Izquierda+$l_anchoFormulario
						$l_abajo:=$l_Arriba+155
						SET WINDOW RECT:C444($l_Izquierda;$l_Arriba;$l_derecha;$l_abajo)
						vl_ProgressIndicators:=2
						
					Else 
						  //$l_Izquierda:=$l_anchoPantalla-$l_anchoFormulario-20
						  //$l_Arriba:=$l_alturaPantalla-85-20
						  //$l_derecha:=$l_Izquierda+$l_anchoFormulario
						  //$l_abajo:=$l_Arriba+85
						SET WINDOW RECT:C444($l_Izquierda;$l_Arriba;$l_derecha;$l_abajo)
						vl_ProgressIndicators:=1
				End case 
			End if 
			
			vElapsed:=(Current time:C178-vStartTime)
			$loopTime:=vElapsed/(vr_Progress1)
			vRemain:=(100*$loopTime)-vElapsed
			
			If (vr_Progress1<1)
				vStrRemain:="Calculando..."
			Else 
				Case of 
					: (vRemain<=?00:00:01?)
						vStrRemain:="1 segundo."
					: (vRemain<=?00:00:59?)
						vStrRemain:=String:C10(vRemain*1)+" segundos."
					: (vRemain<=?00:01:30?)
						vStrRemain:=String:C10(Int:C8(vRemain/60))+" minuto"
					Else 
						vStrRemain:=String:C10(Int:C8(vRemain/60))+" minutos"
				End case 
				
			End if 
		End if 
		
		
	: (Form event:C388=On Close Box:K2:21)
		If (Not:C34(Is compiled mode:C492))
			CANCEL:C270
		End if 
		
	: (Form event:C388=On Load:K2:1)
		$l_alturaPantalla:=Screen height:C188
		$l_anchoPantalla:=Screen width:C187
		FORM GET PROPERTIES:C674("IT_ProgressIndicator";$l_anchoFormulario;$l_altoFormulario)
		GET WINDOW RECT:C443($l_Izquierda;$l_Arriba;$l_derecha;$l_abajo)
		
		Case of 
			: (vl_IndicatorsToDisplay=3)
				$l_Izquierda:=$l_anchoPantalla-$l_anchoFormulario-20
				$l_Arriba:=$l_alturaPantalla-225-20
				$l_derecha:=$l_Izquierda+$l_anchoFormulario
				$l_abajo:=$l_Arriba+225
				SET WINDOW RECT:C444($l_Izquierda;$l_Arriba;$l_derecha;$l_abajo)
				vl_ProgressIndicators:=3
				
			: (vl_IndicatorsToDisplay=2)
				$l_Izquierda:=$l_anchoPantalla-$l_anchoFormulario-20
				$l_Arriba:=$l_alturaPantalla-155-20
				$l_derecha:=$l_Izquierda+$l_anchoFormulario
				$l_abajo:=$l_Arriba+155
				SET WINDOW RECT:C444($l_Izquierda;$l_Arriba;$l_derecha;$l_abajo)
				vl_ProgressIndicators:=2
				
			Else 
				  //$l_Izquierda:=$l_anchoPantalla-$l_anchoFormulario-20
				  //$l_Arriba:=$l_alturaPantalla-85-20
				  //$l_derecha:=$l_Izquierda+$l_anchoFormulario
				$l_abajo:=$l_Arriba+85
				SET WINDOW RECT:C444($l_Izquierda;$l_Arriba;$l_derecha;$l_abajo)
				vl_ProgressIndicators:=1
		End case 
End case 


