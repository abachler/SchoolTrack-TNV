IT_Clairvoyance (Self:C308;->at_Profesores_Nombres;"";False:C215;->al_Profesores_ID)
If (Form event:C388=On Data Change:K2:15)
	If (USR_checkRights ("M";->[Asignaturas:18]))
		If (Self:C308->#"")
			SORT ARRAY:C229(at_Profesores_Nombres;al_Profesores_ID;>)
			$el:=Find in array:C230(at_Profesores_Nombres;Self:C308->)
			If ($el>0)
				READ ONLY:C145([Profesores:4])
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=al_Profesores_ID{$el})
				[Asignaturas:18]profesor_firmante_Nombre:34:=[Profesores:4]Nombres_apellidos:40
				[Asignaturas:18]Habilitacion_del_profesor:37:=[Profesores:4]Habilitacion_MinEduc:26
				[Asignaturas:18]profesor_firmante_numero:33:=[Profesores:4]Numero:1
			Else 
				[Asignaturas:18]profesor_firmante_numero:33:=0
				[Asignaturas:18]profesor_firmante_Nombre:34:=""
				[Asignaturas:18]Habilitacion_del_profesor:37:=""
				REDUCE SELECTION:C351([Profesores:4];0)
			End if 
		Else 
			[Asignaturas:18]profesor_firmante_numero:33:=0
			[Asignaturas:18]profesor_firmante_Nombre:34:=""
			[Asignaturas:18]Habilitacion_del_profesor:37:=""
			REDUCE SELECTION:C351([Profesores:4];0)
		End if 
	Else 
		CD_Dlog (0;__ ("Usted no está autorizado para modificar este registro."))
		Self:C308->:=Old:C35(Self:C308->)
	End if 
End if 
