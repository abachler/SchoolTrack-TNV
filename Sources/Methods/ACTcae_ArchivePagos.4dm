//%attributes = {}
  //ACTcae_ArchivePagos

C_BLOB:C604($blob)
C_TEXT:C284($tipo)
C_LONGINT:C283($id)

ARRAY LONGINT:C221(alACT_DocDepXEliminar;0)

ARRAY LONGINT:C221(alACT_PagosXEliminar;0)
ARRAY LONGINT:C221(alACT_ArchivesPagos;0)
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Documentos_de_Pago:176])

COPY ARRAY:C226(alACTcae_IDsPagosAsoc;alACT_PagosXEliminar)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Archivando pagos..."))
ARRAY LONGINT:C221(alACT_ArchivesPagos;Size of array:C274(alACT_PagosXEliminar))
For ($i;1;Size of array:C274(alACT_PagosXEliminar))
	$pago:=Find in field:C653([ACT_Pagos:172]ID:1;alACT_PagosXEliminar{$i})
	If ($pago#-1)
		GOTO RECORD:C242([ACT_Pagos:172];$pago)
		APPEND TO ARRAY:C911(alACT_DocDepXEliminar;[ACT_Pagos:172]ID_DocumentodePago:6)
		If ([ACT_Pagos:172]ID_Tercero:26#0)
			$tipo:="pagosTer"
			$id:=[ACT_Pagos:172]ID_Tercero:26
		Else 
			$tipo:="pagos"
			$id:=[ACT_Pagos:172]ID_Apoderado:3
		End if 
		CREATE RECORD:C68([xxACT_ArchivosHistoricos:113])
		[xxACT_ArchivosHistoricos:113]ID:7:=SQ_SeqNumber (->[xxACT_ArchivosHistoricos:113]ID:7)
		[xxACT_ArchivosHistoricos:113]ID_Apdo:1:=[ACT_Pagos:172]ID_Apoderado:3
		[xxACT_ArchivosHistoricos:113]ID_Cta:2:=[ACT_Pagos:172]ID_CtaCte:21
		  //[xxACT_ArchivosHistoricos]Tipo:="pagos"
		[xxACT_ArchivosHistoricos:113]ID_Tercero:10:=[ACT_Pagos:172]ID_Tercero:26
		[xxACT_ArchivosHistoricos:113]Tipo:4:=$tipo
		[xxACT_ArchivosHistoricos:113]MesCierre:5:=vl_Mes
		[xxACT_ArchivosHistoricos:113]AñoCierre:6:=vl_Año
		[xxACT_ArchivosHistoricos:113]ID_X_Tipo:9:=[ACT_Pagos:172]ID:1
		  //[xxACT_ArchivosHistoricos]Referencia:=String([xxACT_ArchivosHistoricos]AñoCierre;"0000")+"."+String([xxACT_ArchivosHistoricos]MesCierre;"00")+"."+[xxACT_ArchivosHistoricos]Tipo+"."+String([xxACT_ArchivosHistoricos]ID_Apdo)+"."+String([xxACT_ArchivosHistoricos]ID_X_Tipo)
		[xxACT_ArchivosHistoricos:113]Referencia:8:=String:C10([xxACT_ArchivosHistoricos:113]AñoCierre:6;"0000")+"."+String:C10([xxACT_ArchivosHistoricos:113]MesCierre:5;"00")+"."+$tipo+"."+String:C10($id)+"."+String:C10([xxACT_ArchivosHistoricos:113]ID_X_Tipo:9)
		ACTpp_CargaDetallePago ("0";1;[ACT_Pagos:172]ID:1;"pagos")
		$otRef:=OT New 
		OT PutLong ($otRef;"IDPago";[ACT_Pagos:172]ID:1)
		OT PutDate ($otRef;"Fecha";[ACT_Pagos:172]Fecha:2)
		OT PutText ($otRef;"FormadePago";[ACT_Pagos:172]FormaDePago:7)
		OT PutReal ($otRef;"Monto";[ACT_Pagos:172]Monto_Pagado:5)
		OT PutReal ($otRef;"Saldo";[ACT_Pagos:172]Saldo:15)
		OT_PutBoolean ($otRef;"Nulo";[ACT_Pagos:172]Nulo:14)
		OT PutArray ($otRef;"FechaTrasn";aACT_ApdosDPFecha)
		OT PutArray ($otRef;"PeriodoTrans";aACT_ApdosDPPeriodo)
		OT PutArray ($otRef;"MontoTrans";aACT_ApdosDPMonto)
		OT PutArray ($otRef;"SaldoTrans";aACT_ApdosDPSaldoCargo)
		OT PutArray ($otRef;"PagadoTrans";aACT_ApdosDPPagadoCargo)
		OT PutArray ($otRef;"GlosaTrans";aACT_ApdosDPGlosaCargo)
		OT PutArray ($otRef;"IDCta";aIDCta)
		OT PutArray ($otRef;"IDItem";aACT_ApdosDPIDItem)
		OT PutArray ($otRef;"Alumno";aACT_ApdosDPAlumno)
		$blob:=OT ObjectToNewBLOB ($otRef)
		OT Clear ($otRef)
		COMPRESS BLOB:C534($blob;1)
		[xxACT_ArchivosHistoricos:113]xData:3:=$blob
		SAVE RECORD:C53([xxACT_ArchivosHistoricos:113])
		alACT_ArchivesPagos{$i}:=[xxACT_ArchivosHistoricos:113]ID:7
		AT_DistinctsArrayValues (->aIDCta)
		For ($x;1;Size of array:C274(aIDCta))
			READ WRITE:C146([xxACT_ArchivosHistoricos:113])
			CREATE RECORD:C68([xxACT_ArchivosHistoricos:113])
			[xxACT_ArchivosHistoricos:113]ID:7:=SQ_SeqNumber (->[xxACT_ArchivosHistoricos:113]ID:7)
			[xxACT_ArchivosHistoricos:113]ID_Apdo:1:=0
			[xxACT_ArchivosHistoricos:113]ID_Cta:2:=aIDCta{$x}
			[xxACT_ArchivosHistoricos:113]Tipo:4:="pagosDesdeCtas"
			[xxACT_ArchivosHistoricos:113]MesCierre:5:=vl_Mes
			[xxACT_ArchivosHistoricos:113]AñoCierre:6:=vl_Año
			[xxACT_ArchivosHistoricos:113]ID_X_Tipo:9:=alACT_ArchivesPagos{$i}
			[xxACT_ArchivosHistoricos:113]Referencia:8:=String:C10([xxACT_ArchivosHistoricos:113]AñoCierre:6;"0000")+"."+String:C10([xxACT_ArchivosHistoricos:113]MesCierre:5;"00")+"."+[xxACT_ArchivosHistoricos:113]Tipo:4+"."+String:C10([xxACT_ArchivosHistoricos:113]ID_Cta:2)+"."+String:C10([ACT_Pagos:172]ID:1)
			SAVE RECORD:C53([xxACT_ArchivosHistoricos:113])
		End for 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACT_PagosXEliminar);__ ("Archivando pagos..."))
End for 
KRL_UnloadReadOnly (->[xxACT_ArchivosHistoricos:113])
KRL_UnloadReadOnly (->[ACT_Pagos:172])
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)