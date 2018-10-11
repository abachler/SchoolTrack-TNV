C_BOOLEAN:C305(vb_AplicarDesctos)
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		If (b1=1)
			vTitleDesctos:=__ ("Descuentos Porcentuales")
		Else 
			vTitleDesctos:=__ ("Descuentos Fijos")
		End if 
		ACTdesctos_DeclareArrays 
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		$date1:=DT_GetDateFromDayMonthYear (1;vl_Mes;vl_Año)
		$date2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año);vl_Mes;vl_año)
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		If (Records in set:C195($set)>0)
			OBJECT SET VISIBLE:C603(xALP_Desctos;True:C214)
			OBJECT SET VISIBLE:C603(*;"NoCuentas";False:C215)
			OBJECT SET VISIBLE:C603(*;"NoCargos";False:C215)
			OBJECT SET ENTERABLE:C238(vl_Mes;True:C214)
			OBJECT SET ENTERABLE:C238(vl_Año;True:C214)
			IT_SetButtonState (True:C214;->bReGenerarArea;->bMes)
			CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection1")
			ACTdesctos_BuildDesctosArea ($date1;$date2;"Selection1")
		Else 
			OBJECT SET VISIBLE:C603(xALP_Desctos;False:C215)
			OBJECT SET VISIBLE:C603(*;"NoCuentas";True:C214)
			OBJECT SET VISIBLE:C603(*;"NoCargos";False:C215)
			OBJECT SET ENTERABLE:C238(vl_Mes;False:C215)
			OBJECT SET ENTERABLE:C238(vl_Año;False:C215)
			IT_SetButtonState (False:C215;->bReGenerarArea;->bMes)
			OBJECT SET TITLE:C194(bOK;__ ("Cancelar"))
			vb_AplicarDesctos:=False:C215
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
