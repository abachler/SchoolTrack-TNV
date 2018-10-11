//%attributes = {}
  //ACTac_CargaCargosAviso

ACTpp_FormArraysDeclarations ("DetallePagos")


$vt_yearHist:=$1
$vl_idAviso:=$2
$vt_tipo:=$3
$vl_idApdoCta:=$4

$year:=Num:C11(ST_GetWord ($vt_yearHist;1;"-"))
$month:=Num:C11(ST_GetWord ($vt_yearHist;2;"-"))

If ($vl_idAviso#0)
	Case of 
		: ($year=0)
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_Cargos:173])
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$vl_idAviso)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			ACTcc_LoadCargosIntoArrays 
		Else 
			READ ONLY:C145([xxACT_Datos_de_Cierre:116])
			QUERY:C277([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1=$year;*)
			QUERY:C277([xxACT_Datos_de_Cierre:116]; & ;[xxACT_Datos_de_Cierre:116]Month:3=$month)
			If (Records in selection:C76([xxACT_Datos_de_Cierre:116])=1)
				READ ONLY:C145([xxACT_ArchivosHistoricos:113])
				$key:=String:C10([xxACT_Datos_de_Cierre:116]Year:1;"0000")+"."+String:C10([xxACT_Datos_de_Cierre:116]Month:3;"00")+"."+$vt_tipo+"."+String:C10($vl_idApdoCta)+"."+String:C10($vl_idAviso)
				KRL_FindAndLoadRecordByIndex (->[xxACT_ArchivosHistoricos:113]Referencia:8;->$key)
				If ($vt_tipo="avisosDesdeCtas")
					KRL_FindAndLoadRecordByIndex (->[xxACT_ArchivosHistoricos:113]ID:7;->[xxACT_ArchivosHistoricos:113]ID_X_Tipo:9)
				End if 
				If (Records in selection:C76([xxACT_ArchivosHistoricos:113])=1)
					BLOB_ExpandBlob_byPointer (->[xxACT_ArchivosHistoricos:113]xData:3)
					$blob:=[xxACT_ArchivosHistoricos:113]xData:3
					$otRef:=OT BLOBToObject ($blob)
					OT GetArray ($otRef;"FechaEmisionCargo";adACT_CFechaEmision)
					OT GetArray ($otRef;"FechaVencCargo";adACT_CFechaVencimiento)
					OT GetArray ($otRef;"Alumno";atACT_CAlumno)
					OT GetArray ($otRef;"Glosa";atACT_CGlosa)
					OT GetArray ($otRef;"SimbMoneda";atACT_MonedaSimbolo)
					OT GetArray ($otRef;"Neto";arACT_CMontoNeto)
					OT GetArray ($otRef;"Saldo";arACT_CSaldo)
					OT GetArray ($otRef;"RecNums";alACT_RecNumsCargos)
					OT GetArray ($otRef;"Refs";alACT_CRefs)
					OT GetArray ($otRef;"IDCta";alACT_CIDCtaCte)
					OT GetArray ($otRef;"Marcas";asACT_Marcas)
					OT GetArray ($otRef;"MonedaCargo";atACT_MonedaCargo)
					OT GetArray ($otRef;"MontoMoneda";arACT_MontoMoneda)
					OT Clear ($otRef)
				End if 
				SORT ARRAY:C229(adACT_CFechaEmision;adACT_CFechaVencimiento;atACT_CAlumno;atACT_CGlosa;arACT_CMontoNeto;arACT_CSaldo;alACT_RecNumsCargos;alACT_CRefs;alACT_CIDCtaCte;asACT_Marcas;atACT_MonedaCargo;arACT_MontoMoneda;atACT_MonedaSimbolo;>)
			End if 
			
	End case 
End if 