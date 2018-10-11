//%attributes = {}
  //ACTbol_ImprimeBoletaSub

  //REGISTRO DE CAMBIOS
  //20080407 RCH Se modifica la forma de calcular la variable vr_MontoPagadoCol. Se restaba al monto de la transacción el dcto. Ahora sólo se suma el monto de la transacción

ACTbol_InitVariablesPrintSub 



C_BLOB:C604(xBlob)
SET BLOB SIZE:C606(xBlob;0)
xBlob:=PREF_fGetBlob (0;"PreferenciasImpresionBoletasCompleto";xBlob)
If (BLOB size:C605(xBlob)#0)
	BLOB_Blob2Vars (->xBlob;0;->v_2NombreMesP;->v_2MontoP;->v_2MontoPP;->v_3MontoP;->v_4MontoMensualP;->v_4MontoTotalP;->v_4MontoMensualNoVecesP;->v_4MontosSeparadosP;->v_4RepiteMonto1EnMonto2P;->v_4MontoColegiaturaLinea2P;->v_ImprimeObsC;->vt_obsCompletoSBeca;->vt_obsCompletoCBeca)
End if 
SET BLOB SIZE:C606(xBlob;0)
xBlob:=PREF_fGetBlob (0;"PreferenciasImpresionBoletasAbono";xBlob)
If (BLOB size:C605(xBlob)#0)
	BLOB_Blob2Vars (->xBlob;0;->v_2AbonoA;->v_2NombreMesA;->v_2MontoA;->v_2MontoPA;->v_3MontoA;->v_4MontoMensualA;->v_4MontoTotalA;->v_4MontoMensualNoVecesA;->v_4MontosSeparadosA;->v_4RepiteMonto1EnMonto2A;->v_4MontoColegiaturaLinea2A;->v_5ImprimeAbonoA;->v_ImprimeObsA;->vt_obsAbonoSBeca;->vt_obsAbonoCBeca)
End if 
SET BLOB SIZE:C606(xBlob;0)
xBlob:=PREF_fGetBlob (0;"PreferenciasImpresionBoletasSaldo";xBlob)
If (BLOB size:C605(xBlob)#0)
	BLOB_Blob2Vars (->xBlob;0;->v_2SaldoS;->v_2NombreMesS;->v_2MontoS;->v_2MontoPS;->v_3MontoS;->v_4MontoMensualS;->v_4MontoTotalS;->v_4MontoMensualNoVecesS;->v_4MontosSeparadosS;->v_4RepiteMonto1EnMonto2S;->v_4MontoColegiaturaLinea2S;->v_ImprimeObsS;->vt_obsSaldoSbeca;->vt_obsSaldoCbeca)
End if 
SET BLOB SIZE:C606(xBlob;0)
xBlob:=PREF_fGetBlob (0;"PreferenciasImpresionBoletasOtros";xBlob)
If (BLOB size:C605(xBlob)#0)
	BLOB_Blob2Vars (->xBlob;0;->vb_ImprimeTexto;->textoAImprimir;->v_GSumarP;->v_GSumarA;->v_GSumarS;->vt_AgnoBoleta)
End if 
SET BLOB SIZE:C606(xBlob;0)

READ ONLY:C145([ACT_Boletas:181])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])

C_TEXT:C284($vt_MontoMensual)  //lleno variables
C_TEXT:C284($vt_MontoTotal)
C_TEXT:C284($NoRepeticiones)
C_TEXT:C284(vt_Abono)
C_TEXT:C284(vt_SaldoAbono)
C_BOOLEAN:C305($impresionEspecial)

ARRAY TEXT:C222($at_textoMesEnInforme;0)
ARRAY TEXT:C222($at_textoAbSaInforme;0)
ARRAY TEXT:C222($at_textoMontoMesEnInforme;0)
ARRAY LONGINT:C221($al_mes;0)
ARRAY REAL:C219($ar_MontoDcto;0)
ARRAY TEXT:C222($at_añoMesLineaMes;0)
ARRAY REAL:C219($ar_montoTrans;0)
ARRAY REAL:C219($ar_saldoCargo;0)
ARRAY REAL:C219($ar_tranAnter;0)
ARRAY REAL:C219($ar_pagoConDescto;0)
ARRAY REAL:C219(ar_MontoCategoria;0)
  //20131008 ASM Ticket 125855 
ARRAY LONGINT:C221($al_idsPagos;0)
C_LONGINT:C283($transaccionMasAlta)
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)

QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8#"Balanceo Descuento";*)
QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Pago con Descuento")


  // 20130801 ASM Para manejar las boletas con pagos de terceros.
Case of 
	: ([ACT_Boletas:181]ID_Tercero:21#0)
		$y_IDCargoApoTer:=->[ACT_Cargos:173]ID_Tercero:54
		$y_IDCargoCuenta:=->[ACT_Cargos:173]ID_CuentaCorriente:2
		$id_CtaCte:=[ACT_Transacciones:178]ID_CuentaCorriente:2
		$id_Apoderado:=[ACT_Boletas:181]ID_Tercero:21
		$y_CampoApoTer:=->[ACT_Terceros:138]Id:1
		$y_TablaApoTer:=->[ACT_Terceros:138]
		$y_NombreApoderado:=->[ACT_Terceros:138]Nombre_Completo:9
	Else 
		$y_IDCargoApoTer:=->[ACT_Cargos:173]ID_Apoderado:18
		$y_IDCargoCuenta:=->[ACT_Cargos:173]ID_CuentaCorriente:2
		$id_CtaCte:=[ACT_Transacciones:178]ID_CuentaCorriente:2
		$id_Apoderado:=[ACT_Boletas:181]ID_Apoderado:14
		$y_CampoApoTer:=->[Personas:7]No:1
		$y_TablaApoTer:=->[Personas:7]
		$y_NombreApoderado:=->[Personas:7]Apellidos_y_nombres:30
End case 


$id_Boleta:=[ACT_Boletas:181]ID:1

ARRAY LONGINT:C221(al_RNTransacciones;0)
ARRAY LONGINT:C221(al_RNItems;0)
SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Transaccion:1;al_RNTransacciones)
SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Item:3;al_RNItems)

QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
$vl_idPago:=[ACT_Transacciones:178]ID_Pago:4

$espacio:=" "

  //Carga categorías
ARRAY TEXT:C222(atACT_NombreCategoria;0)

READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([xxACT_ItemsCategorias:98])
ALL RECORDS:C47([xxACT_ItemsCategorias:98])
ORDER BY:C49([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Posicion:3;>)
SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]ID:2;$aIDCategoria;[xxACT_ItemsCategorias:98]Posicion:3;$aPosCategoria;[xxACT_ItemsCategorias:98]Nombre:1;atACT_NombreCategoria)
ARRAY LONGINT:C221($vl_MontoCategoria;Size of array:C274($aIDCategoria))
ARRAY LONGINT:C221(al_IdCategoria;Size of array:C274($aIDCategoria))
ARRAY LONGINT:C221($al_MontoCategoria;Size of array:C274($aIDCategoria))
ARRAY REAL:C219(ar_MontoCategoria;Size of array:C274($aIDCategoria))  // para manejar en arreglos los montos de categorias
ARRAY LONGINT:C221(al_ItemsSinCategoria;0)
ARRAY LONGINT:C221(al_TransaccionesSinCat;0)

