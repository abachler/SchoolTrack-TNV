//%attributes = {"executedOnServer":true}
  // Método: ACTmon_CreaTablaDiaria
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 10-03-10, 19:07:14
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_LONGINT:C283($i;$l_idMoneda;$l_id_monedaParidad;$l_existe;$l_año;$l_mes;$l_ultimoDia;$l_dia;$l_existe2)
C_TEXT:C284($t_codigoPais;$t_llave;$t_nombreMoneda;$t_llaveOrg)
ARRAY LONGINT:C221($al_recNumsMonedas;0)

READ ONLY:C145([xxACT_Monedas:146])

If (Count parameters:C259=1)
	$t_llaveOrg:=$1
	$t_llave:=$t_llaveOrg
	$l_idMoneda:=Num:C11(Substring:C12($t_llave;9))
	QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Genera_Tabla_Diaria:7=True:C214;*)
	QUERY:C277([xxACT_Monedas:146]; & ;[xxACT_Monedas:146]Codigo_Pais:6=<>gCountryCode;*)
	QUERY:C277([xxACT_Monedas:146]; & ;[xxACT_Monedas:146]Id_Moneda:1=$l_idMoneda)
Else 
	QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Genera_Tabla_Diaria:7=True:C214;*)
	QUERY:C277([xxACT_Monedas:146]; & ;[xxACT_Monedas:146]Codigo_Pais:6=<>gCountryCode)
	$t_llaveOrg:="20010101"
End if 

ARRAY LONGINT:C221($al_idRegistro;0)
ARRAY LONGINT:C221($al_idMoneda;0)
ARRAY LONGINT:C221($al_año;0)
ARRAY LONGINT:C221($al_Mes;0)
ARRAY LONGINT:C221($al_Dia;0)
ARRAY DATE:C224($ad_fecha;0)
ARRAY TEXT:C222($at_llave;0)
ARRAY LONGINT:C221($al_IdMonedaParidad;0)
ARRAY REAL:C219($ar_ValorMoneda;0)

  //$ms:=Milliseconds
LONGINT ARRAY FROM SELECTION:C647([xxACT_Monedas:146];$al_recNumsMonedas;"")
For ($i;1;Size of array:C274($al_recNumsMonedas))
	GOTO RECORD:C242([xxACT_Monedas:146];$al_recNumsMonedas{$i})
	$l_idMoneda:=[xxACT_Monedas:146]Id_Moneda:1
	$t_codigoPais:=[xxACT_Monedas:146]Codigo_Pais:6
	$t_nombreMoneda:=[xxACT_Monedas:146]Nombre_Moneda:2
	$r_valorMoneda:=[xxACT_Monedas:146]Valor:3
	QUERY:C277([xxACT_Monedas:146];[xxACT_Monedas:146]Codigo_Pais:6=$t_codigoPais;*)
	QUERY:C277([xxACT_Monedas:146]; & ;[xxACT_Monedas:146]Es_Moneda_Oficial:5=True:C214)
	$l_id_monedaParidad:=[xxACT_Monedas:146]Id_Moneda:1
	If (Length:C16($t_llaveOrg)=8)
		$t_llave:=$t_llaveOrg+String:C10($l_idMoneda)
	End if 
	$l_existe:=Find in field:C653([xxACT_MonedaParidad:147]Key:7;$t_llave)
	$ms:=Milliseconds:C459
	If ($l_existe=-1)
		  // Modificado por: Saúl Ponce (27-07-2017) Ticket 185742, debe partir con 2001 para que los años posteriores se calculen correctamente.
		  //$l_inicio:=Year of(Current date)-1
		$l_inicio:=Num:C11(Substring:C12($t_llaveOrg;1;4))
		$l_fin:=Year of:C25(Current date:C33)+1
		For ($l_año;$l_inicio;$l_fin)
			For ($l_mes;1;12)
				$l_ultimoDia:=DT_GetLastDay ($l_mes;$l_año)
				For ($l_dia;1;$l_ultimoDia)
					$t_llave:=String:C10($l_año;"0000")+String:C10($l_mes;"00")+String:C10($l_dia;"00")+String:C10($l_idMoneda)
					$l_existe2:=Find in field:C653([xxACT_MonedaParidad:147]Key:7;$t_llave)
					If ($l_existe2=-1)
						APPEND TO ARRAY:C911($al_idMoneda;$l_idMoneda)
						APPEND TO ARRAY:C911($al_año;$l_año)
						APPEND TO ARRAY:C911($al_Mes;$l_mes)
						APPEND TO ARRAY:C911($al_Dia;$l_dia)
						APPEND TO ARRAY:C911($ad_fecha;DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año))
						APPEND TO ARRAY:C911($at_llave;String:C10($l_año;"0000")+String:C10($l_mes;"00")+String:C10($l_dia;"00")+String:C10($l_idMoneda))
						APPEND TO ARRAY:C911($al_IdMonedaParidad;$l_id_monedaParidad)
						APPEND TO ARRAY:C911($ar_ValorMoneda;$r_valorMoneda)
						
					End if 
				End for 
			End for 
		End for 
	End if 
	REDUCE SELECTION:C351([xxACT_MonedaParidad:147];0)
	READ WRITE:C146([xxACT_MonedaParidad:147])
	ARRAY TO SELECTION:C261($al_idMoneda;[xxACT_MonedaParidad:147]Id_Moneda:2;\
		$al_año;[xxACT_MonedaParidad:147]Agno:3;\
		$al_Mes;[xxACT_MonedaParidad:147]Mes:4;\
		$al_Dia;[xxACT_MonedaParidad:147]Dia:5;\
		$ad_fecha;[xxACT_MonedaParidad:147]Fecha:12;\
		$at_llave;[xxACT_MonedaParidad:147]Key:7;\
		$al_IdMonedaParidad;[xxACT_MonedaParidad:147]Id_Moneda_Paridad:8;\
		$ar_ValorMoneda;[xxACT_MonedaParidad:147]Valor:6)
	KRL_UnloadReadOnly (->[xxACT_MonedaParidad:147])
End for 
  //$ms:=Milliseconds-$ms
  //ALERT(String($ms))


