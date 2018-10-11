//%attributes = {}
  // Método: TGR_xShell_Reports
  // 
  // 
  // por Alberto Bachler Klein
  // creación 13/01/18, 18:04:15
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––





  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				If (Not:C34(Util_isValidUUID ([xShell_Reports:54]UUID:47)))
					[xShell_Reports:54]UUID:47:=Generate UUID:C1066
				End if 
				If ([xShell_Reports:54]ID:7=0)
					[xShell_Reports:54]ID:7:=SQ_SeqNumber (->[xShell_Reports:54]ID:7;[xShell_Reports:54]IsStandard:38)
				End if 
				
				If (BLOB size:C605([xShell_Reports:54]AssociatedQuery:21)>0)
					[xShell_Reports:54]NoRequiereSeleccion:40:=True:C214
				End if 
				[xShell_Reports:54]Converted_v2003:19:=True:C214
				If (Not:C34([xShell_Reports:54]EnRepositorio:48))  //si el informe es creado a partir del repositorio CONSERVA LA FECHA DE MODIFICACION DEL REGISTRO DEL REPOSITORIO
					[xShell_Reports:54]DTS_creacion:20:=DTS_MakeFromDateTime 
					[xShell_Reports:54]DTS_UltimaModificacion:46:=DTS_MakeFromDateTime 
					[xShell_Reports:54]timestampISO_creacion:36:=Timestamp:C1445
					[xShell_Reports:54]timestampISO_modificacion:35:=Timestamp:C1445
				End if 
				QR_Uso_InicializaObjeto 
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If (Not:C34(Util_isValidUUID ([xShell_Reports:54]UUID:47)))
					[xShell_Reports:54]UUID:47:=Generate UUID:C1066
				End if 
				
				If ([xShell_Reports:54]ID:7=0)
					[xShell_Reports:54]ID:7:=SQ_SeqNumber (->[xShell_Reports:54]ID:7;[xShell_Reports:54]IsStandard:38)
				End if 
				
				If (BLOB size:C605([xShell_Reports:54]AssociatedQuery:21)>0)
					[xShell_Reports:54]NoRequiereSeleccion:40:=True:C214
				End if 
				
				  //se actualiza la fecha de modificación solo si la modificación no es producto de una descarga desde el repositorio
				$b_informeModificado:=KRL_FieldChanges (->[xShell_Reports:54]NoRequiereSeleccion:40;\
					->[xShell_Reports:54]AssociatedQuery:21;\
					->[xShell_Reports:54]Descripción:16;\
					->[xShell_Reports:54]ExecuteAfterEachRecord:32;\
					->[xShell_Reports:54]ExecuteAfterPrinting:30;\
					->[xShell_Reports:54]ExecuteBeforeEachDocument:31;\
					->[xShell_Reports:54]ExecuteBeforePrinting:4;\
					->[xShell_Reports:54]FormName:17;\
					->[xShell_Reports:54]isOneRecordReport:11;\
					->[xShell_Reports:54]IsStandard:38;\
					->[xShell_Reports:54]Modificacion_Usuario:39;\
					->[xShell_Reports:54]MainTable:3;\
					->[xShell_Reports:54]Modulo:41;\
					->[xShell_Reports:54]Public:8;\
					->[xShell_Reports:54]RegistrosXPagina:44;\
					->[xShell_Reports:54]RelatedTable:14;\
					->[xShell_Reports:54]RelatedField:15;\
					->[xShell_Reports:54]ReportName:26;\
					->[xShell_Reports:54]ReportType:2;\
					->[xShell_Reports:54]SourceField:13;\
					->[xShell_Reports:54]SpecialParameter:18;\
					->[xShell_Reports:54]SR_MainTable:42;\
					->[xShell_Reports:54]sub_header:25;\
					->[xShell_Reports:54]Tags:43;\
					->[xShell_Reports:54]Texto:5;\
					->[xShell_Reports:54]xReportData_:29;\
					->[xShell_Reports:54]xAuthorizedGroups:27;\
					->[xShell_Reports:54]xAuthorizedUsers:28)
				
				If ((Not:C34([xShell_Reports:54]EnRepositorio:48) & ($b_informeModificado)))
					[xShell_Reports:54]timestampISO_modificacion:35:=Timestamp:C1445
					[xShell_Reports:54]DTS_UltimaModificacion:46:=DTS_MakeFromDateTime 
				End if 
				
				
				[xShell_Reports:54]Converted_v2003:19:=True:C214
				QR_Uso_InicializaObjeto 
				
		End case 
		
	End if 
End if 