For ($j;1;Size of array:C274(al_RNItems))  //cargo los montos para cada categoria 
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Transaccion:1=al_RNTransacciones{$j})
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=al_RNItems{$j})
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
	$el:=Find in array:C230($aIDCategoria;[xxACT_Items:179]ID_Categoria:8)
	If ($el#-1)  //puede ser un dcto exento en caja o el cargo puede no estar en las categorias
		$in:=Find in array:C230(al_IdCategoria;$aIDCategoria{$el})
		If ($in=-1)
			al_IdCategoria{$el}:=[xxACT_Items:179]ID_Categoria:8
			$al_MontoCategoria{$el}:=[ACT_Transacciones:178]Debito:6
		Else 
			$al_MontoCategoria{$el}:=$al_MontoCategoria{$el}+[ACT_Transacciones:178]Debito:6
		End if 
	Else 
		AT_Insert (1;1;->al_ItemsSinCategoria;->al_TransaccionesSinCat)
		al_ItemsSinCategoria{1}:=al_RNItems{$j}
		al_TransaccionesSinCat{1}:=al_RNTransacciones{$j}  //prueba
	End if 
End for 

C_POINTER:C301($variable)  // declaro variables
C_POINTER:C301($variable2)
For ($i;1;Size of array:C274($aIDCategoria))
	$variable:=Get pointer:C304("vt_CategoriaNombre"+String:C10($i))
	$variable2:=Get pointer:C304("vr_CategoriaMonto"+String:C10($i))
	C_TEXT:C284($variable->)
	C_REAL:C285($variable2->)
	$variable->:=""
	$variable2->:=0
End for 

ARRAY LONGINT:C221(al_RNCargosCol;0)
ARRAY LONGINT:C221($al_RNCArgos;0)

For ($i;1;Size of array:C274($aIDCategoria))  //lleno las variables nombre categoria y monto categoria que se imprimen en el informe
	$variable:=Get pointer:C304("vt_CategoriaNombre"+String:C10($i))
	$variable2:=Get pointer:C304("vr_CategoriaMonto"+String:C10($i))
	$variable->:=atACT_NombreCategoria{$i}
	$variable2->:=$al_MontoCategoria{$i}
	ar_MontoCategoria{$i}:=$al_MontoCategoria{$i}
End for 

atACT_NombreCategoria{0}:="Exención Sistema de Becas@"  //busco la categoria que corresponde descuentos y guardo el id
ARRAY LONGINT:C221($DA_Return;0)
AT_SearchArray (->atACT_NombreCategoria;"=";->$DA_Return)
If (Size of array:C274($DA_Return)>0)
	$idCatdscto:=$DA_Return{1}
	$idCatDctoItem:=$aIDCategoria{$DA_Return{1}}
Else 
	$idCatdscto:=0
	$idCatDctoItem:=0
End if 

ARRAY REAL:C219(ar_DctosMensuales;0)

atACT_NombreCategoria{0}:="Cobro Mensual@"  //busco la categoria que corresponde a la colegiatura y guardo el id
ARRAY LONGINT:C221($DA_Return;0)
AT_SearchArray (->atACT_NombreCategoria;"=";->$DA_Return)
$idCatCol:=$aIDCategoria{$DA_Return{1}}
ARRAY LONGINT:C221(al_PosItemTra;0)
If ($al_MontoCategoria{$DA_Return{1}}>0)  //para colegiatura
	ARRAY LONGINT:C221(al_MontoMensual;0)  //busco el monto mensual, el período y el monto de los descuentos
	ARRAY TEXT:C222(at_Periodo;0)
	ARRAY LONGINT:C221(al_MontoDcto;0)
	ARRAY REAL:C219(ar_montoPagos;0)
	ARRAY TEXT:C222(at_cargosIdsCol;0)
	For ($i;1;Size of array:C274(al_RNItems))
		ARRAY LONGINT:C221(al_RNCargosCol;0)
		ARRAY LONGINT:C221(al_RNCargosColDcto;0)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=al_RNItems{$i})
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
		If ([xxACT_Items:179]ID_Categoria:8=$idCatCol)
			$mes:=[ACT_Cargos:173]Mes:13
			$año:=[ACT_Cargos:173]Año:14
			at_Periodo{0}:=String:C10($mes;"00")+String:C10($año;"0000")
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray (->at_Periodo;"=";->$DA_Return)
			If (Size of array:C274($DA_Return)=0)
				  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=$id_CtaCte;*)
				QUERY:C277([ACT_Cargos:173];$y_IDCargoApoTer->=$id_Apoderado;*)
				If ($id_CtaCte#0)
					QUERY:C277([ACT_Cargos:173]; & ;$y_IDCargoCuenta->=$id_CtaCte;*)
				End if 
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$mes;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$año;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]No_Incluir_en_DocTrib:50=False:C215)
				SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_RNCArgos)  //para cuando haya más que sólo colegiatura para un mes
				For ($r;1;Size of array:C274($al_RNCArgos))
					GOTO RECORD:C242([ACT_Cargos:173];$al_RNCArgos{$r})
					QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
					If ([xxACT_Items:179]ID_Categoria:8=$idCatCol)
						AT_Insert (1;1;->al_RNCargosCol)
						al_RNCargosCol{1}:=[ACT_Cargos:173]ID:1
					Else 
						If ([xxACT_Items:179]ID_Categoria:8=$idCatDctoItem)
							AT_Insert (1;1;->al_RNCargosColDcto)
							al_RNCargosColDcto{1}:=[ACT_Cargos:173]ID:1
						End if 
					End if 
				End for 
				If (Size of array:C274(al_RNCargosCol)>0)
					QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;al_RNCargosCol)
					AT_Insert (0;1;->al_MontoMensual;->at_Periodo;->al_MontoDcto;->ar_montoPagos;->at_cargosIdsCol;->ar_DctosMensuales)
					Case of 
						: ((<>gRolBD="86177") & (Records in selection:C76([ACT_Cargos:173])=1) & ([ACT_Cargos:173]Glosa:12="saldo"))  //Importacon cargos Sara Blinder
							$perSB:="F.C "+String:C10($año)
							QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Glosa:2=$perSB)
							al_MontoMensual{Size of array:C274(al_MontoMensual)}:=[xxACT_Items:179]Monto:7
							$impresionEspecial:=True:C214
						Else 
							al_MontoMensual{Size of array:C274(al_MontoMensual)}:=Sum:C1([ACT_Cargos:173]Monto_Bruto:24)
					End case 
					al_MontoDcto{Size of array:C274(al_MontoDcto)}:=Sum:C1([ACT_Cargos:173]Descuentos_Individual:31)+Sum:C1([ACT_Cargos:173]Descuentos_Familia:26)+Sum:C1([ACT_Cargos:173]Descuentos_XItem:35)
					at_Periodo{Size of array:C274(at_Periodo)}:=String:C10($mes;"00")+String:C10($año;"0000")
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
					  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]ID_Pago>0)
					QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0;*)
					QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Balanceo Descuento")
					ar_montoPagos{Size of array:C274(ar_montoPagos)}:=Sum:C1([ACT_Transacciones:178]Debito:6)
					at_cargosIdsCol{Size of array:C274(at_cargosIdsCol)}:=AT_array2text (->al_RNCargosCol)
					If (Size of array:C274(al_RNCargosColDcto)>0)
						QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;al_RNCargosColDcto)
						al_MontoDcto{Size of array:C274(al_MontoDcto)}:=al_MontoDcto{Size of array:C274(al_MontoDcto)}-Sum:C1([ACT_Cargos:173]Monto_Neto:5)
					End if 
					ar_DctosMensuales{Size of array:C274(ar_DctosMensuales)}:=Round:C94(((al_MontoDcto{Size of array:C274(al_MontoDcto)}/al_MontoMensual{Size of array:C274(al_MontoMensual)})*100);0)
				End if 
			End if 
		Else 
			AT_Insert (1;1;->al_PosItemTra)  //prueba
			al_PosItemTra{1}:=$i
		End if 
	End for 
	SORT ARRAY:C229(al_PosItemTra;>)
	For ($rr;Size of array:C274(al_PosItemTra);1;-1)
		AT_Delete (al_PosItemTra{$rr};1;->al_RNItems;->al_RNTransacciones)
	End for 
	
	  //ARRAY TEXT($at_textoMesEnInforme;0)
	  //ARRAY TEXT($at_textoAbSaInforme;0)
	  //ARRAY TEXT($at_textoMontoMesEnInforme;0)
	  //ARRAY LONGINT($al_mes;0)
	  //ARRAY REAL($ar_MontoDcto;0)
	  //ARRAY TEXT($at_añoMesLineaMes;0)
	  //ARRAY REAL($ar_montoTrans;0)
	  //ARRAY REAL($ar_saldoCargo;0)
	  //ARRAY REAL($ar_tranAnter;0)
	C_REAL:C285($vr_pagoConDescto)
	
	For ($i;1;Size of array:C274(al_RNTransacciones))  //lleno la línea mes
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Transaccion:1=al_RNTransacciones{$i})
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=al_RNItems{$i})
		$mes:=[ACT_Cargos:173]Mes:13
		$año:=[ACT_Cargos:173]Año:14
		$existe:=Find in array:C230($at_añoMesLineaMes;String:C10($mes;"00")+String:C10($año;"0000"))
		$el:=Find in array:C230(at_Periodo;String:C10($mes;"00")+String:C10($año;"0000"))
		If ($el>0)
			ARRAY LONGINT:C221(al_RNCargosCol;0)
			AT_Text2Array (->al_RNCargosCol;at_cargosIdsCol{$el})
			QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;al_RNCargosCol)
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]ID_Pago>0)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Balanceo Descuento")
			$transaccionMasAlta:=AT_Maximum (->al_RNTransacciones)
			ARRAY LONGINT:C221($al_idsPagos;0)
			KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
			AT_DistinctsFieldValues (->[ACT_Pagos:172]ID:1;->$al_idsPagos)
		End if 
		If (Size of array:C274($al_idsPagos)=1)  //solo hay un pago asociado al cargo
			$tranAnter:=0
		Else 
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Transaccion:1<=$transaccionMasAlta)
			If (Find in array:C230($al_idsPagos;$vl_idPago)#-1)
				AT_Delete (Find in array:C230($al_idsPagos;$vl_idPago);1;->$al_idsPagos)
			End if 
			QRY_QueryWithArray (->[ACT_Transacciones:178]ID_Pago:4;->$al_idsPagos;True:C214)
			$tranAnter:=Sum:C1([ACT_Transacciones:178]Debito:6)  //monto anterior
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8="Pago con Descuento")
			$vr_pagoConDescto:=Sum:C1([ACT_Transacciones:178]Debito:6)
		End if 
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Transaccion:1=al_RNTransacciones{$i})
		If ($existe>0)
			$ar_montoTrans{$existe}:=$ar_montoTrans{$existe}+[ACT_Transacciones:178]Debito:6
			$ar_saldoCargo{$existe}:=$ar_saldoCargo{$existe}+[ACT_Cargos:173]Saldo:23
			$ar_tranAnter{$existe}:=$tranAnter  //se suma arriba por eso no se suma el valor del arreglo más lo actual
			$ar_pagoConDescto{$existe}:=$vr_pagoConDescto
		Else 
			INSERT IN ARRAY:C227($at_añoMesLineaMes;Size of array:C274($at_añoMesLineaMes)+1;1)
			INSERT IN ARRAY:C227($ar_montoTrans;Size of array:C274($at_añoMesLineaMes)+1;1)
			INSERT IN ARRAY:C227($ar_saldoCargo;Size of array:C274($at_añoMesLineaMes)+1;1)
			INSERT IN ARRAY:C227($ar_tranAnter;Size of array:C274($at_añoMesLineaMes)+1;1)
			INSERT IN ARRAY:C227($ar_pagoConDescto;Size of array:C274($ar_pagoConDescto)+1;1)
			$at_añoMesLineaMes{Size of array:C274($at_añoMesLineaMes)}:=String:C10($mes;"00")+String:C10($año;"0000")
			$ar_montoTrans{Size of array:C274($ar_montoTrans)}:=[ACT_Transacciones:178]Debito:6
			$ar_saldoCargo{Size of array:C274($ar_saldoCargo)}:=[ACT_Cargos:173]Saldo:23
			$ar_tranAnter{Size of array:C274($ar_tranAnter)}:=$tranAnter
			$ar_pagoConDescto{Size of array:C274($ar_pagoConDescto)}:=$vr_pagoConDescto
		End if 
	End for 
	For ($i;1;Size of array:C274($at_añoMesLineaMes))
		INSERT IN ARRAY:C227($at_textoMesEnInforme;Size of array:C274($at_textoMesEnInforme)+1;1)
		INSERT IN ARRAY:C227($at_textoAbSaInforme;Size of array:C274($at_textoAbSaInforme)+1;1)
		INSERT IN ARRAY:C227($at_textoMontoMesEnInforme;Size of array:C274($at_textoMontoMesEnInforme)+1;1)
		INSERT IN ARRAY:C227($al_mes;Size of array:C274($al_mes)+1;1)
		INSERT IN ARRAY:C227($ar_MontoDcto;Size of array:C274($ar_MontoDcto)+1;1)
		$el:=Find in array:C230(at_Periodo;$at_añoMesLineaMes{$i})
		If ($el>0)  //comparo el monto de la transacción con el monto total del mes + los descuentos
			$mes:=Num:C11(Substring:C12($at_añoMesLineaMes{$i};1;2))
			$año:=Num:C11(Substring:C12($at_añoMesLineaMes{$i};3;4))
			If ($ar_tranAnter{$i}=0)  //hay sólo una transacción asociada
				If (($ar_montoTrans{$i}+al_MontoDcto{$el})=al_MontoMensual{$el})  //mes completo
					$at_textoMesEnInforme{$i}:=Substring:C12(<>atXS_MonthNames{$mes};1;3)
					$at_textoAbSaInforme{$i}:=""
					$at_textoMontoMesEnInforme{$i}:=String:C10($ar_montoTrans{$i};"|Despliegue_ACT")
					$añoMes:=String:C10($año;"0000")+String:C10($mes;"00")
					$al_mes{$i}:=Num:C11($añoMes)
					$ar_MontoDcto{$i}:=al_MontoDcto{$el}
				Else 
					  //If ((($ar_montoTrans{$i}+al_MontoDcto{$el})<al_MontoMensual{$el}) & ($ar_saldoCargo{$i}=0))  `saldo
					If ((($ar_montoTrans{$i}+al_MontoDcto{$el})<al_MontoMensual{$el}) & ((al_MontoMensual{$el}-($ar_montoTrans{$i}+al_MontoDcto{$el}))=0))  //saldo
						  //If ((($ar_montoTrans{$i}+al_MontoDcto{$el})<al_MontoMensual{$el}) & (($ar_montoTrans{$i}-al_MontoDcto{$el})>0) & ($ar_saldoCargo{$i}=0))  `saldo
						$at_textoMesEnInforme{$i}:=Substring:C12(<>atXS_MonthNames{$mes};1;3)
						$at_textoAbSaInforme{$i}:="Saldo"
						$at_textoMontoMesEnInforme{$i}:=String:C10($ar_montoTrans{$i};"|Despliegue_ACT")
						$añoMes:=String:C10($año;"0000")+String:C10($mes;"00")
						$al_mes{$i}:=Num:C11($añoMes)
						$ar_MontoDcto{$i}:=al_MontoDcto{$el}
					Else 
						  //If ((($ar_montoTrans{$i}+al_MontoDcto{$el})<al_MontoMensual{$el}) & ($ar_saldoCargo{$i}<0))  `abono
						If ((($ar_montoTrans{$i}+al_MontoDcto{$el})<al_MontoMensual{$el}) & ((al_MontoMensual{$el}-($ar_montoTrans{$i}+al_MontoDcto{$el}))>0))  //abono
							$at_textoMesEnInforme{$i}:=Substring:C12(<>atXS_MonthNames{$mes};1;3)
							$at_textoAbSaInforme{$i}:="Abono"
							$at_textoMontoMesEnInforme{$i}:=String:C10($ar_montoTrans{$i};"|Despliegue_ACT")
							$añoMes:=String:C10($año;"0000")+String:C10($mes;"00")
							$al_mes{$i}:=Num:C11($añoMes)
							$ar_MontoDcto{$i}:=al_MontoDcto{$el}
						Else   //tiene disponible
							
						End if 
					End if 
				End if 
			Else   //hay más de una transacción asociada y busco si es saldo o abono
				Case of 
					: (($ar_tranAnter{$i}+al_MontoDcto{$el}-$ar_pagoConDescto{$i})=al_MontoMensual{$el})  //pago con descuento Completo
						$at_textoMesEnInforme{$i}:=Substring:C12(<>atXS_MonthNames{$mes};1;3)
						$at_textoAbSaInforme{$i}:=""
						$at_textoMontoMesEnInforme{$i}:=String:C10($ar_montoTrans{$i};"|Despliegue_ACT")
						$añoMes:=String:C10($año;"0000")+String:C10($mes;"00")
						$al_mes{$i}:=Num:C11($añoMes)
						$ar_MontoDcto{$i}:=al_MontoDcto{$el}
					: (($ar_tranAnter{$i}+al_MontoDcto{$el}+$ar_montoTrans{$el})=al_MontoMensual{$el})  //Saldo
						$at_textoMesEnInforme{$i}:=Substring:C12(<>atXS_MonthNames{$mes};1;3)
						$at_textoAbSaInforme{$i}:="Saldo"
						$at_textoMontoMesEnInforme{$i}:=String:C10($ar_montoTrans{$i};"|Despliegue_ACT")
						$añoMes:=String:C10($año;"0000")+String:C10($mes;"00")
						$al_mes{$i}:=Num:C11($añoMes)
						$ar_MontoDcto{$i}:=al_MontoDcto{$el}
					: (($ar_tranAnter{$i}+al_MontoDcto{$el})<al_MontoMensual{$el})  //abono
						$at_textoMesEnInforme{$i}:=Substring:C12(<>atXS_MonthNames{$mes};1;3)
						$at_textoAbSaInforme{$i}:="Abono"
						$at_textoMontoMesEnInforme{$i}:=String:C10($ar_montoTrans{$i};"|Despliegue_ACT")
						$añoMes:=String:C10($año;"0000")+String:C10($mes;"00")
						$al_mes{$i}:=Num:C11($añoMes)
						$ar_MontoDcto{$i}:=al_MontoDcto{$el}
				End case 
			End if 
		End if 
	End for 
	MULTI SORT ARRAY:C718($al_mes;>;$at_textoMesEnInforme;>;$at_textoAbSaInforme;>;$at_textoMontoMesEnInforme;>;$ar_MontoDcto;>)  //ordeno de acuerdo al mes 
	
	C_BOOLEAN:C305($imprimeAbSa)
	C_BOOLEAN:C305($imprimeMes)
	C_BOOLEAN:C305($imprimeMonto)
	C_BOOLEAN:C305($imprimePts)
	ARRAY TEXT:C222(at_textoAbSaInforme;0)
	COPY ARRAY:C226($at_textoAbSaInforme;at_textoAbSaInforme)
	at_textoAbSaInforme{0}:=""
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->at_textoAbSaInforme;"=";->$DA_Return)
	C_BOOLEAN:C305($comodin)
	$contador:=1
	For ($i;1;Size of array:C274($al_mes))  //lleno las varibles que se imprimirán en el informe
		
		If ($at_textoAbSaInforme{$i}="")  //pago completo
			Case of 
				: (Size of array:C274($DA_Return)=1)
					$imprimeAbSa:=False:C215
					$imprimeMes:=(v_2NombreMesP=1)
					$imprimeMonto:=(v_2MontoP=1)
					$imprimePts:=(v_2MontoPP=1)
					$comodin:=True:C214
				: ((Size of array:C274($DA_Return)>=2) & ($contador=1))  //imprime sólo nombre del mes
					$imprimeAbSa:=False:C215
					$imprimeMes:=True:C214
					$imprimeMonto:=False:C215
					$imprimePts:=False:C215
					$contador:=$contador+1
					$comodin:=True:C214
				: ((Size of array:C274($DA_Return)>=2) & (($contador)=Size of array:C274($DA_Return)))
					$imprimeAbSa:=False:C215
					$imprimeMes:=True:C214
					$imprimeMonto:=False:C215
					$imprimePts:=False:C215
					$at_textoMesEnInforme{$i}:="- "+$at_textoMesEnInforme{$i}
					$contador:=$contador+1
					$comodin:=False:C215
				Else 
					$imprimeAbSa:=False:C215
					$imprimeMes:=False:C215
					$imprimeMonto:=False:C215
					$imprimePts:=False:C215
					$contador:=$contador+1
					$comodin:=True:C214
			End case 
		Else   //cuando es un segundo pago
			If ($at_textoAbSaInforme{$i}="Abono")  //abono
				$imprimeAbSa:=(v_2AbonoA=1)
				$imprimeMes:=(v_2NombreMesA=1)
				$imprimeMonto:=(v_2MontoA=1)
				$imprimePts:=(v_2MontoPA=1)
				$comodin:=True:C214
			Else 
				If ($at_textoAbSaInforme{$i}="Saldo")  //saldo
					$imprimeAbSa:=(v_2SaldoS=1)
					$imprimeMes:=(v_2NombreMesS=1)
					$imprimeMonto:=(v_2MontoS=1)
					$imprimePts:=(v_2MontoPS=1)
					$comodin:=True:C214
				End if 
			End if 
		End if 
		If ((($i=1) | (Size of array:C274($DA_Return)<=1) | ($i>Size of array:C274($DA_Return)) | ($contador=2)) & ($comodin))
			vt_Mes:=vt_Mes+ST_Boolean2Str (vt_Mes="";"";","+$espacio)+ST_Boolean2Str ($imprimeAbSa;$at_textoAbSaInforme{$i};"")+ST_Boolean2Str ($imprimeAbSa;$espacio;"")+ST_Boolean2Str ($imprimeMes;$at_textoMesEnInforme{$i};"")+ST_Boolean2Str ($imprimeMes;$espacio;"")+ST_Boolean2Str ($imprimePts;"(";"")+ST_Boolean2Str ($imprimeMonto;$at_textoMontoMesEnInforme{$i};"")+ST_Boolean2Str ($imprimePts;")";"")
		Else 
			If (Size of array:C274($DA_Return)=($contador-1))
				vt_Mes:=vt_Mes+$at_textoMesEnInforme{$i}
			End if 
		End if 
	End for 
	
	COPY ARRAY:C226(al_MontoMensual;al_MontoMensualTemp)
	AT_DistinctsArrayValues (->al_MontoMensualTemp)  //línea monto mensual
	C_BOOLEAN:C305($continuar)
	$continuar:=False:C215
	If (Size of array:C274($at_textoAbSaInforme)>0)
		For ($xx;1;Size of array:C274($at_textoAbSaInforme))
			If (($at_textoAbSaInforme{$xx}="") & (v_3MontoP=1))
				$continuar:=True:C214
			Else 
				If (($at_textoAbSaInforme{$xx}="Abono") & (v_3MontoA=1))
					$continuar:=True:C214
				Else 
					If (($at_textoAbSaInforme{$xx}="Saldo") & (v_3MontoS=1))
						$continuar:=True:C214
					End if 
				End if 
			End if 
		End for 
		If ($continuar)
			For ($i;1;Size of array:C274(al_MontoMensualTemp))  //lleno el monto mensual 
				vt_MontoMensual:=vt_MontoMensual+ST_Boolean2Str (vt_MontoMensual="";"";$espacio+"-"+$espacio)+String:C10(al_MontoMensualTemp{$i};"|Despliegue_ACT")
			End for 
		Else 
			vt_MontoMensual:=""
		End if 
	End if 
	
	C_TEXT:C284($vt_MontoPagado)  //monto total colegiatura
	$vt_MontoPagado:=""
	For ($i;1;Size of array:C274($at_textoMontoMesEnInforme))
		$vt_MontoPagado:=String:C10(Num:C11($vt_MontoPagado)+Num:C11($at_textoMontoMesEnInforme{$i});"|Despliegue_ACT")
	End for 
	
	  //vr_MontoPagadoCol:=AT_GetSumArray (->$ar_montoTrans)-AT_GetSumArray (->$ar_MontoDcto)
	vr_MontoPagadoCol:=AT_GetSumArray (->$ar_montoTrans)
	
	$vt_MontoMensual:=""
	$vt_MontoTotal:=""
	$NoRepeticiones:=""
	For ($i;1;Size of array:C274($ar_MontoDcto))
		If (Num:C11($vt_MontoMensual)#$ar_MontoDcto{$i})
			$vt_MontoMensual:=$vt_MontoMensual+ST_Boolean2Str ($vt_MontoMensual#"";" - ";"")+String:C10($ar_MontoDcto{$i};"|Despliegue_ACT")  //si los montos son distintos se suman
		End if 
		If (($at_textoAbSaInforme{$i}="") & (v_GSumarP=1))
			$vt_MontoTotal:=String:C10(Num:C11($vt_MontoTotal)+$ar_MontoDcto{$i};"|Despliegue_ACT")
			$NoRepeticiones:=String:C10(Num:C11($NoRepeticiones)+1)
		Else 
			If (($at_textoAbSaInforme{$i}="Abono") & (v_GSumarA=1))
				$vt_MontoTotal:=String:C10(Num:C11($vt_MontoTotal)+$ar_MontoDcto{$i};"|Despliegue_ACT")
				$NoRepeticiones:=String:C10(Num:C11($NoRepeticiones)+1)
			Else 
				If (($at_textoAbSaInforme{$i}="Saldo") & (v_GSumarS=1))
					$vt_MontoTotal:=String:C10(Num:C11($vt_MontoTotal)+$ar_MontoDcto{$i};"|Despliegue_ACT")
					$NoRepeticiones:=String:C10(Num:C11($NoRepeticiones)+1)
				End if 
			End if 
		End if 
	End for 
	$NoRepeticiones:=String:C10(Num:C11($NoRepeticiones)-Size of array:C274(al_ItemsSinCategoria))  //para cuando hayan cargos que nos sean de categorias
	
	C_BOOLEAN:C305($continuar)
	C_TEXT:C284($vt_TextoIzq)
	C_TEXT:C284($vt_TextoDer)
	$ImprimelineaIzq:=False:C215
	$ImprimelineaDer:=False:C215
	$vt_TextoIzq:=""
	$vt_TextoDer:=""
	If (Size of array:C274($at_textoAbSaInforme)>0)  //defino lo que se imprime de acuerdo a  lo configurado
		For ($xx;1;Size of array:C274($at_textoAbSaInforme))
			Case of 
				: ($at_textoAbSaInforme{$xx}="")
					If (v_4MontoMensualP=1)
						$ImprimelineaIzq:=True:C214
						$vt_TextoIzq:=$vt_MontoMensual
						If (v_4RepiteMonto1EnMonto2P=1)
							$ImprimelineaDer:=True:C214
							$vt_TextoDer:=$vt_TextoIzq
						End if 
					Else 
						If (v_4MontoTotalP=1)
							$ImprimelineaIzq:=True:C214
							$vt_TextoIzq:=$vt_MontoTotal
							If (v_4RepiteMonto1EnMonto2P=1)
								$ImprimelineaDer:=True:C214
								$vt_TextoDer:=$vt_TextoIzq
							End if 
						Else 
							If (v_4MontoMensualNoVecesP=1)
								If ($vt_MontoMensual#"")
									$ImprimelineaIzq:=True:C214
									$vt_TextoIzq:=$vt_MontoMensual+" x "+$NoRepeticiones
								End if 
							End if 
						End if 
					End if 
					If (v_4MontosSeparadosP=1)
						$ImprimelineaIzq:=True:C214
						$ImprimelineaDer:=True:C214
						$vt_TextoIzq:=$vt_MontoMensual
						$vt_TextoDer:=$vt_MontoTotal
					End if 
					
					If (v_4MontoColegiaturaLinea2P=1)
						$ImprimelineaDer:=True:C214
						$vt_TextoDer:=$vt_MontoPagado
					End if 
				: ($at_textoAbSaInforme{$xx}="Abono")
					If (v_4MontoMensualA=1)
						$ImprimelineaIzq:=True:C214
						$vt_TextoIzq:=$vt_MontoMensual
						If (v_4RepiteMonto1EnMonto2A=1)
							$ImprimelineaDer:=True:C214
							$vt_TextoDer:=$vt_TextoIzq
						End if 
					Else 
						If (v_4MontoTotalA=1)
							$ImprimelineaIzq:=True:C214
							$vt_TextoIzq:=$vt_MontoTotal
							If (v_4RepiteMonto1EnMonto2A=1)
								$ImprimelineaDer:=True:C214
								$vt_TextoDer:=$vt_TextoIzq
							End if 
						Else 
							If (v_4MontoMensualNoVecesA=1)
								If ($vt_MontoMensual#"")
									$ImprimelineaIzq:=True:C214
									$vt_TextoIzq:=$vt_MontoMensual+" x "+$NoRepeticiones
								End if 
							End if 
						End if 
					End if 
					If (v_4MontosSeparadosA=1)
						$ImprimelineaIzq:=True:C214
						$ImprimelineaDer:=True:C214
						$vt_TextoIzq:=$vt_MontoMensual
						$vt_TextoDer:=$vt_MontoTotal
					End if 
					
					If (v_4MontoColegiaturaLinea2A=1)
						$ImprimelineaDer:=True:C214
						$vt_TextoDer:=$vt_MontoPagado
					End if 
				: ($at_textoAbSaInforme{$xx}="Saldo")
					If (v_4MontoMensualS=1)
						$ImprimelineaIzq:=True:C214
						$vt_TextoIzq:=$vt_MontoMensual
						If (v_4RepiteMonto1EnMonto2S=1)
							$ImprimelineaDer:=True:C214
							$vt_TextoDer:=$vt_TextoIzq
						End if 
					Else 
						If (v_4MontoTotalS=1)
							$ImprimelineaIzq:=True:C214
							$vt_TextoIzq:=$vt_MontoTotal
							If (v_4RepiteMonto1EnMonto2S=1)
								$ImprimelineaDer:=True:C214
								$vt_TextoDer:=$vt_TextoIzq
							End if 
						Else 
							If (v_4MontoMensualNoVecesS=1)
								If ($vt_MontoMensual#"")
									$ImprimelineaIzq:=True:C214
									$vt_TextoIzq:=$vt_MontoMensual+" x "+$NoRepeticiones
								End if 
							End if 
						End if 
					End if 
					If (v_4MontosSeparadosS=1)
						$ImprimelineaIzq:=True:C214
						$ImprimelineaDer:=True:C214
						$vt_TextoIzq:=$vt_MontoMensual
						$vt_TextoDer:=$vt_MontoTotal
					End if 
					
					If (v_4MontoColegiaturaLinea2S=1)
						$ImprimelineaDer:=True:C214
						$vt_TextoDer:=$vt_MontoPagado
					End if 
			End case 
		End for 
		
		vt_Becas:=$vt_TextoIzq  //finalmente esto muestra
		vt_Becas2:=$vt_TextoDer
		
		C_REAL:C285($montoMes)
		C_REAL:C285($montoDctoMes)
		C_REAL:C285($pagosMes)
		C_TEXT:C284(vt_Abono)
		vt_Abono:="0"
		C_TEXT:C284(vt_SaldoAbono)  //´linea abono
		vt_SaldoAbono:="0"
		ARRAY TEXT:C222(at_textoAbSaInforme;0)
		COPY ARRAY:C226($at_textoAbSaInforme;at_textoAbSaInforme)
		at_textoAbSaInforme{0}:="Abono"
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->at_textoAbSaInforme;"=")
		
		If (Size of array:C274($DA_Return)>0)
			For ($i;1;Size of array:C274($DA_Return))
				vt_Abono:=String:C10(Num:C11(vt_Abono)+Num:C11($at_textoMontoMesEnInforme{$DA_Return{$i}}))
				$var:=String:C10($al_mes{$DA_Return{$i}})
				$var:=Substring:C12($var;5;2)+Substring:C12($var;1;4)
				$existe:=Find in array:C230(at_Periodo;$var)
				If ($existe>0)
					$montoMes:=$montoMes+al_MontoMensual{$existe}
					$montoDctoMes:=$montoDctoMes+al_MontoDcto{$existe}
					If ($ar_tranAnter{$DA_Return{$i}}=0)
						$pagosMes:=$pagosMes+ar_montoPagos{$existe}
					Else 
						$pagosMes:=$pagosMes+$ar_tranAnter{$DA_Return{$i}}
					End if 
				End if 
			End for 
			If (Size of array:C274($ar_MontoDcto)>0)
				vt_SaldoAbono:="(Saldo Abono "+String:C10($montoMes-$montoDctoMes-$pagosMes;"|Despliegue_ACT")+")"
			Else 
				vt_SaldoAbono:="(Saldo Abono "+String:C10($montoMes-$pagosMes;"|Despliegue_ACT")+")"
			End if 
		Else 
			vt_SaldoAbono:="(Saldo Abono "+String:C10(Num:C11(vt_SaldoAbono);"|Despliegue_ACT")+")"
		End if 
	End if 
	
Else 
	vt_Abono:="0"
	vt_MontoMensual:="0"
End if 

atACT_NombreCategoria{0}:="Derecho de Matrícula@"  //busco la categoria que corresponde a la matrícula
ARRAY LONGINT:C221($DA_Return;0)
AT_SearchArray (->atACT_NombreCategoria;"=";->$DA_Return)
If ($al_MontoCategoria{$DA_Return{1}}=0)
	vt_AgnoBoleta:=""
End if 

ARRAY TEXT:C222(aText1;0)
AT_RedimArrays (12;->aText1)
C_TEXT:C284($mesArr)
For ($i;1;Size of array:C274($at_añoMesLineaMes))
	$mesArr:=Substring:C12($at_añoMesLineaMes{$i};1;2)
	If (Num:C11($mesArr)>0)
		aText1{Num:C11($mesArr)}:="X"
	End if 
End for 

If (Size of array:C274(al_ItemsSinCategoria)>0)  //para cargos que no pertenecen a las categorías
	vt_Abono:="0"
	For ($i;1;Size of array:C274($aIDCategoria))  //lleno las variables nombre categoria y monto categoria que se imprimen en el informe
		$variable:=Get pointer:C304("vt_CategoriaNombre"+String:C10($i))
		$variable2:=Get pointer:C304("vr_CategoriaMonto"+String:C10($i))
		$variable->:=atACT_NombreCategoria{$i}
		$variable2->:=0
	End for 
	For ($i;1;Size of array:C274(al_ItemsSinCategoria))
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=al_ItemsSinCategoria{$i})
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Transaccion:1=al_TransaccionesSinCat{$i})
		$el:=Position:C15(" x ";vt_Becas2)
		If ($el>0)
			$montoBeca2:=Num:C11(Substring:C12(vt_Becas2;1;$el))
		Else 
			$montoBeca2:=Num:C11(vt_Becas2)
		End if 
		If ((v_4MontoColegiaturaLinea2P=1) | (v_4MontoColegiaturaLinea2A=1) | (v_4MontoColegiaturaLinea2S=1))
			  //vt_Becas2:=String($montoBeca2+[ACT_Cargos]Monto_Neto;"|Despliegue_ACT")
			vt_Becas2:=String:C10($montoBeca2+[ACT_Transacciones:178]Debito:6;"|Despliegue_ACT")
		Else 
			If ($montoBeca2>=[ACT_Cargos:173]Monto_Neto:5)
				  //vt_Becas2:=String($montoBeca2-[ACT_Cargos]Monto_Neto;"|Despliegue_ACT")
				vt_Becas2:=String:C10($montoBeca2-[ACT_Transacciones:178]Debito:6;"|Despliegue_ACT")
			Else 
				  //vt_Becas2:=String($montoBeca2+[ACT_Cargos]Monto_Neto;"|Despliegue_ACT")
				vt_Becas2:=String:C10($montoBeca2+[ACT_Transacciones:178]Debito:6;"|Despliegue_ACT")
			End if 
		End if 
		
		If (vb_ImprimeTexto=1)
			vt_Mes:=vt_Mes+" "+textoAImprimir
		End if 
	End for 
	
	ARRAY LONGINT:C221(al_MontoMensual;0)  //busco el monto mensual, el período y el monto de los descuentos
	ARRAY TEXT:C222(at_Periodo;0)
	ARRAY REAL:C219(ar_montoPagos;0)
	ARRAY LONGINT:C221(al_MontoDcto;0)
	ARRAY TEXT:C222(at_cargosIdsCol;0)
	
	For ($i;1;Size of array:C274(al_ItemsSinCategoria))
		ARRAY LONGINT:C221(al_RNCargosCol;0)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=al_ItemsSinCategoria{$i})
		$mes:=[ACT_Cargos:173]Mes:13
		$año:=[ACT_Cargos:173]Año:14
		at_Periodo{0}:=String:C10($mes;"00")+String:C10($año;"0000")
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->at_Periodo;"=";->$DA_Return)
		If (Size of array:C274($DA_Return)=0)
			  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=$id_CtaCte;*)
			QUERY:C277([ACT_Cargos:173];$y_IDCargoApoTer->=$id_Apoderado;*)
			If ($id_CtaCte#0)
				QUERY:C277([ACT_Cargos:173]; & ;$y_IDCargoCuenta->=$id_CtaCte;*)
			End if 
			
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$mes;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$año;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]No_Incluir_en_DocTrib:50=False:C215)
			SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_RNCArgos)  //para cuando haya más que sólo colegiatura para un mes
			For ($r;1;Size of array:C274($al_RNCArgos))
				GOTO RECORD:C242([ACT_Cargos:173];$al_RNCArgos{$r})
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
				If ([xxACT_Items:179]ID_Categoria:8=0)
					AT_Insert (1;1;->al_RNCargosCol)
					al_RNCargosCol{1}:=[ACT_Cargos:173]ID:1
				End if 
			End for 
			If (Size of array:C274(al_RNCargosCol)>0)
				QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;al_RNCargosCol)
				AT_Insert (0;1;->al_MontoMensual;->at_Periodo;->ar_montoPagos;->al_MontoDcto;->at_cargosIdsCol)
				al_MontoMensual{Size of array:C274(al_MontoMensual)}:=Sum:C1([ACT_Cargos:173]Monto_Bruto:24)
				at_Periodo{Size of array:C274(at_Periodo)}:=String:C10($mes;"00")+String:C10($año;"0000")
				al_MontoDcto{Size of array:C274(al_MontoDcto)}:=Sum:C1([ACT_Cargos:173]Descuentos_Individual:31)+Sum:C1([ACT_Cargos:173]Descuentos_Familia:26)+Sum:C1([ACT_Cargos:173]Descuentos_XItem:35)
				KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
				  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]ID_Pago>0)
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0;*)
				QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Balanceo Descuento")
				ar_montoPagos{Size of array:C274(ar_montoPagos)}:=Sum:C1([ACT_Transacciones:178]Debito:6)
				at_cargosIdsCol{Size of array:C274(at_cargosIdsCol)}:=AT_array2text (->al_RNCargosCol)
			End if 
		End if 
	End for 
	
	ARRAY TEXT:C222($at_textoMesEnInforme;0)
	ARRAY TEXT:C222($at_textoAbSaInforme;0)
	ARRAY TEXT:C222($at_textoMontoMesEnInforme;0)
	ARRAY LONGINT:C221($al_mes;0)
	ARRAY REAL:C219($ar_MontoDcto;0)
	ARRAY TEXT:C222($at_añoMesLineaMes;0)
	ARRAY REAL:C219($ar_montoTrans;0)
	ARRAY REAL:C219($ar_saldoCargo;0)
	ARRAY REAL:C219($ar_tranAnter;0)
	
	For ($i;1;Size of array:C274(al_TransaccionesSinCat))  //lleno la línea mes
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Transaccion:1=al_TransaccionesSinCat{$i})
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=al_ItemsSinCategoria{$i})
		$mes:=[ACT_Cargos:173]Mes:13
		$año:=[ACT_Cargos:173]Año:14
		$existe:=Find in array:C230($at_añoMesLineaMes;String:C10($mes;"00")+String:C10($año;"0000"))
		$el:=Find in array:C230(at_Periodo;String:C10($mes;"00")+String:C10($año;"0000"))
		If ($el>0)
			ARRAY LONGINT:C221(al_RNCargosCol;0)
			AT_Text2Array (->al_RNCargosCol;at_cargosIdsCol{$el})
			QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;al_RNCargosCol)
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]ID_Pago>0)
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4>0;*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Balanceo Descuento")
			$transaccionMasAlta:=AT_Maximum (->al_TransaccionesSinCat)
			KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
			ARRAY LONGINT:C221($al_idsPagos;0)
			AT_DistinctsFieldValues (->[ACT_Pagos:172]ID:1;->$al_idsPagos)
		End if 
		If (Size of array:C274($al_idsPagos)=1)  //solo hay un pago asociado al cargo
			$tranAnter:=0
		Else 
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Transaccion:1<=$transaccionMasAlta)
			If (Find in array:C230($al_idsPagos;$vl_idPago)#-1)
				AT_Delete (Find in array:C230($al_idsPagos;$vl_idPago);1;->$al_idsPagos)
			End if 
			QRY_QueryWithArray (->[ACT_Transacciones:178]ID_Pago:4;->$al_idsPagos;True:C214)
			$tranAnter:=Sum:C1([ACT_Transacciones:178]Debito:6)  //monto anterior
		End if 
		If ($existe>0)
			$ar_montoTrans{$existe}:=$ar_montoTrans{$existe}+[ACT_Transacciones:178]Debito:6
			$ar_saldoCargo{$existe}:=$ar_saldoCargo{$existe}+[ACT_Cargos:173]Saldo:23
			$ar_tranAnter{$existe}:=$tranAnter
		Else 
			INSERT IN ARRAY:C227($at_añoMesLineaMes;Size of array:C274($at_añoMesLineaMes)+1;1)
			INSERT IN ARRAY:C227($ar_montoTrans;Size of array:C274($at_añoMesLineaMes)+1;1)
			INSERT IN ARRAY:C227($ar_saldoCargo;Size of array:C274($at_añoMesLineaMes)+1;1)
			INSERT IN ARRAY:C227($ar_tranAnter;Size of array:C274($at_añoMesLineaMes)+1;1)
			$at_añoMesLineaMes{Size of array:C274($at_añoMesLineaMes)}:=String:C10($mes;"00")+String:C10($año;"0000")
			$ar_montoTrans{Size of array:C274($ar_montoTrans)}:=[ACT_Transacciones:178]Debito:6
			$ar_saldoCargo{Size of array:C274($ar_saldoCargo)}:=[ACT_Cargos:173]Saldo:23
			$ar_tranAnter{Size of array:C274($ar_tranAnter)}:=$tranAnter
		End if 
	End for 
	C_REAL:C285($vr_abono;$vr_saldo)
	For ($i;1;Size of array:C274($at_añoMesLineaMes))
		$el:=Find in array:C230(at_Periodo;$at_añoMesLineaMes{$i})
		If ($el#-1)
			If ($ar_tranAnter{$i}=0)  //hay sólo una transacción asociada
				If ($ar_montoTrans{$i}=al_MontoMensual{$el})  //mes completo
				Else 
					  //If ((($ar_montoTrans{$i}+al_MontoDcto{$el})<al_MontoMensual{$el}) & ($ar_saldoCargo{$i}=0))  `saldo
					If (($ar_montoTrans{$i}+al_MontoDcto{$el})=al_MontoMensual{$el})  //saldo
						$vr_abono:=$vr_abono+0
						$vr_saldo:=$vr_saldo+0
					Else 
						  //If ((($ar_montoTrans{$i}+al_MontoDcto{$el})<al_MontoMensual{$el}) & ($ar_saldoCargo{$i}<0))  `abono
						If (($ar_montoTrans{$i}+al_MontoDcto{$el})<al_MontoMensual{$el})  //abono
							$vr_abono:=$vr_abono+$ar_montoTrans{$i}
							$vr_saldo:=$vr_saldo+al_MontoMensual{$el}-$ar_montoTrans{$i}
						End if 
					End if 
				End if 
			Else   //hay más de una transacción asociada y busco si es saldo o abono
				If (($ar_tranAnter{$i}+al_MontoDcto{$el})=al_MontoMensual{$el})  //Saldo
					$vr_abono:=$vr_abono+0
					$vr_saldo:=$vr_saldo+0
				Else 
					If (($ar_tranAnter{$i}+al_MontoDcto{$el})<al_MontoMensual{$el})  //abono
						$vr_abono:=$vr_abono+$ar_tranAnter{$i}
						$vr_saldo:=$vr_saldo+al_MontoMensual{$el}-$ar_tranAnter{$i}
					End if 
				End if 
			End if 
			vt_Abono:=String:C10($vr_abono;"|Despliegue_ACT")
			vt_SaldoAbono:="(Saldo Abono "+String:C10($vr_saldo;"|Despliegue_ACT")+")"
		End if 
	End for 
End if 

For ($i;1;Size of array:C274($at_añoMesLineaMes))  //por si se paga para otros meses con items sin categorias
	$mesArr:=Substring:C12($at_añoMesLineaMes{$i};1;2)
	If (Num:C11($mesArr)>0)
		aText1{Num:C11($mesArr)}:="X"
	End if 
End for 

READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Pagos:172])

