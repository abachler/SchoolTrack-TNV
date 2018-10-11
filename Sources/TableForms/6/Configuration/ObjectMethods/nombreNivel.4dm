  // [xxSTR_Niveles].Configuration.nombreNivel()
  // Por: Alberto Bachler K.: 09-06-14, 14:50:00
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

ARRAY TEXT:C222($at_nombreNivel;0)

Case of 
	: (Form event:C388=On After Keystroke:K2:26)
		$l_elemento:=Find in array:C230(<>aNivNo;[xxSTR_Niveles:6]NoNivel:5)
		If ($l_elemento>0)
			$t_textoEditado:=Get edited text:C655
			<>aNivel{$l_elemento}:=$t_textoEditado
			SET WINDOW TITLE:C213(__ ("Niveles Académicos: ")+<>aNivel{<>aNivel})
		End if 
		
		
	: (Form event:C388=On Data Change:K2:15)
		If ([xxSTR_Niveles:6]Nivel:1="")
			BEEP:C151
			[xxSTR_Niveles:6]Nivel:1:=Old:C35([xxSTR_Niveles:6]Nivel:1)
		Else 
			  //20151007 ASM Ticket 150900
			If (Find in field:C653([xxSTR_Niveles:6]Nivel:1;[xxSTR_Niveles:6]Nivel:1)#-1)
				CD_Dlog (0;"Ya existe un nivel configurado con este nombre.")
				[xxSTR_Niveles:6]Nivel:1:=Old:C35([xxSTR_Niveles:6]Nivel:1)
				$l_elemento:=Find in array:C230(<>aNivNo;[xxSTR_Niveles:6]NoNivel:5)
				If ($l_elemento>0)
					$t_textoEditado:=Get edited text:C655
					<>aNivel{$l_elemento}:=Old:C35([xxSTR_Niveles:6]Nivel:1)
					SET WINDOW TITLE:C213(__ ("Niveles Académicos: ")+<>aNivel{<>aNivel})
				End if 
			Else 
				
				  // inicio una transacción
				START TRANSACTION:C239
				
				  //busco y bloqueo los registros en las tablas en las que debo modificar el nivel
				SET QUERY AND LOCK:C661(True:C214)
				
				READ WRITE:C146([Alumnos:2])
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=[xxSTR_Niveles:6]NoNivel:5)
				If ((OK=1) & (Records in set:C195("LockedSet")=0))
					CREATE SET:C116([Alumnos:2];"alumnos")
				End if 
				If ((OK=1) & (Records in set:C195("LockedSet")=0))
					READ WRITE:C146([Cursos:3])
					QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[xxSTR_Niveles:6]NoNivel:5)
					CREATE SET:C116([Cursos:3];"cursos")
				End if 
				If ((OK=1) & (Records in set:C195("LockedSet")=0))
					READ WRITE:C146([Asignaturas:18])
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=[xxSTR_Niveles:6]NoNivel:5)
					CREATE SET:C116([Asignaturas:18];"asignaturas")
				End if 
				If ((OK=1) & (Records in set:C195("LockedSet")=0))
					READ WRITE:C146([Actividades:29])
					QUERY:C277([Actividades:29];[Actividades:29]Desde_NumeroNivel:5=[xxSTR_Niveles:6]NoNivel:5;*)
					CREATE SET:C116([Actividades:29];"actividadesDesde")
				End if 
				If ((OK=1) & (Records in set:C195("LockedSet")=0))
					READ WRITE:C146([Actividades:29])
					QUERY:C277([Actividades:29];[Actividades:29]Hasta_NumeroNivel:9=[xxSTR_Niveles:6]NoNivel:5;*)
					CREATE SET:C116([Actividades:29];"actividadesHasta")
				End if 
				
				If ((OK=1) & (Records in set:C195("LockedSet")=0))
					  // si no hay ningún registro bloqueado procedo a la modificación
					
					$l_IdProceso:=IT_UThermometer (1;0;__ ("Actualizando nombre del nivel en toda la base de datos…"))
					
					USE SET:C118("cursos")
					AT_Populate (->$at_nombreNivel;->[xxSTR_Niveles:6]Nivel:1;Records in set:C195("cursos"))
					ARRAY TO SELECTION:C261($at_nombreNivel;[Cursos:3]Nivel_Nombre:10)
					
					USE SET:C118("alumnos")
					AT_Populate (->$at_nombreNivel;->[xxSTR_Niveles:6]Nivel:1;Records in set:C195("alumnos"))
					ARRAY TO SELECTION:C261($at_nombreNivel;[Alumnos:2]Nivel_Nombre:34)
					
					USE SET:C118("asignaturas")
					AT_Populate (->$at_nombreNivel;->[xxSTR_Niveles:6]Nivel:1;Records in set:C195("asignaturas"))
					ARRAY TO SELECTION:C261($at_nombreNivel;[Asignaturas:18]Nivel:30)
					
					USE SET:C118("actividadesDesde")
					AT_Populate (->$at_nombreNivel;->[xxSTR_Niveles:6]Nivel:1;Records in set:C195("actividadesDesde"))
					ARRAY TO SELECTION:C261($at_nombreNivel;[Actividades:29]Desde_NombreNivel:12)
					
					USE SET:C118("actividadesHasta")
					AT_Populate (->$at_nombreNivel;->[xxSTR_Niveles:6]Nivel:1;Records in set:C195("actividadesHasta"))
					ARRAY TO SELECTION:C261($at_nombreNivel;[Actividades:29]Hasta_NombreNivel:11)
					
					SET QUERY AND LOCK:C661(False:C215)
					VALIDATE TRANSACTION:C240
					IT_UThermometer (-2;$l_IdProceso)
					
					<>aNivel{<>aNivel}:=[xxSTR_Niveles:6]Nivel:1
					
				Else 
					  // si hay registros bloqueados, informo al usuario, restauro el valor del nombre del nivel anterior a la modifación y cancelo la transacción
					[xxSTR_Niveles:6]Nivel:1:=Old:C35([xxSTR_Niveles:6]Nivel:1)
					SET QUERY AND LOCK:C661(False:C215)
					CANCEL TRANSACTION:C241
					CD_Dlog (0;__ ("No es posible modificar el nombre interno del nivel en este momento.\rPor favor intente nuevamente mas tarde."))
				End if 
			End if 
			
			
		End if 
		
		
		SET_ClearSets ("alumnos";"cursos";"asignaturas")
		KRL_UnloadReadOnly (->[Cursos:3];->[Alumnos:2];->[Asignaturas:18])
		
End case 