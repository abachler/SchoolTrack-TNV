//%attributes = {}
  // NTC_ConfiguraAreaMensaje
  //
  // Configura la zona de visualización del mensaje seleccionado
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 11:24:51
  // ---------------------------------------------
C_BOOLEAN:C305($b_ejecutarMetodo;$b_mostrarEnExplorador)
C_LONGINT:C283($l_IdmensajeProceso;$i;$l_advertencias;$l_areaWidth;$l_blobOffset;$l_bottom;$l_dataWidth;$l_endStyling;$l_errorColumnWidth;$l_errores;$l_headerPad)
C_LONGINT:C283($l_left;$l_maxColumnWidths;$l_numberOfColumns;$l_numberOfRows;$l_pixelsToReasign;$l_resueltos;$l_right;$l_rowLines;$l_rowPad;$l_rows)
C_LONGINT:C283($l_rowsInArea;$l_spareWidth;$l_startStyling;$l_top;$l_totalWidth)
C_POINTER:C301($y_array;$y_punteroArreglo)
C_TEXT:C284($t_arregloColumna;$t_nombreArreglo)

ARRAY TEXT:C222($at_contenidoColumna;0)

  // CÓDIGO
vtMSG_Abstract:=""
QUERY:C277([NTC_Notificaciones:190];[NTC_Notificaciones:190]Auto_UUID:1=vt_UUIDmensaje)

