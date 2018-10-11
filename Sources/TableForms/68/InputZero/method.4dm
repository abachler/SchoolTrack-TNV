If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Formule format : InputZero
	  //Autor: Alberto Bachler
	  //Creada el 25/5/96 a 11:46
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

  //Spell_CheckSpelling 


Case of 
	: (Form event:C388=On Load:K2:1)
		_O_DISABLE BUTTON:C193(bDelXref)
		xALSet_BBL_Thesaurus_CrossRefs 
		AL_SetLine (xALP_CrossRefs;0)
		r1:=Num:C11([BBL_Thesaurus:68]Tipo:8=650)
		r2:=Num:C11([BBL_Thesaurus:68]Tipo:8=600)
		r3:=Num:C11([BBL_Thesaurus:68]Tipo:8=651)
		If ([BBL_Thesaurus:68]Tipo:8=0)  //para registros nuevos...
			r1:=1
			[BBL_Thesaurus:68]Tipo:8:=650
		End if 
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
