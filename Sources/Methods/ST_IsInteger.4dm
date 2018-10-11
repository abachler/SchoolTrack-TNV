//%attributes = {}
  //ST_IsInteger

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_IsNumeric
	  //Autor: Julia Belmar
	  //Creada el 12/03/2010 a 11:55
	  //============================== DESCRIPCION ==============================
	  //Package: 
	  //Descripción: Retorna true si la cadena pasada como parámetro es un número. No funciona para numeros reales, Ejemplo: 3,14
	  //Sintaxis: 
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

ARRAY TEXT:C222($digitos;10)


$digitos{1}:="1"
$digitos{2}:="2"
$digitos{3}:="3"
$digitos{4}:="4"
$digitos{5}:="5"
$digitos{6}:="6"
$digitos{7}:="7"
$digitos{8}:="8"
$digitos{9}:="9"
$digitos{10}:="0"

C_POINTER:C301($1;$puntero)  //puntero a una cadena

  //0000_TestsJBA

$puntero:=$1
$aux:=$puntero->
$0:=True:C214
While ($aux#"")
	$c:=Substring:C12($aux;1;1)  //`extraigo el primer caracter
	$aux:=Substring:C12($aux;2;Length:C16($aux))  //recorto la cadena
	
	If (Find in array:C230($digitos;$c)=-1)
		$0:=False:C215
	End if 
End while 