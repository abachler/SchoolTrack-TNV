vi_PageNumber:=FORM Get current page:C276
Case of 
	: (vi_PageNumber=1)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		vi_step:=1
	: (vi_PageNumber=2)
		vi_step:=2
		_O_ENABLE BUTTON:C192(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (vi_PageNumber=3)
		vi_step:=3
		_O_ENABLE BUTTON:C192(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
	: (vi_PageNumber=4)
		_O_ENABLE BUTTON:C192(bPrev)
		_O_ENABLE BUTTON:C192(bNext)
		vi_step:=4
	: (vi_PageNumber=5)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
		$t:="La matriz de cargos "+vsACT_AsignedMatrix+" sera asignada a <universo>."+"\r\r"
		Case of 
			: (r1=1)
				$t:=$t+"Las cuentas corrientes que ya tengan matriz asignada la conservarán."
			: (r2=1)
				$t:=$t+vsACT_AsignedMatrix+" sera asignada a las cuentas cuya matriz actual es "+vsACT_AsignedMatrix2
			: (r3=1)
				$t:=$t+"Las matrices de cargo actualmente asignadas a esas cuentas serán "+"reemplazadas, cualesquiera que ellas sean."
		End case 
		$t:=Replace string:C233($t;"<universo>";String:C10(viACT_cuentas)+" cuentas corrientes")
		vtACT_ResumenAsistente:=$t
End case 