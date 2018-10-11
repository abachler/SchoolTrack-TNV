  // [xShell_UserGroups].Input.List Box()
  // Por: Alberto Bachler K.: 03-08-15, 17:01:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Double Clicked:K2:5))
	$file:=Int:C8(<>aUserPriv{<>aPictPriv})
	$acces:=Dec:C9(<>aUserPriv{<>aPictPriv})*10
	If ($acces<4)
		$acces:=$acces+1
		<>aUserPriv{<>aPictPriv}:=$file+($acces/10)
	Else 
		$acces:=0
		<>aUserPriv{<>aPictPriv}:=$file
	End if 
	$acces:=20000+$acces
	GET PICTURE FROM LIBRARY:C565($acces;$pict)
	<>aPictPriv{<>aPictPriv}:=$pict
	<>aPictPriv:=0
End if 