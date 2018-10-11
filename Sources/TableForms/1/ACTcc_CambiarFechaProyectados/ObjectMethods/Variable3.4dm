vi_PageNumber:=FORM Get current page:C276
Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		vi_step:=1
	: (vi_PageNumber=2)
		vi_step:=2
		_O_ENABLE BUTTON:C192(bPrev)
		IT_SetButtonState (((b2=1) & ((cbTodosb2=1) | (viACT_IDItem#0)));->bNext)
	: (vi_PageNumber=3)
		vi_step:=3
		_O_ENABLE BUTTON:C192(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (vi_PageNumber=4)
		vi_step:=4
		_O_ENABLE BUTTON:C192(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (vi_PageNumber=5)
		_O_ENABLE BUTTON:C192(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
		If (Application type:C494#4D Remote mode:K5:5)
			OBJECT SET VISIBLE:C603(*;"server@";False:C215)
			bc_ExecuteOnServer:=0
		Else 
			OBJECT SET VISIBLE:C603(*;"server@";True:C214)
			bc_ExecuteOnServer:=1
		End if 
		$t:=""
		$t:=$t+"El cambio de fechas se realizará para <universo>"+"\r\r"
		Case of 
			: (f1=1)
				If (r1=1)
					$universo:="las "+String:C10(viACT_cuentas4)+" cuentas explícitamente seleccionadas en el explorador, cualquiera sea la matriz"+" asignada."
				Else 
					$universo:="las "+String:C10(viACT_cuentas5)+" cuentas explícitamente seleccionadas en el explorador, "+"que tengan asignada la matriz "+vsACT_AsignedMatrix2+"."
				End if 
			: (f2=1)
				If (r1=1)
					$universo:="las "+String:C10(viACT_cuentas4)+" cuentas listadas en el explorador, cualquiera sea la matriz "+"asignada."
				Else 
					$universo:="las "+String:C10(viACT_cuentas5)+" cuentas listadas en el explorador, "+"que tengan asignada la matriz "+vsACT_AsignedMatrix2+"."
				End if 
			: (f3=1)
				If (r1=1)
					$universo:="las "+String:C10(viACT_cuentas4)+" cuentas activas, cualquiera sea la matriz "+"asignada."
				Else 
					$universo:="las "+String:C10(viACT_cuentas5)+" cuentas activas, "+"que tengan asignada la matriz "+vsACT_AsignedMatrix2+"."
				End if 
		End case 
		$t:=Replace string:C233($t;"<universo>";$universo)+"\r\r"
		Case of 
			: (vFecha1=vFecha2)
				$periodo:="Los cargos con fecha de generación "+vFecha1+" serán cambiados a "+vFecha3+"."
			: (vFecha1#vFecha2)
				$periodo:="Los cargos con fechas de generación entre "+vFecha1+" y "+vFecha2+" serán cambiados a "+vFecha3+"."
		End case 
		$t:=$t+$periodo+"\r\r"
		If (cbTodosb2=1)
			$t:=$t+"Se cambiará la fecha de todos los cargos."
		Else 
			$t:=$t+"Se cambiará la fecha de los cargos basándose en la definición del item de cargo "+vsGlosab2+"."
		End if 
		vtACT_ResumenAsistente:=$t
End case 