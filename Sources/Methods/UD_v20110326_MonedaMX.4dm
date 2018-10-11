//%attributes = {}
  //UD_v20110326_MonedaMX 
  //hay  bases que tienen el peso chileno de moneda por defecto...

If (ACT_AccountTrackInicializado )
	If (<>vtXS_CountryCode="mx")
		READ WRITE:C146([Colegio:31])
		ALL RECORDS:C47([Colegio:31])
		FIRST RECORD:C50([Colegio:31])
		[Colegio:31]Moneda:49:=ACT_DivisaPais 
		KRL_SaveUnLoadReadOnly (->[Colegio:31])
	End if 
End if 