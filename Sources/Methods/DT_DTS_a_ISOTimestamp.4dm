//%attributes = {}
  // Método: DT_DTS_a_ISOTimestamp
  // utilitario para convertir un DTS en formato "yyyymmddhhmmss" a Timesstamp standard ISO "yyyy-mm-ddThh:mm:ss.xxxZ
  //
  // por Alberto Bachler Klein
  // creación 14/01/18, 17:34:34
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($0)
C_TEXT:C284($1)
C_DATE:C307($2)
C_TIME:C306($3)

C_BOOLEAN:C305($b_TSModificacionValido)
C_DATE:C307($d_fecha)
C_TIME:C306($h_hora)
C_TEXT:C284($t_dts;$t_ts)


If (False:C215)
	C_TEXT:C284(DT_DTS_a_ISOTimestamp ;$0)
	C_TEXT:C284(DT_DTS_a_ISOTimestamp ;$1)
	C_DATE:C307(DT_DTS_a_ISOTimestamp ;$2)
	C_TIME:C306(DT_DTS_a_ISOTimestamp ;$3)
End if 

If (False:C215)  // casos de prueba
	$t_ts:=DT_DTS_a_ISOTimestamp (Timestamp:C1445)  // OK: el dts pasado en $1 esta en formato ISO
	$t_ts:=DT_DTS_a_ISOTimestamp ("20180114191651")  // OK: el dts pasado en $1 esta en formato antiguo válido
	$t_ts:=DT_DTS_a_ISOTimestamp ("201801")  // Falla: DTS inválido
	$t_ts:=DT_DTS_a_ISOTimestamp ("20182103000000")  // Falla: DTS con fecha inválida
	$t_ts:=DT_DTS_a_ISOTimestamp ("";Current date:C33)  // OK: Timestamp solo con la fecha (00:00:00 local)
	$t_ts:=DT_DTS_a_ISOTimestamp ("sdgzsdfbgzsebhz";!00-00-00!;Current time:C178)  // falla: Timestamp invalido, fecha inválida
	$t_ts:=DT_DTS_a_ISOTimestamp ("sdgzsdfbgzsebhz";!00-00-00!)  // falla: Timestamp invalido, fecha inválida 
	$t_ts:=DT_DTS_a_ISOTimestamp ("0"*14)  // falla: DTS de largo correcto, fecha inválida
	$t_ts:=DT_DTS_a_ISOTimestamp ("A"*14)  // falla: DTS de largo correcto, fecha inválida
	$t_ts:=DT_DTS_a_ISOTimestamp ("0"*24)  // falla: timestamp inválido
End if 


$t_dts:=$1
Case of 
	: (Count parameters:C259=3)
		$d_fecha:=$2
		$h_hora:=$3
		
	: (Count parameters:C259=2)
		$d_fecha:=$2
End case 


Case of 
	: (DT_isValidTimeStamp ($t_dts))
		  // no hacemos nada, el timestamp es valido
		
	: ((Length:C16($t_dts)=14) & (Position:C15("T";$t_dts)=0))
		$b_fechaValida:=(DTS_GetDate ($t_dts)#!00-00-00!)
		If ($b_fechaValida)
			$t_dts:=Substring:C12($t_dts;1;4)+"-"+Substring:C12($t_dts;5;2)+"-"+Substring:C12($t_dts;7;2)+\
				"T"+Substring:C12($t_dts;9;2)+":"+Substring:C12($t_dts;11;2)+":"+Substring:C12($t_dts;13;2)+".000"+"Z"
		Else 
			$t_dts:="0000-00-00T00:00:00.000Z"
		End if 
		
	: ($d_fecha#!00-00-00!)
		  // creo el time stamp en el formato antiguo
		$t_dts:=DTS_Get_GMT_TimeStamp ($d_fecha;$h_hora)
		  // lo convierto al formato ISO
		$t_dts:=Substring:C12($t_dts;1;4)+"-"+Substring:C12($t_dts;5;2)+"-"+Substring:C12($t_dts;7;2)+\
			"T"+Substring:C12($t_dts;9;2)+":"+Substring:C12($t_dts;11;2)+":"+Substring:C12($t_dts;13;2)+".000"+"Z"
		
	Else 
		$t_dts:="0000-00-00T00:00:00.000Z"
End case 


$0:=$t_dts

