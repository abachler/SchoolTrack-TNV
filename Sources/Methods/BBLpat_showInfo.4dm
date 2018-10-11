//%attributes = {}
  //BBLpat_showInfo

If ($1>=0)
	READ ONLY:C145([BBL_Lectores:72])
	GOTO RECORD:C242([BBL_Lectores:72];$1)
	QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1;*)
	QUERY:C277([BBL_Prestamos:60]; & [BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	SELECTION TO ARRAY:C260([BBL_Prestamos:60]Hasta:4;aDate1;[BBL_Prestamos:60]Fecha_de_devolución:5;aDate2;[BBL_Items:61]Clasificacion:2;aText1;[BBL_Items:61]Primer_título:4;aText2;[BBL_Items:61]Primer_autor:6;aText3;[BBL_Prestamos:60]Número_de_registro:1;aLong1;[BBL_Prestamos:60];aLong2;[BBL_Registros:66]Status:10;aText4)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	SORT ARRAY:C229(aDate1;aLong1;aDate2;aText1;aText2;aText3;aLong2;aText4;<)
	WDW_OpenFormWindow (->[BBL_Lectores:72];"Infos";-1;8;__ ("Informaciones sobre usuario"))
	DIALOG:C40([BBL_Lectores:72];"Infos")
	CLOSE WINDOW:C154
End if 