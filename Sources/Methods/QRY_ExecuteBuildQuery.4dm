//%attributes = {}
  // QRY_ExecuteBuildQuery()
  // Por: Alberto Bachler: 08/03/13, 18:05:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($l_indiceConectorLogico;$l_registrosEncontrados;$i;$l_indiceOperador)

ARRAY INTEGER:C220($al_campoRelacionado_Destino;0)
ARRAY INTEGER:C220($al_campoRelacionado_Origen;0)
ARRAY INTEGER:C220($al_TablaRelacionada;0)
If (False:C215)
	C_LONGINT:C283(QRY_ExecuteBuildQuery ;$0)
	C_TEXT:C284(QRY_ExecuteBuildQuery ;$1)
End if 
C_POINTER:C301(fieldP)
C_LONGINT:C283(bCurrentYearOnly)
C_BOOLEAN:C305(vb_ConsultaMultiAño)


bSrchSel:=0
QRY_LoadLogicalConectorsArray 
QRY_LoadOperatorsArray 
ARRAY TEXT:C222(at_NombreTablaRelacionada;0)
READ ONLY:C145([xShell_Tables:51])
READ ONLY:C145([xShell_Queries:53])

$0:=-1

QUERY:C277([xShell_Queries:53];[xShell_Queries:53]FileNo:5=(Table:C252(vyQRY_TablePointer)))
QUERY SELECTION:C341([xShell_Queries:53];[xShell_Queries:53]Name:2=$1)
If (Records in selection:C76([xShell_Queries:53])=1)
	USR_RegisterUserEvent (UE_ExecSavedQuery;vlBWR_SelectedTableRef)
	
	If ([xShell_Queries:53]Executable_method:8#"")
		ARRAY TEXT:C222(atQR_ExecuteCommands;0)
		OK:=1
		AT_Text2Array (->atQR_ExecuteCommands;[xShell_Queries:53]Executable_method:8;Char:C90(Carriage return:K15:38))
		For ($i;1;Size of array:C274(atQR_ExecuteCommands))
			If (Application version:C493>="0800")
				atQR_ExecuteCommands{$i}:=Replace string:C233(atQR_ExecuteCommands{$i};"Automatic Relations";"Set Automatic Relations")
			End if 
			EXECUTE FORMULA:C63(atQR_ExecuteCommands{$i})
		End for 
		ARRAY TEXT:C222(atQR_ExecuteCommands;0)
		$l_registrosEncontrados:=Records in selection:C76(vyQRY_TablePointer->)
	Else 
		$l_registrosEncontrados:=QRY_ExecuteQuery_Blob (vyQRY_TablePointer;[xShell_Queries:53]xFormula:9)
	End if 
End if 

$0:=$l_registrosEncontrados