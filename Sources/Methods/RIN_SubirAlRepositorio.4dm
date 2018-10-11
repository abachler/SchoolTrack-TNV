//%attributes = {}
  // RIN_SubirAlRepositorio()
  // Por: Alberto Bachler K.: 13-08-14, 09:50:21
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)


If (False:C215)
	C_TEXT:C284(RIN_SubirAlRepositorio ;$0)
End if 

KRL_ReloadInReadWriteMode (->[xShell_Reports:54])
WDW_OpenFormWindow (->[xShell_Reports:54];"EnvioRepositorio";-1;8)
DIALOG:C40([xShell_Reports:54];"EnvioRepositorio")
CLOSE WINDOW:C154
If (OK=1)
	$0:=[xShell_Reports:54]DTS_Repositorio:45
Else 
	$0:=""
End if 