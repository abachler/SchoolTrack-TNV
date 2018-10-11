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
C_LONGINT:C283(iTableNumber)

Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(aTableNames;Get last table number:C254)
		ARRAY LONGINT:C221(aTableNumbers;Get last table number:C254)
		For ($i;1;Get last table number:C254)
			If (Is table number valid:C999($i))
				aTableNames{$i}:=Table name:C256($i)
				aTableNumbers{$i}:=$i
			End if 
		End for 
		SORT ARRAY:C229(aTableNames;aTableNumbers;>)
		If (iTableNumber>0)
			aTableNames:=Find in array:C230(aTableNumbers;iTableNumber)
			b1All:=1
			nbRec:=Records in selection:C76(Table:C252(iTableNumber)->)
		Else 
			b1All:=0
			aTableNames:=0
		End if 
		
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		iTableNumber:=aTableNumbers{aTableNames}
End case 