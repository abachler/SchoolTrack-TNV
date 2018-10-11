//%attributes = {}
  // BBLitm_NormalizaEditores()
  // Por: Alberto Bachler: 17/09/13, 13:23:47
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

[BBL_Items:61]Editores:9:=ST_Format (->[BBL_Items:61]Editores:9)
[BBL_Items:61]Editores:9:=ST_ClearExtraCR ([BBL_Items:61]Editores:9)
If (Position:C15("\r";[BBL_Items:61]Editores:9)>0)
	[BBL_Items:61]Primer_editor:8:=Substring:C12([BBL_Items:61]Editores:9;1;Position:C15("\r";[BBL_Items:61]Editores:9)-1)
Else 
	[BBL_Items:61]Primer_editor:8:=[BBL_Items:61]Editores:9
End if 