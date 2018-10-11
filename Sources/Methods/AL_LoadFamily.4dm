//%attributes = {}
  //AL_LoadFamily

Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		READ WRITE:C146([Familia:78])
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
		$readOnlyState:=Locked:C147([Familia:78])
		If (Not:C34($readOnlyState))
			If ([Familia:78]Nombre_de_la_familia:3="")
				[Familia:78]Nombre_de_la_familia:3:=[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4
			End if 
			
			If (([Familia:78]Dirección:7="") & ([Familia:78]Comuna:8="") & ([Familia:78]Ciudad:9="") & ([Familia:78]Codigo_postal:19="") & ([Familia:78]Region_o_estado:34=""))
				[Familia:78]Dirección:7:=[Alumnos:2]Direccion:12
				[Familia:78]Comuna:8:=[Alumnos:2]Comuna:14
				[Familia:78]Ciudad:9:=[Alumnos:2]Ciudad:15
				[Familia:78]Region_o_estado:34:=[Alumnos:2]Región_o_estado:16
				[Familia:78]Codigo_postal:19:=[Alumnos:2]Codigo_Postal:13
			End if 
			If ([Familia:78]Telefono:10="")
				[Familia:78]Telefono:10:=[Alumnos:2]Telefono:17
			End if 
		End if 
		
	: (vsBWR_CurrentModule="AccountTrack")
		
End case 

AL_UpdateArrays (xALP_Hermano;0)
AL_UpdateArrays (xALP_Familia;0)
AL_LoadFamRels 
AL_LoadBrothers 
AL_UpdateArrays (xALP_Hermano;-2)
AL_UpdateArrays (xALP_Familia;-2)
AL_SetLine (xALP_Hermano;0)
AL_SetLine (xALP_Familia;0)
$0:=$readOnlyState