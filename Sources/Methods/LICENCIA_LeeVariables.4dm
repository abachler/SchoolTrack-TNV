//%attributes = {}
  // Licencia_LeeVariables()
  // Por: Alberto Bachler K.: 23-09-14, 14:59:53
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


READ ONLY:C145([xShell_ApplicationData:45])
QUERY:C277([xShell_ApplicationData:45];[xShell_ApplicationData:45]ProductName:16="Main")
FIRST RECORD:C50([xShell_ApplicationData:45])
<>vtXS_CountryCode:=[xShell_ApplicationData:45]Código_Pais:26
<>LDL_RegisterKey:=[xShell_ApplicationData:45]BitRecord:19
UNLOAD RECORD:C212([xShell_ApplicationData:45])