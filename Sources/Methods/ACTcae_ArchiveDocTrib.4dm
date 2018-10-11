//%attributes = {}
  //ACTcae_ArchiveDocTrib

C_BLOB:C604($blob)
C_TEXT:C284($tipo)
C_LONGINT:C283($id)

ARRAY LONGINT:C221(alACT_DocTribXEliminar;0)
ARRAY LONGINT:C221(alACT_ArchivesDocTrib;0)
READ ONLY:C145([ACT_Boletas:181])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Documentos_de_Pago:176])

COPY ARRAY:C226(alACTcae_IDsBoletasAsoc;alACT_DocTribXEliminar)

ARRAY LONGINT:C221(alACT_ArchivesDocTrib;Size of array:C274(alACT_DocTribXEliminar))
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Archivando documentos tributarios..."))
For ($i;1;Size of array:C274(alACT_DocTribXEliminar))
	ACTbol_FormArraysDeclarations 
	$bol:=Find in field:C653([ACT_Boletas:181]ID:1;alACT_DocTribXEliminar{$i})
	GOTO RECORD:C242([ACT_Boletas:181];$bol)
	If ([ACT_Boletas:181]ID_Tercero:21#0)
		$tipo:="doctribTer"
		$id:=[ACT_Boletas:181]ID_Tercero:21
	Else 
		$tipo:="doctrib"
		$id:=[ACT_Boletas:181]ID_Apoderado:14
	End if 
	  //SET QUERY LIMIT(1)
	  //QUERY([ACT_Transacciones];[ACT_Transacciones]No_Boleta=[ACT_Boletas]ID)
	  //SET QUERY LIMIT(0)
	CREATE RECORD:C68([xxACT_ArchivosHistoricos:113])
	[xxACT_ArchivosHistoricos:113]ID:7:=SQ_SeqNumber (->[xxACT_ArchivosHistoricos:113]ID:7)
	  //[xxACT_ArchivosHistoricos]ID_Apdo:=[ACT_Transacciones]ID_Apoderado
	[xxACT_ArchivosHistoricos:113]ID_Apdo:1:=[ACT_Boletas:181]ID_Apoderado:14
	[xxACT_ArchivosHistoricos:113]ID_Cta:2:=0
	[xxACT_ArchivosHistoricos:113]ID_Tercero:10:=[ACT_Boletas:181]ID_Tercero:21
	  //[xxACT_ArchivosHistoricos]Tipo:="doctrib"
	[xxACT_ArchivosHistoricos:113]Tipo:4:=$tipo
	[xxACT_ArchivosHistoricos:113]MesCierre:5:=vl_Mes
	[xxACT_ArchivosHistoricos:113]AñoCierre:6:=vl_Año
	[xxACT_ArchivosHistoricos:113]ID_X_Tipo:9:=[ACT_Boletas:181]ID:1
	[xxACT_ArchivosHistoricos:113]Referencia:8:=String:C10([xxACT_ArchivosHistoricos:113]AñoCierre:6;"0000")+"."+String:C10([xxACT_ArchivosHistoricos:113]MesCierre:5;"00")+"."+$tipo+"."+String:C10($id)+"."+String:C10([xxACT_ArchivosHistoricos:113]ID_X_Tipo:9)
	  //[xxACT_ArchivosHistoricos]Referencia:=String([xxACT_ArchivosHistoricos]AñoCierre;"0000")+"."+String([xxACT_ArchivosHistoricos]MesCierre;"00")+"."+[xxACT_ArchivosHistoricos]Tipo+"."+String([xxACT_ArchivosHistoricos]ID_Apdo)+"."+String([xxACT_ArchivosHistoricos]ID_X_Tipo)
	$otRef:=OT New 
	OT PutLong ($otRef;"ID";[ACT_Boletas:181]ID:1)
	OT PutLong ($otRef;"Numero";[ACT_Boletas:181]Numero:11)
	OT PutText ($otRef;"TipoDoc";[ACT_Boletas:181]TipoDocumento:7)
	OT PutText ($otRef;"Estado";[ACT_Boletas:181]Estado:2)
	OT PutDate ($otRef;"Fecha";[ACT_Boletas:181]FechaEmision:3)
	OT PutReal ($otRef;"Afecto";[ACT_Boletas:181]Monto_Afecto:4)
	OT PutReal ($otRef;"IVA";[ACT_Boletas:181]Monto_IVA:5)
	OT PutReal ($otRef;"Total";[ACT_Boletas:181]Monto_Total:6)
	OT_PutBoolean ($otRef;"Nula";[ACT_Boletas:181]Nula:15)
	
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	ACTcc_LoadCargosIntoArrays 
	ARRAY BOOLEAN:C223(ab_emtiidoSegunMoneda;0)
	ACTcar_CargaArreglos ("DesdeArray";->alACT_RecNumsCargos;->[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;->ab_emtiidoSegunMoneda)
	
	KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
	ARRAY LONGINT:C221($aIDDocPago;0)
	ARRAY TEXT:C222(atACT_PagoEstadoDocBol;0)
	SELECTION TO ARRAY:C260([ACT_Pagos:172]forma_de_pago_new:31;atACT_PagoFormaBol;[ACT_Pagos:172]Monto_Pagado:5;arACT_PagoMontoBol;[ACT_Pagos:172]ID:1;alACT_PagoIDBol;[ACT_Pagos:172]ID_DocumentodePago:6;$aIDDocPago;[ACT_Pagos:172]Saldo:15;arACT_PagoSaldoBol)
	For ($j;1;Size of array:C274($aIDDocPago))
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=$aIDDocPago{$j})
		INSERT IN ARRAY:C227(atACT_PagoEstadoDocBol;Size of array:C274(atACT_PagoEstadoDocBol)+1;1)
		atACT_PagoEstadoDocBol{Size of array:C274(atACT_PagoEstadoDocBol)}:=[ACT_Documentos_de_Pago:176]Estado:14
	End for 
	SORT ARRAY:C229(atACT_PagoFormaBol;arACT_PagoMontoBol;arACT_PagoSaldoBol;alACT_PagoIDBol;atACT_PagoEstadoDocBol;<)
	
	OT PutArray ($otRef;"FechaEmisionCargo";adACT_CFechaEmision)
	OT PutArray ($otRef;"FechaVencCargo";adACT_CFechaVencimiento)
	OT PutArray ($otRef;"Alumno";atACT_CAlumno)
	OT PutArray ($otRef;"Glosa";atACT_CGlosa)
	OT PutArray ($otRef;"SimbMoneda";atACT_MonedaSimbolo)
	OT PutArray ($otRef;"Neto";arACT_CMontoNeto)
	OT PutArray ($otRef;"InteresesCargo";arACT_CIntereses)
	OT PutArray ($otRef;"Saldo";arACT_CSaldo)
	OT PutArray ($otRef;"RecNums";alACT_RecNumsCargos)
	OT PutArray ($otRef;"Refs";alACT_CRefs)
	OT PutArray ($otRef;"IDCta";alACT_CIDCtaCte)
	OT PutArray ($otRef;"Marcas";asACT_Marcas)
	OT PutArray ($otRef;"MonedaCargo";atACT_MonedaCargo)
	OT PutArray ($otRef;"MontoMoneda";arACT_MontoMoneda)
	OT PutArray ($otRef;"PagoForma";atACT_PagoFormaBol)
	OT PutArray ($otRef;"PagoMonto";arACT_PagoMontoBol)
	OT PutArray ($otRef;"PagoSaldo";arACT_PagoSaldoBol)
	OT PutArray ($otRef;"PagoID";alACT_PagoIDBol)
	OT PutArray ($otRef;"PagoEstadoDoc";atACT_PagoEstadoDocBol)
	OT PutArray ($otRef;"EmitidoEnMoneda";ab_emtiidoSegunMoneda)
	$blob:=OT ObjectToNewBLOB ($otRef)
	OT Clear ($otRef)
	COMPRESS BLOB:C534($blob;1)
	[xxACT_ArchivosHistoricos:113]xData:3:=$blob
	SAVE RECORD:C53([xxACT_ArchivosHistoricos:113])
	alACT_ArchivesDocTrib{$i}:=[xxACT_ArchivosHistoricos:113]ID:7
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACT_DocTribXEliminar);__ ("Archivando documentos tributarios..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
KRL_UnloadReadOnly (->[xxACT_ArchivosHistoricos:113])
KRL_UnloadReadOnly (->[ACT_Boletas:181])