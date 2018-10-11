//%attributes = {}
  //ACTcc_RecalculaCargosyDocs
C_BOOLEAN:C305($vb_continuar)
C_LONGINT:C283($vl_idItem)
C_LONGINT:C283($vl_numeroCuota)
C_TEXT:C284($vt_monedaConta)

$recnumDocumentoCargo:=$1
$month:=$2
$year:=$3
$date:=$4
$fechaVencimiento:=$5
$testMes:=$6
$BorrarEspeciales:=$7
$extra:=$8
If (Count parameters:C259>=9)
	$ufDate:=$9
Else 
	$ufDate:=Current date:C33(*)
End if 
If (Count parameters:C259>=10)
	$vl_numeroCuota:=$10
End if 
If ($BorrarEspeciales)
	READ WRITE:C146([ACT_Cargos:173])
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=-1;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
	DELETE SELECTION:C66([ACT_Cargos:173])
End if 

  //asignaremos numero de documento de cargo a los cargos correspondientes a excedentes en los pagos del mes anterior

QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=-2;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)

SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRecNumExcedentes)
GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$recnumDocumentoCargo)
$vl_idDocCargo:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
For ($i;1;Size of array:C274($aRecNumExcedentes))
	READ WRITE:C146([ACT_Cargos:173])
	GOTO RECORD:C242([ACT_Cargos:173];$aRecNumExcedentes{$i})
	[ACT_Cargos:173]ID_Documento_de_Cargo:3:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
	SAVE RECORD:C53([ACT_Cargos:173])
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
End for 

