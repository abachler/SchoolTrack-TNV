//%attributes = {}
  //ACTcc_DuplicaCargoDcto

C_LONGINT:C283($vl_idItemEspecial;$vl_idCargoOrig;$vl_idCargoRel)
C_REAL:C285($vr_dcto;$montonetodsctos;$vr_montoTotal)
C_LONGINT:C283($vl_decimales)
C_BOOLEAN:C305($vb_noEliminarCargosAsoc)
C_TEXT:C284($vt_glosa;$vt_monedaCargo)
C_LONGINT:C283($l_idItemDcto)
C_LONGINT:C283($0)
C_REAL:C285($r_descuentoYaAplicado)
C_LONGINT:C283($l_idDescuento)
C_TEXT:C284($vt_monedaConta)
C_LONGINT:C283($l_pos)
C_LONGINT:C283($l_idTercero)  // Modificado por: Saúl Ponce (11/10/2017) Ticket 188310, para que no se elimine el documento de cargo del 3ro

$vl_idItemEspecial:=$1
$vl_idCargoOrig:=$2
$vr_dcto:=$3
If (Count parameters:C259>=4)
	$vb_noEliminarCargosAsoc:=$4
End if 
If (Count parameters:C259>=5)
	$vt_glosa:=$5
End if 
If (Count parameters:C259>=6)
	$l_idItemDcto:=$6
End if 
If (Count parameters:C259>=7)
	$r_descuentoYaAplicado:=$7
End if 
If (Count parameters:C259>=8)
	$l_idDescuento:=$8
End if 
If (Count parameters:C259>=9)
	$l_pos:=$9
End if 

READ WRITE:C146([ACT_Cargos:173])
GOTO RECORD:C242([ACT_Cargos:173];$vl_idCargoOrig)
$l_idCargo:=[ACT_Cargos:173]ID:1

$l_idTercero:=[ACT_Cargos:173]ID_Tercero:54  // Modificado por: Saúl Ponce (11/10/2017) Ticket 188310

  //20121222 RCH
  //$vt_monedaCargo:=[ACT_Cargos]Moneda
$vt_monedaCargo:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";"))
$vl_idCargoRel:=[ACT_Cargos:173]ID:1
$vr_montoTotal:=[ACT_Cargos:173]Monto_Neto:5
$vr_montoTotal2:=[ACT_Cargos:173]Monto_Neto:5
$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo))

