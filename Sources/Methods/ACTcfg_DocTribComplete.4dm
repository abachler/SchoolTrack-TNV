//%attributes = {}
  //ACTcfg_DocTribComplete

$row:=$1
$l_tipoDoc:=$2  //20140708 RCH Para colorear
$Select:=__ ("Seleccionar...")

$0:=True:C214

If (atACT_Cats{$row}=$Select)
	$0:=False:C215
End if 
If (atACT_NombreDoc{$row}="")
	$0:=False:C215
End if 
If ($l_tipoDoc=1)
	If (alACT_Proxima{$row}=0)
		$0:=False:C215
	End if 
End if 
If (atACT_Tipo{$row}=$Select)
	$0:=False:C215
End if 
If (atACT_Impresora{$row}=$Select)
	$0:=False:C215
End if 
If (atACT_ModeloDoc{$row}=$Select)
	$0:=False:C215
End if 