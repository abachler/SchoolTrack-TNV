
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce, Ticket 193649
  // Fecha y hora: 05/01/18, 13:12:00
  // ----------------------------------------------------
  // Método: [ACT_Avisos_de_Cobranza].ReferenciasMX.bBanco
  // Descripción
  // Para presentar una nómina con los bancos que tiene código de convenio ingresado.
  //
  // Parámetros
  // ----------------------------------------------------



C_LONGINT:C283($seleccion)
C_TEXT:C284(vsACT_ConvenioBanco;vsACT_Banco_Referencias;$vt_Banco)

vsACT_ConvenioBanco:=""
vsACT_Banco_Referencias:=""


ARRAY TEXT:C222($atACT_Convenio;0)
ARRAY TEXT:C222($atACT_NombreBanco;0)
ARRAY LONGINT:C221($al_posValidas;0)


ACTcfgmyt_CargaArreglos 

atACT_BankNumConvenio{0}:=""
AT_SearchArray (->atACT_BankNumConvenio;"#";->$al_posValidas)

For ($y;1;Size of array:C274($al_posValidas))
	APPEND TO ARRAY:C911($atACT_NombreBanco;atACT_BankName{$al_posValidas{$y}})
	APPEND TO ARRAY:C911($atACT_Convenio;atACT_BankNumConvenio{$al_posValidas{$y}})
End for 


If (Size of array:C274($atACT_NombreBanco)>0)
	$vt_Banco:=AT_array2text (->$atACT_NombreBanco)
	$seleccion:=Pop up menu:C542($vt_Banco)
	
	If ($seleccion#0)
		
		$atACT_NombreBanco:=$seleccion
		vsACT_ConvenioBanco:=$atACT_Convenio{$seleccion}
		Variable4:=$atACT_NombreBanco{$seleccion}
		
	End if 
Else 
	CD_Dlog (0;"No existen bancos configurados con código de convenio válidos. Por favor, corrija la configuración de Bancos.")
End if 
