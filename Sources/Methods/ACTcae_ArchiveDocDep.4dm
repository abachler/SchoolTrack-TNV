//%attributes = {}
  //ACTcae_ArchiveDocDep

C_BLOB:C604($blob)
C_TEXT:C284($tipo)
C_LONGINT:C283($id)

ARRAY LONGINT:C221(alACT_ArchivesDocDep;0)
READ ONLY:C145([ACT_Documentos_de_Pago:176])

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Archivando documentos depositados..."))
ARRAY LONGINT:C221(alACT_ArchivesDocDep;Size of array:C274(alACT_DocDepXEliminar))
For ($i;1;Size of array:C274(alACT_DocDepXEliminar))
	$doc:=Find in field:C653([ACT_Documentos_de_Pago:176]ID:1;alACT_DocDepXEliminar{$i})
	  //20121003 RCH Podian haberse eliminado docs de pago
	If ($doc#-1)
		GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$doc)
		If ([ACT_Documentos_de_Pago:176]ID_Tercero:48#0)
			$tipo:="docdepTer"
			$id:=[ACT_Documentos_de_Pago:176]ID_Tercero:48
		Else 
			$tipo:="docdep"
			$id:=[ACT_Documentos_de_Pago:176]ID_Apoderado:2
		End if 
		CREATE RECORD:C68([xxACT_ArchivosHistoricos:113])
		[xxACT_ArchivosHistoricos:113]ID:7:=SQ_SeqNumber (->[xxACT_ArchivosHistoricos:113]ID:7)
		[xxACT_ArchivosHistoricos:113]ID_Apdo:1:=[ACT_Documentos_de_Pago:176]ID_Apoderado:2
		[xxACT_ArchivosHistoricos:113]ID_Tercero:10:=[ACT_Documentos_de_Pago:176]ID_Tercero:48
		[xxACT_ArchivosHistoricos:113]ID_Cta:2:=0
		  //[xxACT_ArchivosHistoricos]Tipo:="docdep"
		[xxACT_ArchivosHistoricos:113]Tipo:4:=$tipo
		[xxACT_ArchivosHistoricos:113]MesCierre:5:=vl_Mes
		[xxACT_ArchivosHistoricos:113]AñoCierre:6:=vl_Año
		[xxACT_ArchivosHistoricos:113]ID_X_Tipo:9:=[ACT_Documentos_de_Pago:176]ID:1
		  //[xxACT_ArchivosHistoricos]Referencia:=String([xxACT_ArchivosHistoricos]AñoCierre;"0000")+"."+String([xxACT_ArchivosHistoricos]MesCierre;"00")+"."+[xxACT_ArchivosHistoricos]Tipo+"."+String([xxACT_ArchivosHistoricos]ID_Apdo)+"."+String([xxACT_ArchivosHistoricos]ID_X_Tipo)
		[xxACT_ArchivosHistoricos:113]Referencia:8:=String:C10([xxACT_ArchivosHistoricos:113]AñoCierre:6;"0000")+"."+String:C10([xxACT_ArchivosHistoricos:113]MesCierre:5;"00")+"."+$tipo+"."+String:C10($id)+"."+String:C10([xxACT_ArchivosHistoricos:113]ID_X_Tipo:9)
		$otRef:=OT New 
		OT PutLong ($otRef;"ID";[ACT_Documentos_de_Pago:176]ID:1)
		OT PutDate ($otRef;"Fecha";[ACT_Documentos_de_Pago:176]Fecha:13)
		OT PutText ($otRef;"Serie";[ACT_Documentos_de_Pago:176]NoSerie:12)
		OT PutReal ($otRef;"Monto";[ACT_Documentos_de_Pago:176]MontoPago:6)
		OT PutText ($otRef;"Banco";[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7)
		OT PutText ($otRef;"Cuenta";[ACT_Documentos_de_Pago:176]Ch_Cuenta:11)
		OT PutText ($otRef;"DepositadoBanco";[ACT_Documentos_de_Pago:176]Depositado_en_Banco:39)
		OT PutText ($otRef;"DepositadoCuenta";[ACT_Documentos_de_Pago:176]Depositado_en_Cuenta:41)
		OT PutText ($otRef;"DepositadoPor";[ACT_Documentos_de_Pago:176]Depositado_Por:43)
		OT PutText ($otRef;"TipoDocumento";[ACT_Documentos_de_Pago:176]Tipodocumento:5)
		OT_PutBoolean ($otRef;"Depositado";[ACT_Documentos_de_Pago:176]Depositado:35)
		$blob:=OT ObjectToNewBLOB ($otRef)
		OT Clear ($otRef)
		COMPRESS BLOB:C534($blob;1)
		[xxACT_ArchivosHistoricos:113]xData:3:=$blob
		SAVE RECORD:C53([xxACT_ArchivosHistoricos:113])
		alACT_ArchivesDocDep{$i}:=[xxACT_ArchivosHistoricos:113]ID:7
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(alACT_DocDepXEliminar))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
KRL_UnloadReadOnly (->[xxACT_ArchivosHistoricos:113])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])