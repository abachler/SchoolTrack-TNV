vd_fecha_hasta:=DT_PopCalendar 

If (vd_fecha_hasta#!00-00-00!)
	
	READ ONLY:C145([BBL_Prestamos:60])
	QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Hasta:4<=vd_fecha_hasta;*)
	QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!;*)
	QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Número_de_lector:2>0)
	
	If (Records in selection:C76([BBL_Prestamos:60])=0)
		CD_Dlog (0;"No existen préstamos pendientes en esa fecha o en anteriores")
		vi_todo:=0
		vd_fecha_hasta:=!00-00-00!
	Else 
		$proc:=IT_UThermometer (1;0;__ ("Cargando préstamos..."))
		ORDER BY:C49([BBL_Prestamos:60];[BBL_Prestamos:60]Hasta:4;<)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([BBL_Prestamos:60];al_recnum_ptm;[BBL_Prestamos:60]Número_de_registro:1;al_numregistro;[BBL_Prestamos:60]Hasta:4;ad_fecha_hasta;[BBL_Lectores:72]NombreCompleto:3;at_usuario_original;[BBL_Items:61]Titulos:5;at_titulo)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		ARRAY BOOLEAN:C223(ab_transferir;Size of array:C274(al_numregistro))
		$vb_opc:=True:C214
		AT_Populate (->ab_transferir;->$vb_opc)
		For ($i;1;Size of array:C274(at_titulo))
			at_titulo{$i}:=ST_GetCleanString (at_titulo{$i})
			at_titulo{$i}:=Replace string:C233(at_titulo{$i};"\r";"")
		End for 
		IT_UThermometer (-2;$proc)
		vi_todo:=1
	End if 
	
Else 
	ARRAY LONGINT:C221(al_recnum_ptm;0)
	ARRAY DATE:C224(ad_fecha_hasta;0)
	ARRAY TEXT:C222(at_usuario_original;0)
	ARRAY TEXT:C222(at_titulo;0)
	ARRAY LONGINT:C221(al_numregistro;0)
	ARRAY BOOLEAN:C223(ab_transferir;0)
	CD_Dlog (0;"Para buscar debe seleccionar una fecha")
End if 


