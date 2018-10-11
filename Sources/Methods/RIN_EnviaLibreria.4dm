//%attributes = {}
  // RIN_EnviaLibreria()
  // Por: Alberto Bachler K.: 01-08-14, 09:49:41
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_idTermometro)

ARRAY LONGINT:C221($al_RecNums;0)

QUERY:C277([xShell_Reports:54];[xShell_Reports:54]EnRepositorio:48=True:C214;*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]IsStandard:38=True:C214)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]DTS_UltimaModificacion:46>="20160321@")


LONGINT ARRAY FROM SELECTION:C647([xShell_Reports:54];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;__ ("Enviando libreria de informes al repositorio..."))
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([xShell_Reports:54];$al_RecNums{$i_registros})
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums);__ ("Enviando libreria de informes al repositorio...")+"\r"+[xShell_Reports:54]ReportName:26)
	RIN_EnviaInforme ("Reemplazo de comandos 4D obsoletos")
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[xShell_Reports:54])


