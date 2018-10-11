  // VC4D.lb_vc4d()
  // Por: Alberto Bachler K.: 30-09-14, 16:12:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------

C_DATE:C307($d_fecha)
C_LONGINT:C283($i;$l_itemSeleccionado)
C_TIME:C306($h_hora)
C_POINTER:C301($y_autorCambio;$y_codigoCambio;$y_dts;$y_fechaCambio;$y_fechaModificacion;$y_listBox;$y_metodo;$y_Ruta;$y_ruta;$y_tipoObjeto)
C_POINTER:C301($y_tipoObjetos)
C_TEXT:C284($t_code;$t_codigoHTML;$t_dtsIntegracion;$t_dtsUltima;$t_fecha;$t_rutaActual;$t_uuidMetodo)
C_OBJECT:C1216($ob_data;$ob_parametros)

ARRAY LONGINT:C221($al_filasSeleccionadas;0)
ARRAY TEXT:C222($at_itemPopUp;0)

$y_listbox:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_vc4d")
$y_Ruta:=OBJECT Get pointer:C1124(Object named:K67:5;"ruta")
$y_fechaCambio:=OBJECT Get pointer:C1124(Object named:K67:5;"fechaCambio")
$y_autorCambio:=OBJECT Get pointer:C1124(Object named:K67:5;"autorCambio")
$y_codigoCambio:=OBJECT Get pointer:C1124(Object named:K67:5;"codigoCambio")
$y_metodo:=OBJECT Get pointer:C1124(Object named:K67:5;"metodo")
$y_uuidMetodo:=OBJECT Get pointer:C1124(Object named:K67:5;"uuid_metodo")
$y_modificacionLocal:=OBJECT Get pointer:C1124(Object named:K67:5;"dts_modificacion")
$y_modificacionServer:=OBJECT Get pointer:C1124(Object named:K67:5;"modificacionServer")
$y_servidorSeleccionado:=OBJECT Get pointer:C1124(Object named:K67:5;"servidorSeleccionado")
$t_servidorSeleccionado:=$y_servidorSeleccionado->{$y_servidorSeleccionado->}
$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"codigo")



$b_conectado:=(VC4D_CheckServerConnection ="Disponible")
$t_menu:=Create menu:C408
Case of 
	: (Form event:C388=On Clicked:K2:4)
		LB_GetSelectedRows ($y_listBox;->$al_filasSeleccionadas)
		
		If (Contextual click:C713)
			MNU_Append ($t_menu;"Editar…";"editar";(Size of array:C274($al_filasSeleccionadas)>=1))
			MNU_Append ($t_menu;"Ver código en "+$t_servidorSeleccionado;"verRemoto";(Size of array:C274($al_filasSeleccionadas)>=1) & ($b_conectado))
			MNU_Append ($t_menu;"Comparar…";"comparar";(Size of array:C274($al_filasSeleccionadas)=1) & ($b_conectado))
			MNU_Append ($t_menu;"(-")
			MNU_Append ($t_menu;"Integrar '"+$y_metodo->{$y_metodo->}+"' en "+$t_servidorSeleccionado;"integrar";(Size of array:C274($al_filasSeleccionadas)=1) & ($b_conectado))
			MNU_Append ($t_menu;"(-")
			MNU_Append ($t_menu;"Quitar de la lista…";"quitar";(Size of array:C274($al_filasSeleccionadas)>=1))
			
			
			$t_accion:=Dynamic pop up menu:C1006($t_menu)
			Case of 
				: ($t_accion="editar")  // abrir métodos
					For ($i;1;Size of array:C274($al_filasSeleccionadas))
						METHOD OPEN PATH:C1213($y_ruta->{$al_filasSeleccionadas{$i}};*)
					End for 
					
				: ($t_accion="verRemoto")  // mostrar código remoto
					VC4D_MuestraCodigoRemoto ($y_ruta->{$al_filasSeleccionadas{1}})
					
				: ($t_accion="comparar")
					$b_codigoDistinto:=VC4D_ComparaCodigo ($y_ruta->{$al_filasSeleccionadas{1}})
					If ($b_codigoDistinto)
						ALERT:C41("El codigo en la estructura local es distinto del código en el servidor.")
					Else 
						ALERT:C41("El código es idéntico en la estructura local y en el servidor.")
					End if 
					
				: ($t_accion="quitar")
					For ($i_filas;Size of array:C274($al_filasSeleccionadas);1;-1)
						LISTBOX DELETE ROWS:C914($y_listBox->;$al_filasSeleccionadas{$i_filas};1)
					End for 
					
				: ($t_accion="integrar")  // integrar métodos
					VC4D_CommitCode 
					
			End case 
			
		Else 
			If ($y_Ruta->>0)
				$t_uuidMetodo:=$y_uuidMetodo->{$y_Ruta->}
				OB SET:C1220($ob_parametros;"uuid";$t_uuidMetodo)
				$ob_data:=VC4D_GetData ("versiones";$ob_parametros)
				OB GET ARRAY:C1229($ob_data;"autor";$y_autorCambio->)
				OB GET ARRAY:C1229($ob_data;"dts_modificacion";$y_fechaCambio->)
				OB GET ARRAY:C1229($ob_data;"codigo";$y_codigoCambio->)
				SORT ARRAY:C229($y_fechaCambio->;$y_autorCambio->;$y_codigoCambio->;<)
				OBJECT SET TITLE:C194(*;"hdr_Historial";"Historial ("+String:C10(Size of array:C274($y_fechaCambio->))+" versiones)")
				If (Size of array:C274($y_fechaCambio->)>0)
					$y_codigo->:=$y_codigoCambio->{1}
					LISTBOX SELECT ROW:C912(*;"lb_cambios";1;lk replace selection:K53:1)
				Else 
					LISTBOX SELECT ROW:C912(*;"lb_cambios";0;lk remove from selection:K53:3)
				End if 
			End if 
		End if 
		
		
	: (Form event:C388=On Double Clicked:K2:5)
		If ($y_Ruta->>0)
			METHOD OPEN PATH:C1213($y_Ruta->{$y_Ruta->};*)
		End if 
End case 



