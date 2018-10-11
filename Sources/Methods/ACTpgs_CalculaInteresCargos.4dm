//%attributes = {}
  //ACTpgs_CalculaInteresCargos

  //método que filtra los cargos que se pagarán para reducir el procesamiento de arreglos innecesarios al ingresar pagos por caja, documentar . Cuando se importa se calcula para todo

C_DATE:C307($1;$fecha)
C_LONGINT:C283($i)
C_BOOLEAN:C305($2;$importando;$vb_borrarCargos)
ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
ARRAY DATE:C224(adACT_fechasEm;0)
$vb_borrarCargos:=True:C214
$fecha:=$1
$importando:=$2
Case of 
	: (Count parameters:C259=3)
		$vb_borrarCargos:=$3
End case 

  //para todos los rec num <0 se crean los intereses asociados...
For ($i;1;Size of array:C274(alACT_RecNumsCargos))
	If ((alACT_RecNumsCargos{$i}<0) & (alACT_CRefs{$i}=-100))
		  //por si se va a pagar un cargo que es de intereses
		alACT_RecNumsCargos{$i}:=ACTcar_CalculaInteres (alACT_CidCargoGenInt{$i};$fecha)
		If (alACT_RecNumsCargos{$i}>0)
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			GOTO RECORD:C242([ACT_Cargos:173];alACT_RecNumsCargos{$i})
			alACT_CIdsCargos{$i}:=[ACT_Cargos:173]ID:1
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
			alACT_CIdDctoCargo{$i}:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
			alACT_CIdsAvisos{$i}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
		End if 
	End if 
End for 

  //se calculan los intereses para todos los cargos a pagar, independiente si en la selección se pagarán dichos intereses o no.
For ($i;1;Size of array:C274(alACT_RecNumsCargos))
	$recNumCargo:=ACTcar_CalculaInteres (alACT_CIdsCargos{$i};$fecha)
	If ($recNumCargo>0)
		  //si se genera un cargo por interés para el cargo que se pagará se busca en los arreglos en memoria para actualizar los ids y saldos
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		C_REAL:C285($monto)
		C_LONGINT:C283($idCta;$idCargoGen)
		C_DATE:C307($fechaE;$fechaV)
		GOTO RECORD:C242([ACT_Cargos:173];$recNumCargo)
		$monto:=[ACT_Cargos:173]Monto_Neto:5
		$idCta:=[ACT_Cargos:173]ID_CuentaCorriente:2
		$fechaE:=[ACT_Cargos:173]FechaEmision:22
		$fechaV:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
		$idCargoGen:=[ACT_Cargos:173]ID_CargoRelacionado:47
		ARRAY LONGINT:C221($al_result1;0)
		ARRAY LONGINT:C221($al_result2;0)
		ARRAY LONGINT:C221($al_result3;0)
		alACT_CidCargoGenInt{0}:=$idCargoGen
		AT_SearchArray (->alACT_CidCargoGenInt;"=";->$al_result1)
		alACT_RecNumsCargos{0}:=0
		AT_SearchArray (->alACT_RecNumsCargos;"<";->$al_result2)
		AT_intersect (->$al_result1;->$al_result2;->$al_result3)
		For ($j;1;Size of array:C274($al_result3))
			If ((arACT_CMontoNeto{$al_result3{$j}}=$monto) & (alACT_CIDCtaCte{$al_result3{$j}}=$idCta) & (adACT_CFechaEmision{$al_result3{$j}}=$fechaE) & (adACT_CFechaVencimiento{$al_result3{$j}}=$fechaV) & (alACT_CidCargoGenInt{$al_result3{$j}}=$idCargoGen))
				alACT_CIdsCargos{$al_result3{$j}}:=[ACT_Cargos:173]ID:1
				alACT_RecNumsCargos{$al_result3{$j}}:=Record number:C243([ACT_Cargos:173])
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
				alACT_CIdDctoCargo{$al_result3{$j}}:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
				$j:=Size of array:C274($al_result3)
			End if 
		End for 
	End if 
End for 