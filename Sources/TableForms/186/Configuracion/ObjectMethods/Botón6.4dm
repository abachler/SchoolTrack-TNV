OBJECT MOVE:C664(*;"P01_AreaAreas_btn@";Self:C308->;0)
OBJECT MOVE:C664(*;"P01_AreaEje_Info@";Self:C308->;0)

AL_GetWidths (xALP_Ejes;2;1;$l_anchoColumnaEjes)
$l_anchoColumnaEjes:=$l_anchoColumnaEjes-Self:C308->



  // ajustes de la posición, visibilidad y tamaño de objetos asociados al área Areas
OBJECT GET COORDINATES:C663(*;"P01_AreaAreas_plg";$l_izquierdaArea;$l_arribaArea;$l_derechaArea;$l_abajoArea)
$l_anchoArea:=$l_derechaArea-$l_izquierdaArea+1
If ($l_anchoArea<3)
	OBJECT SET VISIBLE:C603(*;"P01_AreaAreas_plg";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"P01_AreaAreas_plg";True:C214)
End if 

If ($l_anchoArea<90)
	OBJECT SET VISIBLE:C603(*;"P01_AreaAreas_btn@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"P01_AreaAreas_btn@";True:C214)
End if 

OBJECT GET COORDINATES:C663(*;"P01_AreaAreas_Nombre";$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
$l_izquierdaObjeto:=$l_izquierdaArea+4
$l_derechaObjeto:=$l_derechaArea-50
If (($l_derechaObjeto-$l_izquierdaObjeto)>=10)
	OBJECT SET VISIBLE:C603(*;"P01_AreaAreas_Nombre";True:C214)
	IT_SetNamedObjectRect ("P01_AreaAreas_Nombre";$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
Else 
	OBJECT SET VISIBLE:C603(*;"P01_AreaAreas_Nombre";False:C215)
End if 




  // ajustes de la visibilidad y tamaño de objetos asociados al área Ejes
OBJECT GET COORDINATES:C663(*;"P01_AreaEje_plg";$l_izquierdaArea;$l_arribaArea;$l_derechaArea;$l_abajoArea)
$l_anchoArea:=$l_derechaArea-$l_izquierdaArea+1

If ($l_anchoArea<3)
	OBJECT SET VISIBLE:C603(*;"P01_AreaEje_plg@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"P01_AreaEje_plg@";True:C214)
End if 

If ($l_anchoArea<72)
	OBJECT SET VISIBLE:C603(*;"P01_AreaEje_Info@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"P01_AreaEje_Info@";True:C214)
End if 

If ($l_anchoArea<110)
	OBJECT SET VISIBLE:C603(*;"P01_AreaEje_btn@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"P01_AreaEje_btn@";True:C214)
End if 


OBJECT GET COORDINATES:C663(*;"P01_AreaEje_Nombre";$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
$l_izquierdaObjeto:=$l_izquierdaArea+72
$l_derechaObjeto:=$l_derechaArea-50
If (($l_derechaObjeto-$l_izquierdaObjeto)>=10)
	OBJECT SET VISIBLE:C603(*;"P01_AreaEje_Nombre";True:C214)
	IT_SetNamedObjectRect ("P01_AreaEje_Nombre";$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
Else 
	OBJECT SET VISIBLE:C603(*;"P01_AreaEje_Nombre";False:C215)
End if 
