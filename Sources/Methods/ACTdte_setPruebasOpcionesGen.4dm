//%attributes = {}
  //ACTdte_setPruebasOpcionesGen
C_TEXT:C284($vt_accion;$1;$vt_retorno;$0;$vt_pref)
C_TEXT:C284($vt_atencion;$vt_descripcion;$vt_variableCaso)
C_POINTER:C301($vy_pointer1;$vy_pointer2;$vy_pointer3)
C_POINTER:C301(${2})
C_LONGINT:C283($vl_line)
C_BLOB:C604($xBlob)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 
Case of 
	: ($vt_accion="InitVars")
		C_TEXT:C284(vt_variableCaso;vt_descripcionAtencion;vt_variableCaso;vt_referencia;vt_razonReferencia;vt_numeroAtencion)
		C_REAL:C285(vrACTdte_DescuentoAfecto;vrACTdte_DescuentoExento;vrACTdte_DescuentoGlobal;vr_neto;vr_iva;vr_total;vrACTdte_dctoRecargo)
		C_REAL:C285(vr_exento)
		C_LONGINT:C283(vlACT_idBoleta)
		C_LONGINT:C283(vlACT_apoderadoID;vlACT_terceroID)
		
		ARRAY TEXT:C222(at_tipoDocumento;0)
		
		vt_numeroAtencion:=""
		vt_variableCaso:=""
		vt_descripcionAtencion:=""
		vt_variableCaso:=""
		vt_referencia:=""
		vt_razonReferencia:=""
		vrACTdte_DescuentoAfecto:=0
		vrACTdte_DescuentoExento:=0
		vrACTdte_DescuentoGlobal:=0
		vr_neto:=0
		vr_iva:=0
		vr_total:=0
		vrACTdte_dctoRecargo:=0
		vr_exento:=0
		
		
		ARRAY TEXT:C222(atACT_item;0)
		ARRAY BOOLEAN:C223(abACT_afecto;0)
		ARRAY REAL:C219(arACT_cantidad;0)
		ARRAY REAL:C219(arACT_valorUnitario;0)
		ARRAY REAL:C219(arACT_descuento;0)
		ARRAY REAL:C219(arACT_total;0)
		ARRAY TEXT:C222(atACT_unidadMedida;0)
		at_tipoDocumento:=0
		
		C_BOOLEAN:C305(vbACT_editaCaso)
		vbACT_editaCaso:=False:C215
		
		ARRAY TEXT:C222(atACT_Caso2;0)
		atACT_Caso2:=0
		
		ARRAY TEXT:C222(atACT_referencia;0)
		atACT_referencia:=0
		
		vlACT_idBoleta:=0
		vlACT_apoderadoID:=0
		vlACT_terceroID:=0
		
	: ($vt_accion="CargaReferencias")
		
		READ ONLY:C145([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="ACT_DTE_SETPRUEBAS_@")
		
		ORDER BY:C49([xShell_Prefs:46];[xShell_Prefs:46]Reference:1;>)
		SELECTION TO ARRAY:C260([xShell_Prefs:46]Reference:1;$vy_pointer1->)
		
	: ($vt_accion="CargaListado")
		ARRAY TEXT:C222(atACT_NumAtencion;0)
		ARRAY TEXT:C222(atACT_Descripcion;0)
		ARRAY TEXT:C222(atACT_Text;0)
		ARRAY TEXT:C222(atACT_Caso;0)
		
		ACTdte_setPruebasOpcionesGen ("CargaReferencias";->atACT_Text)
		
		For ($i;1;Size of array:C274(atACT_Text))
			APPEND TO ARRAY:C911(atACT_NumAtencion;ST_GetWord (atACT_Text{$i};4;"_"))
			APPEND TO ARRAY:C911(atACT_Descripcion;ST_GetWord (atACT_Text{$i};5;"_"))
			APPEND TO ARRAY:C911(atACT_Caso;ST_GetWord (atACT_Text{$i};6;"_"))
		End for 
		  //SORT ARRAY(atACT_Text;atACT_NumAtencion;atACT_Descripcion;atACT_Caso;<)
		AT_MultiLevelSort ("<>>>";->atACT_NumAtencion;->atACT_Caso;->atACT_Descripcion;->atACT_Text)
		
	: ($vt_accion="InsertaElemento")
		WDW_OpenFormWindow (->[ACT_Boletas:181];"setDePruebas";-1;4;__ ("Set de pruebas"))
		DIALOG:C40([ACT_Boletas:181];"setDePruebas")
		CLOSE WINDOW:C154
		If (ok=1)
			ACTdte_setPruebasOpcionesGen ("CargaListado")
		End if 
		
	: ($vt_accion="EliminaElemento")
		$vt_pref:=$vy_pointer1->
		If ($vt_pref#"")
			
			READ WRITE:C146([xShell_Prefs:46])
			QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
			QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$vt_pref)
			DELETE RECORD:C58([xShell_Prefs:46])
			KRL_UnloadReadOnly (->[xShell_Prefs:46])
			
			ACTdte_setPruebasOpcionesGen ("CargaListado")
		Else 
			BEEP:C151
		End if 
		
	: ($vt_accion="InsertaElementoDetalle")
		
		AT_Insert (0;1;->atACT_item;->abACT_afecto;->arACT_cantidad;\
			->arACT_valorUnitario;->arACT_descuento;->arACT_total;->atACT_unidadMedida)
		AT_RedimArrays2Max (->atACT_item;->abACT_afecto;->arACT_cantidad;\
			->arACT_valorUnitario;->arACT_descuento;->arACT_total;->atACT_unidadMedida)
		
	: ($vt_accion="EliminaElementoDetalle")
		$vl_line:=$vy_pointer1->
		If ($vl_line>0)
			AT_Delete ($vl_line;1;->atACT_item;->abACT_afecto;->arACT_cantidad;\
				->arACT_valorUnitario;->arACT_descuento;->arACT_total;->atACT_unidadMedida)
		End if 
		
	: ($vt_accion="GuardaCaso")
		$vt_prefName:=ACTdte_setPruebasOpcionesGen ("getNombrePref";->vt_numeroAtencion;->vt_descripcionAtencion;->vt_variableCaso)
		
		If ((vt_numeroAtencion#"") & (vt_descripcionAtencion#"") & (vt_variableCaso#"") & (at_tipoDocumento#0))
			$vb_continuar:=True:C214
			If (vbACT_editaCaso)
				ACTdte_setPruebasOpcionesGen ("EliminaElemento";->$vt_prefName)
			Else 
				$vl_existe:=Find in field:C653([xShell_Prefs:46]Reference:1;$vt_prefName)
				If ($vl_existe#-1)
					$vb_continuar:=False:C215
				End if 
			End if 
			If ($vb_continuar)
				$offSet:=BLOB_Variables2Blob (->$xBlob;0;->vt_numeroAtencion;->vt_variableCaso;->vt_descripcionAtencion;->vt_variableCaso;->vt_referencia;->vt_razonReferencia;->vrACTdte_DescuentoAfecto;->vrACTdte_DescuentoExento;->vrACTdte_DescuentoGlobal;->vr_neto;->vr_iva;->vr_total;->at_tipoDocumento;->atACT_item;->abACT_afecto;->arACT_cantidad;->arACT_valorUnitario;->arACT_descuento;->arACT_total;->vrACTdte_dctoRecargo;->atACT_referencia;->atACT_Caso2;->vlACT_idBoleta;->vlACT_apoderadoID;->atACT_unidadMedida;->vlACT_terceroID)
				
				AT_RedimArrays2Max (->atACT_item;->abACT_afecto;->arACT_cantidad;->arACT_valorUnitario;->arACT_descuento;->arACT_total;->atACT_unidadMedida)
				
				PREF_SetBlob (0;$vt_prefName;$xBlob)
				PREF_Set (0;"ACT_DTE_IDBOL_CASO_"+vt_variableCaso;String:C10(vlACT_idBoleta))  // guardo id boleta en pref
				SET BLOB SIZE:C606($xBlob;0)
				ACTdte_setPruebasOpcionesGen ("InitVars")
				$vt_retorno:="1"
			Else 
				BEEP:C151
				$vt_retorno:="0"
				CD_Dlog (0;"Ya existe el caso: "+vt_variableCaso+". El caso no puede ser guardado.")
			End if 
			ACTdte_setPruebasOpcionesGen ("CargaListado")
		Else 
			CD_Dlog (0;"Antes de guardar complete los campos requeridos.")
		End if 
		
	: ($vt_accion="getNombrePref")
		$vt_atencion:=$vy_pointer1->
		$vt_descripcion:=$vy_pointer2->
		$vt_variableCaso:=$vy_pointer3->
		$vt_retorno:="ACT_DTE_SETPRUEBAS_"+$vt_atencion+"_"+$vt_descripcion+"_"+$vt_variableCaso
		
	: ($vt_accion="EditaCaso")
		vbACT_editaCaso:=True:C214
		$vl_line:=$vy_pointer1->
		If ($vl_line>0)
			$vt_pref:=atACT_Text{$vl_line}
			ACTdte_setPruebasOpcionesGen ("DesarmaBlob";->$vt_pref)
			ACTdte_setPruebasOpcionesGen ("InsertaElemento")
		End if 
		
	: ($vt_accion="DesarmaBlob")
		$vt_pref:=$vy_pointer1->
		$xBlob:=PREF_fGetBlob (0;$vt_pref;$xBlob)
		If (BLOB size:C605($xBlob)>0)
			$offSet:=BLOB_Blob2Vars (->$xBlob;0;->vt_numeroAtencion;->vt_variableCaso;->vt_descripcionAtencion;->vt_variableCaso;->vt_referencia;->vt_razonReferencia;->vrACTdte_DescuentoAfecto;->vrACTdte_DescuentoExento;->vrACTdte_DescuentoGlobal;->vr_neto;->vr_iva;->vr_total;->at_tipoDocumento;->atACT_item;->abACT_afecto;->arACT_cantidad;->arACT_valorUnitario;->arACT_descuento;->arACT_total;->vrACTdte_dctoRecargo;->atACT_referencia;->atACT_Caso2;->vlACT_idBoleta;->vlACT_apoderadoID;->atACT_unidadMedida;->vlACT_terceroID)
			
			AT_RedimArrays2Max (->atACT_item;->abACT_afecto;->arACT_cantidad;->arACT_valorUnitario;->arACT_descuento;->arACT_total;->atACT_unidadMedida)
			
			
			C_BOOLEAN:C305($b_documentoNulo)
			$b_documentoNulo:=KRL_GetBooleanFieldData (->[ACT_Boletas:181]ID:1;->vlACT_idBoleta;->[ACT_Boletas:181]Nula:15)
			If ($b_documentoNulo)
				vlACT_idBoleta:=0
			End if 
			
			
			  //calculo exento
			$vb_boolean:=False:C215
			vr_exento:=AT_GetSumArrayByArrayPos (->$vb_boolean;"=";->abACT_afecto;->arACT_total)
			
		End if 
		
	: ($vt_accion="CalculaTotales")
		$vb_boolean:=True:C214
		$vr_afecto:=AT_GetSumArrayByArrayPos (->$vb_boolean;"=";->abACT_afecto;->arACT_total)
		$vb_boolean:=False:C215
		$vr_exento:=AT_GetSumArrayByArrayPos (->$vb_boolean;"=";->abACT_afecto;->arACT_total)
		
		$vr_total:=AT_GetSumArray (->arACT_total)
		vrACTdte_dctoRecargo:=0
		If (vrACTdte_DescuentoAfecto#0)
			$vr_descuentoAfecto:=(Round:C94($vr_afecto*(vrACTdte_DescuentoAfecto/100);<>vlACT_Decimales))
			vrACTdte_dctoRecargo:=vrACTdte_dctoRecargo+$vr_descuentoAfecto
			$vr_afecto:=$vr_afecto+$vr_descuentoAfecto
		End if 
		If (vrACTdte_DescuentoExento#0)
			$vr_descuentoExento:=(Round:C94($vr_exento*(vrACTdte_DescuentoExento/100);<>vlACT_Decimales))
			vrACTdte_dctoRecargo:=vrACTdte_dctoRecargo+$vr_descuentoExento
			$vr_exento:=$vr_exento+$vr_descuentoExento
		End if 
		If (vrACTdte_DescuentoGlobal#0)
			$vr_total:=$vr_afecto+$vr_exento
			$vr_descuentoTotal:=(Round:C94($vr_total*(vrACTdte_DescuentoGlobal/100);<>vlACT_Decimales))
			vrACTdte_dctoRecargo:=vrACTdte_dctoRecargo+$vr_descuentoTotal
			$vr_total:=$vr_total+$vr_descuentoTotal
		End if 
		
		$vt_tipo:=ST_GetWord (at_tipoDocumento{at_tipoDocumento};1;":")
		$l_referencia:=Num:C11(PREF_fGet (0;"ACT_DTE_IDBOL_CASO_"+vt_referencia;"0"))
		
		$t_codigoSIIRef:=""
		If ($l_referencia#0)
			$t_codigoSIIRef:=KRL_GetTextFieldData (->[ACT_Boletas:181]ID:1;->$l_referencia;->[ACT_Boletas:181]codigo_SII:33)
		End if 
		
		If ((($vt_tipo="39") | ($vt_tipo="41")) | (($vt_tipo="61") & (($t_codigoSIIRef="39") | ($t_codigoSIIRef="41"))))
			$afecto:=($vr_total+vrACTdte_dctoRecargo)/<>vrACT_FactorIVA
			vr_iva:=Round:C94($afecto*<>vrACT_TasaIVA/100;0)
			vr_total:=($vr_total+vrACTdte_dctoRecargo)
			vr_neto:=vr_total-vr_iva
		Else 
			vr_neto:=Round:C94($vr_total+vrACTdte_dctoRecargo;<>vlACT_Decimales)
			vr_iva:=Round:C94($vr_afecto*(<>vrACT_TasaIVA/100);<>vlACT_Decimales)
			vr_total:=Round:C94(vr_neto+vr_iva;<>vlACT_Decimales)
		End if 
		vr_neto:=vr_neto-$vr_exento
		
		$vb_boolean:=False:C215
		$vr_exento:=AT_GetSumArrayByArrayPos (->$vb_boolean;"=";->abACT_afecto;->arACT_total)
		vr_exento:=$vr_exento
		
	: ($vt_accion="Calculalineas")
		$vl_line:=$vy_pointer1->
		If ($vl_line>0)
			arACT_total{$vl_line}:=arACT_cantidad{$vl_line}*arACT_valorUnitario{$vl_line}
			$vr_decuento:=Round:C94(arACT_total{$vl_line}*(arACT_descuento{$vl_line}/100);<>vlACT_Decimales)
			arACT_total{$vl_line}:=arACT_total{$vl_line}-$vr_decuento
		End if 
		
	: ($vt_accion="CalculalineasYTotales")
		$vl_line:=$vy_pointer1->
		If ($vl_line>0)
			ACTdte_setPruebasOpcionesGen ("Calculalineas";->$vl_line)
			ACTdte_setPruebasOpcionesGen ("CalculaTotales")
		End if 
		
	: ($vt_accion="GetTipoDocumento")
		
End case 

$0:=$vt_retorno