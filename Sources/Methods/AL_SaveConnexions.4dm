//%attributes = {}
  //AL_SaveConnexions

  //If (vb_ConnectionsModified)
  //ALL SUBRECORDS([Alumnos]Conexiones)
  //SF_ClearSubtable (->[Alumnos]Conexiones)
  //SF_Array2SubTable (->[Alumnos]Conexiones;->at_Connexions;->[Alumnos]Conexiones'Conexion)
  //vb_ConnectionsModified:=False
  //End if 

  //MONO CONEXIONES
If (vb_ConnectionsModified)
	READ ONLY:C145([Alumnos_Conexiones:212])
	For ($i;1;Size of array:C274(at_Connexions))
		
		If (ab_conexionnueva{$i})
			  //QUERY([Alumnos_Conexiones];[Alumnos_Conexiones]Alumno_AutoUUID=[Alumnos]Auto_UUID;*)
			  //QUERY([Alumnos_Conexiones]; & ;[Alumnos_Conexiones]Conexion=at_Connexions{$i})
			  //
			  //If (Records in selection([Alumnos_Conexiones])=0)
			READ WRITE:C146([Alumnos_Conexiones:212])
			CREATE RECORD:C68([Alumnos_Conexiones:212])
			[Alumnos_Conexiones:212]Alumno_AutoUUID:7:=[Alumnos:2]auto_uuid:72
			[Alumnos_Conexiones:212]Conexion:1:=at_Connexions{$i}
			SAVE RECORD:C53([Alumnos_Conexiones:212])
			KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
		End if 
	End for 
	
	If (Size of array:C274(at_auto_uuid_a_eliminar)>0)
		READ WRITE:C146([Alumnos_Conexiones:212])
		QUERY WITH ARRAY:C644([Alumnos_Conexiones:212]Auto_UUID:6;at_auto_uuid_a_eliminar)
		DELETE SELECTION:C66([Alumnos_Conexiones:212])
		KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
	End if 
	
	vb_ConnectionsModified:=False:C215
End if 