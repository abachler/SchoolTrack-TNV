//%attributes = {}
  //ACTqf_LoadDialogArrays

Case of 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
		ALL RECORDS:C47(yBWR_CurrentTable->)
		vTitle:="Buscar documentos en cartera"
		ARRAY TEXT:C222(aCamposQFDocumentos;0)
		ARRAY TEXT:C222(aCamposQFDocumentos;8)
		aCamposQFDocumentos{1}:="Fecha Documento"
		aCamposQFDocumentos{2}:="Apellido"
		aCamposQFDocumentos{3}:="Estado"
		aCamposQFDocumentos{4}:="Ubicación"
		aCamposQFDocumentos{5}:="Depositar Hasta"
		aCamposQFDocumentos{6}:="Fecha de Vencimiento"
		aCamposQFDocumentos{7}:="Monto"
		aCamposQFDocumentos{8}:="Banco"
		ARRAY BOOLEAN:C223(aUsaCalendarioQF;0)
		ARRAY BOOLEAN:C223(aUsaCalendarioQF;8)
		aUsaCalendarioQF{1}:=True:C214
		aUsaCalendarioQF{2}:=False:C215
		aUsaCalendarioQF{3}:=False:C215
		aUsaCalendarioQF{4}:=False:C215
		aUsaCalendarioQF{5}:=True:C214
		aUsaCalendarioQF{6}:=True:C214
		aUsaCalendarioQF{7}:=False:C215
		aUsaCalendarioQF{8}:=False:C215
		ARRAY BOOLEAN:C223(aRangeableQF;0)
		ARRAY BOOLEAN:C223(aRangeableQF;8)
		aRangeableQF{1}:=True:C214
		aRangeableQF{2}:=True:C214
		aRangeableQF{3}:=False:C215
		aRangeableQF{4}:=False:C215
		aRangeableQF{5}:=True:C214
		aRangeableQF{6}:=True:C214
		aRangeableQF{7}:=True:C214
		aRangeableQF{8}:=False:C215
		ARRAY BOOLEAN:C223(aRangoFechasQF;0)
		ARRAY BOOLEAN:C223(aRangoFechasQF;8)
		aRangoFechasQF{1}:=False:C215
		aRangoFechasQF{2}:=True:C214
		aRangoFechasQF{3}:=True:C214
		aRangoFechasQF{4}:=True:C214
		aRangoFechasQF{5}:=False:C215
		aRangoFechasQF{6}:=False:C215
		aRangoFechasQF{7}:=True:C214
		aRangoFechasQF{8}:=True:C214
		ARRAY POINTER:C280(aCamposQuery;0)
		ARRAY POINTER:C280(aCamposQuery;8)
		aCamposQuery{1}:=->[ACT_Documentos_en_Cartera:182]Fecha_Doc:5
		aCamposQuery{2}:=->[ACT_Documentos_en_Cartera:182]ID_Apoderado:2
		aCamposQuery{3}:=->[ACT_Documentos_en_Cartera:182]Estado:9
		aCamposQuery{4}:=->[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8
		aCamposQuery{5}:=->[ACT_Documentos_en_Cartera:182]Ch_Depositarhasta:13
		aCamposQuery{6}:=->[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10
		aCamposQuery{7}:=->[ACT_Documentos_en_Cartera:182]Monto_Doc:7
		aCamposQuery{8}:=->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3
		ARRAY POINTER:C280(aFechasQuery;0)
		ARRAY POINTER:C280(aFechasQuery;8)
		aFechasQuery{1}:=->[ACT_Documentos_en_Cartera:182]Fecha_Doc:5
		aFechasQuery{2}:=->[ACT_Documentos_en_Cartera:182]Fecha_Doc:5
		aFechasQuery{3}:=->[ACT_Documentos_en_Cartera:182]Fecha_Doc:5
		aFechasQuery{4}:=->[ACT_Documentos_en_Cartera:182]Fecha_Doc:5
		aFechasQuery{5}:=->[ACT_Documentos_en_Cartera:182]Ch_Depositarhasta:13
		aFechasQuery{6}:=->[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10
		aFechasQuery{7}:=->[ACT_Documentos_en_Cartera:182]Fecha_Doc:5
		aFechasQuery{8}:=->[ACT_Documentos_en_Cartera:182]Fecha_Doc:5
		ARRAY POINTER:C280(aPrimerQuery;0)
		ARRAY POINTER:C280(aPrimerQuery;8)
		aPrimerQuery{2}:=->[Personas:7]Apellidos_y_nombres:30
		aPrimerQuery{8}:=->[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
		ARRAY POINTER:C280(aRelationFieldQF;0)
		ARRAY POINTER:C280(aRelationFieldQF;8)
		aRelationFieldQF{2}:=->[Personas:7]No:1
		aRelationFieldQF{8}:=->[ACT_Documentos_de_Pago:176]ID:1
		ARRAY LONGINT:C221(aTiposCamposQF;0)
		ARRAY LONGINT:C221(aTiposCamposQF;8)
		aTiposCamposQF{1}:=Is date:K8:7
		aTiposCamposQF{2}:=Is text:K8:3
		aTiposCamposQF{3}:=Is text:K8:3
		aTiposCamposQF{4}:=Is text:K8:3
		aTiposCamposQF{5}:=Is date:K8:7
		aTiposCamposQF{6}:=Is date:K8:7
		aTiposCamposQF{7}:=Is real:K8:4
		aTiposCamposQF{8}:=Is text:K8:3
		ARRAY BOOLEAN:C223(aUsaComodinQF;0)
		ARRAY BOOLEAN:C223(aUsaComodinQF;8)
		aUsaComodinQF{1}:=False:C215
		aUsaComodinQF{2}:=True:C214
		aUsaComodinQF{3}:=True:C214
		aUsaComodinQF{4}:=True:C214
		aUsaComodinQF{5}:=False:C215
		aUsaComodinQF{6}:=False:C215
		aUsaComodinQF{7}:=False:C215
		aUsaComodinQF{8}:=True:C214
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
		vTitle:="Buscar documentos depositados"
		QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Depositado:35=True:C214)
		ARRAY TEXT:C222(aCamposQFDocumentos;0)
		ARRAY TEXT:C222(aCamposQFDocumentos;5)
		aCamposQFDocumentos{1}:="Fecha"
		aCamposQFDocumentos{2}:="Banco"
		aCamposQFDocumentos{3}:="Nº de Serie"
		aCamposQFDocumentos{4}:="Monto"
		aCamposQFDocumentos{5}:="Apoderado"
		ARRAY BOOLEAN:C223(aUsaCalendarioQF;0)
		ARRAY BOOLEAN:C223(aUsaCalendarioQF;5)
		aUsaCalendarioQF{1}:=True:C214
		aUsaCalendarioQF{2}:=False:C215
		aUsaCalendarioQF{3}:=False:C215
		aUsaCalendarioQF{4}:=False:C215
		aUsaCalendarioQF{5}:=False:C215
		ARRAY BOOLEAN:C223(aRangeableQF;0)
		ARRAY BOOLEAN:C223(aRangeableQF;5)
		aRangeableQF{1}:=True:C214
		aRangeableQF{2}:=False:C215
		aRangeableQF{3}:=False:C215
		aRangeableQF{4}:=True:C214
		aRangeableQF{5}:=True:C214
		ARRAY BOOLEAN:C223(aRangoFechasQF;0)
		ARRAY BOOLEAN:C223(aRangoFechasQF;5)
		aRangoFechasQF{1}:=False:C215
		aRangoFechasQF{2}:=True:C214
		aRangoFechasQF{3}:=False:C215
		aRangoFechasQF{4}:=True:C214
		aRangoFechasQF{5}:=True:C214
		ARRAY POINTER:C280(aCamposQuery;0)
		ARRAY POINTER:C280(aCamposQuery;5)
		aCamposQuery{1}:=->[ACT_Documentos_de_Pago:176]Fecha:13
		aCamposQuery{2}:=->[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
		aCamposQuery{3}:=->[ACT_Documentos_de_Pago:176]NoSerie:12
		aCamposQuery{4}:=->[ACT_Documentos_de_Pago:176]MontoPago:6
		aCamposQuery{5}:=->[ACT_Documentos_de_Pago:176]ID_Apoderado:2
		ARRAY POINTER:C280(aFechasQuery;0)
		ARRAY POINTER:C280(aFechasQuery;5)
		aFechasQuery{1}:=->[ACT_Documentos_de_Pago:176]Fecha:13
		aFechasQuery{2}:=->[ACT_Documentos_de_Pago:176]Fecha:13
		aFechasQuery{3}:=->[ACT_Documentos_de_Pago:176]Fecha:13
		aFechasQuery{4}:=->[ACT_Documentos_de_Pago:176]Fecha:13
		aFechasQuery{5}:=->[ACT_Documentos_de_Pago:176]Fecha:13
		ARRAY POINTER:C280(aPrimerQuery;0)
		ARRAY POINTER:C280(aPrimerQuery;5)
		aPrimerQuery{5}:=->[Personas:7]Apellidos_y_nombres:30
		ARRAY POINTER:C280(aRelationFieldQF;0)
		ARRAY POINTER:C280(aRelationFieldQF;5)
		aRelationFieldQF{5}:=->[ACT_Documentos_de_Pago:176]ID_Apoderado:2
		ARRAY LONGINT:C221(aTiposCamposQF;0)
		ARRAY LONGINT:C221(aTiposCamposQF;5)
		aTiposCamposQF{1}:=Is date:K8:7
		aTiposCamposQF{2}:=Is text:K8:3
		aTiposCamposQF{3}:=Is text:K8:3
		aTiposCamposQF{4}:=Is real:K8:4
		aTiposCamposQF{5}:=Is text:K8:3
		ARRAY BOOLEAN:C223(aUsaComodinQF;0)
		ARRAY BOOLEAN:C223(aUsaComodinQF;5)
		aUsaComodinQF{1}:=False:C215
		aUsaComodinQF{2}:=True:C214
		aUsaComodinQF{3}:=False:C215
		aUsaComodinQF{4}:=False:C215
		aUsaComodinQF{5}:=True:C214
End case 