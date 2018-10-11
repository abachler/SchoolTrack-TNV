//%attributes = {}
  // SYS_IsServerRunningAsWINService()
  // Por: Alberto Bachler: 31/03/13, 17:47:17
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_BOOLEAN:C305($b_esServicio)

C_TEXT:C284($t_systemProfile)

If (False:C215)
	C_BOOLEAN:C305(SYS_IsServerRunningAsWINService ;$0)
End if 


If (SYS_IsWindows )
	$b_esServicio:=False:C215
	$t_systemProfile:="C:\\Windows\\system32\\config\\systemprofile\\"
	$b_esServicio:=(System folder:C487(User preferences_user:K41:4)=$t_systemProfile)
	
	  // doble verificacion, por si acaso
	$b_esServicio:=$b_esServicio & (sys_IsAppRunningAsService =1)
	
	$0:=$b_esServicio
	
Else 
	$0:=False:C215
End if 
