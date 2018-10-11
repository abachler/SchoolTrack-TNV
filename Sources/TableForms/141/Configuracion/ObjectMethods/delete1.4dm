$r:=CD_Dlog (0;__ ("Este campo no podrá ser utilizado en ninguna base de datos pero, la información existente no será eliminada.\r\r¿Seguro que quieres eliminarlo?");__ ("");__ ("No");__ ("Si. Eliminar"))
If ($r=2)
	DELETE RECORD:C58([xxSTR_MetadatosLocales:141])
	MDATA_ObjectHandler 
End if 