//%attributes = {}
  //ACTdteRec_LlenaArreglos

C_LONGINT:C283($l_idRS;$1)
C_TEXT:C284($t_rutR)

C_TEXT:C284($t_razonSocial;$t_rutE;$t_periodo;$t_periodoRecep)
C_REAL:C285($r_folio)
C_DATE:C307($d_fechaE;$d_fechaRec)
C_POINTER:C301($y_arregloIDs)

ACTcfg_DeclaraArreglos ("ACTdteRecibidos_Listado")

vtACT_TextoFiltro:=""

$l_idRS:=$1
If (Count parameters:C259>=2)
	$t_razonSocial:=$2
End if 
If (Count parameters:C259>=3)
	$t_rutE:=$3
End if 
If (Count parameters:C259>=4)
	$r_folio:=$4
End if 
If (Count parameters:C259>=5)
	$d_fechaE:=$5
End if 
If (Count parameters:C259>=6)
	$d_fechaRec:=$6
End if 
If (Count parameters:C259>=7)
	$t_periodo:=$7
End if 
If (Count parameters:C259>=8)
	$t_periodoRecep:=$8
End if 
If (Count parameters:C259>=9)
	$y_arregloIDs:=$9
End if 

If ($t_razonSocial=" -")
	$t_razonSocial:=""
End if 
If ($t_rutE=" -")
	$t_rutE:=""
End if 
If ($t_periodo=" -")
	$t_periodo:=""
End if 
If ($t_periodoRecep=" -")
	$t_periodoRecep:=""
End if 

READ ONLY:C145([ACT_RazonesSociales:279])
READ ONLY:C145([ACT_DTEs_Recibidos:238])