C_TEXT:C284(vText1;vText2;vText3;vText4;vText5;vText6)
vText1:=""
vText2:=""
vText3:=""
vText4:=""
vText5:=""
vText6:=""  //se llena sólo en X
QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$id_CtaCte)
vText4:=String:C10([ACT_CuentasCorrientes:175]Descuento:23)
QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
vt_NombreAlumno:=[Alumnos:2]apellidos_y_nombres:40
vt_CursoAlumno:=[Alumnos:2]curso:20
vText1:=[Alumnos:2]RUT:5
vText2:=[Alumnos:2]Direccion:12
vText3:=[Alumnos:2]Ciudad:15
  //QUERY([Personas];[Personas]No=$id_Apoderado)
QUERY:C277($y_TablaApoTer->;$y_CampoApoTer->=$id_Apoderado)  //cambio
vt_NombreApo:=$y_NombreApoderado->
vt_MontoBoletaPalabras:=""
QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=$id_Boleta)
vr_NoBoleta:=[ACT_Boletas:181]Numero:11
vText6:=[ACT_Boletas:181]EmitidoPor:17  //sólo en X se llena
vt_MontoBoletaPalabras:=ST_Num2Text2 ([ACT_Boletas:181]Monto_Total:6;"Spanish")+" pesos."
vr_MontoBoleta:=[ACT_Boletas:181]Monto_Total:6
vr_Abono:=Num:C11(vt_Abono)  //para dar el forrmato en el informe
  //vr_MontoMensual:=Num(vt_MontoMensual)  `esta línea la tenía comentada sin querer... `hay que cambiar el nombre de la variable en el informe a vt_MontoMensual
