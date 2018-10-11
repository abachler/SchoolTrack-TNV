  // [xxSTR_Materias].Input.lb_matrices()
  // Por: Alberto Bachler K.: 21-05-14, 15:26:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_numeroNivel;$l_recNumMatrizSeleccionada)
C_POINTER:C301($y_listaEnunciadosMapas;$y_listaEnunciadosMatriz;$y_nivelNumero_al;$y_nombreMatriz_at;$y_nombreNivel;$y_recNumMatriz_al)
C_TEXT:C284($t_nombreMatriz;$t_nombreNivel;$t_tituloMatriz)

$y_recNumMatriz_al:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizRecnum")
$y_nombreMatriz_at:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizNombre")
$l_recNumMatrizSeleccionada:=$y_recNumMatriz_al->{$y_recNumMatriz_al->}
$t_nombreMatriz:=$y_nombreMatriz_at->{$y_nombreMatriz_at->}
$y_nivelNumero_al:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNumero")
$l_numeroNivel:=$y_nivelNumero_al->{$y_nivelNumero_al->}
$y_nombreNivel:=OBJECT Get pointer:C1124(Object named:K67:5;"nivelNombre")
$t_nombreNivel:=$y_nombreNivel->{$y_nombreNivel->}

$y_listaEnunciadosMatriz:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados")
$y_listaEnunciadosMapas:=OBJECT Get pointer:C1124(Object named:K67:5;"enunciadosMapa")

Case of 
	: (Form event:C388=On Clicked:K2:4)
		
	: (Form event:C388=On Selection Change:K2:29)
		If ($y_recNumMatriz_al->>0)
			$l_recNumMatrizSeleccionada:=$y_recNumMatriz_al->{$y_recNumMatriz_al->}
			MPA_ListaEnunciadosMatriz ($l_recNumMatrizSeleccionada;$l_numeroNivel;$y_listaEnunciadosMatriz)
			$t_tituloMatriz:=__ ("Competencias en ^0")
			$t_tituloMatriz:=Replace string:C233($t_tituloMatriz;"^0";$t_nombreMatriz)
			OBJECT SET TITLE:C194(*;"tituloMatriz";$t_tituloMatriz)
		End if 
End case 

