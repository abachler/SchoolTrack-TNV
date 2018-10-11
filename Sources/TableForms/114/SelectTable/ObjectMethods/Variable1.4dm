If (False:C215)
	  //============================== IDENTIFICACION ==============================
	
	  // Script ◊aFilePop
	
	  //Autor: Alberto Bachler
	
	  //Creada el 24/6/96 a 8:11 AM
	
	  //============================== DESCRIPCION ==============================
	
	  //Package:
	
	  //Descripción:
	
	  //Sintaxis:
	
	  //============================== MODIFICACIONES ==============================
	
	  //Fecha: 
	
	  //Autor:
	
	  //Descripción:
	
End if 

Case of 
	: (Form event:C388=On Load:K2:1)
		  //20130321 RCH
		  //ARRAY TEXT(aTableNames;Get last table number)
		  //ARRAY LONGINT(aTableNumbers;Get last table number)
		  //For ($i;1;Get last table number)
		  //aTableNames{$i}:=Table name($i)
		  //aTableNumbers{$i}:=$i
		  //End for 
		ARRAY TEXT:C222(aTableNames;0)
		ARRAY LONGINT:C221(aTableNumbers;0)
		For ($i;1;Get last table number:C254)
			If (Is table number valid:C999($i))
				APPEND TO ARRAY:C911(aTableNames;Table name:C256($i))
				APPEND TO ARRAY:C911(aTableNumbers;$i)
			End if 
		End for 
		aTableNames:=0
		vi_TableNumber:=0
		SORT ARRAY:C229(aTableNames;aTableNumbers;>)
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		vi_TableNumber:=aTableNumbers{aTableNames}
		
End case 