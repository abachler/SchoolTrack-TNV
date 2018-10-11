//%attributes = {}
  //USR_BuildAccesTables

C_LONGINT:C283($itemRef;$listRef)
C_TEXT:C284($module)

C_TEXT:C284(<>vtXS_Langage)

If (<>vtXS_Langage="")
	READ ONLY:C145([Colegio:31])
	ALL RECORDS:C47([Colegio:31])
	FIRST RECORD:C50([Colegio:31])
	Case of 
		: ((Records in selection:C76([Colegio:31])=0) | ([Colegio:31]Codigo_Pais:31=""))
			<>vtXS_langage:="es"
		: ([Colegio:31]Codigo_Pais:31="br")
			<>vtXS_langage:="pt"
		Else 
			<>vtXS_langage:="es"
	End case 
End if 

  //Tables with restricted acces
ARRAY REAL:C219(<>aPriv;0)
ARRAY TEXT:C222(<>aPrivN;0)
QUERY:C277([xShell_Tables:51];[xShell_Tables:51]AccesoProtegido:32=True:C214)
SELECTION TO ARRAY:C260([xShell_Tables:51]NumeroDeTabla:5;$tableNumber;[xShell_Tables:51]ReferenciaModulo:36;$aModuleRef)
ARRAY REAL:C219(<>aPriv;Records in selection:C76([xShell_Tables:51]))
ARRAY TEXT:C222(<>aPrivN;Records in selection:C76([xShell_Tables:51]))

$listRef:=Load list:C383("XS_Modules")

For ($i;1;Size of array:C274($tableNumber))
	<>aPriv{$i}:=$tableNumber{$i}
	<>aPrivN{$i}:=XSvs_nombreTablaLocal_Numero ($tableNumber{$i};<>vtXS_CountryCode;<>vtXS_Langage)
	SELECT LIST ITEMS BY REFERENCE:C630($listRef;$aModuleRef{$i})
	GET LIST ITEM:C378($listRef;*;$itemRef;$module)
	<>aPrivN{$i}:=$module+": "+<>aPrivN{$i}
End for 

ARRAY TEXT:C222(<>ATUSR_METHODNAMES;0)
ARRAY TEXT:C222(<>atUSR_Commands;0)
ARRAY TEXT:C222(<>aProcName;0)
READ ONLY:C145([xShell_ExecutableCommands:19])
QUERY:C277([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]PermissionRequired:6=True:C214)
SELECTION TO ARRAY:C260([xShell_ExecutableCommands:19]MethodName:2;<>atUSR_MethodNames;[xShell_ExecutableCommands:19];$aRecNums)
ARRAY TEXT:C222(<>atUSR_Commands;Size of array:C274(<>atUSR_MethodNames))
For ($i;1;Size of array:C274($aRecNums))
	<>atUSR_Commands{$i}:=ST_GetWord (XS_GetCommandAliasDescription ($aRecNums{$i};<>vtXS_CountryCode;<>vtXS_Langage);1;"\t")
End for 
SORT ARRAY:C229(<>atUSR_Commands;<>atUSR_MethodNames;>)