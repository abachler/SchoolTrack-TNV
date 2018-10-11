//%attributes = {}
  // DT_DayNameFromISODayNumber()
  // Por: Alberto Bachler: 20/03/13, 10:18:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_numeroDiaISO)
C_TEXT:C284($t_nombreDia)

If (False:C215)
	C_TEXT:C284(DT_DayNameFromISODayNumber ;$0)
	C_LONGINT:C283(DT_DayNameFromISODayNumber ;$1)
End if 
$l_numeroDiaISO:=$1

Case of 
	: ($l_numeroDiaISO=1)
		$t_nombreDia:=__ ("Lunes")
		
	: ($l_numeroDiaISO=2)
		$t_nombreDia:=__ ("Martes")
		
	: ($l_numeroDiaISO=3)
		$t_nombreDia:=__ ("Miércoles")
		
	: ($l_numeroDiaISO=4)
		$t_nombreDia:=__ ("Jueves")
		
	: ($l_numeroDiaISO=5)
		$t_nombreDia:=__ ("Viernes")
		
	: ($l_numeroDiaISO=6)
		$t_nombreDia:=__ ("Sábado")
		
	: ($l_numeroDiaISO=7)
		$t_nombreDia:=__ ("Domingo")
End case 

$0:=$t_nombreDia

