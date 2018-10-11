//%attributes = {}
  //ACTpp_GuardaRechazos

_O_ARRAY STRING:C218(80;$at_rutRechazos;0)
ARRAY TEXT:C222($at_descRechazos;0)
ARRAY LONGINT:C221($aIDAvisoRechazo;0)
C_LONGINT:C283($vl_tableNum;$vl_fieldNum;$i)
C_POINTER:C301($vLinkingTable;$vLinkingField)
C_BOOLEAN:C305($vb_obsApdos;$vb_obsCtas)

C_DATE:C307($vd_fechaImportacion)
C_TEXT:C284($vt_tipoArchivo;$vt_fileName;$vt_obs)

COPY ARRAY:C226($1->;$at_rutRechazos)
COPY ARRAY:C226($2->;$at_descRechazos)
$vd_fechaImportacion:=$3
$vt_tipoArchivo:=$4
$vt_fileName:=$5
$vl_tableNum:=$6
$vl_fieldNum:=$7
$vb_obsApdos:=($8=1)
$vb_obsCtas:=($9=1)
COPY ARRAY:C226($10->;$aIDAvisoRechazo)

$vLinkingTable:=Table:C252($vl_tableNum)
$vLinkingField:=Field:C253($vl_tableNum;$vl_fieldNum)
$vt_obs:="Rechazo en importación de pago tipo: "+$vt_tipoArchivo+". Pago leído desde archivo: "+$vt_fileName+". Motivo rechazo: "

READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Guardando observaciones. Un momento por favor...")
For ($i;1;Size of array:C274($at_rutRechazos))
	If ($aIDAvisoRechazo{$i}=0)
		If (vLabelLink="ID")
			$vl_valor:=Num:C11($at_rutRechazos{$i})
			$ptr_Id:=->$vl_valor
		Else 
			$vt_valor:=$at_rutRechazos{$i}
			$ptr_Id:=->$vt_valor
		End if 
		QUERY:C277(vLinkingTable->;vLinkingField->=$ptr_Id->)
	Else 
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$aIDAvisoRechazo{$i})
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
	End if 
	If (Table:C252($vLinkingTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
	End if 
	If (Records in selection:C76($vLinkingTable->)=1)
		If ($vb_obsApdos)
			ACTpp_CreateObs ([Personas:7]No:1;$vt_obs+$at_descRechazos{$i};$vd_fechaImportacion)
		End if 
		If ($vb_obsCtas)
			If (Table:C252($vLinkingTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				ACTcc_CreateObs ([ACT_CuentasCorrientes:175]ID:1;$vt_obs+$at_descRechazos{$i};$vd_fechaImportacion;Table:C252(->[ACT_CuentasCorrientes:175]))
			Else 
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
				QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				FIRST RECORD:C50([ACT_CuentasCorrientes:175])
				While (Not:C34(End selection:C36([ACT_CuentasCorrientes:175])))
					ACTcc_CreateObs ([ACT_CuentasCorrientes:175]ID:1;$vt_obs+$at_descRechazos{$i};$vd_fechaImportacion;Table:C252(->[ACT_CuentasCorrientes:175]))
					NEXT RECORD:C51([ACT_CuentasCorrientes:175])
				End while 
			End if 
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($at_rutRechazos);"Guardando observaciones. Un momento por favor...")
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)