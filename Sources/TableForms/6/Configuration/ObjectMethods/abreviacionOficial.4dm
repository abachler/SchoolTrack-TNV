  // [xxSTR_Niveles].Configuration.abreviacionOficial()
  // Por: Alberto Bachler K.: 09-06-14, 13:37:48
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


START TRANSACTION:C239
SET QUERY AND LOCK:C661(True:C214)
READ WRITE:C146([Cursos:3])
QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[xxSTR_Niveles:6]NoNivel:5)
If ((OK=1) & (Records in set:C195("LockedSet")=0))
	APPLY TO SELECTION:C70([Cursos:3];[Cursos:3]Nombre_Oficial_Curso:15:=[xxSTR_Niveles:6]Abreviatura_Oficial:35+"-"+[Cursos:3]Letra_Oficial_del_Curso:18)
	KRL_UnloadReadOnly (->[Cursos:3])
	SAVE RECORD:C53([xxSTR_Niveles:6])
	SET QUERY AND LOCK:C661(False:C215)
	VALIDATE TRANSACTION:C240
Else 
	SET QUERY AND LOCK:C661(False:C215)
	CANCEL TRANSACTION:C241
	[xxSTR_Niveles:6]Abreviatura_Oficial:35:=Old:C35([xxSTR_Niveles:6]Abreviatura_Oficial:35)
	CD_Dlog (0;__ ("No es posible actualizar la abreviación del nivel en este momento.\rPor favor inténtelo nuevamente mas tarde."))
	GOTO OBJECT:C206([xxSTR_Niveles:6]Abreviatura_Oficial:35)
End if 

