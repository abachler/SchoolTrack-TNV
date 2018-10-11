//%attributes = {}
  // BBLpat_fSave()
  // Por: Alberto Bachler: 17/09/13, 13:28:32
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
If (False:C215)
	C_LONGINT:C283(BBLpat_fSave ;$0)
End if 

$0:=0
If (USR_checkRights ("M";->[BBL_Lectores:72]))
	If (KRL_RegistroFueModificado (->[BBL_Lectores:72]))
		If (([BBL_Lectores:72]Grupo:2#"") & ([BBL_Lectores:72]Apellido_paterno:12#""))
			BBLpat_GeneraCodigoBarra   // el codigo de barra se regenera solo si es distinto del codigo barra previamente almacenado o si estaba vacío
			SAVE RECORD:C53([BBL_Lectores:72])
			$0:=1
		Else 
			BEEP:C151
			$0:=-1
		End if 
	End if 
End if 