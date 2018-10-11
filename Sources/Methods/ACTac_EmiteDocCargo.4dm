//%attributes = {}
  //ACTac_EmiteDocCargo

C_LONGINT:C283($idDoc;$idAviso)
C_DATE:C307($dateEmision;$dateVenc)

$idDoc:=Num:C11(ST_GetWord ($1;1;";"))
$dateEmision:=Date:C102(ST_GetWord ($1;2;";"))
$dateVenc:=Date:C102(ST_GetWord ($1;3;";"))
$idAviso:=Num:C11(ST_GetWord ($1;4;";"))
$0:=True:C214

READ WRITE:C146([ACT_Documentos_de_Cargo:174])
QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=$idDoc)
If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=1)
	If (Not:C34(Locked:C147([ACT_Documentos_de_Cargo:174])))
		[ACT_Documentos_de_Cargo:174]FechaEmision:21:=$dateEmision
		[ACT_Documentos_de_Cargo:174]Fecha_Vencimiento:20:=$dateVenc
		[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15:=$idAviso
		SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
	Else 
		$0:=False:C215
	End if 
End if 
UNLOAD RECORD:C212([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])