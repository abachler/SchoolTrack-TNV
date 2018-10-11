//%attributes = {}
  // IT_Confirmacion_ProcesaElemento()
  // Por: Alberto Bachler: 07/06/13, 19:29:13
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($0)
C_POINTER:C301($1)

C_BLOB:C604($x_blob)
_O_C_INTEGER:C282($i_elementos;$i_tags)
C_LONGINT:C283($l_numeroDeOpciones)
C_POINTER:C301($y_textoLog_t)

If (False:C215)
	C_BLOB:C604(IT_Confirmacion_ProcesaElemento ;$0)
	C_POINTER:C301(IT_Confirmacion_ProcesaElemento ;$1)
End if 

C_TEXT:C284(vt_boton3;vt_boton4;vt_Boton5)
C_TEXT:C284(vt_ColorBoton1;vt_ColorBoton2;vt_ColorBoton3;vt_ColorBoton4;vt_ColorBoton5)

If (Count parameters:C259=1)
	$y_textoLog_t:=$1
End if 

If (Size of array:C274(at_Confirmacion_Elementos)<0)
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

For ($i_elementos;1;$l_numeroDeOpciones+1)
	For ($i_tags;1;Size of array:C274(at_Confirmacion_Tags))
		$ay_Elementos_t{$i_elementos}->:=Replace string:C233($ay_Elementos_t{$i_elementos}->;at_Confirmacion_Tags{$i_tags};at_Confirmacion_Valor{$i_tags})
	End for 
End for 

BLOB_Variables2Blob (->$x_blob;0;->vt_mensaje;->vt_boton1;->vt_boton2;->vt_boton3;->vt_boton4;->vt_boton5)

$0:=$x_blob