If (vt_UUIDmensaje#"")
	QR_InitGenericObjects 
	vt_fecha:=String:C10([NTC_Notificaciones:190]Fecha_creacion:2;System date long:K1:3)+", "+String:C10([NTC_Notificaciones:190]Hora_creacion:3)  //201804018 RCH Se quita del caso porque se podría desplegar info errónea
	Case of 
		: (BLOB size:C605([NTC_Notificaciones:190]Contenido_arreglos:8)=0)
			  //OBJECT SET SCROLLBAR([NTC_Notificaciones]Descripción;False;True)
			OBJECT SET VISIBLE:C603([NTC_Notificaciones:190]Descripción:6;True:C214)
			OBJECT SET VISIBLE:C603(*;"P2@";True:C214)
			OBJECT SET VISIBLE:C603(*;"P1@";True:C214)
			AL_SetScroll (xALP_MsgWarnings;0;0)
			ALP_RemoveAllArrays (xALP_MsgWarnings)
			FORM GOTO PAGE:C247(2)
			
			
		: (BLOB size:C605([NTC_Notificaciones:190]Contenido_arreglos:8)>0)
			ARRAY TEXT:C222(at_ArreglosErrores;0)
			  //vt_fecha:=String([NTC_Notificaciones]Fecha_creacion;System date long)+", "+String([NTC_Notificaciones]Hora_creacion)
			$l_blobOffset:=BLOB_Blob2Vars (->[NTC_Notificaciones:190]Contenido_arreglos:8;$l_blobOffset;->at_TitulosColumnas)
			For ($i;1;Size of array:C274(at_TitulosColumnas))
				$t_nombreArreglo:="aQR_Text"+String:C10($i)
				$y_punteroArreglo:=Get pointer:C304($t_nombreArreglo)
				$l_blobOffset:=BLOB_Blob2Vars (->[NTC_Notificaciones:190]Contenido_arreglos:8;$l_blobOffset;$y_punteroArreglo)
				APPEND TO ARRAY:C911(at_ArreglosErrores;$t_nombreArreglo)
			End for 
			
			If (BLOB size:C605([NTC_Notificaciones:190]Colores_estilos:9)>0)
				$l_blobOffset:=BLOB_Blob2Vars (->[NTC_Notificaciones:190]Colores_estilos:9;0;->al_Estilos;->al_Colores)
			End if 
			
			
			If (Size of array:C274(aQR_Text1)>500)
				$l_IdmensajeProceso:=IT_UThermometer (1;0;__ ("Leyendo anomalías detectadas..."))
			End if 
			
			  // redimensiono los arreglos de colores y estilos en caso que no hayan sido pasados en el blob
			$y_array:=Get pointer:C304(at_ArreglosErrores{1})
			$l_rowsInArea:=Size of array:C274($y_array->)
			ARRAY LONGINT:C221(al_Colores;$l_rowsInArea)
			ARRAY LONGINT:C221(al_Estilos;$l_rowsInArea)
			
			  // elimino los arreglos sin contenido para no desplegarlos
			For ($i;Size of array:C274(at_ArreglosErrores);1;-1)
				$y_array:=Get pointer:C304(at_ArreglosErrores{$i})
				If (Not:C34(AT_ArrayHasNonNulValues ($y_array)))
					DELETE FROM ARRAY:C228(at_ArreglosErrores;$i)
					DELETE FROM ARRAY:C228(at_TitulosColumnas;$i)
				End if 
			End for 
			
			  // determino el ancho óptimo de las columnas
			OBJECT GET COORDINATES:C663(xALP_MsgWarnings;$l_left;$l_top;$l_right;$l_bottom)
			$l_areaWidth:=$l_right-$l_left-16
			
			$l_errorColumnWidth:=300
			$l_maxColumnWidths:=250
			$l_numberOfRows:=1
			ARRAY LONGINT:C221(al_columnWidhts;0)
			ARRAY LONGINT:C221(al_maxColumnWidhts;0)
			ARRAY LONGINT:C221(al_RowsInColumn;0)
			ARRAY LONGINT:C221(al_columnWidhts;Size of array:C274(at_ArreglosErrores))
			ARRAY LONGINT:C221(al_maxColumnWidhts;Size of array:C274(at_ArreglosErrores))
			ARRAY LONGINT:C221(al_RowsInColumn;Size of array:C274(at_ArreglosErrores))
			For ($i;2;Size of array:C274(at_ArreglosErrores))
				$y_array:=Get pointer:C304(at_ArreglosErrores{$i})
				COPY ARRAY:C226($y_array->;$at_contenidoColumna)
				APPEND TO ARRAY:C911($at_contenidoColumna;at_TitulosColumnas{$i})
				al_maxColumnWidhts{$i}:=hmFree_GetArrayWidth ($at_contenidoColumna;"Tahoma";11;0)+20
				If (al_maxColumnWidhts{$i}>$l_maxColumnWidths)
					al_columnWidhts{$i}:=$l_maxColumnWidths
					$l_rows:=(al_columnWidhts{$i}/$l_maxColumnWidths)+(1-Dec:C9(al_columnWidhts{$i}/$l_maxColumnWidths))
					If ($l_rows>$l_numberOfRows)
						$l_numberOfRows:=$l_rows
						al_columnWidhts{$i}:=$l_maxColumnWidths
						al_RowsInColumn{$i}:=$l_Rows
						  //Else
						  //al_columnWidhts{$i}:=al_maxColumnWidhts{$i}
					End if 
				Else 
					al_columnWidhts{$i}:=al_maxColumnWidhts{$i}
					al_RowsInColumn{$i}:=1
				End if 
			End for 
			
			$l_dataWidth:=AT_GetSumArray (->al_columnWidhts)
			$y_array:=Get pointer:C304(at_ArreglosErrores{1})
			al_columnWidhts{1}:=$l_errorColumnWidth
			COPY ARRAY:C226($y_array->;$at_contenidoColumna)
			APPEND TO ARRAY:C911($at_contenidoColumna;at_TitulosColumnas{1})
			al_maxColumnWidhts{1}:=hmFree_GetArrayWidth ($at_contenidoColumna;"Tahoma";11;0)+20
			Case of 
				: (al_maxColumnWidhts{1}<=$l_errorColumnWidth)
					$l_errorColumnWidth:=al_maxColumnWidhts{1}
					$l_rows:=1
				: (al_maxColumnWidhts{1}>$l_errorColumnWidth)
					$l_rows:=(al_maxColumnWidhts{1}/$l_errorColumnWidth)+(1-Dec:C9(al_maxColumnWidhts{1}/$l_errorColumnWidth))
					If ($l_rows>$l_numberOfRows)
						$l_numberOfRows:=$l_rows
					End if 
				Else 
			End case 
			al_RowsInColumn{1}:=$l_rows
			
			$l_totalWidth:=AT_GetSumArray (->al_columnWidhts)
			If ($l_totalWidth<$l_areaWidth)
				$l_spareWidth:=$l_areaWidth-$l_totalWidth
				For ($i;1;Size of array:C274(at_ArreglosErrores))
					If ((al_maxColumnWidhts{$i}>al_columnWidhts{$i}) & ($l_spareWidth>0))
						If ((al_columnWidhts{$i}+$l_spareWidth)>al_maxColumnWidhts{$i})
							$l_spareWidth:=al_maxColumnWidhts{$i}-al_columnWidhts{$i}
							al_columnWidhts{$i}:=al_maxColumnWidhts{$i}
							al_RowsInColumn{$i}:=1
						End if 
					End if 
				End for 
			End if 
			
			$l_totalWidth:=AT_GetSumArray (->al_columnWidhts)
			If ($l_totalWidth<$l_areaWidth)
				$l_spareWidth:=$l_areaWidth-$l_totalWidth
			End if 
			
			If ($l_spareWidth>0)
				$l_numberOfColumns:=Size of array:C274(at_ArreglosErrores)
				$l_pixelsToReasign:=Int:C8($l_spareWidth/$l_numberOfColumns)
				If ($l_pixelsToReasign>0)
					For ($i;1;Size of array:C274(at_ArreglosErrores))
						$y_array:=Get pointer:C304(at_ArreglosErrores{$i})
						  //al_maxColumnWidhts{$i}:=hmFree_GetArrayWidth ($y_array->;"Tahoma";11;0)+20
						If (al_maxColumnWidhts{$i}>al_columnWidhts{$i})
							al_columnWidhts{$i}:=al_columnWidhts{$i}+$l_pixelsToReasign
						End if 
						If (al_maxColumnWidhts{$i}>al_columnWidhts{$i})
							$l_rows:=(al_maxColumnWidhts{$i}/al_columnWidhts{$i})+(1-Dec:C9(al_maxColumnWidhts{$i}/al_columnWidhts{$i}))
							al_RowsInColumn{$i}:=$l_Rows
						Else 
							al_columnWidhts{$i}:=al_maxColumnWidhts{$i}
						End if 
						$l_numberOfColumns:=Size of array:C274(at_ArreglosErrores)-$i
						$l_pixelsToReasign:=Int:C8($l_spareWidth/$l_numberOfColumns)
					End for 
				End if 
			End if 
			
			$l_rowLines:=AT_Maximum (->al_RowsInColumn)
			$l_headerPad:=8
			$l_rowPad:=8
			
			ALP_RemoveAllArrays (xALP_MsgWarnings)
			For ($i;1;Size of array:C274(at_ArreglosErrores))
				$t_arregloColumna:=at_ArreglosErrores{$i}
				ALP_DefaultColSettings (xALP_MsgWarnings;$i+1;at_ArreglosErrores{$i};at_TitulosColumnas{$i};al_columnWidhts{$i})
			End for 
			ALP_SetAlternateLigneColor (xALP_MsgWarnings)
			ALP_SetDefaultAppareance (xALP_MsgWarnings;11)
			AL_SetMiscOpts (xALP_MsgWarnings;0;0;"\\";0;1)
			AL_SetSortOpts (xALP_MsgWarnings;1;1;0;"";0)
			AL_SetHeight (xALP_MsgWarnings;1;$l_headerPad;$l_rowLines;$l_rowPad;0;0)
			AL_SetColOpts (xALP_MsgWarnings;1;0;1;0;0;0;0)
			AL_SetColLock (xALP_MsgWarnings;1)
			AL_SetInterface (xALP_MsgWarnings;0;0;0;0;0;1;0;0)
			AL_SetCopyOpts (xALP_MsgWarnings;0)
			AL_SetRowOpts (xALP_MsgWarnings;1)
			AL_SetScroll (xALP_MsgWarnings;-1;-1)
			
			$l_errores:=0
			$l_advertencias:=0
			$l_resueltos:=0
			For ($i;1;Size of array:C274(al_Colores))
				Case of 
					: (al_Colores{$i}=Red:K11:4)
						AL_SetRowRGBColor (xALP_MsgWarnings;$i;255;0;0;-1;-1;-1)
						$l_errores:=$l_errores+1
						  //: (al_Colores{$i}=Blue)
						  //AL_SetRowRGBColor (xALP_MsgWarnings;$i;0;0;128;-1;-1;-1)
					: (al_Colores{$i}=Green:K11:9)
						AL_SetRowRGBColor (xALP_MsgWarnings;$i;0;128;0;-1;-1;-1)
						$l_resueltos:=$l_resueltos+1
						
					: ((al_Colores{$i}=Black:K11:16) | (al_Colores{$i}=Blue:K11:7))
						AL_SetRowRGBColor (xALP_MsgWarnings;$i;0;0;0;-1;-1;-1)
						$l_advertencias:=$l_advertencias+1
				End case 
			End for 
			
			vtMSG_Abstract:=""
			$l_startStyling:=1
			If ($l_errores>0)
				vtMSG_Abstract:=String:C10($l_errores)+" error"+("es"*Num:C11($l_errores>1))
				$l_endStyling:=Length:C16(vtMSG_Abstract)+1
				ST SET ATTRIBUTES:C1093(vtMSG_Abstract;$l_startStyling;$l_endStyling;Attribute text color:K65:7;"#D81E05";Attribute bold style:K65:1;1)
				$l_startStyling:=$l_endStyling+1
			End if 
			
			If ($l_resueltos>0)
				If (vtMSG_Abstract#"")
					If ($l_resueltos>1)
						vtMSG_Abstract:=vtMSG_Abstract+",  "+String:C10($l_resueltos)+" problemas resueltos"
					Else 
						vtMSG_Abstract:=vtMSG_Abstract+",  "+String:C10($l_resueltos)+" problema resuelto"
					End if 
					$l_endStyling:=Length:C16(vtMSG_Abstract)+1
					ST SET ATTRIBUTES:C1093(vtMSG_Abstract;$l_startStyling+2;$l_endStyling;Attribute text color:K65:7;"#008000";Attribute bold style:K65:1;1)
					$l_startStyling:=$l_endStyling+1
				Else 
					If ($l_resueltos>1)
						vtMSG_Abstract:=vtMSG_Abstract+String:C10($l_resueltos)+" problemas resueltos"
					Else 
						vtMSG_Abstract:=String:C10($l_resueltos)+" problema resuelto"
					End if 
					$l_endStyling:=Length:C16(vtMSG_Abstract)+1
					ST SET ATTRIBUTES:C1093(vtMSG_Abstract;$l_startStyling;$l_endStyling;Attribute text color:K65:7;"#008000";Attribute bold style:K65:1;1)
					$l_startStyling:=$l_endStyling+1
				End if 
			End if 
			
			If ($l_advertencias>0)
				If (vtMSG_Abstract#"")
					vtMSG_Abstract:=vtMSG_Abstract+", "+String:C10($l_advertencias)+" advertencia"+("s"*Num:C11($l_advertencias>1))
					$l_endStyling:=Length:C16(vtMSG_Abstract)
					ST SET ATTRIBUTES:C1093(vtMSG_Abstract;$l_startStyling+1;$l_endStyling;Attribute text color:K65:7;"#000000";Attribute bold style:K65:1;1)
					$l_startStyling:=$l_endStyling+1
				Else 
					vtMSG_Abstract:=String:C10($l_advertencias)+" advertencias"
					$l_endStyling:=Length:C16(vtMSG_Abstract)+1
					ST SET ATTRIBUTES:C1093(vtMSG_Abstract;$l_startStyling;$l_endStyling;Attribute text color:K65:7;"#000000";Attribute bold style:K65:1;1)
					$l_startStyling:=$l_endStyling+1
				End if 
			End if 
			
			AL_UpdateArrays (xALP_MsgWarnings;-2)
			OBJECT SET SCROLLBAR:C843([NTC_Notificaciones:190]Descripción:6;False:C215;True:C214)
			OBJECT SET VISIBLE:C603(*;"P1@";True:C214)
			AL_SetScroll (xALP_MsgWarnings;-2;-2)
			
			If ($l_IdmensajeProceso>0)
				$l_IdmensajeProceso:=IT_UThermometer (-2;$l_IdmensajeProceso)
			End if 
			FORM GOTO PAGE:C247(1)
			
	End case 
	
	
Else 
	FORM GOTO PAGE:C247(1)
	OBJECT SET SCROLLBAR:C843([NTC_Notificaciones:190]Descripción:6;False:C215;False:C215)
	AL_SetScroll (xALP_MsgWarnings;0;0)
	ALP_RemoveAllArrays (xALP_MsgWarnings)
	OBJECT SET VISIBLE:C603(*;"P1@";False:C215)
End if 

$b_mostrarEnExplorador:=((([NTC_Notificaciones:190]Explorador_modulo:13#"") & ([NTC_Notificaciones:190]Explorador_pestaña:14>0)) & ((BLOB size:C605([NTC_Notificaciones:190]Explorador_registros:15)>0) | ([NTC_Notificaciones:190]Explorador_ejecutarAntes:20#"")))
$b_ejecutarMetodo:=([NTC_Notificaciones:190]Ejecucion_nombreMetodo:17#"")

OBJECT SET VISIBLE:C603(*;"P1_option@";True:C214)
OBJECT SET VISIBLE:C603(*;"P1_task@";$b_mostrarEnExplorador | $b_ejecutarMetodo)







