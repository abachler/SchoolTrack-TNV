//%attributes = {}
  //ACTcfg_LoadPrinters
C_LONGINT:C283($err;$i)

ARRAY TEXT:C222($at_modelos;0)
ARRAY TEXT:C222($at_nombreImpresoras;0)
ARRAY TEXT:C222($at_ubicacionImpresoras;0)

PRINTERS LIST:C789($at_nombreImpresoras;$at_ubicacionImpresoras;$at_modelos)


ARRAY TEXT:C222(atACT_Impresoras;0)
ARRAY TEXT:C222(atACT_PrinterNames;0)
ARRAY TEXT:C222(atACT_SystemPrinters;0)
If (SYS_IsWindows )
	$err:=sys_EnumPrinters (atACT_SystemPrinters;EP_USE_REGISTRY)
	AT_RedimArrays (Size of array:C274(atACT_SystemPrinters);->atACT_PrinterNames)
	For ($i;1;Size of array:C274(atACT_SystemPrinters))
		atACT_PrinterNames{$i}:=ST_GetWord (atACT_SystemPrinters{$i};1;",")
	End for 
	COPY ARRAY:C226($at_nombreImpresoras;atACT_Impresoras)
Else 
	PRINTERS LIST:C789(atACT_Impresoras)
	COPY ARRAY:C226(atACT_Impresoras;atACT_PrinterNames)
End if 