For ($itemIndex;1;Size of array:C274(alACT_IdItemMatriz))
	$vl_idItem:=alACT_IdItemMatriz{$itemIndex}
	$vb_continuar:=ACTcfg_ItemsMatricula ("ValidaEmisionAlumnoMatriculado";->[ACT_CuentasCorrientes:175]Matriculado:29;->$vl_idItem)
	If ($vb_continuar)
		$vb_continuar:=ACTcfg_ItemsMatricula ("ValidaEmisionAlumnoXEgresar";->[ACT_CuentasCorrientes:175]ID_Alumno:3;->$vl_idItem)
		If ($vb_continuar)
			READ WRITE:C146([ACT_Cargos:173])
			GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$recnumDocumentoCargo)
			$vl_idMatrizMax:=Num:C11(ACTcfg_OpcionesPagares ("MaxIDMatriz"))
			If (([ACT_Documentos_de_Cargo:174]ID_Matriz:2>-1) | ([ACT_Documentos_de_Cargo:174]ID_Matriz:2<=$vl_idMatrizMax))  //matrices creadas por codigo
				If ($testMes)
					If (alACT_MesDeCargo{$itemIndex} ?? $month)
						  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Documento_de_Cargo=[ACT_Documentos_de_Cargo]ID_Documento;*)
						  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item=alACT_IdItemMatriz{$itemIndex};*)
						  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Mes=$month;*)
						  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Año=$year;*)
						  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
						  //
						  //If (Records in selection([ACT_Cargos])>0)
						  //20091202 Cuando se emitia por una matriz para un mes, luego se cambiaba a otra matriz y se volvia a emitir para el mismo mes. Si habia un mismo cargo de imputacion unica presente en ambas matrices, este era cobrado 2 veces.
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=alACT_IdItemMatriz{$itemIndex};*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year)
						CREATE SET:C116([ACT_Cargos:173];"ACTcc_RecalCargos")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
						$vb_continuar:=True:C214
						If (Records in selection:C76([ACT_Cargos:173])>0) & (abACT_ImputacionUnica{$itemIndex})
							$vb_continuar:=False:C215
						End if 
						If ($vb_continuar)
							USE SET:C118("ACTcc_RecalCargos")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
							If (Records in selection:C76([ACT_Cargos:173])>0)
								READ WRITE:C146([ACT_Cargos:173])
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
								If (bc_EliminaDesctos=1)
									READ WRITE:C146([xxACT_DesctosXItem:103])
									FIRST RECORD:C50([ACT_Cargos:173])
									While (Not:C34(End selection:C36([ACT_Cargos:173])))
										QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID_Cargo:8=[ACT_Cargos:173]ID:1)
										DELETE RECORD:C58([xxACT_DesctosXItem:103])
										NEXT RECORD:C51([ACT_Cargos:173])
									End while 
									READ ONLY:C145([xxACT_DesctosXItem:103])
								End if 
							End if 
							
							If (Records in selection:C76([ACT_Cargos:173])=0)
								CREATE RECORD:C68([ACT_Cargos:173])
								[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11:=(Find in array:C230(atACT_NombreMonedaEm;[xxACT_Items:179]Moneda:10)=-1)
								[ACT_Cargos:173]ID_CuentaCorriente:2:=[ACT_CuentasCorrientes:175]ID:1
								[ACT_Cargos:173]ID_Documento_de_Cargo:3:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
								[ACT_Cargos:173]Mes:13:=$month
								[ACT_Cargos:173]Año:14:=$year
								[ACT_Cargos:173]Fecha_de_generacion:4:=$date
								[ACT_Cargos:173]FechaEmision:22:=!00-00-00!
								[ACT_Cargos:173]Glosa:12:=atACT_GlosaItemMatriz{$itemIndex}
								[ACT_Cargos:173]Ref_Item:16:=alACT_IdItemMatriz{$itemIndex}
								[ACT_Cargos:173]Fecha_de_Vencimiento:7:=$fechaVencimiento
								  //[ACT_Cargos]LastInterestsUpdate:=$fechaVencimiento
								  //ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos]FechaEmision;->[ACT_Cargos]Fecha_de_Vencimiento)  //20140825 RCH Intereses
								[ACT_Cargos:173]LastInterestsUpdate:42:=ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos:173]FechaEmision:22;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)  //20171117 RCH
								[ACT_Cargos:173]Afecto_a_Descuentos:19:=abACT_esDescontable{$itemIndex}
								[ACT_Cargos:173]Afecto_a_descuentos_Individual:32:=abACT_AfectoDescInd{$itemIndex}
								[ACT_Cargos:173]EsRelativo:10:=abACT_isPercentItemMatriz{$itemIndex}
								[ACT_Cargos:173]Moneda:28:=atACT_MonedaItem{$itemIndex}
								
								  // Modificado por: Saúl Ponce (09-12-2016) para identificar información de cuentas contables por nivel
								$vt_monedaConta:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;<>vtACT_monedaPais)
								
								  //[ACT_Cargos]No_de_Cuenta_contable:=asACT_CtaContableItem{$itemIndex}
								  //[ACT_Cargos]No_CCta_contable:=asACT_CCtaContableItem{$itemIndex}
								  //[ACT_Cargos]Centro_de_costos:=asACT_CentroContableItem{$itemIndex}//20130906 RCH
								  //[ACT_Cargos]CCentro_de_costos:=asACT_CCentroContableItem{$itemIndex}//20130906 RCH
								  //[ACT_Cargos]Centro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CC")//20130906 RCH
								  //[ACT_Cargos]CCentro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CCC")//20130906 RCH
								  //[ACT_Cargos]CodAuxCta:=asACT_CodAuxCta{$itemIndex}
								  //[ACT_Cargos]CodAuxCCta:=asACT_CodAuxCCta{$itemIndex}
								
								[ACT_Cargos:173]No_de_Cuenta_contable:17:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CTA";$vt_monedaConta)
								[ACT_Cargos:173]No_CCta_contable:39:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCTA";$vt_monedaConta)
								[ACT_Cargos:173]Centro_de_costos:15:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CC";$vt_monedaConta)
								[ACT_Cargos:173]CCentro_de_costos:40:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCC";$vt_monedaConta)
								[ACT_Cargos:173]CodAuxCta:43:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CA";$vt_monedaConta)
								[ACT_Cargos:173]CodAuxCCta:44:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCA";$vt_monedaConta)
								
								[ACT_Cargos:173]No_Incluir_en_DocTrib:50:=abACT_NoDocTrib{$itemIndex}
								[ACT_Cargos:173]RazonSocialAsociada:56:=atACT_NombreRazonSocial{$itemIndex}
								[ACT_Cargos:173]ID_RazonSocial:57:=alACT_NombreRazonSocial{$itemIndex}
								[ACT_Cargos:173]NoAfecto_a_DescuentosAut:60:=abACT_NoRecargoAut{$itemIndex}
								If (abACT_ItemAfectoIVA{$itemIndex})
									[ACT_Cargos:173]TasaIVA:21:=<>vrACT_TasaIVA
								End if 
								Case of 
									: (abACT_isPercentItemMatriz{$itemIndex})
										[ACT_Cargos:173]Monto_Neto:5:=0
								End case 
								SAVE RECORD:C53([ACT_Cargos:173])
								ACTcfg_ItemsMatricula ("AgregaElementoArreglo")
							Else 
								[ACT_Cargos:173]ID_CuentaCorriente:2:=[ACT_CuentasCorrientes:175]ID:1
								[ACT_Cargos:173]Mes:13:=$month
								[ACT_Cargos:173]Año:14:=$year
								[ACT_Cargos:173]Fecha_de_generacion:4:=$date
								[ACT_Cargos:173]FechaEmision:22:=!00-00-00!
								[ACT_Cargos:173]Glosa:12:=atACT_GlosaItemMatriz{$itemIndex}
								[ACT_Cargos:173]Ref_Item:16:=alACT_IdItemMatriz{$itemIndex}
								[ACT_Cargos:173]Fecha_de_Vencimiento:7:=$fechaVencimiento
								[ACT_Cargos:173]Afecto_a_Descuentos:19:=abACT_esDescontable{$itemIndex}
								[ACT_Cargos:173]Afecto_a_descuentos_Individual:32:=abACT_AfectoDescInd{$itemIndex}
								[ACT_Cargos:173]EsRelativo:10:=abACT_isPercentItemMatriz{$itemIndex}
								[ACT_Cargos:173]Moneda:28:=atACT_MonedaItem{$itemIndex}
								
								  // Modificado por: Saúl Ponce (09-12-2016) para identificar información de cuentas contables por nivel
								$vt_monedaConta:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;<>vtACT_monedaPais)
								
								  //[ACT_Cargos]No_de_Cuenta_contable:=asACT_CtaContableItem{$itemIndex}
								  //[ACT_Cargos]No_CCta_contable:=asACT_CCtaContableItem{$itemIndex}
								  //[ACT_Cargos]Centro_de_costos:=asACT_CentroContableItem{$itemIndex}//20130906 RCH
								  //[ACT_Cargos]CCentro_de_costos:=asACT_CCentroContableItem{$itemIndex}//20130906 RCH
								  //[ACT_Cargos]Centro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CC")//20130906 RCH
								  //[ACT_Cargos]CCentro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CCC")//20130906 RCH
								  //[ACT_Cargos]CodAuxCta:=asACT_CodAuxCta{$itemIndex}
								  //[ACT_Cargos]CodAuxCCta:=asACT_CodAuxCCta{$itemIndex}
								
								[ACT_Cargos:173]No_de_Cuenta_contable:17:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CTA";$vt_monedaConta)
								[ACT_Cargos:173]Centro_de_costos:15:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CC";$vt_monedaConta)
								[ACT_Cargos:173]CodAuxCta:43:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CA";$vt_monedaConta)
								[ACT_Cargos:173]No_CCta_contable:39:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCTA";$vt_monedaConta)
								[ACT_Cargos:173]CCentro_de_costos:40:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCC";$vt_monedaConta)
								[ACT_Cargos:173]CodAuxCCta:44:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCA";$vt_monedaConta)
								
								[ACT_Cargos:173]No_Incluir_en_DocTrib:50:=abACT_NoDocTrib{$itemIndex}
								[ACT_Cargos:173]RazonSocialAsociada:56:=atACT_NombreRazonSocial{$itemIndex}
								[ACT_Cargos:173]ID_RazonSocial:57:=alACT_NombreRazonSocial{$itemIndex}
								[ACT_Cargos:173]NoAfecto_a_DescuentosAut:60:=abACT_NoRecargoAut{$itemIndex}
								If (abACT_ItemAfectoIVA{$itemIndex})
									[ACT_Cargos:173]TasaIVA:21:=<>vrACT_TasaIVA
								End if 
								Case of 
									: (abACT_isPercentItemMatriz{$itemIndex})
										[ACT_Cargos:173]Monto_Neto:5:=0
								End case 
								SAVE RECORD:C53([ACT_Cargos:173])
								ACTcfg_ItemsMatricula ("AgregaElementoArreglo")
							End if 
						End if 
						CLEAR SET:C117("ACTcc_RecalCargos")
						KRL_UnloadReadOnly (->[ACT_Cargos:173])
					End if 
				End if 
				
			Else 
				If ([ACT_Documentos_de_Cargo:174]ID_Matriz:2>=-2)
					If ($extra)
						If (Records in selection:C76([ACT_CuentasCorrientes:175])=0)  //Venta directa
							C_POINTER:C301($ptr1;$ptr2)
							If ([ACT_Documentos_de_Cargo:174]ID_Tercero:24#0)
								$ptr1:=->[ACT_Cargos:173]ID_Tercero:54
								$ptr2:=->[ACT_Documentos_de_Cargo:174]ID_Tercero:24
							Else 
								$ptr1:=->[ACT_Cargos:173]ID_Apoderado:18
								$ptr2:=->[ACT_Documentos_de_Cargo:174]ID_Apoderado:12
							End if 
							  //QUERY([ACT_Cargos];[ACT_Cargos]ID_Tercero=[ACT_Documentos_de_Cargo]ID_Tercero;*)
							QUERY:C277([ACT_Cargos:173];$ptr1->=$ptr2->;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CuentaCorriente:2=0;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=alACT_IdItemMatriz{$itemIndex};*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year)
							CREATE SET:C116([ACT_Cargos:173];"ACTcc_RecalCargos")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
						Else 
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=alACT_IdItemMatriz{$itemIndex};*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year)
							CREATE SET:C116([ACT_Cargos:173];"ACTcc_RecalCargos")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
						End if 
						$vb_continuar:=True:C214
						If (Records in selection:C76([ACT_Cargos:173])>0) & (abACT_ImputacionUnica{$itemIndex})
							$vb_continuar:=False:C215
						End if 
						If ($vb_continuar)
							USE SET:C118("ACTcc_RecalCargos")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
							  // no puede existir mas de un cargo por item en el mismo período
							  // se eliminan los cargos duplicados, a condicion que no hayan sido objeto de 
							  // aviso de cobranza
							If ((Records in selection:C76([ACT_Cargos:173])>0) & (abACT_ImputacionUnica{$itemIndex}))
								READ WRITE:C146([ACT_Cargos:173])
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
								If (bc_EliminaDesctos=1)
									READ WRITE:C146([xxACT_DesctosXItem:103])
									FIRST RECORD:C50([ACT_Cargos:173])
									While (Not:C34(End selection:C36([ACT_Cargos:173])))
										QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID_Cargo:8=[ACT_Cargos:173]ID:1)
										DELETE RECORD:C58([xxACT_DesctosXItem:103])
										NEXT RECORD:C51([ACT_Cargos:173])
									End while 
									READ ONLY:C145([xxACT_DesctosXItem:103])
								End if 
								DELETE SELECTION:C66([ACT_Cargos:173])
							End if 
							CREATE RECORD:C68([ACT_Cargos:173])
							[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11:=(Find in array:C230(atACT_NombreMonedaEm;[xxACT_Items:179]Moneda:10)=-1)
							[ACT_Cargos:173]ID_CuentaCorriente:2:=[ACT_CuentasCorrientes:175]ID:1
							[ACT_Cargos:173]ID_Documento_de_Cargo:3:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
							[ACT_Cargos:173]Mes:13:=$month
							[ACT_Cargos:173]Año:14:=$year
							[ACT_Cargos:173]Fecha_de_generacion:4:=$date
							[ACT_Cargos:173]FechaEmision:22:=!00-00-00!
							[ACT_Cargos:173]Glosa:12:=vsACT_Glosa
							[ACT_Cargos:173]Ref_Item:16:=alACT_IdItemMatriz{$itemIndex}
							[ACT_Cargos:173]Fecha_de_Vencimiento:7:=$fechaVencimiento
							  //[ACT_Cargos]LastInterestsUpdate:=$fechaVencimiento
							  //ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos]FechaEmision;->[ACT_Cargos]Fecha_de_Vencimiento)  //20140825 RCH Intereses
							[ACT_Cargos:173]LastInterestsUpdate:42:=ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos:173]FechaEmision:22;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)  //20171117 RCH
							[ACT_Cargos:173]Afecto_a_Descuentos:19:=False:C215
							[ACT_Cargos:173]EsRelativo:10:=False:C215
							[ACT_Cargos:173]Moneda:28:=vsACT_Moneda
							
							  // Modificado por: Saúl Ponce (09-12-2016) para identificar información de cuentas contables por nivel
							$vt_monedaConta:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;<>vtACT_monedaPais)
							
							  //[ACT_Cargos]No_de_Cuenta_contable:=vsACT_CtaContable
							  //[ACT_Cargos]No_CCta_contable:=vsACT_CCtaContable
							  //[ACT_Cargos]Centro_de_costos:=vsACT_CentroContable//20130906 RCH
							  //[ACT_Cargos]CCentro_de_costos:=vsACT_CCentroContable//20130906 RCH
							  //[ACT_Cargos]Centro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CC")//20130906 RCH
							  //[ACT_Cargos]CCentro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CCC")//20130906 RCH
							  //[ACT_Cargos]CodAuxCta:=vsACT_CodAuxCta
							  //[ACT_Cargos]CodAuxCCta:=vsACT_CodAuxCCta
							
							
							[ACT_Cargos:173]No_de_Cuenta_contable:17:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CTA";$vt_monedaConta)
							[ACT_Cargos:173]Centro_de_costos:15:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CC";$vt_monedaConta)
							[ACT_Cargos:173]CodAuxCta:43:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CA";$vt_monedaConta)
							[ACT_Cargos:173]No_CCta_contable:39:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCTA";$vt_monedaConta)
							[ACT_Cargos:173]CCentro_de_costos:40:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCC";$vt_monedaConta)
							[ACT_Cargos:173]CodAuxCCta:44:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCA";$vt_monedaConta)
							
							
							[ACT_Cargos:173]No_Incluir_en_DocTrib:50:=(cbACT_NoDocTrib=1)
							[ACT_Cargos:173]RazonSocialAsociada:56:=atACT_NombreRazonSocial{$itemIndex}
							[ACT_Cargos:173]ID_RazonSocial:57:=alACT_NombreRazonSocial{$itemIndex}
							[ACT_Cargos:173]NoAfecto_a_DescuentosAut:60:=abACT_NoRecargoAut{$itemIndex}
							If (cbACT_Afecto_IVA=1)
								[ACT_Cargos:173]TasaIVA:21:=<>vrACT_TasaIVA
							End if 
							Case of 
								: ((vrACT_Monto>0) & (cbACT_EsDescuento=1))
									[ACT_Cargos:173]Monto_Neto:5:=Abs:C99(vrACT_Monto)*-1
								: ((vrACT_Monto<0) & (cbACT_EsDescuento=0))
									[ACT_Cargos:173]Monto_Neto:5:=Abs:C99(vrACT_Monto)
								Else 
									[ACT_Cargos:173]Monto_Neto:5:=vrACT_Monto
							End case 
							[ACT_Cargos:173]Extraordinario:41:=True:C214
							<>cbACT_NoRedondear:=True:C214
							SAVE RECORD:C53([ACT_Cargos:173])
							<>cbACT_NoRedondear:=False:C215
							ACTcfg_ItemsMatricula ("AgregaElementoArreglo")
						End if 
						CLEAR SET:C117("ACTcc_RecalCargos")
						KRL_UnloadReadOnly (->[ACT_Cargos:173])
					Else 
						If ($testMes)
							If (alACT_MesDeCargo{$itemIndex} ?? $month)
								QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
								QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=alACT_IdItemMatriz{$itemIndex};*)
								QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$month;*)
								QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$year)
								CREATE SET:C116([ACT_Cargos:173];"ACTcc_RecalCargos")
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
								$vb_continuar:=True:C214
								If (Records in selection:C76([ACT_Cargos:173])>0) & (abACT_ImputacionUnica{$itemIndex})
									$vb_continuar:=False:C215
								End if 
								If ($vb_continuar)
									USE SET:C118("ACTcc_RecalCargos")
									QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
									
									  // no puede existir mas de un cargo por item en el mismo período
									  // se eliminan los cargos duplicados, a condicion que no hayan sido objeto de 
									  // aviso de cobranza
									If ((Records in selection:C76([ACT_Cargos:173])>0) & (abACT_ImputacionUnica{$itemIndex}))
										READ WRITE:C146([ACT_Cargos:173])
										QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
										If (bc_EliminaDesctos=1)
											READ WRITE:C146([xxACT_DesctosXItem:103])
											FIRST RECORD:C50([ACT_Cargos:173])
											While (Not:C34(End selection:C36([ACT_Cargos:173])))
												QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID_Cargo:8=[ACT_Cargos:173]ID:1)
												DELETE RECORD:C58([xxACT_DesctosXItem:103])
												NEXT RECORD:C51([ACT_Cargos:173])
											End while 
											READ ONLY:C145([xxACT_DesctosXItem:103])
										End if 
										DELETE SELECTION:C66([ACT_Cargos:173])
									End if 
									CREATE RECORD:C68([ACT_Cargos:173])
									[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11:=(Find in array:C230(atACT_NombreMonedaEm;[xxACT_Items:179]Moneda:10)=-1)
									[ACT_Cargos:173]ID_CuentaCorriente:2:=[ACT_CuentasCorrientes:175]ID:1
									[ACT_Cargos:173]ID_Documento_de_Cargo:3:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
									[ACT_Cargos:173]Mes:13:=$month
									[ACT_Cargos:173]Año:14:=$year
									[ACT_Cargos:173]Fecha_de_generacion:4:=$date
									[ACT_Cargos:173]FechaEmision:22:=!00-00-00!
									[ACT_Cargos:173]Glosa:12:=atACT_GlosaItemMatriz{$itemIndex}
									[ACT_Cargos:173]Ref_Item:16:=alACT_IdItemMatriz{$itemIndex}
									[ACT_Cargos:173]Fecha_de_Vencimiento:7:=$fechaVencimiento
									  //[ACT_Cargos]LastInterestsUpdate:=$fechaVencimiento
									  //ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos]FechaEmision;->[ACT_Cargos]Fecha_de_Vencimiento)  //20140825 RCH Intereses
									[ACT_Cargos:173]LastInterestsUpdate:42:=ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos:173]FechaEmision:22;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)  //20171117 RCH
									[ACT_Cargos:173]Afecto_a_Descuentos:19:=abACT_esDescontable{$itemIndex}
									[ACT_Cargos:173]EsRelativo:10:=abACT_isPercentItemMatriz{$itemIndex}
									[ACT_Cargos:173]Moneda:28:=atACT_MonedaItem{$itemIndex}
									
									  // Modificado por: Saúl Ponce (09-12-2016) para identificar información de cuentas contables por nivel
									$vt_monedaConta:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;<>vtACT_monedaPais)
									
									  //[ACT_Cargos]No_de_Cuenta_contable:=asACT_CtaContableItem{$itemIndex}
									  //[ACT_Cargos]No_CCta_contable:=asACT_CCtaContableItem{$itemIndex}
									  //[ACT_Cargos]Centro_de_costos:=asACT_CentroContableItem{$itemIndex}//20130906 RCH
									  //[ACT_Cargos]CCentro_de_costos:=asACT_CCentroContableItem{$itemIndex}//20130906 RCH
									  //[ACT_Cargos]Centro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CC")//20130906 RCH
									  //[ACT_Cargos]CCentro_de_costos:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos]Ref_Item;[ACT_Cargos]ID_CuentaCorriente;"CCC")//20130906 RCH
									  //[ACT_Cargos]CodAuxCta:=asACT_CodAuxCta{$itemIndex}
									  //[ACT_Cargos]CodAuxCCta:=asACT_CodAuxCCta{$itemIndex}
									
									
									[ACT_Cargos:173]No_de_Cuenta_contable:17:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CTA";$vt_monedaConta)
									[ACT_Cargos:173]Centro_de_costos:15:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CC";$vt_monedaConta)
									[ACT_Cargos:173]CodAuxCta:43:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CA";$vt_monedaConta)
									[ACT_Cargos:173]No_CCta_contable:39:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCTA";$vt_monedaConta)
									[ACT_Cargos:173]CCentro_de_costos:40:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCC";$vt_monedaConta)
									[ACT_Cargos:173]CodAuxCCta:44:=ACTitems_ObtieneCCostoXNivel ([ACT_Cargos:173]Ref_Item:16;[ACT_Cargos:173]ID_CuentaCorriente:2;"CCA";$vt_monedaConta)
									
									[ACT_Cargos:173]No_Incluir_en_DocTrib:50:=abACT_NoDocTrib{$itemIndex}
									[ACT_Cargos:173]RazonSocialAsociada:56:=atACT_NombreRazonSocial{$itemIndex}
									[ACT_Cargos:173]ID_RazonSocial:57:=alACT_NombreRazonSocial{$itemIndex}
									[ACT_Cargos:173]NoAfecto_a_DescuentosAut:60:=abACT_NoRecargoAut{$itemIndex}
									If (abACT_ItemAfectoIVA{$itemIndex})
										[ACT_Cargos:173]TasaIVA:21:=<>vrACT_TasaIVA
									End if 
									Case of 
										: (abACT_isPercentItemMatriz{$itemIndex})
											[ACT_Cargos:173]Monto_Neto:5:=0
									End case 
									SAVE RECORD:C53([ACT_Cargos:173])
									ACTcfg_ItemsMatricula ("AgregaElementoArreglo")
								End if 
								CLEAR SET:C117("ACTcc_RecalCargos")
								KRL_UnloadReadOnly (->[ACT_Cargos:173])
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
End for 

QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-2;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CargoRelacionado:47=0)

LOAD RECORD:C52([ACT_Documentos_de_Cargo:174])
$Mes:=[ACT_Documentos_de_Cargo:174]Mes:13
$Year:=[ACT_Documentos_de_Cargo:174]Año:14
$Apdo:=[ACT_Documentos_de_Cargo:174]ID_Apoderado:12
SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRecNumsCargos)

$idmatriz:=[ACT_CuentasCorrientes:175]ID_Matriz:7

For ($i_Cargos;1;Size of array:C274($aRecNumsCargos))
	GOTO RECORD:C242([ACT_Cargos:173];$aRecNumsCargos{$i_Cargos})
	QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$idmatriz;*)
	QUERY:C277([xxACT_ItemsMatriz:180]; & ;[xxACT_ItemsMatriz:180]ID_Item:2=[ACT_Cargos:173]Ref_Item:16)
	UNLOAD RECORD:C212([ACT_Cargos:173])
	If (Records in selection:C76([xxACT_ItemsMatriz:180])>0)
		$itemnomatriz:=False:C215
	Else 
		$itemnomatriz:=True:C214
	End if 
	READ WRITE:C146([ACT_Cargos:173])
	ACTcc_CalculaMontoItem ($aRecNumsCargos{$i_Cargos};$idmatriz;$itemnomatriz;$ufDate;"";False:C215;$vl_numeroCuota)
	UNLOAD RECORD:C212([ACT_Cargos:173])
	READ ONLY:C145([ACT_Cargos:173])
End for 

$montoDoc:=ACTcc_CalculaDocumentoCargo ($recnumDocumentoCargo)

If ($montoDoc=0)
	$done:=ACTcc_BorrarDocdeCargo (String:C10($vl_idDocCargo))
	If (Not:C34($done))
		BM_CreateRequest ("ACT_BorrarDocdeCargo";String:C10($vl_idDocCargo))
	End if 
End if 