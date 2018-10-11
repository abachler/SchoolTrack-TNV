//%attributes = {}
  // DT_FechaAbreviada()
  // Por: Alberto Bachler: 29/05/13, 15:25:59
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_DATE:C307($1;$d_fecha)
C_TEXT:C284($0;$t_fecha;$t_modo)

$d_fecha:=$1
$t_modo:=$2

$l_numeroDiaISO:=DT_GetDayNumber_ISO8601 ($d_fecha)
$l_dia:=Day of:C23($d_fecha)
$l_Mes:=Month of:C24($d_fecha)
$l_año:=Year of:C25($d_fecha)

Case of 
	: ($l_numeroDiaISO=1)
		$t_diaLargo:=__ ("Lunes")
		$t_diaAbreviado:=__ ("Lun")
	: ($l_numeroDiaISO=2)
		$t_diaLargo:=__ ("Martes")
		$t_diaAbreviado:=__ ("Mar")
	: ($l_numeroDiaISO=3)
		$t_diaLargo:=__ ("Miércoles")
		$t_diaAbreviado:=__ ("Mie")
	: ($l_numeroDiaISO=4)
		$t_diaLargo:=__ ("Jueves")
		$t_diaAbreviado:=__ ("Jue")
	: ($l_numeroDiaISO=5)
		$t_diaLargo:=__ ("Viernes")
		$t_diaAbreviado:=__ ("Vie")
	: ($l_numeroDiaISO=6)
		$t_diaLargo:=__ ("Sabado")
		$t_diaAbreviado:=__ ("Sab")
	: ($l_numeroDiaISO=7)
		$t_diaLargo:=__ ("Domingo")
		$t_diaAbreviado:=__ ("Dom")
End case 

Case of 
	: ($l_Mes=1)
		$t_mesLargo:=__ ("Enero")
		$t_mesAbreviado:=__ ("Ene")
	: ($l_Mes=2)
		$t_mesLargo:=__ ("Febrero")
		$t_mesAbreviado:=__ ("Feb")
	: ($l_Mes=3)
		$t_mesLargo:=__ ("Marzo")
		$t_mesAbreviado:=__ ("Mar")
	: ($l_Mes=4)
		$t_mesLargo:=__ ("Abril")
		$t_mesAbreviado:=__ ("Abr")
	: ($l_Mes=5)
		$t_mesLargo:=__ ("Mayo")
		$t_mesAbreviado:=__ ("May")
	: ($l_Mes=6)
		$t_mesLargo:=__ ("Junio")
		$t_mesAbreviado:=__ ("Jun")
	: ($l_Mes=7)
		$t_mesLargo:=__ ("Julio")
		$t_mesAbreviado:=__ ("Jul")
	: ($l_Mes=8)
		$t_mesLargo:=__ ("Agosto")
		$t_mesAbreviado:=__ ("Ago")
	: ($l_Mes=9)
		$t_mesLargo:=__ ("Septiembre")
		$t_mesAbreviado:=__ ("Sep")
	: ($l_Mes=10)
		$t_mesLargo:=__ ("Octubre")
		$t_mesAbreviado:=__ ("Oct")
	: ($l_Mes=11)
		$t_mesLargo:=__ ("Noviembre")
		$t_mesAbreviado:=__ ("Nov")
	: ($l_Mes=12)
		$t_mesLargo:=__ ("Diciembre")
		$t_mesAbreviado:=__ ("Dic")
End case 

Case of 
	: ($t_modo="Abreviado")
		$t_Fecha:=$t_diaAbreviado+", "+String:C10($l_dia)+" "+$t_mesAbreviado+", "+String:C10($l_año)
		
	: ($t_Modo="Largo")
		$t_Fecha:=$t_diaLargo+", "+String:C10($l_dia)+" "+$t_mesLargo+", "+String:C10($l_año)
		
End case 


$0:=$t_fecha


