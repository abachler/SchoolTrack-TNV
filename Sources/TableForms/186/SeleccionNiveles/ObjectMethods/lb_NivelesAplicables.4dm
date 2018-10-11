Case of 
	: (vl_TipoObjeto=Eje_Aprendizaje)
		MPAcfg_Eje_NivelesAplicacion 
	: (vl_TipoObjeto=Dimension_Aprendizaje)
		MPAcfg_Dim_NivelesAplicacion 
	: (vl_TipoObjeto=Logro_Aprendizaje)
		MPAcfg_Comp_NivelesAplicacion 
End case 




For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
	$noNivelEnLista:=Find in array:C230(<>aNivNo;<>al_NumeroNivelesActivos{$i})
	If (vl_AplicaEnNiveles ?? $noNivelEnLista)
		  //GET ICON RESOURCE(17000;$pict)
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";$pict)
		ap_MarcaNiveles{$i}:=$pict
	Else 
		  //GET ICON RESOURCE(17001;$pict)
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";$pict)
		ap_MarcaNiveles{$i}:=$pict
	End if 
End for 