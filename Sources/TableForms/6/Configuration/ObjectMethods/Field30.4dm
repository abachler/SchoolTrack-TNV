READ WRITE:C146([Cursos:3])
  //20151007 ASM Ticket 150900
If (Find in field:C653([xxSTR_Niveles:6]Nombre_Oficial_NIvel:21;[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)#-1)
	CD_Dlog (0;"Ya existe un nivel configurado con este nombre.")
	[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21:=Old:C35([xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)
Else 
	START TRANSACTION:C239
	SET QUERY AND LOCK:C661(True:C214)
	QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[xxSTR_Niveles:6]NoNivel:5)
	If ((OK=1) & (Records in set:C195("lockedset")=0))
		SAVE RECORD:C53([xxSTR_Niveles:6])
		APPLY TO SELECTION:C70([Cursos:3];[Cursos:3]Nombre_Oficial_Nivel:14:=[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)
		SET QUERY AND LOCK:C661(False:C215)
		VALIDATE TRANSACTION:C240
	Else 
		[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21:=Old:C35([xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)
		SET QUERY AND LOCK:C661(False:C215)
		CANCEL TRANSACTION:C241
		CD_Dlog (0;__ ("No es posible actualizar el nombre oficial del nivel en este momento.\rPor favor inténtelo nuevamente mas tarde."))
	End if 
	
End if 

KRL_UnloadReadOnly (->[Cursos:3])