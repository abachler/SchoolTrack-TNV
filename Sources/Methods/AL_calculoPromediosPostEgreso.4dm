//%attributes = {}
  //AL_calculoPromediosPostEgreso
  //recalcula los promedios Post-Egreso de los alumnos que actualmente estan cursando cuarto medio, más se consideran los alumnos egresados del año ingresado

C_LONGINT:C283($year;$i)
ARRAY LONGINT:C221($aRecNum;0)
CD_Dlog (0;__ ("Usted se dispone a recalcular  los promedios de Post-Egreso. \r\r")+__ ("Es posible que para los alumnos egresados el puntaje de enseñanza media presente diferencias."))
$year:=Num:C11(CD_Request (__ ("Ingrese año de egreso");__ ("Aceptar");__ ("Cancelar");__ ("");__ ("")))
If ((OK=1) & ($year>0))
	EVS_initialize 
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=Nivel_Egresados;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]AgnoEgreso:91=$year)
	CREATE SET:C116([Alumnos:2];"Egresados")
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=12)
	CREATE SET:C116([Alumnos:2];"Actuales")
	UNION:C120("Egresados";"Actuales";"Alumnos")
	USE SET:C118("Alumnos")
	SELECTION TO ARRAY:C260([Alumnos:2];$aRecNum)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Calculando promedios Post-Egreso")
	For ($i;1;Size of array:C274($aRecNum))
		READ WRITE:C146([Alumnos:2])
		GOTO RECORD:C242([Alumnos:2];$aRecNum{$i})
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNum);"Calculando datos Post-Egreso para el alumno(a): "+[Alumnos:2]apellidos_y_nombres:40)
		If ([Alumnos:2]nivel_numero:29=Nivel_Egresados)
			AL_PromedioUChileEgresados_cl 
		Else 
			AL_PromedioUChile_cl 
		End if 
		KRL_UnloadReadOnly (->[Alumnos:2])
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
Else 
	CD_Dlog (0;"Se ha cancelado la ejecución del método.")
End if 
SET_ClearSets ("Egresados";"Actuales";"Alumnos")
KRL_UnloadReadOnly (->[Alumnos:2])

