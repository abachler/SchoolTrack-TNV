//%attributes = {}
  // LV_SeleccionValorEnLista()
  // Por: Alberto Bachler K.: 01-07-14, 09:23:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_edicionAutorizada;$b_listaEditable)
C_LONGINT:C283($l_abajo;$l_abajoVentana;$l_arriba;$l_arribaVentana;$l_caracter;$l_derecha;$l_derechaVentana;$l_fin;$l_inicio;$l_item)
C_LONGINT:C283($l_izquierda;$l_izquierdaVentana;$l_largoTexto;$l_numeroElementos;$l_posicion;$l_primerElemento;$l_refVentana;$l_resalteDesde;$l_resalteHasta)
C_TEXT:C284($t_lenguaje;$t_nombreLista;$t_nombreObjeto;$t_textoEditado)

C_POINTER:C301($y_objectoActual_t)

If (False:C215)
	C_TEXT:C284(LV_SeleccionValorEnLista ;$1)
	C_TEXT:C284(LV_SeleccionValorEnLista ;$2)
End if 

C_TEXT:C284(LV_valorActual_t)

$t_nombreLista:=$1
$t_lenguaje:=$2
$l_posicion:=0

$y_objectoActual_t:=OBJECT Get pointer:C1124(Object current:K67:2)
$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		LV_valorActual_t:=$y_objectoActual_t->
		ARRAY TEXT:C222(LV_elementosLista_at;0)
		LV_LeeLista ($t_nombreLista;$t_lenguaje;->LV_elementosLista_at)
		
	: (Form event:C388=On After Keystroke:K2:26)
		$y_objectoActual_t->:=Get edited text:C655
		$t_textoEditado:=$y_objectoActual_t->+"@"
		$l_caracter:=Character code:C91(Keystroke:C390)
		If (($l_caracter#Backspace key:K12:29) & ($l_caracter#DEL ASCII code:K15:34))
			$l_largoTexto:=Length:C16($y_objectoActual_t->)
			If ($l_largoTexto>0)
				$l_item:=Find in array:C230(LV_elementosLista_at;$t_textoEditado)
				If ($l_item>0)
					$y_objectoActual_t->:=LV_elementosLista_at{$l_item}
					$l_resalteDesde:=$l_largoTexto+1
					$l_resalteHasta:=Length:C16($y_objectoActual_t->)+1
					HIGHLIGHT TEXT:C210(*;$t_nombreObjeto;$l_resalteDesde;$l_resalteHasta)
				End if 
			End if 
		End if 
		
	: (Form event:C388=On Losing Focus:K2:8)
		If (($y_objectoActual_t->#"") & ($y_objectoActual_t->#LV_valorActual_t))
			GET HIGHLIGHT:C209($y_objectoActual_t->;$l_inicio;$l_fin)
			If (($l_inicio>1) & ($l_fin>$l_inicio) & ($l_inicio<Length:C16($y_objectoActual_t->)))
				$y_objectoActual_t->:=Substring:C12($y_objectoActual_t->;0;$l_inicio-1)
			End if 
			$t_textoEditado:=Substring:C12($y_objectoActual_t->;0;$l_inicio-1)+"@"
			$l_numeroElementos:=AT_CountValueOccurrences (->LV_elementosLista_at;->$t_textoEditado)
			Case of 
				: ($l_numeroElementos=0)
					$b_listaEditable:=KRL_GetBooleanFieldData (->[xShell_List:39]Listname:1;->$t_nombreLista;->[xShell_List:39]Enriquecible:8)
					$b_edicionAutorizada:=USR_GetMethodAcces ("Listas";0)
					Case of 
						: ($b_edicionAutorizada & $b_listaEditable)
							OK:=CD_Dlog (0;__ ("Valor inexistente. \r¿Desea Ud. agregarlo a la tabla?");__ ("");__ ("Sí");__ ("No"))
							If (OK=1)
								LV_AgregaValor ($t_nombreLista;$t_lenguaje;$y_objectoActual_t->)
							Else 
								$y_objectoActual_t->:=LV_valorActual_t
							End if 
							
						: (Not:C34($b_listaEditable))
							CD_Dlog (0;__ ("Esta lista no ha sido configurada para poder agregar valores durante el ingreso.\rPor favor consulte al administrador de SchoolTrack."))
							$y_objectoActual_t->:=LV_valorActual_t
							
						: (Not:C34($b_edicionAutorizada))
							CD_Dlog (0;__ ("Usted no está autorizado a modificar esta lista.\rPor favor seleccione un valor existente."))
							$y_objectoActual_t->:=LV_valorActual_t
							
					End case 
					
				: ($l_numeroElementos=1)
					$y_objectoActual_t->:=Get edited text:C655
					
				: ($l_numeroElementos>1)
					LV_refItemSeleccionado_l:=0
					LV_textoItemSeleccionado_t:=""
					LV_ListaValores_hl:=New list:C375
					$l_primerElemento:=Find in array:C230(LV_elementosLista_at;$t_textoEditado)
					For ($i;$l_primerElemento;Size of array:C274(LV_elementosLista_at))
						If (LV_elementosLista_at{$i}=$t_textoEditado)
							APPEND TO LIST:C376(LV_ListaValores_hl;LV_elementosLista_at{$i};$i)
						Else 
							$i:=Size of array:C274(LV_elementosLista_at)+1
						End if 
					End for 
					
					GET WINDOW RECT:C443($l_izquierdaVentana;$l_arribaVentana;$l_derechaVentana;$l_abajoVentana;Frontmost window:C447)
					OBJECT GET COORDINATES:C663(*;$t_nombreObjeto;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
					
					SET LIST PROPERTIES:C387(LV_ListaValores_hl;_o_Ala Macintosh:K28:1;_o_Macintosh node:K28:5;20)
					$l_arriba:=$l_arribaVentana+$l_abajo+5
					$l_izquierda:=$l_izquierdaVentana+$l_izquierda
					$l_refVentana:=Open window:C153($l_izquierda;$l_arriba;$l_derecha;$l_arriba+180;Pop up window:K34:14)
					DIALOG:C40("PopupList")
					CLOSE WINDOW:C154
					
					If (OK=1)
						$y_objectoActual_t->:=LV_textoItemSeleccionado_t
					Else 
						$y_objectoActual_t->:=LV_valorActual_t
					End if 
			End case 
		End if 
End case 

