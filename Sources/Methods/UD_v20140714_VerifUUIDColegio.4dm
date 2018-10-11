//%attributes = {}
  // UD_v20140714_VerifUUIDColegio

  // Por: Alberto Bachler K.: 14-07-14, 16:56:19
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])

If (Not:C34(Util_isValidUUID ([Colegio:31]UUID:58)))
	$t_ignorar:=LICENCIA_ObtieneUUIDinstitucion 
End if 
