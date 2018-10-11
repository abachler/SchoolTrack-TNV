If (ACTdc_DocumentoNoBloq ("Prorroga"))
	C_LONGINT:C283($maxProrrogaDias)
	$Prorrogar:=True:C214
	If ([ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10<vdACT_FechaProrroga)
		$maxProrrogaDias:=[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10-[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12-1
		$maxProrrogaFecha:=[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12+$maxProrrogaDias
		$format:="|Despliegue_ACT"
		$action:=CD_Dlog (0;__ ("El cheque No ")+[ACT_Documentos_en_Cartera:182]Numero_Doc:6+__ (" por $")+String:C10([ACT_Documentos_en_Cartera:182]Monto_Doc:7;$format)+__ (" no puede ser prorrogado para esa fecha dado que\rse alcanzaría la fecha de vencimiento. La prorroga máxima posible es para el ")+String:C10($maxProrrogaFecha)+__ (".\r\r¿Desea prorrogar a esta fecha?");__ ("");__ ("Si");__ ("No"))
		If ($action#1)
			$Prorrogar:=False:C215
			vdACT_FechaProrroga:=Current date:C33(*)
			GOTO OBJECT:C206(vdACT_FechaProrroga)
		Else 
			vdACT_FechaProrroga:=$maxProrrogaFecha
		End if 
	End if 
	
	If ($Prorrogar)
		$done:=ACTdc_ProrrogaCheques (String:C10(vdACT_FechaProrroga)+";"+String:C10([ACT_Documentos_en_Cartera:182]ID:1))
		If (Not:C34($done))
			BM_CreateRequest ("ACT_ProrrogaCheques";String:C10(vdACT_FechaProrroga)+";"+String:C10([ACT_Documentos_en_Cartera:182]ID:1))
		End if 
	End if 
	i_Doc:=i_Doc+1
	If (i_Doc=Size of array:C274(alACT_RecNumsDocs))
		OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
		OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
	End if 
	ACTdc_CargaDatosDCartera 
	GOTO OBJECT:C206(vdACT_FechaProrroga)
Else 
	ACTdc_DocumentoNoBloq ("MensajeProrroga")
End if 
ACTdc_DocumentoNoBloq ("ProrrogaLiberaRegistros")