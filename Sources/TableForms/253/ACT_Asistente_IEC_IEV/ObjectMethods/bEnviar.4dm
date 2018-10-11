C_BOOLEAN:C305($b_continuar)
C_TEXT:C284($t_tipo;$t_periodo;$t_tipoDoc)

ARRAY LONGINT:C221($DA_Return;0)
abACTie_Error{0}:=True:C214
AT_SearchArray (->abACTie_Error;"=";->$DA_Return)

Case of 
	: ((vtACT_CodAut#"") & (Length:C16(vtACT_CodAut)#10))
		CD_Dlog (0;__ ("El código de autorización de reemplazo debe ser de 10 caracteres."))
		
	: (Size of array:C274($DA_Return)>0)
		CD_Dlog (0;__ ("Hay líneas con errores en la validación. Corrija los errores antes de continuar."))
		
	: ((vrACT_Proporcionalidad=0) & (l_compra=1))
		  //verifico si hay IVA uso comun para exigir que se ingerse el factor de proporcionalidad del IVA.
		ARRAY LONGINT:C221($DA_Return;0)  //2016091 4RCH
		atACTie_COLUMNA18{0}:="0"
		AT_SearchArray (->atACTie_COLUMNA18;"#";->$DA_Return)
		If (Size of array:C274($DA_Return)=0)
			$b_continuar:=True:C214
		Else 
			If (Shift down:C543)
				$b_continuar:=True:C214
			End if 
		End if 
		
	Else 
		$b_continuar:=True:C214
End case 

If ($b_continuar)
	C_TEXT:C284($t_suma)
	C_LONGINT:C283($i;$l_resp)
	
	Case of 
		: (l_compra=1)
			$t_tipo:="Libro de compras"
		: (l_venta=1)
			$t_tipo:="Libro de ventas"
	End case 
	$t_periodo:=String:C10(vlACTdte_YearIE;"0000")+"-"+String:C10(vlACTdte_MesIE;"00")
	
	ARRAY REAL:C219($arACTie_COLUMNA1;0)
	ARRAY REAL:C219($arACTie_COLUMNA1_2;0)
	ARRAY REAL:C219($arACTie_COLUMNA20;0)
	
	AT_CopyArrayElements (->atACTie_COLUMNA1;->$arACTie_COLUMNA1)
	AT_CopyArrayElements (->$arACTie_COLUMNA1;->$arACTie_COLUMNA1_2)
	AT_DistinctsArrayValues (->$arACTie_COLUMNA1_2)
	$t_suma:=""
	
	Case of 
		: (cs_totales=1)
			AT_CopyArrayElements (->atACTie_COLUMNA18;->$arACTie_COLUMNA20)
			For ($i;1;Size of array:C274($arACTie_COLUMNA1_2))
				$t_tipoDoc:=String:C10($arACTie_COLUMNA1_2{$i})
				$t_suma:=$t_suma+"Tipo: "+$t_tipoDoc+" ("+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->$t_tipoDoc)+"). Cantidad: "+atACTie_COLUMNA2{Find in array:C230($arACTie_COLUMNA1;$arACTie_COLUMNA1_2{$i})}+". Monto: "+String:C10(AT_GetSumArrayByArrayPos (->$arACTie_COLUMNA1_2{$i};"=";->$arACTie_COLUMNA1;->$arACTie_COLUMNA20);"|Despliegue_ACT_Pagos")+"\r"
			End for 
			
		: (l_compra=1)
			AT_CopyArrayElements (->atACTie_COLUMNA20;->$arACTie_COLUMNA20)
			For ($i;1;Size of array:C274($arACTie_COLUMNA1_2))
				$t_tipoDoc:=String:C10($arACTie_COLUMNA1_2{$i})
				$t_suma:=$t_suma+"Tipo: "+$t_tipoDoc+" ("+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->$t_tipoDoc)+"). Cantidad: "+String:C10(Count in array:C907($arACTie_COLUMNA1;$arACTie_COLUMNA1_2{$i}))+". Monto: "+String:C10(AT_GetSumArrayByArrayPos (->$arACTie_COLUMNA1_2{$i};"=";->$arACTie_COLUMNA1;->$arACTie_COLUMNA20);"|Despliegue_ACT_Pagos")+"\r"
			End for 
			
		: (l_venta=1)
			AT_CopyArrayElements (->atACTie_COLUMNA29;->$arACTie_COLUMNA20)
			For ($i;1;Size of array:C274($arACTie_COLUMNA1_2))
				$t_tipoDoc:=String:C10($arACTie_COLUMNA1_2{$i})
				$t_suma:=$t_suma+"Tipo: "+$t_tipoDoc+" ("+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->$t_tipoDoc)+"). Cantidad: "+String:C10(Count in array:C907($arACTie_COLUMNA1;$arACTie_COLUMNA1_2{$i}))+". Monto: "+String:C10(AT_GetSumArrayByArrayPos (->$arACTie_COLUMNA1_2{$i};"=";->$arACTie_COLUMNA1;->$arACTie_COLUMNA20);"|Despliegue_ACT_Pagos")+"\r"
			End for 
			
	End case 
	
	C_TEXT:C284($t_msj)
	If (Size of array:C274($arACTie_COLUMNA1_2)>0)
		$t_msj:="Los totales a informar para "+ST_Qte ($t_tipo)+", para el período "+ST_Qte ($t_periodo)+" son: "+"\r\r"+$t_suma+"\r\r"
		If (l_compra=1)
			$t_msj:=$t_msj+"El factor de proporcionalidad de IVA a utilizar es de: "+String:C10(vrACT_Proporcionalidad)+"."+"\r\r"
		End if 
	Else 
		$t_msj:="No hay totales informados para "+ST_Qte ($t_tipo)+", para el período "+ST_Qte ($t_periodo)+"."+"\r\r"
	End if 
	$t_msj:=$t_msj+__ ("¿Desea continuar?")
	
	$l_resp:=CD_Dlog (0;$t_msj;"";__ ("Si");__ ("No"))
	If ($l_resp=1)
		ACCEPT:C269
		  //20150504 RCH Se usan las teclas para calcular el iva uso comun
		IT_MODIFIERS 
	End if 
End if 