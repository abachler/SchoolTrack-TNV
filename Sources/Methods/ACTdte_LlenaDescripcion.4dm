//%attributes = {}
C_LONGINT:C283($1;$3;$l_enviaDesc;$l_indice)
C_TEXT:C284($2;$tACT_TextoDescripcion;$t_retorno)
$l_enviaDesc:=$1
$tACT_TextoDescripcion:=$2
$l_indice:=$3

If (($l_enviaDesc=1) & ($tACT_TextoDescripcion#""))
	C_TEXT:C284($t_apellidos_y_nombres;$t_mes;$t_curso;$t_rut;$t_year;$t_nivel)
	If (Position:C15("&al_ape&";$tACT_TextoDescripcion)>0)
		vQR_Pointer1:=Get pointer:C304("vtACT_SRbol_CuentaCargo"+String:C10($l_indice)+"1")  //nombre
		$t_apellidos_y_nombres:=vQR_Pointer1->
	Else 
		$t_apellidos_y_nombres:=""
	End if 
	If (Position:C15("&car_mes&";$tACT_TextoDescripcion)>0)
		vQR_Pointer1:=Get pointer:C304("vtACT_SRbol_MesCargo"+String:C10($l_indice)+"1")  //mes
		$t_mes:=vQR_Pointer1->
	Else 
		$t_mes:=""
	End if 
	If (Position:C15("&al_cur&";$tACT_TextoDescripcion)>0)
		vQR_Pointer1:=Get pointer:C304("vtACT_SRbol_CuentaCurCargo"+String:C10($l_indice)+"1")
		$t_curso:=vQR_Pointer1->
	Else 
		$t_curso:=""
	End if 
	If (Position:C15("&al_rut&";$tACT_TextoDescripcion)>0)
		vQR_Pointer1:=Get pointer:C304("vtACT_SRbol_CuentaRUT"+String:C10($l_indice)+"1")
		$t_rut:=vQR_Pointer1->
	Else 
		$t_rut:=""
	End if 
	If (Position:C15("&car_year&";$tACT_TextoDescripcion)>0)
		vQR_Pointer1:=Get pointer:C304("vtACT_SRbol_AñoCargo"+String:C10($l_indice)+"1")
		$t_year:=vQR_Pointer1->
	Else 
		$t_year:=""
	End if 
	If (Position:C15("&al_nivel&";$tACT_TextoDescripcion)>0)
		vQR_Pointer1:=Get pointer:C304("vtACT_SRbol_CuentaNivCargo"+String:C10($l_indice)+"1")
		$t_nivel:=vQR_Pointer1->
	Else 
		$t_nivel:=""
	End if 
	
	If (($t_apellidos_y_nombres#"") | ($t_mes#"") | ($t_curso#"") | ($t_rut#"") | ($t_year#"") | ($t_nivel#""))
		$t_retorno:=$tACT_TextoDescripcion
		$t_retorno:=Replace string:C233($t_retorno;"&al_ape&";$t_apellidos_y_nombres)
		$t_retorno:=Replace string:C233($t_retorno;"&car_mes&";$t_mes)
		$t_retorno:=Replace string:C233($t_retorno;"&al_cur&";$t_curso)
		$t_retorno:=Replace string:C233($t_retorno;"&al_rut&";$t_rut)
		$t_retorno:=Replace string:C233($t_retorno;"&car_year&";$t_year)
		$t_retorno:=Replace string:C233($t_retorno;"&al_nivel&";$t_nivel)
	Else 
		  //$t_retorno:=""
		$t_retorno:=" "  //20160428 RCH Para que el XML genere el tag desc
	End if 
	
Else 
	$t_retorno:=""
End if 

$0:=$t_retorno