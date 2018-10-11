//%attributes = {}
  //ACTcfg_TranslateDocsTribData

ARRAY TEXT:C222(atACT_Tipos;2)
atACT_Tipos{1}:=__ ("Impreso")
atACT_Tipos{2}:=__ ("Digital")
ACTcfg_LoadPrinters 
ACTcfg_LoadBolModels 
$Select:=__ ("Seleccionar...")
If (Find in array:C230(atACT_ModelosDoc;vtACT_ModRecibo)=-1)
	vtACT_ModRecibo:=$select
	vlACT_ModRecibo:=0
End if 
If (Find in array:C230(atACT_Categorias;vtACT_CatVR)=-1)
	vtACT_CatVR:=$select
	vlACT_CatVR:=0
End if 
If (Find in array:C230(atACT_Impresoras;vtACT_PrinterRecibo)=-1)
	vtACT_PrinterRecibo:=$select
End if 
For ($i;1;Size of array:C274(atACT_Cats))
	If (Find in array:C230(atACT_Categorias;atACT_Cats{$i})=-1)
		atACT_Cats{$i}:=$select
	End if 
	Case of 
		: (aiACT_Tipo{$i}=1)
			atACT_Tipo{$i}:=atACT_Tipos{1}
		: (aiACT_Tipo{$i}=2)
			atACT_Tipo{$i}:=atACT_Tipos{2}
		Else 
			atACT_Tipo{$i}:=$select
	End case 
	  //If (Find in array(atACT_Impresoras;atACT_Impresora{$i})=-1)
	  //atACT_Impresora{$i}:=$select
	  //End if 
	If (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$i})=-1)
		atACT_ModeloDoc{$i}:=$select
	End if 
End for 
  //ACTcfg_SaveConfig (8)