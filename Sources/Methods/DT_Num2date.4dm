//%attributes = {}
  //DT_Num2date

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : dt_Numtodate
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
C_DATE:C307($0)
Case of 
	: ($1=0)
		$0:=!00-00-00!
	: ($1>0)
		$0:=!1904-01-01!+$1
	: ($1<0)
		$0:=!1904-01-01!-$1
End case 