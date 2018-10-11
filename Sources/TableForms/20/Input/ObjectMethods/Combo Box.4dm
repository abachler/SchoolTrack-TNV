  // [xxSTR_Materias].Input.Combo Box()
  // Por: Alberto Bachler K.: 20-05-14, 18:15:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
ARRAY TEXT:C222($at_grupo;0)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		[xxSTR_Materias:20]Grupo_estadístico:19:=Self:C308->{0}
		[xxSTR_Materias:20]Grupo_estadístico:19:=ST_Format (->[xxSTR_Materias:20]Grupo_estadístico:19)
		
	: (Form event:C388=On Data Change:K2:15)
		IT_Clairvoyance (-><>at_SubjectStatsGroups{0};-><>at_SubjectStatsGroups;"")
		[xxSTR_Materias:20]Grupo_estadístico:19:=Self:C308->{0}
		[xxSTR_Materias:20]Grupo_estadístico:19:=ST_Format (->[xxSTR_Materias:20]Grupo_estadístico:19)
		
		If (([xxSTR_Materias:20]Grupo_estadístico:19#Old:C35([xxSTR_Materias:20]Grupo_estadístico:19)) & ([xxSTR_Materias:20]Grupo_estadístico:19#""))
			START TRANSACTION:C239
			SET QUERY AND LOCK:C661(True:C214)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2)
			
			Case of 
				: ((Records in set:C195("lockedset")>0) & (OK=0))
					[xxSTR_Materias:20]Grupo_estadístico:19:=Old:C35([xxSTR_Materias:20]Grupo_estadístico:19)
					CANCEL TRANSACTION:C241
					ModernUI_Notificacion (__ ("Edición de subsector de aprendizaje");__ ("El grupo estadístico de este subsector de aprendizaje no puede ser modificado en este momento.\rPor favor intente nuevamente más tarde.");"OK")
					
				: (Records in selection:C76([Asignaturas:18])>0)
					AT_Populate (->$at_grupo;->[xxSTR_Materias:20]Grupo_estadístico:19;Records in selection:C76([Asignaturas:18]))
					KRL_Array2Selection (->$at_grupo;->[Asignaturas:18]GrupoEstadistico:89)
					SAVE RECORD:C53([xxSTR_Materias:20])
					VALIDATE TRANSACTION:C240
					
				: (Old:C35([xxSTR_Materias:20]Grupo_estadístico:19)#[xxSTR_Materias:20]Grupo_estadístico:19)  //ABC 20180320//201134 
					SAVE RECORD:C53([xxSTR_Materias:20])  //si no tiene aisgnaturas igual se debería poder aqsignar el grupo estadistico 
					VALIDATE TRANSACTION:C240  //ya que se pueden configurar todas las materias primero y luego aisgnarlas al crear asignaturas
					
				Else 
					CANCEL TRANSACTION:C241
					
			End case 
		End if 
		
End case 



