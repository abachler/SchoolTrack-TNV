//%attributes = {}
  //DT_GetWorkingDayDate

  //`xShell, Alberto Bachler
  //Metodo: DT_GetWorkingDayDate
  //Por Administrator
  //Creada el 11/08/2005, 07:48:57
  //Modificaciones:

If ("DESCRIPCION"="")
	  //retorna la primera fecha laborable (de acuerdo a la configuración del calendario) igual o superior a la fecha pasada en $1
	  //$1 fecha de referencia
	  //$2 id de la configuración del calendario; si es omitida se utiliza elcalendario por defecto
End if 

  //****DECLARACIONES****
C_LONGINT:C283($configRef;$2)
C_DATE:C307($1;$date)
C_DATE:C307($0)

  //****INICIALIZACIONES****
$date:=$1
$configRef:=-1

  //****CUERPO****

Case of 
	: (Count parameters:C259=2)
		$configRef:=$2
		$date:=$1
	: (Count parameters:C259=1)
		$date:=$1
End case 

PERIODOS_LoadData (0;$configRef)

While (Find in array:C230(adSTR_Calendario_Feriados;$date)>0)
	$date:=$date+1
End while 

$0:=$date

  //****LIMPIEZA****