//%attributes = {}
  // UTIL_isValidUUID()
  // Por: Alberto Bachler K.: 10-02-14, 16:50:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($t_uuid)

$0:=True:C214
$t_uuid:=$1
Case of 
	: ($t_uuid="32303230@")
		$0:=False:C215
		
	: ($t_uuid=("@"+("20"*12)))
		  // el algunas Bds (postgre, por ejemplo) un uuid nulo puede comenzar con una secuencia valida y terminar con una secuencia inválida
		$0:=False:C215
		
	: ($t_uuid=("20"*16))
		$0:=False:C215
		
	: ($t_uuid=("0"*32))
		$0:=False:C215
		
	: ($t_uuid=(" "*32))
		$0:=False:C215
		
	: ($t_uuid="NULL")  // para conexiones a bases SQL
		$0:=False:C215
		
		
	: ($t_uuid="")
		$0:=False:C215
		
End case 




