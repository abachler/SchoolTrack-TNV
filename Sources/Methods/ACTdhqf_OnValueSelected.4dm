//%attributes = {}
  //ACTdhqf_OnValueSelected

RESOLVE POINTER:C394(Focus object:C278;$varName;$tableNum;$fieldNum)
$trapped:=False:C215
$option:=((Macintosh option down:C545) | (Windows Alt down:C563))
TRACE:C157
  // 20110827 RCH no se desde donde se llama. si se llama se debe modificar los textos fijos
Case of 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
		Case of 
			: (aCamposQFDocumentos=3)
				Case of 
					: (aValoresQFDocumentos=1)
						If (($varName="vValor1") | ($varName="vValor2"))
							Focus object:C278->:="Al Dia@"
						End if 
						$trapped:=True:C214
					: (aValoresQFDocumentos=2)
						If (($varName="vValor1") | ($varName="vValor2"))
							Focus object:C278->:="A Fecha@"
						End if 
						$trapped:=True:C214
					: (aValoresQFDocumentos=3)
						If (($varName="vValor1") | ($varName="vValor2"))
							Focus object:C278->:="@Venc@"
						End if 
						$trapped:=True:C214
					: (aValoresQFDocumentos=4)
						If (($varName="vValor1") | ($varName="vValor2"))
							Focus object:C278->:="Protes@"
						End if 
						$trapped:=True:C214
				End case 
		End case 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
		Case of 
				
		End case 
End case 

If (($trapped) & ($option))
	ACTqf_DocumentosRunQuery 
End if 

$0:=$trapped