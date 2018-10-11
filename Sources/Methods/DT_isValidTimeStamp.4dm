//%attributes = {}
  // Método: DT_isValidTimeStamp
  //
  //
  // por Alberto Bachler Klein
  // creación 15/01/18, 09:27:50
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($b_timestampValido)
C_TEXT:C284($t_isoTimestamp)


If (False:C215)
	C_BOOLEAN:C305(DT_isValidTimeStamp ;$0)
	C_TEXT:C284(DT_isValidTimeStamp ;$1)
End if 

$t_isoTimestamp:=$1

Case of 
	: (Count parameters:C259=0)
		
	: (Length:C16($t_isoTimestamp)#24)
		
	Else 
		$b_timestampValido:=(Choose:C955(($t_isoTimestamp[[5]]="-") & ($t_isoTimestamp[[8]]="-")\
			 & ($t_isoTimestamp[[11]]="T") & \
			($t_isoTimestamp[[14]]=":") & ($t_isoTimestamp[[17]]=":") & \
			($t_isoTimestamp[[20]]=".") & ($t_isoTimestamp[[24]]="Z")\
			;True:C214;False:C215))
End case 

$0:=$b_timestampValido



