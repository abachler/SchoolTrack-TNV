Case of 
	: (Form event:C388=On Load:K2:1)
		$name:=Replace string:C233(Lowercase:C14(SN3_PlantillasNombres{lb_Plantillas});" ";"_")
		$ruta:="http://sn3ws.colegium.com/GetPlantilla.php?name="+$name+".jpg"
		WA OPEN URL:C1020(WEBImagen;$ruta)
End case 