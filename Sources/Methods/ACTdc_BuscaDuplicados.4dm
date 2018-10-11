//%attributes = {}
  //ACTdc_buscaDuplicados

  //TRACE
  //método que busca los documentos en cartera duplicados recibe como primer parámetro el modo de pago. Retorna el número de documentos encontrados
C_LONGINT:C283($tipoDcto;$0;$1;$tipoDcto;$pID)
C_TEXT:C284(vt_retorno)
C_TEXT:C284($2;$noSerieDcto;$vt_cuenta;$vt_codigoBanco)
C_BOOLEAN:C305(vb_termino)
C_LONGINT:C283($idUther)
C_BOOLEAN:C305(vbTerminoProc)
C_BOOLEAN:C305(vb_puedeTerminar)
C_LONGINT:C283($itThermPiD;$ignore;$indexKey)
C_TEXT:C284($vt_cuentaSinFormato;$vt_serieSinFormato;$index)

Case of 
	: (Count parameters:C259=2)
		$tipoDcto:=$1
		$noSerieDcto:=$2
	Else 
		$tipoDcto:=$1
		$noSerieDcto:=$2
		$vt_cuenta:=$3
		$vt_codigoBanco:=$4
End case 
  //  `****INICIALIZACIONES****
vbTerminoProc:=False:C215
vb_puedeTerminar:=False:C215
vt_retorno:=""
  //  `****CUERPO****
If (Application type:C494=4D Remote mode:K5:5)
	Case of 
		: (Count parameters:C259=2)
			$pID:=Execute on server:C373(Current method name:C684;Pila_256K;"Búsqueda de documentos tributarios duplicados";$tipoDcto;$noSerieDcto)
		Else 
			$pID:=Execute on server:C373(Current method name:C684;Pila_256K;"Búsqueda de documentos tributarios duplicados";$tipoDcto;$noSerieDcto;$vt_cuenta;$vt_codigoBanco)
	End case 
	While (Process number:C372("Búsqueda de documentos tributarios duplicados";*)=0)
		IDLE:C311
	End while 
	DELAY PROCESS:C323(Current process:C322;1)
	vb_termino:=False:C215
	While (Not:C34(vb_termino))
		IDLE:C311
		GET PROCESS VARIABLE:C371($pID;vbTerminoProc;vb_termino;vt_retorno;vt_retorno)
	End while 
	SET PROCESS VARIABLE:C370($pID;vb_puedeTerminar;vb_termino)
	$0:=Num:C11(vt_retorno)
Else 
	Case of 
		: ($tipoDcto=2)  //cheque
			$vt_cuentaSinFormato:=Replace string:C233($vt_cuenta;" ";"")
			$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;"-";"")
			$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;".";"")
			$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;",";"")
			$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;",";"")
			$vt_cuentaSinFormato:=ST_DeleteCharsLeft ($vt_cuentaSinFormato;"0")
			$vt_serieSinFormato:=Replace string:C233($noSerieDcto;" ";"")
			$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;"-";"")
			$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;".";"")
			$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;",";"")
			$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;",";"")
			$vt_serieSinFormato:=ST_DeleteCharsLeft ($vt_serieSinFormato;"0")
			$index:=$vt_codigoBanco+"."+$vt_cuentaSinFormato+"."+$vt_serieSinFormato
			$indexKey:=Find in field:C653([ACT_Documentos_de_Pago:176]indexDocDePago:45;$index)
		: ($tipoDcto=5)  //letra
			QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]NoSerie:12=$noSerieDcto;*)
			QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-8;*)
			QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]Nulo:37=False:C215)
			$indexKey:=Records in selection:C76([ACT_Documentos_de_Pago:176])
		: ($tipoDcto=-2)  //cheque
			$vt_cuentaSinFormato:=Replace string:C233($vt_cuenta;" ";"")
			$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;"-";"")
			$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;".";"")
			$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;",";"")
			$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;",";"")
			$vt_cuentaSinFormato:=ST_DeleteCharsLeft ($vt_cuentaSinFormato;"0")
			$vt_serieSinFormato:=Replace string:C233($noSerieDcto;" ";"")
			$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;"-";"")
			$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;".";"")
			$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;",";"")
			$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;",";"")
			$vt_serieSinFormato:=ST_DeleteCharsLeft ($vt_serieSinFormato;"0")
			$index:=$vt_codigoBanco+"."+$vt_cuentaSinFormato+"."+$vt_serieSinFormato
			SET QUERY DESTINATION:C396(Into variable:K19:4;$indexKey)
			QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]indexDocDePago:45=$index)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
		: ($tipoDcto=-5)  //letra
			SET QUERY DESTINATION:C396(Into variable:K19:4;$indexKey)
			QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]NoSerie:12=$noSerieDcto;*)
			QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]Tipodocumento:5="Letra@";*)
			QUERY:C277([ACT_Documentos_de_Pago:176]; & ;[ACT_Documentos_de_Pago:176]Nulo:37=False:C215)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
	End case 
	vt_retorno:=String:C10($indexKey)
	$0:=Num:C11(vt_retorno)
	vbTerminoProc:=True:C214
	If (Application type:C494=4D Server:K5:6)
		While (Not:C34(vb_puedeTerminar))
			IDLE:C311
		End while 
	End if 
End if 