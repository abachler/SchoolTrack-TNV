//%attributes = {}
  //Metodo: PERIODOS_PeriodosActuales
  //Por abachler
  //Creada el 01/03/2008, 11:15:30
  // ----------------------------------------------------
  // Descripción
  // retorna el numero del período principal actual
  // si $2 es TRUE, y la fecha no corresponde a nungún período definido retorna el numero del período más cercano
  // si $2 es FALSE, y la fecha no corresponde a nungún período definido retorna 0
  // si 
  // ----------------------------------------------------
  // Parámetros
  // $1: Fecha: la fecha para la que se desea obetener el número de período
  // $2: Booleano, Opcional: determina si se retorna el período mas cercano si la fecah no corresponde a ningún período
  // $3: Puntero, Opcional: puntero sobre variable o campo que recibe el número de subperíodo
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_DATE:C307($1;$date)
C_BOOLEAN:C305($2;$devolverPeriodoMasCercano)
C_POINTER:C301($3)  //puntero sobre variable o campo para retornar el número del subperíodo
C_LONGINT:C283($0;$periodo)
$date:=$1


If (Count parameters:C259=2)
	$devolverPeriodoMasCercano:=$2
End if 

  //CUERPO

For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
	If (($date>=adSTR_Periodos_Desde{$i}) & ($date<=adSTR_Periodos_Hasta{$i}))
		$periodo:=aiSTR_Periodos_Numero{$i}
		$i:=Size of array:C274(aiSTR_Periodos_Numero)+1
	End if 
End for 



If (Size of array:C274(adSTR_Periodos_Desde)>0)
	If (($devolverPeriodoMasCercano) & ($periodo=0))
		Case of 
			: ($date<adSTR_Periodos_Desde{1})
				$periodo:=1
			: ($date>adSTR_Periodos_Hasta{Size of array:C274(aiSTR_Periodos_Numero)})
				$periodo:=aiSTR_Periodos_Numero{Size of array:C274(aiSTR_Periodos_Numero)}
		End case 
		
		If ($periodo=0)
			For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
				If ($date<=adSTR_Periodos_Hasta{$i})
					$periodo:=aiSTR_Periodos_Numero{$i}
					$i:=Size of array:C274(aiSTR_Periodos_Numero)+1
				End if 
			End for 
		End if 
	End if 
End if 


$0:=$periodo



  //LIMPIEZA


