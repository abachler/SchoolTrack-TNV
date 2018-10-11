Case of 
	: (Form event:C388=On Load:K2:1)
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		If (Self:C308->>0)
			sCurso:=Self:C308->{Self:C308->}
		Else 
			sCurso:=""
		End if 
		$nivelCurso:=<>aCUNivNo{Self:C308->}
		$modoRegistroAtrasos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelCurso;->[xxSTR_Niveles:6]Lates_Mode:16)
		If ($modoRegistroAtrasos=3)
			CD_Dlog (0;__ ("Este nivel no ha sido configurado para el ingreso diario de atrasos."))
			sCurso:=""
		End if 
		If (sCurso#"")
			PERIODOS_LoadData ($nivelCurso)
			OBJECT SET ENTERABLE:C238(dDate;True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(dDate;False:C215)
		End if 
		If ((sCurso="") | (dDate=!00-00-00!))
			OBJECT SET ENTERABLE:C238(sName;False:C215)
			GOTO OBJECT:C206(xALP_Anot)
		Else 
			PERIODOS_LoadData ($nivelCurso)
			OBJECT SET ENTERABLE:C238(sName;True:C214)
		End if 
		
		$r:=DateIsValid (dDate;0)
		If (dDate#!00-00-00!)
			If (Not:C34($r))
				dDate:=!00-00-00!
				GOTO OBJECT:C206(dDate)
			End if 
		End if 
		
	: (Form event:C388=On Unload:K2:2)
		
End case 

$nivelCurso:=<>aCUNivNo{Self:C308->}
$modoRegistroInasistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelCurso;->[xxSTR_Niveles:6]AttendanceMode:3)
If ($modoRegistroInasistencia=3)
	CD_Dlog (0;__ ("Este nivel no ha sido configurado para el ingreso diario de atrasos."))
	sCurso:=""
End if 
