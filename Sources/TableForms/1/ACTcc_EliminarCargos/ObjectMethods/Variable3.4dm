vi_PageNumber:=FORM Get current page:C276
Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		vi_step:=1
	: (vi_PageNumber=2)
		vi_step:=2
		_O_ENABLE BUTTON:C192(bPrev)
		If ((b1=1) | ((b2=1) & (vsGlosab2#"")) | ((b3=1) & (vsGlosab3#"")) | ((b2=1) & (cbTodosb2=1)) | ((b3=1) & (cbTodosb3=1)))
			_O_ENABLE BUTTON:C192(bNext)
		Else 
			_O_DISABLE BUTTON:C193(bNext)
		End if 
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
		$t:=$t+"La eliminación se realizará para <universo>"+"\r"
		$t:=$t+"Se eliminarán cargos <periodos>."+"\r\r"
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
		$t:=Replace string:C233($t;"<universo>";$universo)
		If (vs1=vs2)
			If (vdACT_AñoAviso=vdACT_AñoAviso2)
				$periodo:="en el mes de "+vs1+" de "+String:C10(vdACT_AñoAviso)
			Else 
				$periodo:="entre los meses de "+vs1+" de "+String:C10(vdACT_AñoAviso)+" y "+vs2+" de "+String:C10(vdACT_AñoAviso2)
			End if 
		Else 
			$periodo:="desde el mes de "+vs1+" de "+String:C10(vdACT_AñoAviso)+" hasta el mes de "+vs2+" de "+String:C10(vdACT_AñoAviso2)
		End if 
		$t:=Replace string:C233($t;"<periodos>";$periodo)
		If (b1=1)
			$t:=$t+"Se eliminarán cargos sobre la base de las matrices de cargo "+"actualmente asignadas a esas cuentas."+"\r\r"
		End if 
		If (b2=1)
			If (cbTodosb2=1)
				$t:=$t+"Se eliminarán todos los cargos que no correspondan a las matrices asignadas a las"+" cuentas."+"\r\r"
			Else 
				$t:=$t+"Se eliminarán cargos basándose el la definición del item de cargo "+vsGlosab2+"."+"\r\r"
			End if 
		End if 
		vtACT_ResumenAsistente:=$t
End case 