//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce
  // Fecha y hora: 05-09-18, 15:28:35
  // ----------------------------------------------------
  // Método: ACT_verificaPeriodo
  // Descripción (Ticket Nº 216060)
  // Buscar los periodos para los cuales no se logrará generar cargos o emitir avisos de cobranza porque el periodo se encuentra bloqueado.
  //
  // Parámetros
  //$1, variable de tipo texto inidicando la acción a realizar.
  //$2 y $4, punteros a variables de tipo texto que corresponden a los meses de inicio y fin del lapso a validar
  //$2 y $5, punteros a variables de tipo longint que corresponden a los años de inicio y fin del lapso a validar
  //
  //$0, objeto que retorna un atributo "mensaje" que contiene la cantidad de periodos bloqueados y un atributo periodos con el detalle.
  // ----------------------------------------------------

C_POINTER:C301($2;$3;$4;$5)
C_TEXT:C284($1;$t_mes1;$t_mes2;$t_accion)
C_LONGINT:C283($l_mes1;$l_mes2;$l_año1;$l_año2)

C_OBJECT:C1216($ob_respuesta;$0)

$t_accion:=$1

If (Count parameters:C259>=2)
	$l_mes1:=Find in array:C230(<>atXS_MonthNames;$2->)
End if 
If (Count parameters:C259>=3)
	$l_año1:=$3->
End if 
If (Count parameters:C259>=4)
	$l_mes2:=Find in array:C230(<>atXS_MonthNames;$4->)
End if 
If (Count parameters:C259>=5)
	$l_año2:=$5->
End if 


Case of 
	: ($t_accion="verificaLapso")
		
		C_TEXT:C284($t_msg)
		C_DATE:C307($d_fechaIni;$d_fechaFin)
		ARRAY TEXT:C222($at_periodosCerrados;0)
		
		$t_msg:="0"
		
		$d_fechaIni:=DT_GetDateFromDayMonthYear (1;$l_mes1;$l_año1)
		$d_fechaFin:=DT_GetDateFromDayMonthYear (1;$l_mes2;$l_año2)
		
		While ($d_fechaIni<=$d_fechaFin)
			If (Not:C34(ACTcm_IsMonthOpenFromMonthYear (Month of:C24($d_fechaIni);Year of:C25($d_fechaIni))))
				APPEND TO ARRAY:C911($at_periodosCerrados;String:C10(Month of:C24($d_fechaIni);"00")+"-"+String:C10(Year of:C25($d_fechaIni);"0000"))
			End if 
			$d_fechaIni:=Add to date:C393($d_fechaIni;0;1;0)
		End while 
		
		If (Size of array:C274($at_periodosCerrados)>0)
			OB SET ARRAY:C1227($ob_respuesta;"periodos";$at_periodosCerrados)
			$t_msg:=String:C10(Size of array:C274($at_periodosCerrados))
		End if 
		
		OB SET:C1220($ob_respuesta;"mensaje";$t_msg)
		
		
End case 

$0:=$ob_respuesta
