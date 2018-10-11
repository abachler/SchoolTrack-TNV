Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vt_TransDesde:=""
		vt_TransHasta:=""
		vd_TransDesde:=!00-00-00!
		vd_TransHasta:=!00-00-00!
		cb_1:=0
		cb_2:=0
		cb_3:=0
		cb_4:=0
		cb_5:=1
		cb_Todas:=1
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
