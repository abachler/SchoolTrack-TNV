//%attributes = {}
  //ACTdteEmi_LlenaArreglos

C_LONGINT:C283($l_idRS;$1)
C_TEXT:C284($t_rutR)

C_TEXT:C284($t_periodo)
C_REAL:C285($r_folio)
C_DATE:C307($d_fechaE;$d_fechaH)
C_BOOLEAN:C305($b_cargarSeleccion)

ACTcfg_DeclaraArreglos ("ACTdteEmitidos_Listado")

$l_idRS:=$1
If (Count parameters:C259>=2)
	$r_folio:=$2
End if 
If (Count parameters:C259>=3)
	$d_fechaE:=$3
End if 
If (Count parameters:C259>=4)
	$d_fechaH:=$4
End if 
If (Count parameters:C259>=5)
	$t_periodo:=$5
End if 
If (Count parameters:C259>=6)
	$b_cargarSeleccion:=$6
End if 

If ($t_periodo=" -")
	$t_periodo:=""
End if 

READ ONLY:C145([ACT_RazonesSociales:279])
READ ONLY:C145([ACT_Boletas:181])

If (Not:C34($b_cargarSeleccion))
	If (($r_folio#0) | ($d_fechaE#!00-00-00!) | ($d_fechaH#!00-00-00!) | ($t_periodo#""))
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=vlACT_RSSel;*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214;*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11#0)
		
		If ($r_folio#0)
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=$r_folio)
		End if 
		
		Case of 
			: (($d_fechaE#!00-00-00!) & ($d_fechaH#!00-00-00!))
				QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3>=$d_fechaE;*)
				QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3<=$d_fechaH)
			: ($d_fechaE#!00-00-00!)
				QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3=$d_fechaE)
			: ($d_fechaH#!00-00-00!)
				QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3=$d_fechaH)
		End case 
		
		If ($t_periodo#"")
			QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];Year of:C25([ACT_Boletas:181]FechaEmision:3)=Num:C11(Substring:C12($t_periodo;1;4)))
			QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];Month of:C24([ACT_Boletas:181]FechaEmision:3)=Num:C11(Substring:C12($t_periodo;6;2)))
		End if 
	Else 
		REDUCE SELECTION:C351([ACT_Boletas:181];0)
	End if 
Else 
	
End if 
ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3;<)

SELECTION TO ARRAY:C260([ACT_Boletas:181]codigo_SII:33;atACT_TipoEmi;[ACT_Boletas:181]Numero:11;alACT_FolioEmi;[ACT_Boletas:181]FechaEmision:3;adACT_FechaEmisionEmi;[ACT_Boletas:181]ID:1;alACT_IdDteEmi;[ACT_Boletas:181]Monto_Total:6;arACT_MontoTotalEmi)

For ($l_indice;1;Size of array:C274(atACT_TipoEmi))
	atACT_TipoEmi{$l_indice}:=atACT_TipoEmi{$l_indice}+":"+ACTdte_GeneraArchivo ("RetornaNombreCatDesdeIDSII";->atACT_TipoEmi{$l_indice})
	
	APPEND TO ARRAY:C911(atACT_PDFEmi;"")
	APPEND TO ARRAY:C911(atACT_PDF_rutaEmi;"")
	
	APPEND TO ARRAY:C911(atACT_XMLEmi;"")
	APPEND TO ARRAY:C911(atACT_XML_rutaEmi;"")
	
	APPEND TO ARRAY:C911(atACT_PDFCCEmi;"")
	APPEND TO ARRAY:C911(atACT_PDFCC_rutaEmi;"")
End for 

ACTdteEmi_LlenaArreglosRutas 

COPY ARRAY:C226(alACT_IdDteEmi;alACT_IdDteEmiTemp)
COPY ARRAY:C226(atACT_TipoEmi;atACT_TipoEmiTemp)
COPY ARRAY:C226(alACT_FolioEmi;alACT_FolioEmiTemp)
COPY ARRAY:C226(adACT_FechaEmisionEmi;adACT_FechaEmisionEmiTemp)
COPY ARRAY:C226(arACT_MontoTotalEmi;arACT_MontoTotalEmiTemp)
COPY ARRAY:C226(atACT_PDFEmi;atACT_PDFEmiTemp)
COPY ARRAY:C226(atACT_PDF_rutaEmi;atACT_PDF_rutaEmiTemp)

COPY ARRAY:C226(atACT_XMLEmi;atACT_XMLEmiTemp)
COPY ARRAY:C226(atACT_XML_rutaEmi;atACT_XML_rutaEmiTemp)

COPY ARRAY:C226(atACT_PDFCCEmi;atACT_PDFCCEmiTemp)
COPY ARRAY:C226(atACT_PDFCC_rutaEmi;atACT_PDFCC_rutaEmiTemp)

  //filtro
ACTdteEmi_CreaListaFiltro 

  //colorea listbox
ACTdteEmi_ColoreaListBox 

  //var form
l_totalListado:=Size of array:C274(alACT_IdDteEmiTemp)