vt_DiaBol:=String:C10(Day of:C23([ACT_Boletas:181]FechaEmision:3);"00")
vt_MesBol:=String:C10(Month of:C24([ACT_Boletas:181]FechaEmision:3);"00")
vt_AgnoBol:=String:C10(Year of:C25([ACT_Boletas:181]FechaEmision:3);"0000")
vt_MesAgnoBol:=<>atXS_MonthNames{Month of:C24([ACT_Boletas:181]FechaEmision:3)}+" de "+String:C10(Year of:C25([ACT_Boletas:181]FechaEmision:3);"0000")
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=[ACT_Transacciones:178]ID_Pago:4)
vText5:=[ACT_Pagos:172]forma_de_pago_new:31

C_TEXT:C284(vt_ObservacionBol;$periodo;$texto)
C_REAL:C285($saldoTemp)
vt_ObservacionBol:=""
If (Size of array:C274(at_Periodo)>0)
	ARRAY TEXT:C222(at_periodoTemp;0)
	COPY ARRAY:C226(at_Periodo;at_periodoTemp)
	For ($i;1;Size of array:C274(at_periodoTemp))
		at_periodoTemp{$i}:=Substring:C12(at_periodoTemp{$i};3;4)  //obtengo sólo el año de este arreglo
	End for 
	AT_DistinctsArrayValues (->ar_DctosMensuales)  //Para obtener los descuentos mensuales por mes
	
	AT_DistinctsArrayValues (->at_periodoTemp)  //obtengo los años
	For ($i;1;Size of array:C274(at_periodoTemp))  //lleno la variable con los años
		$periodo:=ST_Boolean2Str ($periodo="";"";$periodo+" - ")+at_periodoTemp{$i}
	End for 
	C_BOOLEAN:C305($completoObs;$abonoObs;$saldoObs)
	C_REAL:C285($montoObsC;$montoObsA;$montoObsS)
	Case of 
		: ($impresionEspecial)
			$imprimeAbSa:=(v_2SaldoS=1)
			$imprimeMes:=(v_2NombreMesS=1)
			$imprimeMonto:=(v_2MontoS=1)
			$imprimePts:=(v_2MontoPS=1)
			
			$at_textoAbSaInforme{1}:="Saldo"
			
			vt_Mes:=ST_Boolean2Str ($imprimeAbSa;$at_textoAbSaInforme{1};"")+ST_Boolean2Str ($imprimeAbSa;$espacio;"")+ST_Boolean2Str ($imprimeMes;$at_textoMesEnInforme{1};"")+ST_Boolean2Str ($imprimeMes;$espacio;"")+ST_Boolean2Str ($imprimePts;"(";"")+ST_Boolean2Str ($imprimeMonto;$at_textoMontoMesEnInforme{1};"")+ST_Boolean2Str ($imprimePts;")";"")
			vt_Becas:=""
			vt_Becas2:=""
			
			vt_Abono:=""
			vr_Abono:=0
			
			vt_Abono:="0"
			vt_SaldoAbono:="(Saldo Abono 0)"
			$montoObsS:=$ar_montoTrans{1}
			$vt_MontoTotal:="0"
			$saldoObs:=True:C214
		Else 
			If (Size of array:C274($ar_MontoDcto)>0)
				For ($i;1;Size of array:C274($ar_MontoDcto))
					Case of 
						: (at_textoAbSaInforme{$i}="")
							$montoObsC:=$montoObsC+$ar_MontoDcto{$i}
							$completoObs:=True:C214
						: (at_textoAbSaInforme{$i}="Abono")
							$montoObsA:=$montoObsA+$ar_MontoDcto{$i}
							$abonoObs:=True:C214
						: (at_textoAbSaInforme{$i}="Saldo")
							$montoObsS:=$montoObsS+$ar_MontoDcto{$i}
							$saldoObs:=True:C214
					End case 
				End for 
			Else 
				vt_ObservacionBol:=vt_ObservacionBol+vt_obsCompletoSBeca+"\r"  //para ítems sin categorías.
			End if 
	End case 
	
	If (v_ImprimeObsS=1)
		If ($saldoObs)
			If (Num:C11($vt_MontoTotal)>0)  //con beca
				vt_ObservacionBol:=vt_ObservacionBol+vt_obsSaldoCbeca+"\r"
				vt_ObservacionBol:=Replace string:C233(vt_ObservacionBol;"&M";String:C10($montoObsS;"|Despliegue_ACT"))
			Else   //sin beca
				vt_ObservacionBol:=vt_ObservacionBol+vt_obsSaldoSbeca+"\r"
			End if 
		End if 
	End if 
	
	If (v_ImprimeObsC=1)
		If ($completoObs)
			If (Num:C11($vt_MontoTotal)>0)
				vt_ObservacionBol:=vt_ObservacionBol+vt_obsCompletoCBeca+"\r"
				vt_ObservacionBol:=Replace string:C233(vt_ObservacionBol;"&M";String:C10($montoObsC;"|Despliegue_ACT"))
			Else 
				vt_ObservacionBol:=vt_ObservacionBol+vt_obsCompletoSBeca+"\r"
			End if 
		End if 
	End if 
	If (v_ImprimeObsA=1)
		If ($abonoObs)
			If (Num:C11($vt_MontoTotal)>0)  //con beca
				vt_ObservacionBol:=vt_ObservacionBol+vt_obsAbonoCBeca+"\r"
				vt_ObservacionBol:=Replace string:C233(vt_ObservacionBol;"&M";String:C10($montoObsA;"|Despliegue_ACT"))
			Else   //sin beca
				vt_ObservacionBol:=vt_ObservacionBol+vt_obsAbonoSBeca+"\r"
			End if 
		End if 
	End if 
	
