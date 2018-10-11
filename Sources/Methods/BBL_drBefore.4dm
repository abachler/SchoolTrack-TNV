//%attributes = {}
  //BBL_drBefore

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : MT_drBefore
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 16:23
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 


If (<>aPrefDoc=0)
	<>aPrefDoc:=Find in array:C230(<>aPrefDoc;"GEN")
	QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1="GEN")
End if 
If (<>aPrefDoc{<>aPrefDoc}="GEN")
	_O_DISABLE BUTTON:C193(bDelDR)
	OBJECT SET ENTERABLE:C238([xxBBL_ReglasParaItems:69]Codigo_regla:1;False:C215)
	OBJECT SET COLOR:C271([xxBBL_ReglasParaItems:69]Codigo_regla:1;-61711)
Else 
	OBJECT SET ENTERABLE:C238([xxBBL_ReglasParaItems:69]Codigo_regla:1;True:C214)
	OBJECT SET COLOR:C271([xxBBL_ReglasParaItems:69]Codigo_regla:1;-15)
	_O_ENABLE BUTTON:C192(bDelDR)
End if 

If (Record number:C243([xxBBL_ReglasParaItems:69])=-3)
	[xxBBL_ReglasParaItems:69]DiasPrestamo:3:=<>MTi_LnDay
	[xxBBL_ReglasParaItems:69]Dias_gracia:4:=<>MTi_GrDay
	[xxBBL_ReglasParaItems:69]Multa_diaria:5:=<>MTr_Fine
	[xxBBL_ReglasParaItems:69]Max_renovacione:6:=<>MTi_Renov
	[xxBBL_ReglasParaItems:69]Reserva_anticipación:7:=<>MTi_RsDays
End if 