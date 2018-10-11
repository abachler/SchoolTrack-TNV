
C_TEXT:C284($vt_nombreCampo)

$vt_nombreCampo:="Ítem Venta Directa"
vtMsg:="Si lo desea puede aplicar el cambio a los cargos ya generados/emitidos o bien sól"+"o para lo"+"s cargos que se generen de ahora en adelante."
vtDesc1:="La opción "+ST_Qte ($vt_nombreCampo)+" es modificada, pero sólo será aplicada a los nuevos "+"cargos que se generen."
vtDesc2:="Se asigna el cambio a los cargos ya generados/emitidos (sólo a los cargos no incl"+"uidos en "+"docu"+"mentos tributarios)."
vtBtn1:="Sólo para los nuevos cargos"
vtBtn2:="Aplicar también a los cargos ya generados/emitidos"
WDW_OpenDialogInDrawer (->[xxACT_GlosasExtraordinarias:5];"ACT_DLG_ModGExtras")
If (ok=1)
	Case of 
		: (r1=1)
			
		: (r2=1)
			
			C_LONGINT:C283($proc;$vl_id_item)
			$proc:=IT_UThermometer (1;0;"Aplicando cambio a cargos ya generados/emitidos...")
			READ WRITE:C146([ACT_Cargos:173])
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=[xxACT_Items:179]ID:1)
			APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]Venta_Directa:59:=Self:C308->)
			
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			IT_UThermometer (-2;$proc)
			LOG_RegisterEvt ("Configuración ítems: Campo "+ST_Qte ($vt_nombreCampo)+" modificado a: "+ST_Boolean2Str (Self:C308->;"Verdadero";"Falso"))
			
			
			
	End case 
End if 
  //  //20160223 JVP ticket 153095 
  //C_BOOLEAN($vb_codigo_interno)
  //$vb_codigo_interno:=Choose(ST_Boolean2Str (Self->;"Verdadero";"Falso")="Verdadero";True;False)
  //If (Not($vb_codigo_interno))
  //[xxACT_Items]Codigo_interno:=""
  //End if 
If (Self:C308->)
	If ([xxACT_Items:179]Meses_de_cargo:9#0)
		[xxACT_Items:179]Meses_de_cargo:9:=0
		ACTcfg_OpcionesItems ("ColoreaMeses")
	End if 
	ACTcfg_OpcionesItems ("MuestraAlerta")
End if 