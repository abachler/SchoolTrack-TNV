//%attributes = {}
  //dhQRY_GetReferencedValue

C_TEXT:C284($0;$1;$reference;$value)


$reference:=$1
Case of 
	: ($1="Inicio Año escolar")
		PERIODOS_LoadData 
		$value:=String:C10(vdSTR_Periodos_InicioEjercicio;dt_GetNullDateString )
End case 

$0:=$value