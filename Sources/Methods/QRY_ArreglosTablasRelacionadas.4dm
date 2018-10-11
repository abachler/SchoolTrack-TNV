//%attributes = {}
  // QRY_ArreglosTablasRelacionadas()
  // Por: Alberto Bachler: 03/04/13, 11:07:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_tablaAccesible)
C_LONGINT:C283($i)
C_TEXT:C284($t_nombreTabla)

ARRAY INTEGER:C220($al_campoRelacionado_Destino;0)
ARRAY INTEGER:C220($al_campoRelacionado_Origen;0)
ARRAY INTEGER:C220($al_TablaRelacionada;0)
If (False:C215)
	C_BOOLEAN:C305(QRY_ArreglosTablasRelacionadas ;$0)
End if 

$b_tablaAccesible:=True:C214
ARRAY TEXT:C222(at_NombreTablaRelacionada;0)
ARRAY INTEGER:C220(al_TablaRelacionada;0)
ARRAY INTEGER:C220(al_campoRelacionado_Origen;0)
ARRAY INTEGER:C220(al_campoRelacionado_Destino;0)
READ ONLY:C145([xShell_Tables_RelatedFiles:243])
QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11=Table:C252(vyQRY_TablePointer))
SELECTION TO ARRAY:C260([xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;$al_TablaRelacionada;[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3;$al_campoRelacionado_Origen;[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4;$al_campoRelacionado_Destino)
For ($i;1;Size of array:C274($al_TablaRelacionada))
	$t_nombreTabla:=XSvs_nombreTablaLocal_Numero ($al_TablaRelacionada{$i})
	If (($t_nombreTabla#"") & (Find in array:C230(at_NombreTablaRelacionada;$t_nombreTabla)=-1))
		If (USR_checkRights ("L";Table:C252($al_TablaRelacionada{$i})))
			APPEND TO ARRAY:C911(at_NombreTablaRelacionada;$t_nombreTabla)
			APPEND TO ARRAY:C911(al_campoRelacionado_Origen;$al_campoRelacionado_Origen{$i})
			APPEND TO ARRAY:C911(al_TablaRelacionada;$al_TablaRelacionada{$i})
			APPEND TO ARRAY:C911(al_campoRelacionado_Destino;$al_campoRelacionado_Destino{$i})
		Else 
			$b_tablaAccesible:=False:C215
		End if 
	End if 
End for 
SORT ARRAY:C229(at_NombreTablaRelacionada;al_campoRelacionado_Origen;al_TablaRelacionada;al_campoRelacionado_Destino;>)
AT_Insert (1;1;->at_NombreTablaRelacionada;->al_campoRelacionado_Origen;->al_TablaRelacionada;->al_campoRelacionado_Destino)
at_NombreTablaRelacionada{1}:=XSvs_nombreTablaLocal_Numero (Table:C252(vyQRY_TablePointer))
al_TablaRelacionada{1}:=Table:C252(vyQRY_TablePointer)
at_NombreTablaRelacionada:=1

$0:=$b_tablaAccesible