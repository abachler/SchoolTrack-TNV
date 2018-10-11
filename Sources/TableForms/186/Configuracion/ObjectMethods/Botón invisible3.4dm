FORM GET PROPERTIES:C674([MPA_DefinicionAreas:186];"Configuracion";$formWidth;$formHeight)
If (Not:C34(vb_wholeScreen))
	vb_wholeScreen:=True:C214
	OBJECT GET COORDINATES:C663(xALP_Competencias;vl_left;vl_top;vl_right;vl_bottom)
	If (SYS_IsWindows )
		$screenRight:=Screen width:C187
		$screenBottom:=Screen height:C188
	Else 
		SCREEN COORDINATES:C438($screenleft;$screenTop;$screenright;$screenbottom)
	End if 
	OBJECT GET COORDINATES:C663(xALP_Competencias;vl_left;vl_top;vl_right;vl_bottom)
	GET WINDOW RECT:C443($winleft;$wintop;$winright;$winbottom)
	vl_GrowWidth:=$screenright-$winright-10
	vl_Growheight:=$screenbottom-$winbottom-10
	
	RESIZE FORM WINDOW:C890(vl_GrowWidth;vl_Growheight)
	OBJECT SET TITLE:C194(Self:C308->;__ ("Tamaño original"))
	
	OBJECT MOVE:C664(xALP_Ejes;0;0;Int:C8(vl_GrowWidth/2);0)
	OBJECT GET COORDINATES:C663(xALP_Ejes;$l_eje;$t_eje;$r_eje;$b_eje)
	OBJECT MOVE:C664(*;"P01_AreaEje_btn_@";Int:C8(vl_GrowWidth/2);0)
	OBJECT MOVE:C664(*;"P01_AreaEje_Nombre";0;0;Int:C8(vl_GrowWidth/2);0)
	OBJECT MOVE:C664(*;"P01_AreaDim_Info@";Int:C8(vl_GrowWidth/2);0)
	OBJECT MOVE:C664(*;"P01_AreaDim_Nombre";Int:C8(vl_GrowWidth/2);0;Int:C8(vl_GrowWidth/2);0)
	OBJECT MOVE:C664(vl_SeparadorDimensiones;Int:C8(vl_GrowWidth/2);0)
	
	OBJECT GET COORDINATES:C663(xALP_Dimensiones;$l_dim;$t_dim;$r_dim;$b_dim)
	OBJECT MOVE:C664(xALP_Dimensiones;$r_eje-$l_dim+3;0;-Int:C8(vl_GrowWidth/2)+2;0)
	
	AL_GetWidths (xALP_Ejes;2;1;$l_anchoColumnaEjes)
	$l_anchoColumnaEjes:=$l_anchoColumnaEjes+Int:C8(vl_GrowWidth/2)
	AL_SetWidths (xALP_Ejes;2;1;$l_anchoColumnaEjes)
	
	AL_GetWidths (xALP_Dimensiones;2;1;$l_anchoColumnaDimension)
	$l_anchoColumnaDimension:=$l_anchoColumnaDimension+Int:C8(vl_GrowWidth/2)
	AL_SetWidths (xALP_Dimensiones;2;1;$l_anchoColumnaDimension)
	
	
	MPAcfg_Comp_DistribuyeColumnas 
	
	
End if 