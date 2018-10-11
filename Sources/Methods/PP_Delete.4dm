//%attributes = {}
  //PP_Delete

C_LONGINT:C283($vl_RegistrosCargos;$vl_RegistrosPagos)
C_LONGINT:C283($r;$0)
C_BOOLEAN:C305($delete)
If (USR_checkRights ("D";->[Personas:7]))
	READ ONLY:C145([Familia:78])
	QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Personas:7]No:1;*)
	QUERY:C277([Familia:78]; | [Familia:78]Madre_Número:6=[Personas:7]No:1)
	$familia:=[Familia:78]Nombre_de_la_familia:3
	
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1;*)
	QUERY:C277([Alumnos:2]; | [Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
	SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aText1)
	For ($i;1;Size of array:C274(aText1))
		aText1{$i}:="   - "+aText1{$i}
	End for 
	$alumnos:=AT_array2text (->aText1;"\r")
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_RegistrosCargos)
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_RegistrosPagos)
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	$delete:=False:C215
	Case of 
		: (($familia#"") & ($alumnos#""))
			$msg:=[Personas:7]Apellidos_y_nombres:30+" tiene relación con la familia: "+"\r"+"   - "+$familia+"\r\r"
			$msg:=$msg+" y con los siguientes alumnos: "+"\r"+$alumnos+"\r\r"+"El registro no puede ser eliminado."
		: (($familia="") & ($alumnos#""))
			$msg:=[Personas:7]Apellidos_y_nombres:30+" tiene relación con los alumnos "+"\r"+$alumnos+"\r\r"
			$msg:=$msg+"El registro no puede ser eliminado."
		: ((($vl_RegistrosPagos>0) | ($vl_RegistrosCargos>0)) & (Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))=1))
			$msg:=[Personas:7]Apellidos_y_nombres:30+" posee información relacionada a AccountTrack. El apoderado no puede ser eliminad"+"o."
		: (($familia#"") & ($alumnos=""))
			$msg:=[Personas:7]Apellidos_y_nombres:30+" tiene relación con la familia "+"\r"+"   - "+$familia+"\r"
			$msg:=$msg+"¿Desea Ud. realmente eliminar esta ficha?"
			$delete:=True:C214
		: (($familia="") & ($alumnos=""))
			$msg:="¿Desea Ud. realmente eliminar la ficha de "+[Personas:7]Apellidos_y_nombres:30+"?"
			$delete:=True:C214
	End case 
	If ($delete=False:C215)
		CD_Dlog (0;$msg)
	Else 
		$r:=CD_Dlog (2;$msg;__ ("");__ ("No");__ ("Eliminar"))
		If ($r=2)
			$vl_recNum:=Record number:C243([Personas:7])
			READ WRITE:C146([Familia:78])
			QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Personas:7]No:1)
			If (Records in selection:C76([Familia:78])>0)
				While (Not:C34(End selection:C36([Familia:78])))
					[Familia:78]Padre_Número:5:=0
					[Familia:78]Padre_Nombre:15:=""
					[Familia:78]Nombres_padres:22:=ST_GetLine ([Familia:78]Nombres_padres:22;1)+"\r"
					SAVE RECORD:C53([Familia:78])
					NEXT RECORD:C51([Familia:78])
				End while 
				UNLOAD RECORD:C212([Familia:78])
			Else 
				QUERY:C277([Familia:78];[Familia:78]Madre_Número:6=[Personas:7]No:1)
				If (Records in selection:C76([Familia:78])>0)
					While (Not:C34(End selection:C36([Familia:78])))
						[Familia:78]Madre_Número:6:=0
						[Familia:78]Madre_Nombre:16:=""
						[Familia:78]Nombres_padres:22:=""+"\r"+ST_GetLine ([Familia:78]Nombres_padres:22;2)
						SAVE RECORD:C53([Familia:78])
						NEXT RECORD:C51([Familia:78])
					End while 
					UNLOAD RECORD:C212([Familia:78])
				End if 
			End if 
			READ ONLY:C145([Familia:78])
			
			READ WRITE:C146([Familia_RelacionesFamiliares:77])
			QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
			If (Records in selection:C76([Familia_RelacionesFamiliares:77])>0)
				DELETE SELECTION:C66([Familia_RelacionesFamiliares:77])
			End if 
			READ ONLY:C145([Familia_RelacionesFamiliares:77])
			
			READ WRITE:C146([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1)
			APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27:=0)
			QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
			APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28:=0)
			UNLOAD RECORD:C212([Alumnos:2])
			READ ONLY:C145([Alumnos:2])
			
			READ WRITE:C146([Profesores:4])
			QUERY:C277([Profesores:4];[Profesores:4]ID_Persona:65=[Personas:7]No:1)
			[Profesores:4]ID_Persona:65:=0
			[Profesores:4]ConAlumnosRelacionados:64:=False:C215
			SAVE RECORD:C53([Profesores:4])
			KRL_ReloadAsReadOnly (->[Profesores:4])
			
			  //20140611 RCH borrar educacion anterior
			ARRAY LONGINT:C221($aIDs;0)
			APPEND TO ARRAY:C911($aIDs;[Personas:7]No:1)
			ADTcdd_DeleteEducacionAnterior (->$aIDs;"pe")
			
			READ WRITE:C146([Personas:7])
			GOTO RECORD:C242([Personas:7];$vl_recNum)
			DELETE RECORD:C58([Personas:7])
			
			$0:=1
		End if 
	End if 
Else 
	USR_ALERT_UserHasNoRights (3)
End if 