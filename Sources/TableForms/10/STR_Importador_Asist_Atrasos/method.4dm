Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_TIME:C306(vh_hora;vh_hora_too_late)
		
		vt_g2:=OBJECT Get title:C1068(*;"texto")
		vt_g1:=""
		vt_g1Temp:=""
		cb_gen_inasistencias:=0  //generar inasistencias para los alumnos que no están en el archivo
		cb_gen_too_late:=False:C215
		vh_hora_too_late:=?10:30:00?
		op1:=1
		op2:=0
		
		If (SYS_IsMacintosh )
			r1:=1
			r2:=0
		Else 
			r1:=0
			r2:=1
		End if 
		
		cb_TieneEncabezado:=0
		vi_PageNumber:=1
		vi_Step:=1
		
		C_op1:=1
		C_op2:=0
		C_op3:=0
		C_op4:=0
		C_op5:=0
		
		hora_p:=1
		hora_m:=0
		
		OBJECT SET ENTERABLE:C238(vh_hora;True:C214)
		vh_hora:=?08:00:00?
		OBJECT SET VISIBLE:C603(vh_hora;False:C215)
		
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		_O_DISABLE BUTTON:C193(bImport)
		
		If (Application type:C494=4D Remote mode:K5:5)
			bc_ExecuteOnServer:=0
			OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;True:C214)
		Else 
			bc_ExecuteOnServer:=0
			OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;False:C215)
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 

Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		vi_Step:=1
	: (vi_PageNumber=2)
		_O_ENABLE BUTTON:C192(bPrev)
		vi_Step:=2
End case 

