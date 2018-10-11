//%attributes = {}
  //ACTcfg_LoadCargosEspeciales

C_LONGINT:C283($1;$accion)
$accion:=$1

C_TEXT:C284(vt_glosaImpIE)
C_REAL:C285(vr_noDctoTIE;vr_agruparACIE;vr_agruparDTIE;vr_afectoIVAIE)
C_TEXT:C284(vsACT_CtaInteresesIE;vsACT_CodInteresesIE;vsACT_CentroInteresesIE;vsACT_CCtaInteresesIE;vsACT_CCodInteresesIE;vsACT_CCentroInteresesIE)
C_REAL:C285(vl_idItemIE)
_O_C_INTEGER:C282(b1;b2;b3;b4)
C_TEXT:C284(vt_monedaIE)
C_REAL:C285(vr_montoIE)
C_LONGINT:C283(vl_idIE)
C_LONGINT:C283(vl_mesIE)
C_BOOLEAN:C305(vModificaCPCCS)
C_REAL:C285(vr_NoAfectoRecargoAut)
C_LONGINT:C283($l_eliminado)  //20130730 RCH
C_BLOB:C604(vx_CentroCostoXNivel)  //20131007 RCH

  //C_REAL(vr_montoEnPctIE)

vl_mesIE:=0
vl_idIE:=0
vt_monedaIE:=""
vr_montoIE:=0
vt_glosaImpIE:=""
vr_noDctoTIE:=0
vr_agruparACIE:=0
vr_agruparDTIE:=0
vsACT_CtaInteresesIE:=""
vsACT_CodInteresesIE:=""
vsACT_CentroInteresesIE:=""
vsACT_CCtaInteresesIE:=""
vsACT_CCodInteresesIE:=""
vsACT_CCentroInteresesIE:=""
vr_afectoIVAIE:=0
vl_idItemIE:=0
vr_NoAfectoRecargoAut:=0
b1:=0
b2:=0
b3:=0
b4:=0
SET BLOB SIZE:C606(vx_CentroCostoXNivel;0)

  //vr_montoEnPctIE:=0

REDUCE SELECTION:C351([xxACT_Items:179];0)

Case of 
	: ($accion=1)  //intereses
		READ WRITE:C146([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-100)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateInteresRecord 
		End if 
		b1:=Num:C11([xxACT_Items:179]UbicacionInteresGenerado:30 ?? 1)
		b2:=Num:C11([xxACT_Items:179]UbicacionInteresGenerado:30 ?? 2)
		b3:=Num:C11([xxACT_Items:179]UbicacionInteresGenerado:30 ?? 3)
		b4:=Num:C11([xxACT_Items:179]UbicacionInteresGenerado:30 ?? 4)
		If ((b1=0) & (b2=0) & (b3=0) & (b4=0))
			b1:=1
		End if 
		
		ACTcar_FechaCalculoIntereses ("LeeConf")  //20140825 RCH Intereses
		
	: ($accion=2)  //recargos por adelantado
		READ WRITE:C146([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-101)
		Case of 
			: (Records in selection:C76([xxACT_Items:179])=0)
				ACTinit_CreateDesctoXARecord 
			: (Records in selection:C76([xxACT_Items:179])>1)
				REDUCE SELECTION:C351([xxACT_Items:179];Records in selection:C76([xxACT_Items:179])-1)
				$l_eliminado:=KRL_DeleteSelection (->[xxACT_Items:179])
				If ($l_eliminado=0)
					LOG_RegisterEvt ("El ítem "+[xxACT_Items:179]Glosa:2+" no pudo ser eliminado.")
				End if 
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-101)
		End case 
		[xxACT_Items:179]Imputacion_Unica:24:=True:C214
		SAVE RECORD:C53([xxACT_Items:179])
		vr_montoIE:=[xxACT_Items:179]Monto:7
		vl_mesIE:=8190
		
	Else 
		ACTqry_CargoEspecial ($accion)
End case 

KRL_ReloadAsReadOnly (->[xxACT_Items:179])

If ($accion>0)
	vl_idIE:=[xxACT_Items:179]ID:1
	vl_idItemIE:=Record number:C243([xxACT_Items:179])
	vt_glosaImpIE:=[xxACT_Items:179]Glosa_de_Impresión:20
	vr_noDctoTIE:=Num:C11([xxACT_Items:179]No_incluir_en_DocTributario:31)
	vr_agruparACIE:=Num:C11([xxACT_Items:179]AgruparInteresesAC:33)
	vr_agruparDTIE:=Num:C11([xxACT_Items:179]AgruparInteresesDT:34)
	vsACT_CtaInteresesIE:=[xxACT_Items:179]No_de_Cuenta_Contable:15
	vsACT_CodInteresesIE:=[xxACT_Items:179]CodAuxCta:27
	vsACT_CentroInteresesIE:=[xxACT_Items:179]Centro_de_Costos:21
	vsACT_CCtaInteresesIE:=[xxACT_Items:179]No_CCta_contable:22
	vsACT_CCodInteresesIE:=[xxACT_Items:179]CodAuxCCta:28
	vsACT_CCentroInteresesIE:=[xxACT_Items:179]CCentro_de_costos:23
	vr_afectoIVAIE:=Num:C11([xxACT_Items:179]Afecto_IVA:12)
	vt_monedaIE:=[xxACT_Items:179]Moneda:10
	
	  //vr_montoEnPctIE:=Num([xxACT_Items]EsRelativo)
	
	vtACT_CPCCS:=[xxACT_Items:179]No_de_Cuenta_Contable:15
	vtACT_CAUXCC:=[xxACT_Items:179]CodAuxCta:27
	vtACT_CCCCS:=[xxACT_Items:179]Centro_de_Costos:21
	vtACT_CCPCCS:=[xxACT_Items:179]No_CCta_contable:22
	vtACT_CAUXCCC:=[xxACT_Items:179]CodAuxCCta:28
	vtACT_CCCCCS:=[xxACT_Items:179]CCentro_de_costos:23
	  //vr_NoAfectoRecargoAut:=Num([xxACT_Items]NoAfecto_a_RecargosAut)
	vr_NoAfectoRecargoAut:=Num:C11(([xxACT_Items:179]id_tipoRecargoAut:45=0))  //cuando esta en 0, el cargo no es afecto a recargos
	  //vb_imputacionUnica:=[xxACT_Items]Imputacion_Unica
	
	vx_CentroCostoXNivel:=[xxACT_Items:179]xCentro_Costo:41  //20131007 RCH
	
End if 
vModificaCPCCS:=False:C215