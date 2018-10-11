  // [xShell_ExecutableCommands].Manager_v14.codigo()
  // Por: Alberto Bachler K.: 20-02-14, 19:38:25 (basado en codigo de JHB)
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_esCaracterValido)
C_LONGINT:C283($i_linea;$i_linea_lineas;$l_finSeleccion;$l_inicioSeleccion;$l_inicoProximoParrafo;$l_inicoProximoParrafo2;$l_lineaActual;$l_lineaActual2;$l_numeroDeLineas;$l_posicionCR)
C_POINTER:C301($y_codigo)
C_TEXT:C284($t_caracter;$t_codigoHTML;$t_textoEditado)

ARRAY TEXT:C222($at_lineasCodigo;0)
ARRAY TEXT:C222($at_lineasTexto;0)

$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"codigo")
Case of 
	: (Form event:C388=On Selection Change:K2:29)
		GET HIGHLIGHT:C209($y_codigo;$l_inicioSeleccion;$l_finSeleccion)
		
	: (Form event:C388=On Before Keystroke:K2:6)
		If (USR_GetUserID >=0)
			  //$t_caracter:=Keystroke
			  //$b_esCaracterValido:=(Position($t_caracter;Char(Backspace)+Char(Left arrow key)+Char(Right arrow key)+Char(Up arrow key)+Char(Down arrow key)+Char(DEL ASCII code)+Char(Carriage return)+Char(Enter))>0)
			  //If ($b_esCaracterValido)
			  //FILTER KEYSTROKE("")
			  //End if 
		End if 
		
	: (Form event:C388=On After Keystroke:K2:26)
		If (Keystroke:C390="\r")
			GET HIGHLIGHT:C209($y_codigo->;$l_inicioSeleccion;$l_finSeleccion)
			$t_textoEditado:=Get edited text:C655
			If (Length:C16($t_textoEditado)>0)
				AT_Text2Array (->$at_lineasTexto;$t_textoEditado;"\r")
				If (Size of array:C274($at_lineasTexto)>1)
					$l_inicoProximoParrafo:=Position:C15("\r";$t_textoEditado;$l_finSeleccion)
					If ($l_inicoProximoParrafo=0)
						$l_lineaActual:=-1  //ultima
					Else 
						$l_numeroDeLineas:=ST_countlines ($t_textoEditado)
						$l_inicoProximoParrafo2:=0
						For ($i_linea;1;$l_numeroDeLineas)
							$l_inicoProximoParrafo2:=Position:C15("\r";$t_textoEditado;$l_inicoProximoParrafo2+1)
							If ($l_inicoProximoParrafo2>=$l_inicoProximoParrafo)
								$l_lineaActual:=$i_linea
								$i_linea:=$l_numeroDeLineas+1
							End if 
						End for 
					End if 
				Else 
					$l_lineaActual:=1
				End if 
				EXE_StyleCodeText (->$t_textoEditado)
				$y_codigo->:=$t_textoEditado+"\r"
				If ($l_lineaActual=1)
					HIGHLIGHT TEXT:C210($y_codigo->;Length:C16($at_lineasTexto{1})+2;Length:C16($at_lineasTexto{1})+2)
				Else 
					If ($l_lineaActual=-1)
						HIGHLIGHT TEXT:C210($y_codigo->;Length:C16($y_codigo->)+1;Length:C16($y_codigo->)+1)
					Else 
						$l_posicionCR:=0
						$l_lineaActual2:=1
						AT_Text2Array (->$at_lineasTexto;$t_textoEditado;"\r")
						Repeat 
							$l_posicionCR:=Position:C15("\r";$y_codigo->;$l_posicionCR+1)
							$l_lineaActual2:=$l_lineaActual2+1
						Until ($l_lineaActual2=$l_lineaActual)
						HIGHLIGHT TEXT:C210($y_codigo->;$l_posicionCR+Length:C16($at_lineasTexto{$l_lineaActual2})+1;$l_posicionCR+Length:C16($at_lineasTexto{$l_lineaActual2})+1)
					End if 
				End if 
			End if 
		End if 
		
		
	: (Form event:C388=On After Edit:K2:43)
		$t_textoEditado:=Get edited text:C655
		$t_textoEditado:=Replace string:C233($t_textoEditado;"\r";"")
		$t_textoEditado:=Replace string:C233($t_textoEditado;" ";"")
		OBJECT SET ENABLED:C1123(*;"ejecutarCodigo";(Length:C16($t_textoEditado)>0))
		
	: (Form event:C388=On Losing Focus:K2:8)
		GOTO OBJECT:C206(Self:C308->)
		AT_Text2Array (->$at_lineasCodigo;$y_codigo->)
		For ($i_linea_lineas;1;Size of array:C274($at_lineasCodigo))
			$at_lineasCodigo{$i_linea_lineas}:=ST_TrimLeadingChars ($at_lineasCodigo{$i_linea_lineas};" ")
		End for 
		$y_codigo->:=AT_array2text (->$at_lineasCodigo)
		$t_codigoHTML:=CODE_Get_html ($y_codigo->)
		WA SET PAGE CONTENT:C1037(*;"codigoHTML";$t_codigoHTML;"")
		
	Else 
		
End case 






