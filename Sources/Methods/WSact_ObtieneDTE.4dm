//%attributes = {}
  //WSact_ObtieneDTE

C_TEXT:C284($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
C_BOOLEAN:C305($5)
C_TEXT:C284($6)
C_TEXT:C284($7)

C_LONGINT:C283($0)
C_LONGINT:C283(vlWS_estado;vlWS_tipoDTE;vlWS_folioDTE)
C_TEXT:C284(vtWS_glosa;vtWS_xml)
C_BLOB:C604(vxWS_pdf)
vlWS_estado:=0
vtWS_glosa:=""

WEB SERVICE SET PARAMETER:C777("rutEmisor";$1)
WEB SERVICE SET PARAMETER:C777("tipo";$2)
WEB SERVICE SET PARAMETER:C777("folio";$3)
WEB SERVICE SET PARAMETER:C777("formato";$4)
WEB SERVICE SET PARAMETER:C777("cedible";$5)
WEB SERVICE SET PARAMETER:C777("operacion";$6)
If (Count parameters:C259>=7)
	WEB SERVICE SET PARAMETER:C777("rutReceptor";$7)
End if 

WSact_DTECallWebService ("doObtieneDTE")

If (OK=1)
	WEB SERVICE GET RESULT:C779(vlWS_estado;"estado")
	WEB SERVICE GET RESULT:C779(vtWS_glosa;"glosa")
	If (vlWS_estado=0)
		TRACE:C157
	Else 
		C_BLOB:C604($vxBlob)
		Case of 
			: ($4="xml")
				WEB SERVICE GET RESULT:C779(vtWS_xml;"xml";*)
				
			: ($4="pdf")
				  //20110922 RCH se debe probar el funcionamiento cuando el ws retorne info
				WEB SERVICE GET RESULT:C779(vxWS_pdf;"pdf";*)
				
		End case 
		
		
	End if 
End if 
$0:=vlWS_estado