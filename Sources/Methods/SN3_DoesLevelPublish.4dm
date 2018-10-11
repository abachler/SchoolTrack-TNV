//%attributes = {}
C_LONGINT:C283($1;$nivel)

$nivel:=$1
$dataType:=$2
If (Count parameters:C259=3)
	$subDataType:=$3
End if 
SN3_InitPubVariables 

READ ONLY:C145([SN3_PublicationPrefs:161])
QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=$nivel)
Case of 
	: (Records in selection:C76([SN3_PublicationPrefs:161])=0)
		SN3_SavePubConfig ($nivel)
	: (Records in selection:C76([SN3_PublicationPrefs:161])>1)
		KRL_DeleteSelection (->[SN3_PublicationPrefs:161];False:C215)
		SN3_SavePubConfig ($nivel)
End case 
BLOB_ExpandBlob_byPointer (->[SN3_PublicationPrefs:161]xData:2)
If (BLOB size:C605([SN3_PublicationPrefs:161]xData:2)>0)
	$xmlRef:=DOM Parse XML variable:C720([SN3_PublicationPrefs:161]xData:2)
	Case of 
		: ($dataType=SN3_DTi_EventosAgenda)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/agenda/publicar"))
		: ($dataType=SN3_DTi_Calificaciones)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/calificaciones/publicar"))
		: ($dataType=SN3_DTi_Conducta)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/publicar"))
			If ($0=1)
				Case of 
					: ($subDataType=SN3_SDTx_Anotaciones)
						$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/anotaciones/publicar"))
					: ($subDataType=SN3_SDTx_Atrasos)
						$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/atrasos/publicar"))
					: ($subDataType=SN3_SDTx_Castigos)
						$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/castigos/publicar"))
					: (($subDataType=SN3_SDTx_InasistDiaria) | ($subDataType=SN3_SDTx_InasistHoraAcumulado) | ($subDataType=SN3_SDTx_InasistHoraDetalle))
						$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/inasistencias/publicar"))
					: ($subDataType=SN3_SDTx_Suspensiones)
						$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/suspensiones/publicar"))
					: ($subDataType=SN3_SDTx_Condicionalidad)
						$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/conducta/condicionalidad/publicar"))
				End case 
			End if 
		: ($dataType=SN3_DTi_Companeros)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/companeros/publicar"))
		: ($dataType=SN3_DTi_Horarios)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/horario/publicar"))
		: ($dataType=SN3_DTi_Observaciones)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/observaciones/publicar"))
			If ($0=1)
				Case of 
					: ($subDataType=SN3_SDTx_Asignatura)
						$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/observaciones/obsasignaturas"))
					: ($subDataType=SN3_SDTx_ProfesorJefe)
						$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/observaciones/obspj"))
				End case 
			End if 
		: ($dataType=SN3_DTi_Salud)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/salud/publicar"))
			If ($0=1)
				Case of 
					: ($subDataType=SN3_SDTx_EventosEnfermeria)
						$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/salud/visitas"))
					: ($subDataType=SN3_SDTx_ControlesMedicos)
						$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/salud/controles"))
				End case 
			End if 
		: ($dataType=SN3_DTi_PlanesClase)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/planes/publicar"))
		: ($dataType=SN3_DTi_CalificacionesMPA)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/aprendizajes/publicar"))
		: ($dataType=SN3_DTi_AvisosCobranza)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/avisos/publicar"))
		: ($dataType=SN3_DTi_Pagos)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/pagos/publicar"))
		: ($dataType=SN3_DTi_Prestamos)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/prestamos/publicar"))
		: ($dataType=SN3_DTi_ActividadesExtraCurr)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/actividades/publicar"))
		: ($dataType=SN3_DTi_CalificacionesMPA)
			$0:=Num:C11(DOM_GetValue ($xmlRef;"opciones/aprendizajes/publicar"))
	End case 
	DOM CLOSE XML:C722($xmlRef)
End if 
UNLOAD RECORD:C212([SN3_PublicationPrefs:161])