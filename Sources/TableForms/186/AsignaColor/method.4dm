Case of 
	: (Form event:C388=On Load:K2:1)
		GET PICTURE FROM LIBRARY:C565("PrefPanel"+vsBWR_CurrentModule;PrefIcon)
		OBJECT SET FORMAT:C236(bCFG_ShowALL2;"1;2;PrefIcon;96;0")
		ARRAY TEXT:C222(at_areaAprendizajes;0)
		ARRAY TEXT:C222(at_ejesAprendizajes;0)
		ARRAY TEXT:C222(at_dimAprendizajes;0)
		ARRAY TEXT:C222(at_logrosAprendizajes;0)
		ARRAY LONGINT:C221(al_colorArea;0)
		ARRAY LONGINT:C221(al_colorEje;0)
		ARRAY LONGINT:C221(al_colorDim;0)
		ARRAY LONGINT:C221(al_colorLogros;0)
		
		GET PICTURE FROM LIBRARY:C565("PrefPanel"+vsBWR_CurrentModule;PrefIcon)
		OBJECT SET FORMAT:C236(bCFG_ShowALL;"1;2;PrefIcon;96;0")
		
		ALL RECORDS:C47([MPA_DefinicionAreas:186])
		ORDER BY:C49([MPA_DefinicionAreas:186];[MPA_DefinicionAreas:186]AreaAsignatura:4;>)
		SELECTION TO ARRAY:C260([MPA_DefinicionAreas:186]ID:1;al_IDAreaAprendizajes;[MPA_DefinicionAreas:186]AreaAsignatura:4;at_areaAprendizajes)
		
	: (Form event:C388=On Close Box:K2:21)
		ARRAY TEXT:C222(at_areaAprendizajes;0)
		ARRAY TEXT:C222(at_ejesAprendizajes;0)
		ARRAY TEXT:C222(at_dimAprendizajes;0)
		ARRAY TEXT:C222(at_logrosAprendizajes;0)
		ARRAY LONGINT:C221(al_colorArea;0)
		ARRAY LONGINT:C221(al_colorEje;0)
		ARRAY LONGINT:C221(al_colorDim;0)
		ARRAY LONGINT:C221(al_colorLogros;0)
		ARRAY BOOLEAN:C223(lb_ejesaprendizajes;0)
		ARRAY BOOLEAN:C223(lb_dimaprendizajes;0)
		ARRAY BOOLEAN:C223(lb_logrosaprendizajes;0)
		CANCEL:C270
End case 