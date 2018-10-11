Case of 
	: (Form event:C388=On Load:K2:1)
		
		C_LONGINT:C283(rb_actual0;rb_otro1;rb_otro2;rb_noEmitir;rb_publicoGeneral)
		C_TEXT:C284(t_otroApoderado;t_otroTercero)
		
		C_LONGINT:C283(l_idResponsable)
		
		C_LONGINT:C283(l_idApdoSel;l_idTerSel)
		
		rb_actual0:=0
		rb_otro1:=0
		rb_otro2:=0
		rb_noEmitir:=0
		rb_publicoGeneral:=0
		
		l_idApdoSel:=0
		l_idTerSel:=0
		
		t_otroApoderado:=""
		t_otroTercero:=""
		
		If (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
			Case of 
				: ([Personas:7]ACT_ReceptorDT_Tipo:112=0)
					rb_actual0:=1
				: ([Personas:7]ACT_ReceptorDT_Tipo:112=1)
					rb_otro1:=1
					l_idApdoSel:=[Personas:7]ACT_ReceptorDT_id_Apdo:113
				: ([Personas:7]ACT_ReceptorDT_Tipo:112=2)
					rb_otro2:=1
					l_idTerSel:=[Personas:7]ACT_ReceptorDT_id_Ter:114
				: ([Personas:7]ACT_ReceptorDT_Tipo:112=3)
					rb_publicoGeneral:=1
				: ([Personas:7]ACT_ReceptorDT_Tipo:112=4)
					rb_noEmitir:=1
			End case 
		Else 
			If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
				
				Case of 
					: ([ACT_Terceros:138]ReceptorDT_tipo:76=0)
						rb_actual0:=1
					: ([ACT_Terceros:138]ReceptorDT_tipo:76=1)
						rb_otro1:=1
						l_idApdoSel:=[ACT_Terceros:138]ReceptorDT_id_apoderado:78
					: ([ACT_Terceros:138]ReceptorDT_tipo:76=2)
						rb_otro2:=1
						l_idTerSel:=[ACT_Terceros:138]ReceptorDT_id_tercero:77
					: ([ACT_Terceros:138]ReceptorDT_tipo:76=3)
						rb_publicoGeneral:=1
					: ([ACT_Terceros:138]ReceptorDT_tipo:76=4)
						rb_noEmitir:=1
				End case 
			End if 
		End if 
		
		If ((rb_actual0=0) & (rb_otro1=0) & (rb_otro2=0) & (rb_noEmitir=0) & (rb_publicoGeneral=0))
			rb_actual0:=1
			l_idApdoSel:=0
			l_idTerSel:=0
		End if 
		
		If (l_idApdoSel#0)
			t_otroApoderado:=KRL_GetTextFieldData (->[Personas:7]No:1;->l_idApdoSel;->[Personas:7]Apellidos_y_nombres:30)
		End if 
		
		If (l_idTerSel#0)
			t_otroTercero:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->l_idTerSel;->[ACT_Terceros:138]Nombre_Completo:9)
		End if 
		
		OBJECT SET ENABLED:C1123(t_otroApoderado;False:C215)
		OBJECT SET ENABLED:C1123(t_otroTercero;False:C215)
		Case of 
			: (rb_actual0=1)
			: (rb_otro1=1)
				OBJECT SET ENABLED:C1123(t_otroApoderado;True:C214)
			: (rb_otro2=1)
				OBJECT SET ENABLED:C1123(t_otroTercero;True:C214)
			: (rb_noEmitir=1)
			: (rb_publicoGeneral=1)
		End case 
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		
		OBJECT SET ENABLED:C1123(t_otroApoderado;False:C215)
		OBJECT SET ENABLED:C1123(t_otroTercero;False:C215)
		
		Case of 
			: (rb_actual0=1)
				l_idApdoSel:=0
				l_idTerSel:=0
				t_otroApoderado:=""
				t_otroTercero:=""
				
			: (rb_otro1=1)
				l_idTerSel:=0
				t_otroTercero:=""
				OBJECT SET ENABLED:C1123(t_otroApoderado;True:C214)
				
			: (rb_otro2=1)
				l_idApdoSel:=0
				t_otroApoderado:=""
				OBJECT SET ENABLED:C1123(t_otroTercero;True:C214)
				
			: (rb_publicoGeneral=1)
				l_idApdoSel:=0
				l_idTerSel:=0
				t_otroApoderado:=""
				t_otroTercero:=""
				
			: (rb_noEmitir=1)
				l_idApdoSel:=0
				l_idTerSel:=0
				t_otroApoderado:=""
				t_otroTercero:=""
				
		End case 
		
		$b_habilitar:=True:C214
		Case of 
			: (rb_actual0=1)
			: (rb_otro1=1)
				If (t_otroApoderado="")
					$b_habilitar:=False:C215
				End if 
			: (rb_otro2=1)
				If (t_otroTercero="")
					$b_habilitar:=False:C215
				End if 
			: (rb_publicoGeneral=1)
			: (rb_noEmitir=1)
		End case 
		OBJECT SET ENABLED:C1123(btn_aceptar;$b_habilitar)
		
End case 
