//%attributes = {}
  //BBLusr_OnActivate

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : MT_usrActivatio
	  //Autor: Alberto Bachler
	  //Creada el 9/6/96 a 12:27 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

If (Record number:C243([BBL_Lectores:72])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo usuario"))
Else 
	SET WINDOW TITLE:C213(__ ("Lector: ")+[BBL_Lectores:72]NombreCompleto:3)
End if 

If ([BBL_Lectores:72]ID:1<0)
	OBJECT SET ENTERABLE:C238(*;"@";False:C215)
	OBJECT SET VISIBLE:C603(*;"popups@";False:C215)
End if 

If (([BBL_Lectores:72]Número_de_alumno:6#0) | ([BBL_Lectores:72]Número_de_Persona:31#0) | ([BBL_Lectores:72]Número_de_Profesor:30#0))
	OBJECT SET VISIBLE:C603(*;"linkLectores@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"linkLectores@";True:C214)
End if 