If (Is nil pointer:C315($y_arregloIDs))
	$t_rutR:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$l_idRS;->[ACT_RazonesSociales:279]RUT:3)
	
	If (($t_razonSocial#"") | ($t_rutE#"") | ($r_folio#0) | ($d_fechaE#!00-00-00!) | ($d_fechaRec#!00-00-00!) | ($t_periodo#"") | ($t_periodoRecep#""))
		QUERY:C277([ACT_DTEs_Recibidos:238];[ACT_DTEs_Recibidos:238]rut_receptor:4=$t_rutR)
		vtACT_TextoFiltro:=SR_FormatoRUT2 ($t_rutR)
		
		If ($t_razonSocial#"")
			QUERY SELECTION:C341([ACT_DTEs_Recibidos:238];[ACT_DTEs_Recibidos:238]razon_social_emiror:3=$t_razonSocial)
			vtACT_TextoFiltro:=vtACT_TextoFiltro+";"+__ ("Emisor")+": "+$t_razonSocial
		End if 
		
		If ($t_rutE#"")
			$t_rutE:=Replace string:C233($t_rutE;".";"")
			$t_rutE:=Replace string:C233($t_rutE;"-";"")
			QUERY SELECTION:C341([ACT_DTEs_Recibidos:238];[ACT_DTEs_Recibidos:238]rut_emisor:2=$t_rutE)
			
			vtACT_TextoFiltro:=vtACT_TextoFiltro+";"+__ ("RUT Emisor")+": "+SR_FormatoRUT2 ($t_rutE)
		End if 
		
		If ($r_folio#0)
			QUERY SELECTION:C341([ACT_DTEs_Recibidos:238];[ACT_DTEs_Recibidos:238]folio_dte:6=String:C10($r_folio))
			vtACT_TextoFiltro:=vtACT_TextoFiltro+";"+__ ("Folio")+": "+String:C10($r_folio)
		End if 
		
		If ($d_fechaE#!00-00-00!)
			QUERY SELECTION:C341([ACT_DTEs_Recibidos:238];[ACT_DTEs_Recibidos:238]fecha_emision:7=$d_fechaE)
			vtACT_TextoFiltro:=vtACT_TextoFiltro+";"+__ ("Fecha Emisión")+": "+String:C10($d_fechaE)
		End if 
		
		If ($d_fechaRec#!00-00-00!)
			QUERY SELECTION:C341([ACT_DTEs_Recibidos:238];[ACT_DTEs_Recibidos:238]fecha_registro:8=$d_fechaRec)
			vtACT_TextoFiltro:=vtACT_TextoFiltro+";"+__ ("Fecha Recepción")+": "+String:C10($d_fechaRec)
		End if 
		
		If ($t_periodo#"")
			QUERY SELECTION BY FORMULA:C207([ACT_DTEs_Recibidos:238];Year of:C25([ACT_DTEs_Recibidos:238]fecha_emision:7)=Num:C11(Substring:C12($t_periodo;1;4)))
			QUERY SELECTION BY FORMULA:C207([ACT_DTEs_Recibidos:238];Month of:C24([ACT_DTEs_Recibidos:238]fecha_emision:7)=Num:C11(Substring:C12($t_periodo;6;2)))
			vtACT_TextoFiltro:=vtACT_TextoFiltro+";"+__ ("Período Emisión")+": "+$t_periodo
		End if 
		
		If ($t_periodoRecep#"")
			QUERY SELECTION BY FORMULA:C207([ACT_DTEs_Recibidos:238];Year of:C25([ACT_DTEs_Recibidos:238]fecha_registro:8)=Num:C11(Substring:C12($t_periodoRecep;1;4)))
			QUERY SELECTION BY FORMULA:C207([ACT_DTEs_Recibidos:238];Month of:C24([ACT_DTEs_Recibidos:238]fecha_registro:8)=Num:C11(Substring:C12($t_periodoRecep;6;2)))
			vtACT_TextoFiltro:=vtACT_TextoFiltro+";"+__ ("Período Emisión")+": "+$t_periodoRecep
		End if 
	Else 
		
		ACTdteRec_CreaArreglosBusqueda 
		REDUCE SELECTION:C351([ACT_DTEs_Recibidos:238];0)
		
	End if 
Else 
	QUERY WITH ARRAY:C644([ACT_DTEs_Recibidos:238]id:1;$y_arregloIDs->)
End if 
ORDER BY:C49([ACT_DTEs_Recibidos:238];[ACT_DTEs_Recibidos:238]fecha_emision:7;<)

SELECTION TO ARRAY:C260([ACT_DTEs_Recibidos:238]tipo_dte:5;atACT_Tipo;[ACT_DTEs_Recibidos:238]razon_social_emiror:3;atACT_Emisor;[ACT_DTEs_Recibidos:238]folio_dte:6;atACT_Folio;[ACT_DTEs_Recibidos:238]fecha_emision:7;adACT_FechaEmision;[ACT_DTEs_Recibidos:238]id:1;alACT_IdDteRec;[ACT_DTEs_Recibidos:238]monto_total:12;arACT_MontoTotal;[ACT_DTEs_Recibidos:238]rut_emisor:2;atACT_EmisorRUT;[ACT_DTEs_Recibidos:238]fecha_registro:8;adACT_recepcionFecha)

For ($l_indice;1;Size of array:C274(atACT_Tipo))
	atACT_Tipo{$l_indice}:=atACT_Tipo{$l_indice}+":"+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->atACT_Tipo{$l_indice})
	
	APPEND TO ARRAY:C911(atACT_PDF;"")
	APPEND TO ARRAY:C911(atACT_PDF_ruta;"")
End for 

ACTdteRec_LlenaArreglosRutas 

COPY ARRAY:C226(alACT_IdDteRec;alACT_IdDteRecTemp)
COPY ARRAY:C226(atACT_Tipo;atACT_TipoTemp)
COPY ARRAY:C226(atACT_Emisor;atACT_EmisorTemp)
COPY ARRAY:C226(atACT_EmisorRUT;atACT_EmisorRUTTemp)
COPY ARRAY:C226(atACT_Folio;atACT_FolioTemp)
COPY ARRAY:C226(adACT_FechaEmision;adACT_FechaEmisionTemp)
COPY ARRAY:C226(arACT_MontoTotal;arACT_MontoTotalTemp)
COPY ARRAY:C226(adACT_recepcionFecha;adACT_recepcionFechaTemp)
COPY ARRAY:C226(atACT_PDF;atACT_PDFTemp)
COPY ARRAY:C226(atACT_PDF_ruta;atACT_PDF_rutaTemp)

  //filtro
ACTdteRec_CreaListaFiltro 

  //colorea listbox
ACTdteRec_ColoreaListBox 

  //var form
l_totalListado:=Size of array:C274(alACT_IdDteRecTemp)