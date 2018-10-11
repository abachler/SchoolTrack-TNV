If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Script aFamilia
	  //Autor: Alberto Bachler
	  //Creada el 30/6/96 a 7:02 PM
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
	: (Form event:C388=On Double Clicked:K2:5)
		GOTO SELECTED RECORD:C245([Familia:78];aFamilia)
		[Alumnos:2]Familia_Número:24:=[Familia:78]Numero:1
		vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
		bSelect:=1
		ACCEPT:C269
	: (Form event:C388=On Clicked:K2:4)
		GOTO SELECTED RECORD:C245([Familia:78];aFamilia)
		vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
End case 