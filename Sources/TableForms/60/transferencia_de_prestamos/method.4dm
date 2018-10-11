Case of 
	: (Form event:C388=On Load:K2:1)
		C_DATE:C307(vd_fecha_hasta)
		C_TEXT:C284(vt_usr_name)
		C_LONGINT:C283(vl_id_usr)
		_O_C_INTEGER:C282(vi_todo)
		C_BOOLEAN:C305(vb_modificacion_de_registros)
		
		vd_fecha_hasta:=!00-00-00!
		vt_usr_name:=""
		vl_id_usr:=0
		vb_modificacion_de_registros:=False:C215
		vi_todo:=0
		
		ARRAY LONGINT:C221(al_recnum_ptm;0)
		ARRAY DATE:C224(ad_fecha_hasta;0)
		ARRAY TEXT:C222(at_usuario_original;0)
		ARRAY TEXT:C222(at_titulo;0)
		ARRAY LONGINT:C221(al_numregistro;0)
		ARRAY BOOLEAN:C223(ab_transferir;0)
		
		READ ONLY:C145([BBL_Lectores:72])
		QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Regla:4="SYS";*)
		QUERY:C277([BBL_Lectores:72]; | ;[BBL_Lectores:72]ID:1<0)
		
		ARRAY LONGINT:C221(al_id_usr_sys;0)
		ARRAY TEXT:C222(at_nom_usr_sys;0)
		
		If (Records in selection:C76([BBL_Lectores:72])=0)
			BBLsys_LoadSystemUsers 
			READ ONLY:C145([BBL_Lectores:72])
			QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Regla:4="SYS";*)
			QUERY:C277([BBL_Lectores:72]; | ;[BBL_Lectores:72]ID:1<0)
		End if 
		SELECTION TO ARRAY:C260([BBL_Lectores:72]ID:1;al_id_usr_sys;[BBL_Lectores:72]NombreCompleto:3;at_nom_usr_sys)
		
	: (Form event:C388=On Close Box:K2:21)
		
		If (vb_modificacion_de_registros)
			If (Application type:C494=4D Remote mode:K5:5)
				$process_id:=Execute on server:C373("BBL_BajaMasivaPtmoPOST";128000;"BajaMasivaPtmoPOST")
			Else 
				$process_id:=New process:C317("BBL_BajaMasivaPtmoPOST";Pila_256K;"Baja Masiva de volúmenes")
			End if 
			
		End if 
		CANCEL:C270
		
End case 