If ($r_descuentoYaAplicado#0)
	$vr_montoTotal:=Round:C94([ACT_Cargos:173]Monto_Neto:5-$r_descuentoYaAplicado;$vl_decimales)
End if 

$0:=-1

  //ACTcfg_LoadCargosEspeciales ($vl_idItemEspecial)
READ ONLY:C145([xxACT_Items:179])
If ($vl_idItemEspecial#0)
	ACTqry_CargoEspecial ($vl_idItemEspecial)
Else 
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$l_idItemDcto)
End if 

If ($vl_idCargoRel#0)
	If (Not:C34($vb_noEliminarCargosAsoc))
		  //QUERY([ACT_Cargos];[ACT_Cargos]Ref_Item=[xxACT_Items]ID;*)
		  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]ID_CargoRelacionado=$vl_idCargoRel)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$vl_idCargoRel;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Tercero:54=$l_idTercero;*)  // Modificado por: Saúl Ponce (11/10/2017) Ticket 188310, para que no se elimine el documento de cargo del 3ro
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7=!00-00-00!)
		  //DELETE SELECTION([ACT_Cargos])
		ACTcc_EliminaCargosLoop 
	End if 
	If ($vr_dcto#0)
		GOTO RECORD:C242([ACT_Cargos:173];$vl_idCargoOrig)
		DUPLICATE RECORD:C225([ACT_Cargos:173])
		  //[ACT_Cargos]ID:=SQ_SeqNumber (->[ACT_Cargos]ID) // Modificado por: Saúl Ponce (11/10/2017) Ticket 188310, La asignación de id se realiza en el trigger
		[ACT_Cargos:173]Auto_UUID:66:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
		[ACT_Cargos:173]Monto_Neto:5:=$vr_dcto
		[ACT_Cargos:173]Ref_Item:16:=[xxACT_Items:179]ID:1
		[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
		[ACT_Cargos:173]ID_CargoRelacionado:47:=$vl_idCargoRel
		[ACT_Cargos:173]Monto_Moneda:9:=[ACT_Cargos:173]Monto_Neto:5
		[ACT_Cargos:173]Afecto_a_Descuentos:19:=False:C215
		  //[ACT_Cargos]PctDescuentoAplicado:=0
		If ([ACT_Cargos:173]TasaIVA:21#0)
			[ACT_Cargos:173]Monto_Bruto:24:=Round:C94([ACT_Cargos:173]Monto_Neto:5/<>vrACT_FactorIVA;$vl_decimales)
			$montonetodsctos:=[ACT_Cargos:173]Monto_Neto:5
			[ACT_Cargos:173]TasaIVA:21:=<>vrACT_TasaIVA
			$afecto:=$montonetodsctos/<>vrACT_FactorIVA
			[ACT_Cargos:173]Monto_IVA:20:=Round:C94($afecto*<>vrACT_TasaIVA/100;$vl_decimales)
			[ACT_Cargos:173]Monto_Neto:5:=$montonetodsctos
			[ACT_Cargos:173]Monto_Afecto:27:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Monto_IVA:20
		Else 
			[ACT_Cargos:173]TasaIVA:21:=0
			[ACT_Cargos:173]Monto_Afecto:27:=0
			[ACT_Cargos:173]Monto_IVA:20:=0
			[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
			[ACT_Cargos:173]Monto_Neto:5:=[ACT_Cargos:173]Monto_Neto:5
		End if 
		
		If ($vt_glosa="")
			[ACT_Cargos:173]Glosa:12:=[xxACT_Items:179]Glosa:2
			
			  // Modificado por: Saúl Ponce (04-03-2017) Ticket Nº 175355 se toma directamente el porcentaje de descuento a aplicar para mostrarlo en la glosa
			  // [ACT_Cargos]Glosa:=[xxACT_Items]Glosa+" ("+String(Round(Abs([ACT_Cargos]Monto_Neto*100/$vr_montoTotal);2))+"%)"
			  // [ACT_Cargos]Glosa:=[xxACT_Items]Glosa+" ("+String(arACT_PctDcto{$l_pos})+"%)" // esto no funcionó bien para todos los casos...
			
			  // Modificado por: Saúl Ponce (11-03-2017) Ticket 176649, la glosa del nuevo cargo podía no mencionar correctamente el monto de descuento, por ejemplo, al descuento por número de hijo le colocaba 0.
			If (Size of array:C274(arACT_PctDcto)>0)
				[ACT_Cargos:173]Glosa:12:=[xxACT_Items:179]Glosa:2+" ("+String:C10(arACT_PctDcto{$l_pos})+"%)"
			Else 
				[ACT_Cargos:173]Glosa:12:=[xxACT_Items:179]Glosa:2+" ("+String:C10(Round:C94(Abs:C99([ACT_Cargos:173]Monto_Neto:5*100/$vr_montoTotal);2))+"%)"
			End if 
			
			  //20170125 RCH detalles de calculo de descuento
			OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"id_descuento";$l_idDescuento)
			OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"nombre_descuento";KRL_GetTextFieldData (->[ACT_CFG_DctosIndividuales:229]ID:1;->$l_idDescuento;->[ACT_CFG_DctosIndividuales:229]Nombre:5))
			OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"orden";$l_pos)
			OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"monto_descuento";[ACT_Cargos:173]Monto_Neto:5)
			OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"pct_glosa";Round:C94(Abs:C99([ACT_Cargos:173]Monto_Neto:5*100/$vr_montoTotal);2))
			OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"calculado_sobre";$vr_montoTotal)
			OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"monto_original";$vr_montoTotal2)
			OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"pct_descuento";arACT_PctDcto{$l_pos})
			OB SET:C1220([ACT_Cargos:173]Detalle_CalculoDescuento:69;"calculado_sobre_total";abACT_SobreTotal{$l_pos})
			
		Else 
			[ACT_Cargos:173]Glosa:12:=$vt_glosa
		End if 
		
		  // Modificado por: Saúl Ponce (09-12-2016) - para utilizar el nuevo parámetro del método
		$vt_monedaConta:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;<>vtACT_monedaPais)
		
		  //[ACT_Cargos]No_de_Cuenta_contable:=[xxACT_Items]No_de_Cuenta_Contable
		  //[ACT_Cargos]Centro_de_costos:=[xxACT_Items]Centro_de_Costos
		  //[ACT_Cargos]Centro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CC")  //20131015 RCH
		  //[ACT_Cargos]CodAuxCta:=[xxACT_Items]CodAuxCta
		  //[ACT_Cargos]No_CCta_contable:=[xxACT_Items]No_CCta_contable
		  //[ACT_Cargos]CCentro_de_costos:=[xxACT_Items]CCentro_de_costos
		  //[ACT_Cargos]CCentro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CCC")  //20131015 RCH
		  //[ACT_Cargos]CodAuxCCta:=[xxACT_Items]CodAuxCCta
		
		[ACT_Cargos:173]No_de_Cuenta_contable:17:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]ID:1;[ACT_Cargos:173]ID_CuentaCorriente:2;"CTA";$vt_monedaConta)
		[ACT_Cargos:173]Centro_de_costos:15:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CC";$vt_monedaConta)
		[ACT_Cargos:173]CodAuxCta:43:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]ID:1;[ACT_Cargos:173]ID_CuentaCorriente:2;"CA";$vt_monedaConta)
		[ACT_Cargos:173]No_CCta_contable:39:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]ID:1;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCTA";$vt_monedaConta)
		[ACT_Cargos:173]CCentro_de_costos:40:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCC";$vt_monedaConta)
		[ACT_Cargos:173]CodAuxCCta:44:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]ID:1;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCA";$vt_monedaConta)
		
		[ACT_Cargos:173]id_DescuentoIndividual:68:=$l_idDescuento
		
		SAVE RECORD:C53([ACT_Cargos:173])
		$0:=Record number:C243([ACT_Cargos:173])
	End if 
End if 
KRL_UnloadReadOnly (->[ACT_Cargos:173])