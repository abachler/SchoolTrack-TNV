  // [xShell_Reports].Repositorio.hlRIN_Informes()
  // Por: Alberto Bachler K.: 19-08-14, 11:37:58
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_editable)
_O_C_INTEGER:C282($i_elementos)
C_LONGINT:C283($l_color;$l_estilo;$l_icono;$l_itemSeleccionado;$l_posicion)
C_TEXT:C284($t_nombre;$t_uuidActualizacion;$t_uuidEnLista;$t_uuidInforme)

ARRAY TEXT:C222($at_itemsMenu;0)

Case of 
	: ((Form event:C388=On Clicked:K2:4) & (Contextual click:C713))
		GET LIST ITEM PROPERTIES:C631(hlRIN_Informes;*;$b_editable;$l_estilo;$l_icono;$l_color)
		Case of 
			: (($l_color=IT_IndexColor2RGB (Dark green:K11:10)) | (Macintosh option down:C545 | Windows Alt down:C563))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Descargar informe"))
				
			: ($l_color=IT_IndexColor2RGB (Red:K11:4))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Actualizar informe"))
				
			: ($l_color=IT_IndexColor2RGB (Dark blue:K11:6))
				APPEND TO ARRAY:C911($at_itemsMenu;"("+__ ("El informe está actualizado"))
		End case 
		$at_itemsMenu:=0
		$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_itemsMenu)
		
		If ($l_itemSeleccionado=1)
			GET LIST ITEM PARAMETER:C985(hlRIN_Informes;*;"uuidActualizacion";$t_uuidActualizacion)
			RIN_DescargaActualizacion ($t_uuidActualizacion)
			RIN_BuscaInformes (vSearch)
			For ($i_elementos;1;Count list items:C380(hlRIN_Informes))
				SELECT LIST ITEMS BY POSITION:C381(hlRIN_Informes;$i_elementos)
				GET LIST ITEM PARAMETER:C985(hlRIN_Informes;*;"uuidActualizacion";$t_uuidEnLista)
				If ($t_uuidEnLista=$t_uuidActualizacion)
					$l_posicion:=$i_elementos
					$i_elementos:=Count list items:C380(hlRIN_Informes)+1
				End if 
			End for 
			POST KEY:C465(Character code:C91("+");Command key mask:K16:1+Shift key mask:K16:3)
			
			GET LIST ITEM PARAMETER:C985(hlRIN_Informes;*;"uuidActualizacion";$t_uuidActualizacion)
			RIN_LeeInformaciones ($t_uuidActualizacion)
			
		End if 
		
		
		
	: (Form event:C388=On Selection Change:K2:29)
		GET LIST ITEM PARAMETER:C985(hlRIN_Informes;*;"uuidActualizacion";$t_uuidActualizacion)
		GET LIST ITEM PARAMETER:C985(hlRIN_Informes;*;"uuidInforme";$t_uuidInforme)
		RIN_LeeInformaciones ($t_uuidActualizacion)
		
End case 


  //$l_informeSeleccionado:=Selected list items(hlRIN_Informes)
  //(OBJECT Get pointer(Object named;"informe_informaciones"))->:=(OBJECT Get pointer(Object named;"descripcion"))->
  //OBJECT SET FONT STYLE(*;"informe_boton@";Plain)
  //OBJECT SET FONT STYLE(*;"informe_botonDescripcion";Bold)
OBJECT SET VISIBLE:C603(*;"sinSeleccion@";OBJECT Get title:C1068(*;"informe_nombre")="")


