//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 31-01-18, 13:00:47
  //MONO 184433
  // ----------------------------------------------------
  // Método: NIV_AbrirAsistentePromocion
If ((Application type:C494#4D Remote mode:K5:5) & (Application type:C494#4D Server:K5:6))
	WDW_OpenFormWindow (->[xxSTR_Niveles:6];"PromoverNivel";0;5;__ ("Asistente de Promoción de Niveles"))
	DIALOG:C40([xxSTR_Niveles:6];"PromoverNivel")
	CLOSE WINDOW:C154
Else 
	CD_Dlog (0;__ ("Esta funcionalidad debe ejecutarse en SchoolTrack MonoUsuario"))
End if 