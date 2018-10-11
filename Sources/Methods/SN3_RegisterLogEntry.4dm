//%attributes = {}
  //SN3_RegisterLogEntry

C_TEXT:C284($descError)
C_LONGINT:C283($codigoError)

$tipoEvento:=$1
$evento:=$2

Case of 
	: (Count parameters:C259=3)
		$codigoError:=$3
		$descError:=""
	: (Count parameters:C259=4)
		$codigoError:=$3
		$descError:=$4
End case 
If (($descError="") & ($codigoError#0))
	$descError:="(Error N° "+String:C10($codigoError)+")"
End if 
$dts:=DTS_MakeFromDateTime 

CREATE RECORD:C68([xxSN3_Log:160])
[xxSN3_Log:160]codigoError:3:=$codigoError
[xxSN3_Log:160]descripcionError:5:=$descError
[xxSN3_Log:160]dts:4:=$dts
[xxSN3_Log:160]evento:2:=$evento
[xxSN3_Log:160]maquina:6:=Current machine:C483
[xxSN3_Log:160]tipoEvento:1:=$tipoEvento
[xxSN3_Log:160]usuarioMaquina:7:=Current system user:C484
SAVE RECORD:C53([xxSN3_Log:160])

