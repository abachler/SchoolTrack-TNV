
OBJECT SET VISIBLE:C603(*;"post@";True:C214)
OBJECT SET VISIBLE:C603(*;"nopost@";False:C215)


READ ONLY:C145([Profesores:4])
QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[ADT_Candidatos:49]ID_Entrevistador:54)

Case of 
		
	: (<>lUSR_CurrentUserID<0)
		OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
		If (([Familia:78]Es_Postulante:18) & ([ADT_Candidatos:49]Fecha_de_Entrevista:4=!00-00-00!) & ([ADT_Candidatos:49]Fecha_de_presentación:5=!00-00-00!))
			OBJECT SET VISIBLE:C603(*;"nopost@";True:C214)
			OBJECT SET VISIBLE:C603(*;"PostGrupo@";False:C215)
			OBJECT SET ENTERABLE:C238(*;"PostGrupoG@";True:C214)
			OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"PostGrupo@";True:C214)
			OBJECT SET VISIBLE:C603(*;"nopost@";False:C215)
			OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
		End if 
		
	: (([ADT_Candidatos:49]Si_ObsEntPrivada:55) & (<>tUSR_CurrentUserName#[Profesores:4]Nombre_comun:21))
		If ([ADT_Candidatos:49]Observaciones_entrevista:12#"")
			OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";True:C214)
			OBJECT SET VISIBLE:C603(*;"PostGrupoG@";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
			OBJECT SET VISIBLE:C603(*;"PostGrupoG@";True:C214)
		End if 
		
	: (([ADT_Candidatos:49]Si_ObsEntPrivada:55) & (<>tUSR_CurrentUserName=[Profesores:4]Nombre_comun:21))
		OBJECT SET VISIBLE:C603(*;"PostGrupoG@";True:C214)
		OBJECT SET ENTERABLE:C238(*;"PostGrupoG@";True:C214)
		OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
	: (([ADT_Candidatos:49]Si_ObsEntPrivada:55=False:C215) & (<>tUSR_CurrentUserName#[Profesores:4]Nombre_comun:21))
		OBJECT SET ENTERABLE:C238(*;"PostGrupoG@";False:C215)
		OBJECT SET VISIBLE:C603(*;"PostGrupoG@";True:C214)
		OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
	: (([ADT_Candidatos:49]Si_ObsEntPrivada:55=False:C215) & (<>tUSR_CurrentUserName=[Profesores:4]Nombre_comun:21))
		OBJECT SET ENTERABLE:C238(*;"PostGrupoG@";True:C214)
		OBJECT SET VISIBLE:C603(*;"PostGrupoG@";True:C214)
		OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
End case 