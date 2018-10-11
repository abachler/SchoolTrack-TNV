//%attributes = {}
  //ACTcae_ArchiveAvisos

C_BLOB:C604($blob)

ARRAY LONGINT:C221(alACTcae_IDsPagosAsoc;0)
ARRAY LONGINT:C221(alACTcae_IDsBoletasAsoc;0)

ARRAY LONGINT:C221(alACT_AvisosXEliminar;0)
ARRAY LONGINT:C221(alACT_ArchivesAvisos;0)

ARRAY LONGINT:C221(alACT_AvisosNoEliminarT;0)
ARRAY LONGINT:C221(alACT_PagosNoEliminarT;0)
ARRAY LONGINT:C221(alACT_BoletasNoEliminarT;0)

$date:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año);vl_Mes;vl_Año)
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4<=$date;*)
QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14=0)
SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;alACT_AvisosXEliminar)
ARRAY LONGINT:C221(alACT_ArchivesAvisos;Size of array:C274(alACT_AvisosXEliminar))
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Validando avisos de cobranza a archivar..."))
For ($i;1;Size of array:C274(alACT_AvisosXEliminar))
	  //$aviso:=find in field([ACT_Avisos_de_Cobranza]ID_Aviso;alACT_AvisosXEliminar{$i})
	  //GOTO RECORD([ACT_Avisos_de_Cobranza];$aviso)
	
	ARRAY LONGINT:C221($alACT_IDsPagosAsoc;0)
	ARRAY LONGINT:C221($alACT_IDsBoletasAsoc;0)
	READ ONLY:C145([ACT_Transacciones:178])
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=alACT_AvisosXEliminar{$i})
	DISTINCT VALUES:C339([ACT_Transacciones:178]ID_Pago:4;$alACT_IDsPagosAsoc)
	DISTINCT VALUES:C339([ACT_Transacciones:178]No_Boleta:9;$alACT_IDsBoletasAsoc)
	  //elimino el id 0 si es que existe en pagos y boletas
	$el:=Find in array:C230($alACT_IDsPagosAsoc;0)
	If ($el#-1)
		AT_Delete ($el;1;->$alACT_IDsPagosAsoc)
	End if 
	$el:=Find in array:C230($alACT_IDsBoletasAsoc;0)
	If ($el#-1)
		AT_Delete ($el;1;->$alACT_IDsBoletasAsoc)
	End if 
	  //20120103 RCH
	$el:=Find in array:C230($alACT_IDsBoletasAsoc;-1)
	If ($el#-1)
		AT_Delete ($el;1;->$alACT_IDsBoletasAsoc)
	End if 
	
	  //20120103 RCH cargo documentos asociados
	ARRAY LONGINT:C221($alACT_idsDTSAsociados;0)
	ARRAY LONGINT:C221($alACT_idsDTSAsociados2;0)
	For ($x;1;Size of array:C274($alACT_IDsBoletasAsoc))
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=$alACT_IDsBoletasAsoc{$x};*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_DctoAsociado:19#0)
		SELECTION TO ARRAY:C260([ACT_Boletas:181]ID_DctoAsociado:19;$alACT_idsDTSAsociados)
		For ($y;1;Size of array:C274($alACT_idsDTSAsociados))
			APPEND TO ARRAY:C911($alACT_idsDTSAsociados2;$alACT_idsDTSAsociados{$y})
		End for 
	End for 
	AT_DistinctsArrayValues (->$alACT_idsDTSAsociados2)
	For ($x;1;Size of array:C274($alACT_idsDTSAsociados2))
		If (Find in array:C230($alACT_IDsBoletasAsoc;$alACT_idsDTSAsociados2{$x})=-1)
			APPEND TO ARRAY:C911($alACT_IDsBoletasAsoc;$alACT_idsDTSAsociados2{$x})
		End if 
	End for 
	
	$continuar:=True:C214
	  //valida que todos los avisos asociados al pago esten para eliminacion
	ARRAY LONGINT:C221($alACT_idsAvisosDesdePagos;0)
	For ($x;1;Size of array:C274($alACT_IDsPagosAsoc))
		If ($alACT_IDsPagosAsoc{$x}>0)
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$alACT_IDsPagosAsoc{$x})
			DISTINCT VALUES:C339([ACT_Transacciones:178]No_Comprobante:10;$alACT_idsAvisosDesdePagos)
			For ($y;1;Size of array:C274($alACT_idsAvisosDesdePagos))
				$existe:=Find in array:C230(alACT_AvisosXEliminar;$alACT_idsAvisosDesdePagos{$y})
				If ($existe=-1)  //si algún aviso asociado al pago no se va a archivar, el pago no se archiva
					$y:=Size of array:C274($alACT_idsAvisosDesdePagos)
					$x:=Size of array:C274($alACT_IDsPagosAsoc)
					$continuar:=False:C215
					ACTcae_QuitaDctos2Del ($alACT_idsAvisosDesdePagos{$y})
				Else 
					If (Find in array:C230(alACT_AvisosNoEliminarT;$alACT_idsAvisosDesdePagos{$y})>0)
						ACTcae_QuitaDctos2Del ($alACT_idsAvisosDesdePagos{$y})
					End if 
				End if 
			End for 
		End if 
	End for 
	
	  //valida que todos los pagos NO tengan doc en cartera
	  //20100219 ni saldo
	If ($continuar)
		READ ONLY:C145([ACT_Pagos:172])
		READ ONLY:C145([ACT_Documentos_en_Cartera:182])
		READ ONLY:C145([ACT_Transacciones:178])
		For ($x;1;Size of array:C274($alACT_IDsPagosAsoc))
			If ($alACT_IDsPagosAsoc{$x}>0)
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=$alACT_IDsPagosAsoc{$x})
				SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_DocdePago:3=[ACT_Pagos:172]ID_DocumentodePago:6)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				$vb_pagoConSaldo:=([ACT_Pagos:172]Saldo:15>0)
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$alACT_IDsPagosAsoc{$x})
				SELECTION TO ARRAY:C260([ACT_Transacciones:178]No_Comprobante:10;$al_idsAvisos2Del)
				AT_DistinctsArrayValues (->$al_idsAvisos2Del)
				$el:=Find in array:C230($al_idsAvisos2Del;0)
				If ($el#-1)
					AT_Delete ($el;1;->$al_idsAvisos2Del)
				End if 
				If (($recs#0) | ([ACT_Pagos:172]Fecha:2>$date) | ($vb_pagoConSaldo))
					$x:=Size of array:C274($alACT_IDsPagosAsoc)
					$continuar:=False:C215
					For ($y;1;Size of array:C274($al_idsAvisos2Del))
						ACTcae_QuitaDctos2Del ($al_idsAvisos2Del{$y})
					End for 
				Else 
					If (Find in array:C230(alACT_PagosNoEliminarT;$alACT_IDsPagosAsoc{$x})>0)
						For ($y;1;Size of array:C274($al_idsAvisos2Del))
							ACTcae_QuitaDctos2Del ($al_idsAvisos2Del{$y})
						End for 
					End if 
				End if 
			End if 
		End for 
	End if 
	
	  //valida que todos los doc tributarios estén asociados a pagos o avisos eliminables
	If ($continuar)
		ARRAY LONGINT:C221($alACT_idsAvisosDesdeBoletas;0)
		$continuar:=True:C214
		For ($x;1;Size of array:C274($alACT_IDsBoletasAsoc))
			$index:=Find in field:C653([ACT_Boletas:181]ID:1;$alACT_IDsBoletasAsoc{$x})
			If ($index#-1)
				GOTO RECORD:C242([ACT_Boletas:181];$index)
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=$alACT_IDsBoletasAsoc{$x})
				DISTINCT VALUES:C339([ACT_Transacciones:178]No_Comprobante:10;$alACT_idsAvisosDesdeBoletas)
				For ($y;1;Size of array:C274($alACT_idsAvisosDesdeBoletas))
					$existe:=Find in array:C230(alACT_AvisosXEliminar;$alACT_idsAvisosDesdeBoletas{$y})
					If (($existe=-1) | ([ACT_Boletas:181]FechaEmision:3>$date))
						For ($y;1;Size of array:C274($alACT_idsAvisosDesdeBoletas))
							ACTcae_QuitaDctos2Del ($alACT_idsAvisosDesdeBoletas{$y})
						End for 
						$y:=Size of array:C274($alACT_idsAvisosDesdeBoletas)
						$x:=Size of array:C274($alACT_IDsBoletasAsoc)
						$continuar:=False:C215
					Else 
						If (Find in array:C230(alACT_BoletasNoEliminarT;$alACT_IDsBoletasAsoc{$x})>0)
							For ($y;1;Size of array:C274($alACT_idsAvisosDesdeBoletas))
								ACTcae_QuitaDctos2Del ($alACT_idsAvisosDesdeBoletas{$y})
							End for 
						End if 
					End if 
				End for 
			End if 
		End for 
	End if 
	
	If ($continuar)
		For ($x;1;Size of array:C274($alACT_IDsPagosAsoc))
			If (Find in array:C230(alACTcae_IDsPagosAsoc;$alACT_IDsPagosAsoc{$x})=-1)
				If ($alACT_IDsPagosAsoc{$x}>0)
					APPEND TO ARRAY:C911(alACTcae_IDsPagosAsoc;$alACT_IDsPagosAsoc{$x})
				End if 
			End if 
		End for 
		
		For ($x;1;Size of array:C274($alACT_IDsBoletasAsoc))
			$index:=Find in field:C653([ACT_Boletas:181]ID:1;$alACT_IDsBoletasAsoc{$x})
			If ($index#-1)
				If (Find in array:C230(alACTcae_IDsBoletasAsoc;$alACT_IDsBoletasAsoc{$x})=-1)
					APPEND TO ARRAY:C911(alACTcae_IDsBoletasAsoc;$alACT_IDsBoletasAsoc{$x})
				End if 
			End if 
		End for 
		
	Else 
		If (Find in array:C230(alACT_AvisosNoEliminarT;alACT_AvisosXEliminar{$i})=-1)
			APPEND TO ARRAY:C911(alACT_AvisosNoEliminarT;alACT_AvisosXEliminar{$i})
		End if 
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACT_AvisosXEliminar);__ ("Validando avisos de cobranza a archivar..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
ARRAY LONGINT:C221($alACT_AvisosXEliminar;0)
COPY ARRAY:C226(alACT_AvisosXEliminar;$alACT_AvisosXEliminar)
AT_Difference (->$alACT_AvisosXEliminar;->alACT_AvisosNoEliminarT;->alACT_AvisosXEliminar)

ARRAY LONGINT:C221($alACTcae_IDsPagosAsoc;0)
COPY ARRAY:C226(alACTcae_IDsPagosAsoc;$alACTcae_IDsPagosAsoc)
AT_Difference (->$alACTcae_IDsPagosAsoc;->alACT_PagosNoEliminarT;->alACTcae_IDsPagosAsoc)

ARRAY LONGINT:C221($alACTcae_IDsBoletasAsoc;0)
COPY ARRAY:C226(alACTcae_IDsBoletasAsoc;$alACTcae_IDsBoletasAsoc)
AT_Difference (->$alACTcae_IDsBoletasAsoc;->alACT_BoletasNoEliminarT;->alACTcae_IDsBoletasAsoc)

  //20120606 RCH archivo boletas nulas...
READ ONLY:C145([ACT_Boletas:181])
QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]FechaEmision:3<=$date;*)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=True:C214)
SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;$alACTcae_IDsBoletasAsoc)
For ($x;1;Size of array:C274($alACTcae_IDsBoletasAsoc))
	If (Find in array:C230(alACTcae_IDsBoletasAsoc;$alACTcae_IDsBoletasAsoc{$x})=-1)
		APPEND TO ARRAY:C911(alACTcae_IDsBoletasAsoc;$alACTcae_IDsBoletasAsoc{$x})
	End if 
