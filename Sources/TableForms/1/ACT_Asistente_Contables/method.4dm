Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		_O_DISABLE BUTTON:C193(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
		cbFacturacion:=0
		cbRecaudacion:=0
		cbResumidoR:=1
		cbResumidoF:=1
		cbAgrupadoDTF:=0
		cbNoEnDT:=0
		fo1:=1
		fo2:=0
		fo3:=0
		ro1:=1
		ro2:=0
		ro3:=0
		td1:=1
		td2:=0
		td3:=0
		IT_SetButtonState (False:C215;->fo1;->fo2;->fo3;->ro1;->ro2;->ro3;->cbResumidoF;->cbResumidoR;->td1;->td2;->td3)
		vi_PageNumber:=1
		vi_step:=1
		
		ARRAY TEXT:C222(aSoftwares;1)
		ARRAY LONGINT:C221(al_idsArchivosContables;1)
		aSoftwares{1}:="Softland"
		al_idsArchivosContables{1}:=0
		vSoftware:=aSoftwares{1}
		
		READ ONLY:C145([xxACT_ArchivosBancarios:118])
		  //20121124  RCH no se manejaba la contabilidad por id
		  //QUERY([xxACT_ArchivosBancarios];[xxACT_ArchivosBancarios]Tipo="Contabilidad";*)
		QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]id_forma_de_pago:13=-17;*)
		QUERY:C277([xxACT_ArchivosBancarios:118]; & ;[xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=True:C214)
		
		If (Records in selection:C76([xxACT_ArchivosBancarios:118])>0)
			FIRST RECORD:C50([xxACT_ArchivosBancarios:118])
			While (Not:C34(End selection:C36([xxACT_ArchivosBancarios:118])))
				APPEND TO ARRAY:C911(aSoftwares;[xxACT_ArchivosBancarios:118]Nombre:3)
				APPEND TO ARRAY:C911(al_idsArchivosContables;[xxACT_ArchivosBancarios:118]ID:1)
				NEXT RECORD:C51([xxACT_ArchivosBancarios:118])
			End while 
		End if 
		
		b1:=1
		b3:=0
		b5:=0
		b6:=0
		viAño:=Year of:C25(Current date:C33(*))
		viAño2:=viAño
		IT_SetButtonState (False:C215;->bMes)
		IT_SetEnterable (False:C215;0;->viAño)
		vi_SelectedMonth:=Month of:C24(Current date:C33(*))
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vt_Mes:=aMeses{vi_SelectedMonth}
		IT_SetEnterable (False:C215;0;->vt_Fecha1;->vt_Fecha2;->viAño2)
		IT_SetButtonState (False:C215;->bCalendar1;->bCalendar2)
		vd_Fecha1:=Current date:C33(*)
		vt_Fecha1:=String:C10(vd_Fecha1;7)
		vd_Fecha2:=Current date:C33(*)
		vt_Fecha2:=String:C10(vd_Fecha2;7)
		_O_DISABLE BUTTON:C193(cbAgrupadoDTF)
		_O_DISABLE BUTTON:C193(cbNoEnDT)
		
		cb_exportacionNormal:=0
		_O_DISABLE BUTTON:C193(cb_exportacionNormal)
		
		_O_DISABLE BUTTON:C193(td3)
		
		  //para generar archivo segun tipo de documento...
		ARRAY TEXT:C222(atACTwiz_Categorias;0)
		ARRAY LONGINT:C221(alACTwiz_Categorias;0)
		ARRAY LONGINT:C221($alDA_Return;0)
		C_TEXT:C284(vtACT_Documento)
		C_LONGINT:C283(vlACT_idDocumento)
		
		vtACT_Documento:=""
		vlACT_idDocumento:=0
		ACTcfg_LoadConfigData (8)
		
		COPY ARRAY:C226(atACT_Categorias;atACTwiz_Categorias)
		COPY ARRAY:C226(alACT_IDsCats;alACTwiz_Categorias)
		
		$vl_pos:=Find in array:C230(alACTwiz_Categorias;-2)
		If ($vl_pos#-1)
			AT_Delete ($vl_pos;1;->atACTwiz_Categorias;->alACTwiz_Categorias)
		End if 
		
		alACTwiz_Categorias{0}:=0
		AT_SearchArray (->alACTwiz_Categorias;">";->$alDA_Return)
		If (Size of array:C274($alDA_Return)>0)
			vtACT_Documento:=atACTwiz_Categorias{$alDA_Return{1}}
			vlACT_idDocumento:=alACTwiz_Categorias{$alDA_Return{1}}
		Else 
			$vl_pos:=Find in array:C230(alACTwiz_Categorias;-1)
			If ($vl_pos#-1)
				vtACT_Documento:=atACTwiz_Categorias{$vl_pos}
				vlACT_idDocumento:=alACTwiz_Categorias{$vl_pos}
			End if 
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		$el:=Find in array:C230(aSoftwares;vSoftware)
		If ($el#-1)
			If ((al_idsArchivosContables{$el}#0) & (cbFacturacion=1) & (cbResumidoF=0) & (td2=1))
				_O_ENABLE BUTTON:C192(cbAgrupadoDTF)
			Else 
				cbAgrupadoDTF:=0
				_O_DISABLE BUTTON:C193(cbAgrupadoDTF)
			End if 
			
			If ((al_idsArchivosContables{$el}#0) & (cbRecaudacion=1) & (cbResumidoR=0))
				_O_ENABLE BUTTON:C192(cb_exportacionNormal)
			Else 
				cb_exportacionNormal:=0
				_O_DISABLE BUTTON:C193(cb_exportacionNormal)
			End if 
			
			If ((al_idsArchivosContables{$el}#0) & (cbFacturacion=1))
				_O_ENABLE BUTTON:C192(td3)
			Else 
				If (td3=1)
					td1:=1
					td3:=0
				End if 
				_O_DISABLE BUTTON:C193(td3)
			End if 
			
			If (td2=1)
				OBJECT SET VISIBLE:C603(*;"tipoDoc@";True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"tipoDoc@";False:C215)
			End if 
			
			  //20140324 RCH items no en DT
			If ((al_idsArchivosContables{$el}=0) & (cbFacturacion=1) & (td1=1))
				_O_ENABLE BUTTON:C192(cbNoEnDT)
			Else 
				cbNoEnDT:=0
				_O_DISABLE BUTTON:C193(cbNoEnDT)
			End if 
			
		End if 
End case 
