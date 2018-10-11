//%attributes = {}
  // IT_Confirmacion_MuestraMensaje()
  // Por: Alberto Bachler: 07/06/13, 18:50:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)

_O_C_INTEGER:C282($i_elementos;$i_elementos;$i_tags)
C_LONGINT:C283($l_numeroDeOpciones;$l_OpcionUsuario;$l_tipoVentana)
C_POINTER:C301($y_nil;$y_textoOpcion_t)
C_TEXT:C284($t_encabezado;vtMSG_Detalle)

If (False:C215)
	C_LONGINT:C283(IT_Confirmacion_MuestraMensaje ;$0)
	C_TEXT:C284(IT_Confirmacion_MuestraMensaje ;$1)
End if 

C_TEXT:C284(vt_boton3;vt_boton4;vt_Boton5)
C_TEXT:C284(vt_ColorBoton1;vt_ColorBoton2;vt_ColorBoton3;vt_ColorBoton4;vt_ColorBoton5)

vtMSG_Detalle:=""
Case of 
	: (Count parameters:C259=1)
		$t_textoLog:=$1
	: (Count parameters:C259=2)
		$t_textoLog:=$1
		vtMSG_Detalle:=$2
End case 

If (Size of array:C274(at_Confirmacion_Elementos)<6)
	ARRAY TEXT:C222(at_Confirmacion_Elementos;6)
End if 
vt_mensaje:=at_Confirmacion_Elementos{1}
vt_boton1:=at_Confirmacion_Elementos{2}
vt_boton2:=at_Confirmacion_Elementos{3}
vt_boton3:=at_Confirmacion_Elementos{4}
vt_boton4:=at_Confirmacion_Elementos{5}
vt_boton5:=at_Confirmacion_Elementos{6}

ARRAY POINTER:C280($ay_Elementos_t;6)
$ay_Elementos_t{1}:=->vt_mensaje
$ay_Elementos_t{2}:=->vt_boton1
$ay_Elementos_t{3}:=->vt_boton2
$ay_Elementos_t{4}:=->vt_boton3
$ay_Elementos_t{5}:=->vt_boton4
$ay_Elementos_t{6}:=->vt_boton5

$l_numeroDeOpciones:=0
For ($i_elementos;2;Size of array:C274(at_Confirmacion_Elementos))
	If (at_Confirmacion_Elementos{$i_elementos}#"")
		$l_numeroDeOpciones:=$l_numeroDeOpciones+1
	Else 
		$i_elementos:=Size of array:C274(at_Confirmacion_Elementos)
	End if 
End for 

  // calculo el largo de los tags y los ordeno de manera descendente para evitar
  // que al procesarlos se reemplace un fragmento de del tag por un valor inapropiado 
ARRAY LONGINT:C221($al_Largo_Tag;Size of array:C274(at_Confirmacion_Tags))
For ($i;1;Size of array:C274(at_Confirmacion_Tags))
	$al_Largo_Tag{$i}:=Length:C16(at_Confirmacion_Tags{$i})
End for 
SORT ARRAY:C229($al_Largo_Tag;at_Confirmacion_Tags;at_Confirmacion_Valor;<)

  // proceso los tags reemplazándolos por el valor
For ($i_elementos;1;$l_numeroDeOpciones+1)
	For ($i_tags;1;Size of array:C274(at_Confirmacion_Tags))
		$t_expresion:=$ay_Elementos_t{$i_elementos}->
		$tag:=at_Confirmacion_Tags{$i_tags}
		$valor:=at_Confirmacion_Valor{$i_tags}
		$valor:=XML_GetValidXMLText ($valor)  //MONO TICKET 198343
		$ay_Elementos_t{$i_elementos}->:=Replace string:C233($t_expresion;$tag;$valor)
	End for 
End for 


Case of 
	: (vt_mensaje="")
		$l_OpcionUsuario:=-1  // error en el llamado a este método, el cuadro de diálogo debe  contar con un mensaje de encabezado
		
	: ($l_numeroDeOpciones<2)
		$l_OpcionUsuario:=-2  // error en el llamado a este método, el cuadro de diálogo debe proponer al menos dos opciones al usuario
		
	Else 
		
		WDW_OpenFormWindow ($y_nil;"DLOG_Confirmacion";-1;Movable form dialog box:K39:8;__ ("Confirmación"))
		DIALOG:C40("DLOG_Confirmacion")
		CLOSE WINDOW:C154
		
		Case of 
			: (bCancelar=1)  // el usuario cerró la ventana con Escape, CTRL-. o con lic en la casilla de cierre
				$l_OpcionUsuario:=0
				
			: (bboton1=1)
				$l_OpcionUsuario:=1
				
			: (bboton2=1)
				If ($l_numeroDeOpciones>=3)
					$l_OpcionUsuario:=2
				Else 
					$l_OpcionUsuario:=0  // el último botón retorna siempre 0 (generalmente se usará para cancelar)
				End if 
				
			: (bboton3=1)
				If ($l_numeroDeOpciones>=4)
					$l_OpcionUsuario:=3
				Else 
					$l_OpcionUsuario:=0  // el último botón retorna siempre 0 (generalmente se usará para cancelar)
				End if 
				
			: (bboton4=1)
				If ($l_numeroDeOpciones=5)
					$l_OpcionUsuario:=4
				Else 
					$l_OpcionUsuario:=0  // el último botón retorna siempre 0 (generalmente se usará para cancelar)
				End if 
				
			: (bboton5=1)
				$l_OpcionUsuario:=0  // el último botón retorna siempre 0 (generalmente se usará para cancelar)
		End case 
		
		
		If (($l_OpcionUsuario>0) & ($t_textoLog#""))
			$y_textoOpcion_t:=Get pointer:C304("vt_boton"+String:C10($l_opcionUsuario))
			$t_textoLog:=$t_textoLog+"\r"+__ ("Confirmación solicitada al usuario:\r^1\r\rOpción seleccionada:\r^2")
			$t_textoLog:=Replace string:C233($t_textoLog;"^1";vt_mensaje)
			$t_textoLog:=Replace string:C233($t_textoLog;"^2";$y_textoOpcion_t->)
			LOG_RegisterEvt ($t_textoLog)
		End if 
		
End case 

$0:=$l_OpcionUsuario
