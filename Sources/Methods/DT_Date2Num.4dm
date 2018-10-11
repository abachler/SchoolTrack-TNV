//%attributes = {}
  //DT_Date2Num

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : dt_Date2Num
	  //Autor: Alberto Bachler
	  //Creada el 20/6/96 a 3:37 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_DATE:C307($1)
C_LONGINT:C283($d;$0)
$d:=($1-!1904-01-01!)
$0:=$d

