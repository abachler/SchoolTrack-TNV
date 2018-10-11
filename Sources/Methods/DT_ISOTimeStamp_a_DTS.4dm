//%attributes = {}
  // Método: DT_ISOTimeStamp_a_DTS ({timesStamp:T {;formato:L}})
  // • Si timeStamp no se pasa (o es vacío) y formato no se pasa se devuelve el timestamp actual en el formato standard (YYYY-MM-DDTHH:MM:SS.msZ)
  // • Si formato no se pasa se devuelve un DTS en un formato obsoleto (YYYYMMDDHHMM). Se mantiene solo por razones de compatibilidad
  // • Si formato es superior a 0 (se pueden utilizar y compbinar las siguientes constantes):
  //     dts_ISO_whitoutMS (2): se devuelve un DTS en formato ISO sin millisegundos
  //     dts_FileNameCompatible (4): se devuelve un DTS en el se reemplazan los ":" por un guión
  //     dts_NoSeparators (8): en el DTS resultante se eliminan los separadores de "-" y ":"
  // por Alberto Bachler Klein
  // creación 15/01/18, 07:09:11
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


C_TEXT:C284($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_timestampValido)
C_TEXT:C284($t_isoTimestamp;$t_dtsVariant;$t_dtsVariantformat)



If (False:C215)
	C_TEXT:C284(DT_ISOTimeStamp_a_DTS ;$1)
End if 


If (False:C215)  // casos de prueba
	$t_dtsVariant:=DT_ISOTimeStamp_a_DTS (Timestamp:C1445)  // OK
	$t_dtsVariant:=DT_ISOTimeStamp_a_DTS (Timestamp:C1445;dts_ISO_whitoutMS)
	$t_dtsVariant:=DT_ISOTimeStamp_a_DTS (Timestamp:C1445;dts_FileNameCompatible)
	$t_dtsVariant:=DT_ISOTimeStamp_a_DTS (Timestamp:C1445;dts_NoSeparators)
	$t_dtsVariant:=DT_ISOTimeStamp_a_DTS (Timestamp:C1445;dts_ISO_whitoutMS)
	$t_dtsVariant:=DT_ISOTimeStamp_a_DTS (Timestamp:C1445;dts_ISO_whitoutMS+dts_FileNameCompatible)
	$t_dtsVariant:=DT_ISOTimeStamp_a_DTS (Timestamp:C1445;dts_ISO_whitoutMS+dts_NoSeparators)
	$t_dtsVariant:=DT_ISOTimeStamp_a_DTS   // OK: se obtiene el timestamp actual
	$t_dtsVariant:=DT_ISOTimeStamp_a_DTS ("2180115222222")  // Falla: timestamp inválido (largo incorrecto)"
	$t_dtsVariant:=DT_ISOTimeStamp_a_DTS ("0"*24)  // Falla: Largo correcto pero no correspponde a formato
End if 


Case of 
	: (Count parameters:C259=2)
		$t_isoTimestamp:=$1
		$l_formato:=$2
		
	: (Count parameters:C259=1)
		$t_isoTimestamp:=$1
End case 

If ($t_isoTimestamp="")
	$t_isoTimestamp:=Timestamp:C1445
End if 


If (Length:C16($t_isoTimestamp)#24)
	
Else 
	$b_timestampValido:=(Choose:C955(($t_isoTimestamp[[5]]="-") & ($t_isoTimestamp[[8]]="-")\
		 & ($t_isoTimestamp[[11]]="T") & \
		($t_isoTimestamp[[14]]=":") & ($t_isoTimestamp[[17]]=":") & \
		($t_isoTimestamp[[20]]=".") & ($t_isoTimestamp[[24]]="Z")\
		;True:C214;False:C215))
	
	If ($b_timestampValido)
		If (Count parameters:C259=2)
			$0:=$t_isoTimestamp
			
			$0:=Choose:C955($l_formato ?? (dts_ISO_whitoutMS-1);Substring:C12($0;1;19)+"Z";$0)
			$0:=Choose:C955($l_formato ?? (dts_FileNameCompatible-2);Replace string:C233($0;":";"-");$0)
			$0:=Choose:C955($l_formato ?? (dts_NoSeparators-5);Replace string:C233(Replace string:C233($0;"-";"");":";"");$0)
			
		Else 
			$0:=Substring:C12($t_isoTimestamp;1;19)
			$0:=Replace string:C233($0;"-";"")
			$0:=Replace string:C233($0;":";"")
			$0:=Replace string:C233($0;"T";"")
		End if 
	End if 
End if 


