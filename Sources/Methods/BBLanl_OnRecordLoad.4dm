//%attributes = {}
  //BBLanl_OnRecordLoad

If (Record number:C243([BBL_RegistrosAnaliticos:74])=-3)
	[BBL_RegistrosAnaliticos:74]ID:1:=[BBL_Items:61]Numero:1
	[BBL_RegistrosAnaliticos:74]ID_sub:8:=SQ_SeqNumber (->[BBL_RegistrosAnaliticos:74]ID_sub:8)
End if 

If (Record number:C243([BBL_Registros:66])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo Registro Analítico"))
Else 
	SET WINDOW TITLE:C213(Replace string:C233([BBL_RegistrosAnaliticos:74]Titulos:3;"\r";", "))
End if 
