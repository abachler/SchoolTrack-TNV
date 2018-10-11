//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Patricio Aliaga
  // Fecha y hora: 03-02-18, 16:14:42
  // ----------------------------------------------------
  // Método: actabc_NombreArchivoBancario
  // Descripción
  // Metodo aplica el formato entregado en el primer parametro, si el formato no esta definido devuelve la misma cadena que se ingreso
  // Parámetros
  // $1 String al cual aplicar el formato
  // ----------------------------------------------------

C_TEXT:C284($t_cadena)

$t_cadena:=$1

Case of 
	: ($t_cadena="DDMMAA")
		$t_cadena:=String:C10(Day of:C23(vdACT_Fecha1);"00")+String:C10(Month of:C24(vdACT_Fecha1);"00")+Substring:C12(String:C10(Year of:C25(vdACT_Fecha1));3;2)
	: ($t_cadena="DDMMAAAA")
		$t_cadena:=String:C10(Day of:C23(vdACT_Fecha1);"00")+String:C10(Month of:C24(vdACT_Fecha1);"00")+String:C10(Year of:C25(vdACT_Fecha1))
	: ($t_cadena="AAMMDD")
		$t_cadena:=Substring:C12(String:C10(Year of:C25(vdACT_Fecha1));3;2)+String:C10(Month of:C24(vdACT_Fecha1);"00")+String:C10(Day of:C23(vdACT_Fecha1);"00")
	: ($t_cadena="AAAAMMDD")
		$t_cadena:=String:C10(Year of:C25(vdACT_Fecha1))+String:C10(Month of:C24(vdACT_Fecha1);"00")+String:C10(Day of:C23(vdACT_Fecha1);"00")
	Else 
		$t_cadena:=$t_cadena
End case 

$0:=$t_cadena

