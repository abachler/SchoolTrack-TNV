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
		ARRAY TEXT:C222(aTableNames;0)
		ARRAY LONGINT:C221(aTableNumbers;0)
		For ($i;1;Get last table number:C254)
			If (Is table number valid:C999($i))
				APPEND TO ARRAY:C911(aTableNumbers;$i)
				APPEND TO ARRAY:C911(aTableNames;Table name:C256($i))
			End if 
		End for 
		SORT ARRAY:C229(aTableNames;aTableNumbers)
		aTableNames:=1
		aTableNumbers:=1
		
		ARRAY TEXT:C222(aFieldNames;0)
		ARRAY LONGINT:C221(aFieldNumbers;0)
		For ($i;1;Get last field number:C255(aTableNumbers{aTableNumbers}))
			If (Is field number valid:C1000(aTableNumbers{aTableNumbers};$i))
				APPEND TO ARRAY:C911(aFieldNames;Field name:C257(aTableNumbers{aTableNumbers};$i))
				APPEND TO ARRAY:C911(aFieldNumbers;$i)
			End if 
		End for 
		SORT ARRAY:C229(aFieldNames;aFieldNumbers)
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		aTableNumbers:=aTableNames
		ARRAY TEXT:C222(aFieldNames;0)
		ARRAY LONGINT:C221(aFieldNumbers;0)
		For ($i;1;Get last field number:C255(aTableNumbers{aTableNumbers}))
			If (Is field number valid:C1000(aTableNumbers{aTableNumbers};$i))
				APPEND TO ARRAY:C911(aFieldNames;Field name:C257(aTableNumbers{aTableNumbers};$i))
				APPEND TO ARRAY:C911(aFieldNumbers;$i)
			End if 
		End for 
		SORT ARRAY:C229(aFieldNames;aFieldNumbers)
		aFieldNames:=0
End case 