End for 

  //20120629 RCH archivo pagos nulos...
READ ONLY:C145([ACT_Pagos:172])
QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=$date;*)
QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=True:C214)
SELECTION TO ARRAY:C260([ACT_Pagos:172]ID:1;$alACTcae_IDsPagosAsoc)
For ($x;1;Size of array:C274($alACTcae_IDsPagosAsoc))
	If (Find in array:C230(alACTcae_IDsPagosAsoc;$alACTcae_IDsPagosAsoc{$x})=-1)
		APPEND TO ARRAY:C911(alACTcae_IDsPagosAsoc;$alACTcae_IDsPagosAsoc{$x})
	End if 
End for 

AT_Initialize (->alACT_AvisosNoEliminarT;->alACT_PagosNoEliminarT;->alACT_BoletasNoEliminarT)

C_TEXT:C284($tipo)
C_LONGINT:C283($id)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Archivando avisos de cobranza..."))
For ($i;1;Size of array:C274(alACT_AvisosXEliminar))
	$aviso:=Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;alACT_AvisosXEliminar{$i})
	GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$aviso)
	If ([ACT_Avisos_de_Cobranza:124]ID_Tercero:26#0)
		$tipo:="avisosTer"
		$id:=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26
	Else 
		$tipo:="avisos"
		$id:=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
	End if 
	CREATE RECORD:C68([xxACT_ArchivosHistoricos:113])
	[xxACT_ArchivosHistoricos:113]ID:7:=SQ_SeqNumber (->[xxACT_ArchivosHistoricos:113]ID:7)
	[xxACT_ArchivosHistoricos:113]ID_Apdo:1:=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
	[xxACT_ArchivosHistoricos:113]ID_Cta:2:=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2
	  //[xxACT_ArchivosHistoricos]Tipo:="avisos"
	[xxACT_ArchivosHistoricos:113]ID_Tercero:10:=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26
	[xxACT_ArchivosHistoricos:113]Tipo:4:=$tipo
	[xxACT_ArchivosHistoricos:113]MesCierre:5:=vl_Mes
	[xxACT_ArchivosHistoricos:113]AñoCierre:6:=vl_Año
	[xxACT_ArchivosHistoricos:113]ID_X_Tipo:9:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
	  //[xxACT_ArchivosHistoricos]Referencia:=String([xxACT_ArchivosHistoricos]AñoCierre;"0000")+"."+String([xxACT_ArchivosHistoricos]MesCierre;"00")+"."+[xxACT_ArchivosHistoricos]Tipo+"."+String([xxACT_ArchivosHistoricos]ID_Apdo)+"."+String([xxACT_ArchivosHistoricos]ID_X_Tipo)
	[xxACT_ArchivosHistoricos:113]Referencia:8:=String:C10([xxACT_ArchivosHistoricos:113]AñoCierre:6;"0000")+"."+String:C10([xxACT_ArchivosHistoricos:113]MesCierre:5;"00")+"."+$tipo+"."+String:C10($id)+"."+String:C10([xxACT_ArchivosHistoricos:113]ID_X_Tipo:9)
	ACTav_FormArrayDeclarations 
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	READ ONLY:C145([ACT_Cargos:173])
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
	ACTcc_LoadCargosIntoArrays 
	ACTcar_CargaArreglos ("DesdeArray";->alACT_RecNumsCargos;->[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;->ab_emtiidoSegunMoneda)
	
	$otRef:=OT New 
	OT PutLong ($otRef;"IDAviso";[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	OT PutDate ($otRef;"FechaEmision";[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
	OT PutReal ($otRef;"MontoNeto";[ACT_Avisos_de_Cobranza:124]Monto_Neto:11)
	OT PutReal ($otRef;"MontoAPagar";[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14)
	OT PutText ($otRef;"Moneda";[ACT_Avisos_de_Cobranza:124]Moneda:17)
	OT PutReal ($otRef;"Intereses";[ACT_Avisos_de_Cobranza:124]Intereses:13)
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
	OT PutArray ($otRef;"EmitidoEnMonedaCargo";ab_emtiidoSegunMoneda)
	$blob:=OT ObjectToNewBLOB ($otRef)
	OT Clear ($otRef)
	COMPRESS BLOB:C534($blob;1)
	[xxACT_ArchivosHistoricos:113]xData:3:=$blob
	SAVE RECORD:C53([xxACT_ArchivosHistoricos:113])
	alACT_ArchivesAvisos{$i}:=[xxACT_ArchivosHistoricos:113]ID:7
	AT_DistinctsArrayValues (->alACT_IDCtaCte)
	For ($x;1;Size of array:C274(alACT_IDCtaCte))
		If (alACT_IDCtaCte{$x}>0)
			READ WRITE:C146([xxACT_ArchivosHistoricos:113])
			CREATE RECORD:C68([xxACT_ArchivosHistoricos:113])
			[xxACT_ArchivosHistoricos:113]ID:7:=SQ_SeqNumber (->[xxACT_ArchivosHistoricos:113]ID:7)
			[xxACT_ArchivosHistoricos:113]ID_Apdo:1:=0
			[xxACT_ArchivosHistoricos:113]ID_Cta:2:=alACT_IDCtaCte{$x}
			[xxACT_ArchivosHistoricos:113]Tipo:4:="avisosDesdeCtas"
			[xxACT_ArchivosHistoricos:113]MesCierre:5:=vl_Mes
			[xxACT_ArchivosHistoricos:113]AñoCierre:6:=vl_Año
			[xxACT_ArchivosHistoricos:113]ID_X_Tipo:9:=alACT_ArchivesAvisos{$i}
			[xxACT_ArchivosHistoricos:113]Referencia:8:=String:C10([xxACT_ArchivosHistoricos:113]AñoCierre:6;"0000")+"."+String:C10([xxACT_ArchivosHistoricos:113]MesCierre:5;"00")+"."+[xxACT_ArchivosHistoricos:113]Tipo:4+"."+String:C10([xxACT_ArchivosHistoricos:113]ID_Cta:2)+"."+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			SAVE RECORD:C53([xxACT_ArchivosHistoricos:113])
		End if 
	End for 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACT_AvisosXEliminar);__ ("Archivando avisos de cobranza..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
KRL_UnloadReadOnly (->[xxACT_ArchivosHistoricos:113])