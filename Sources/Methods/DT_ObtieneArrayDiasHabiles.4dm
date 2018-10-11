//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Patricio Aliaga
  // Fecha y hora: 26-09-17, 09:40:49
  // ----------------------------------------------------
  // Método: DT_GetWorkingDates
  // Descripción
  // Este metodo devuelve un array de fechas las cuales contienen solo 
  // los dias habiles dependiendo de la configuracion de periodos del nivel y fechas
  // recibidos por parametros de entrada.
  //
  // Parámetros
  // 1: No Nivel
  // 2: Fecha de inicio
  // 3: Fecha de termino
  // 4: Puntero a arreglo de retorno
  // ----------------------------------------------------

C_LONGINT:C283($l_nivel;$1)
C_BOOLEAN:C305($b_continuar)
C_DATE:C307($d_from;$d_to;$2;$3)
ARRAY DATE:C224($ad_dias_habiles;0)
C_POINTER:C301($y_haciaretorno)

$b_continuar:=False:C215
If (Count parameters:C259=4)
	$l_nivel:=$1
	If (($2#!00-00-00!) & ($3#!00-00-00!))
		$d_from:=$2
		$d_to:=$3
		If (Type:C295($4->)=Date array:K8:20)
			$y_haciaretorno:=$4
			$b_continuar:=True:C214
		End if 
	End if 
End if 

If ($b_continuar)
	PERIODOS_LoadData ($l_nivel)
	While ($d_from<=$d_to)
		If ((Find in array:C230(ADSTR_CALENDARIO_FERIADOS;$d_from))=-1)
			APPEND TO ARRAY:C911($ad_dias_habiles;$d_from)
		End if 
		$d_from:=Add to date:C393($d_from;0;0;1)
	End while 
	COPY ARRAY:C226($ad_dias_habiles;$y_haciaretorno->)
End if 
