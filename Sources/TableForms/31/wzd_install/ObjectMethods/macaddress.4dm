  // [Colegio].wzd_install.macaddress()
  // Por: Alberto Bachler K.: 10-10-14, 10:59:13
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_item:=Pop up menu:C542(__ ("Copiar"))
If ($l_item>0)
	SET TEXT TO PASTEBOARD:C523(OBJECT Get title:C1068(*;OBJECT Get name:C1087(Object current:K67:2)))
End if 
