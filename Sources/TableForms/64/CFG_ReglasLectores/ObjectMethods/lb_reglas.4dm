  // [xxBBL_ReglasParaUsuarios].CFG_ReglasLectores.List Box()
  // Por: Alberto Bachler K.: 14-07-14, 15:59:28
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If ((<>aPrefusrName>0) & (<>aPrefusr{<>aPrefusrName}#[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1))
	If (KRL_RegistroFueModificado (->[xxBBL_ReglasParaUsuarios:64]))
		If ([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1#"")
			SAVE RECORD:C53([xxBBL_ReglasParaUsuarios:64])
		End if 
	End if 
	READ WRITE:C146([xxBBL_ReglasParaUsuarios:64])
	QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1=<>aPrefusr{<>aPrefusr})
End if 