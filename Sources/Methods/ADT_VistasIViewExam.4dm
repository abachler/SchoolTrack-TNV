//%attributes = {}
  //ADT_VistasIViewExam

  //esto va a depender de si se ha asignado o no una entrevista, aunque
  //sea a una familia nueva
  //`verificar visibilidad de los objetos

If (([ADT_Candidatos:49]Fecha_de_Entrevista:4=!00-00-00!) & ([ADT_Candidatos:49]Fecha_de_presentación:5=!00-00-00!))
	OBJECT SET VISIBLE:C603(*;"nopost@";Not:C34([Familia:78]Es_Postulante:18))
	OBJECT SET VISIBLE:C603(*;"post@";[Familia:78]Es_Postulante:18)
	OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
	OBJECT SET VISIBLE:C603(*;"postGrupo@";False:C215)
	OBJECT SET VISIBLE:C603(*;"PostGrupoG@";False:C215)
End if 
OBJECT SET VISIBLE:C603(*;"PresEnt";True:C214)
  //`si el postulante tiene asignada entrevista o si es familia postulante
If (([ADT_Candidatos:49]Fecha_de_Entrevista:4#!00-00-00!) | ([ADT_Candidatos:49]Fecha_de_presentación:5#!00-00-00!) | ([Familia:78]Es_Postulante:18))
	
	READ ONLY:C145([Profesores:4])
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[ADT_Candidatos:49]ID_Entrevistador:54)
	Case of 
		: ((<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)))  //MONO TICkET 204006
			OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
			OBJECT SET VISIBLE:C603(*;"postGrupo@";True:C214)
			OBJECT SET ENTERABLE:C238(*;"pstGrupoG";True:C214)
			OBJECT SET VISIBLE:C603(*;"nopost@";False:C215)
		: (([ADT_Candidatos:49]Si_ObsEntPrivada:55) & (<>lUSR_RelatedTableUserID#[Profesores:4]Numero:1))
			If ([ADT_Candidatos:49]Observaciones_entrevista:12#"")
				OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";True:C214)
				OBJECT SET VISIBLE:C603(*;"nopost@";False:C215)
				OBJECT SET VISIBLE:C603(*;"postGrupo@";True:C214)
				OBJECT SET VISIBLE:C603(*;"PostGrupoG@";False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*;"nopost@";False:C215)
				OBJECT SET VISIBLE:C603(*;"postGrupo@";True:C214)
				OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
				OBJECT SET VISIBLE:C603(*;"PostGrupoG@";True:C214)
			End if 
			
		: (([ADT_Candidatos:49]Si_ObsEntPrivada:55) & (<>lUSR_RelatedTableUserID=[Profesores:4]Numero:1))
			OBJECT SET VISIBLE:C603(*;"PostGrupo@";True:C214)
			OBJECT SET ENTERABLE:C238(*;"PostGrupoG@";True:C214)
			OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
			OBJECT SET VISIBLE:C603(*;"nopost@";False:C215)
		: (([ADT_Candidatos:49]Si_ObsEntPrivada:55=False:C215) & (<>lUSR_RelatedTableUserID#[Profesores:4]Numero:1))
			OBJECT SET ENTERABLE:C238(*;"PostGrupoG@";False:C215)
			OBJECT SET VISIBLE:C603(*;"PostGrupo@";True:C214)
			OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
			OBJECT SET VISIBLE:C603(*;"nopost@";False:C215)
		: (([ADT_Candidatos:49]Si_ObsEntPrivada:55=False:C215) & (<>lUSR_RelatedTableUserID=[Profesores:4]Numero:1))
			OBJECT SET VISIBLE:C603(*;"nopost@";False:C215)
			OBJECT SET ENTERABLE:C238(*;"PostGrupo@";True:C214)
			OBJECT SET VISIBLE:C603(*;"PostGrupo@";True:C214)
			OBJECT SET VISIBLE:C603(*;"mensaje_hayObs";False:C215)
	End case 
	REDRAW WINDOW:C456
End if 

  //para el examen
READ ONLY:C145([Profesores:4])
QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[ADT_Candidatos:49]ID_Examinador:53)
  //READ WRITE([ADT_Candidatos])
  //[ADT_Candidatos]Examinador:=[Profesores]Nombre_común
  //SAVE RECORD([ADT_Candidatos])
  //READ ONLY([ADT_Candidatos])
Case of 
	: ((<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)))  //MONO TICkET 204006
		OBJECT SET VISIBLE:C603(*;"hayObsEx";False:C215)
		OBJECT SET VISIBLE:C603(*;"ObsEx@";True:C214)
		OBJECT SET ENTERABLE:C238(*;"ObsEx@";True:C214)
	: (([ADT_Candidatos:49]Si_ObsExPrivada:56) & ((<>lUSR_RelatedTableUserID#[Profesores:4]Numero:1)))
		If ([ADT_Candidatos:49]Observaciones_examen:14#"")
			OBJECT SET VISIBLE:C603(*;"hayObsEx";True:C214)
			OBJECT SET VISIBLE:C603(*;"ObsEx@";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"hayObsEx";False:C215)
			OBJECT SET VISIBLE:C603(*;"ObsEx@";True:C214)
			OBJECT SET ENTERABLE:C238(*;"ObsEx@";False:C215)
		End if 
	: (([ADT_Candidatos:49]Si_ObsExPrivada:56) & ((<>lUSR_RelatedTableUserID=[Profesores:4]Numero:1)))
		OBJECT SET VISIBLE:C603(*;"hayObsEx";False:C215)
		OBJECT SET VISIBLE:C603(*;"ObsEx@";True:C214)
		OBJECT SET ENTERABLE:C238(*;"ObsEx@";True:C214)
	: (([ADT_Candidatos:49]Si_ObsExPrivada:56=False:C215) & ((<>lUSR_RelatedTableUserID#[Profesores:4]Numero:1)))
		OBJECT SET VISIBLE:C603(*;"hayObsEx";False:C215)
		OBJECT SET VISIBLE:C603(*;"ObsEx@";True:C214)
		OBJECT SET ENTERABLE:C238(*;"ObsEx@";False:C215)
	: (([ADT_Candidatos:49]Si_ObsExPrivada:56=False:C215) & ((<>lUSR_RelatedTableUserID=[Profesores:4]Numero:1)))
		OBJECT SET VISIBLE:C603(*;"hayObsEx";False:C215)
		OBJECT SET VISIBLE:C603(*;"ObsEx@";True:C214)
		OBJECT SET ENTERABLE:C238(*;"ObsEx@";True:C214)
End case 
