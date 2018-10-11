$r:=CD_Dlog (0;__ ("El cambio de condición del item de cargo es imposible de deshacer.\r\r¿Desea continuar?");"";__ ("No");__ ("Si"))
If ($r=2)
	IT_SetEnterable (False:C215;0;->[xxACT_Items:179]EsRelativo:5;->[xxACT_Items:179]EsDescuento:6;->[xxACT_Items:179]AfectoDsctoIndividual:17;->[xxACT_Items:179]Afecto_a_descuentos:4;->[xxACT_Items:179]Reembolsable:18;->[xxACT_Items:179]Item_Global:13)
	ACTcfg_Habilitatramoshijos (False:C215;False:C215)
	For ($i;1;12)
		[xxACT_Items:179]Meses_de_cargo:9:=[xxACT_Items:179]Meses_de_cargo:9 ?- $i
		OBJECT SET COLOR:C271(*;"mes"+String:C10($i);-3)
	End for 
	OBJECT SET VISIBLE:C603(bDisableMeses;True:C214)
	[xxACT_Items:179]VentaRapida:3:=True:C214
	ACTcfg_SaveItemdeCargo 
Else 
	j1:=1
	j2:=0
End if 