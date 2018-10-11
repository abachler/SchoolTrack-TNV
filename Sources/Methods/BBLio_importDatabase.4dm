//%attributes = {}
  //BBLio_importDatabase

$r:=CD_Dlog (0;__ ("Los datos existentes serán reemplazados por los datos del archivo a importar.\r¿Continuamos?");__ ("");__ ("Si");__ ("No"))

If ($r=1)
	ARRAY POINTER:C280(aMTExport;13)
	aMTExport{1}:=->[BBL_Transacciones:59]
	aMTExport{2}:=->[BBL_Prestamos:60]
	aMTExport{3}:=->[BBL_Items:61]
	aMTExport{4}:=->[xxBBL_ReglasParaUsuarios:64]
	aMTExport{5}:=->[xxBBL_Preferencias:65]
	aMTExport{6}:=->[BBL_Registros:66]
	aMTExport{7}:=->[BBL_Thesaurus:68]
	aMTExport{8}:=->[xxBBL_ReglasParaItems:69]
	aMTExport{9}:=->[BBL_Index:70]
	aMTExport{10}:=->[BBL_Lectores:72]
	aMTExport{11}:=->[BBL_RegistrosAnaliticos:74]
	aMTExport{12}:=->[BBL_FichasCatalograficas:81]
	aMTExport{13}:=->[BBL_Reservas:115]
	For ($i;1;Size of array:C274(aMTExport))
		READ WRITE:C146(aMTExport{$i}->)
	End for 
	For ($i;1;Size of array:C274(aMTExport))
		ALL RECORDS:C47(aMTExport{$i}->)
		KRL_DeleteSelection (aMTExport{$i})
	End for 
	IO_ImportRecords2Tables 
	SQ_SetSequences 
End if 