Else 
	Case of 
		: (vt_AgnoBoleta#"")
			$periodo:=vt_AgnoBoleta
		: (Size of array:C274(al_RNItems)>0)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=al_RNItems{1})
			$periodo:=String:C10([ACT_Cargos:173]Año:14)
		: (Size of array:C274(al_ItemsSinCategoria)>0)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=al_ItemsSinCategoria{1})
			$periodo:=String:C10([ACT_Cargos:173]Año:14)
		Else 
			$periodo:=String:C10(Year of:C25(Current date:C33(*));"0000")
	End case 
	If (v_ImprimeObsC=1)
		If ([ACT_Boletas:181]Monto_Total:6>0)
			vt_ObservacionBol:=vt_obsCompletoSBeca+"\r"
		End if 
	End if 
End if 
$texto:=vt_ObservacionBol
$saldoTemp:=Num:C11(vt_SaldoAbono)
  //$texto:=Replace string($texto;"&B";String([ACT_CuentasCorrientes]Descuento)+"%")
$texto:=Replace string:C233($texto;"&B";AT_array2text (->ar_DctosMensuales;" - ";"###")+"%")
$texto:=Replace string:C233($texto;"&M";$vt_MontoTotal)
$texto:=Replace string:C233($texto;"&A";$periodo)
$texto:=Replace string:C233($texto;"&S";String:C10($saldoTemp;"|Despliegue_ACT"))
vt_ObservacionBol:=$texto

If (v_5ImprimeAbonoA=0)  //si no imprime abono limpio la variable porque la utilizo.
	vt_SaldoAbono:=""
End if 