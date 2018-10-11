//%attributes = {}
  //ACTcfgban_ValidaDuplicados 

  //validacion bancos...
C_LONGINT:C283($i;$vl_esEstandar)
C_TEXT:C284($vt_convenio;$vt_codigo)
ARRAY TEXT:C222($atACT_codigoBanco;0)
ARRAY LONGINT:C221($alACT_recNum;0)

READ ONLY:C145([xxACT_Bancos:129])
QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Estandar:4=True:C214;*)
QUERY:C277([xxACT_Bancos:129]; & ;[xxACT_Bancos:129]Pais:3=<>gCountryCode)
SELECTION TO ARRAY:C260([xxACT_Bancos:129]Codigo:2;$atACT_codigoBanco)

READ ONLY:C145([xxACT_Bancos:129])
QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Estandar:4=False:C215;*)
QUERY:C277([xxACT_Bancos:129]; & ;[xxACT_Bancos:129]Pais:3=<>gCountryCode)
LONGINT ARRAY FROM SELECTION:C647([xxACT_Bancos:129];$alACT_recNum;"")
For ($i;1;Size of array:C274($alACT_recNum))
	READ WRITE:C146([xxACT_Bancos:129])
	GOTO RECORD:C242([xxACT_Bancos:129];$alACT_recNum{$i})
	$vl_esEstandar:=Find in array:C230($atACT_codigoBanco;[xxACT_Bancos:129]Codigo:2)
	If ($vl_esEstandar>0)
		$vt_codigo:=[xxACT_Bancos:129]Codigo:2
		$vt_convenio:=[xxACT_Bancos:129]mx_NumeroConvenio:5
		DELETE RECORD:C58([xxACT_Bancos:129])
		If ($vt_convenio#"")
			QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Estandar:4=True:C214;*)
			QUERY:C277([xxACT_Bancos:129]; & ;[xxACT_Bancos:129]Codigo:2=$vt_codigo;*)
			QUERY:C277([xxACT_Bancos:129]; & ;[xxACT_Bancos:129]Pais:3=<>gCountryCode)
			If ([xxACT_Bancos:129]mx_NumeroConvenio:5#"")
				LOG_RegisterEvt ("Número de convenio bancario modificado para el banco código "+$vt_codigo+". El número cambió de "+[xxACT_Bancos:129]mx_NumeroConvenio:5+" a "+$vt_convenio+".")
			End if 
			[xxACT_Bancos:129]mx_NumeroConvenio:5:=$vt_convenio
			SAVE RECORD:C53([xxACT_Bancos:129])
		End if 
	End if 
	KRL_UnloadReadOnly (->[xxACT_Bancos:129])
End for 