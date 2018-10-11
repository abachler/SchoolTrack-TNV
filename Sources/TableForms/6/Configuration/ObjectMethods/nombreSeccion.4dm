  // [xxSTR_Niveles].Configuration.nombreSeccion()
  // Por: Alberto Bachler K.: 09-06-14, 15:38:42
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
ARRAY TEXT:C222($at_nombreSeccion;0)


$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (-><>aListSect;->[xxSTR_Niveles:6]Sección:9)
If ($l_itemSeleccionado>0)
	If ([xxSTR_Niveles:6]Sección:9#<>aListSect{$l_itemSeleccionado})
		[xxSTR_Niveles:6]Sección:9:=<>aListSect{$l_itemSeleccionado}
		
		START TRANSACTION:C239
		SET QUERY AND LOCK:C661(True:C214)
		
		READ WRITE:C146([Alumnos:2])
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=[xxSTR_Niveles:6]NoNivel:5)
		CREATE SET:C116([Alumnos:2];"alumnos")
		
		If ((OK=1) & (Records in set:C195("lockedSet")=0))
			READ WRITE:C146([Cursos:3])
			QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[xxSTR_Niveles:6]NoNivel:5)
			CREATE SET:C116([Cursos:3];"cursos")
		End if 
		
		If ((OK=1) & (Records in set:C195("lockedSet")=0))
			$l_IdProceso:=IT_UThermometer (1;0;__ ("Actualizando nombre de la sección en toda la base de datos…"))
			
			USE SET:C118("alumnos")
			AT_Populate (->$at_nombreSeccion;->[xxSTR_Niveles:6]Sección:9;Records in set:C195("alumnos"))
			ARRAY TO SELECTION:C261($at_nombreSeccion;[Alumnos:2]Sección:26)
			
			USE SET:C118("cursos")
			AT_Populate (->$at_nombreSeccion;->[xxSTR_Niveles:6]Sección:9;Records in set:C195("cursos"))
			ARRAY TO SELECTION:C261($at_nombreSeccion;[Cursos:3]Ciclo:5)
			
			IT_UThermometer (-2;$l_IdProceso)
			
			SAVE RECORD:C53([xxSTR_Niveles:6])
			SET QUERY AND LOCK:C661(False:C215)
			VALIDATE TRANSACTION:C240
			
		Else 
			[xxSTR_Niveles:6]Sección:9:=Old:C35([xxSTR_Niveles:6]Sección:9)
			SET QUERY AND LOCK:C661(False:C215)
			CANCEL TRANSACTION:C241
			CD_Dlog (0;"No es posible modificar el nombre de ciclo o sección en este momento.\rPor favor inténtelo nuevamente más tarde.")
		End if 
	End if 
	
	SET_ClearSets ("alumnos";"cursos")
	KRL_UnloadReadOnly (->[Alumnos:2];->[Cursos:3])
	
End if 