$fileName:=Select document:C905("";"TEXT";"Seleccione el archivo a importar...";0)
If (document#"")
	$r:=CD_Dlog (0;__ ("Usted seleccionó el documento ")+document+__ (" para importar su contenido en MediaTrack\r\r ¿Desea iniciar la importación ahora?");__ ("");__ ("Aceptar");__ ("Cancelar"))
	If ($r=1)
		ACCEPT:C269
	Else 
		document:=""
	End if 
Else 
	document:=""
End if 

