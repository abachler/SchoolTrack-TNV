//%attributes = {}
  // XCR_Before()
  // Por: Alberto Bachler K.: 08-06-14, 14:54:06
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$y_inscritosPeriodo:=OBJECT Get pointer:C1124(Object named:K67:5;"inscritosPeriodo")
$y_profesorJefe:=OBJECT Get pointer:C1124(Object named:K67:5;"profesorJefe")
$y_periodoSeleccionado:=OBJECT Get pointer:C1124(Object named:K67:5;"periodo")

If ([Actividades:29]ID:1=0)
	[Actividades:29]ID:1:=SQ_SeqNumber (->[Actividades:29]ID:1)
	[Asignaturas:18]Incide_en_promedio:27:=True:C214
	[Actividades:29]Desde_NumeroNivel:5:=1
	[Actividades:29]Desde_NombreNivel:12:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Actividades:29]Desde_NumeroNivel:5;->[xxSTR_Niveles:6]Nivel:1)
	[Actividades:29]Hasta_NumeroNivel:9:=12
	[Actividades:29]Hasta_NombreNivel:11:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Actividades:29]Hasta_NumeroNivel:9;->[xxSTR_Niveles:6]Nivel:1)
	[Actividades:29]ID_ConfiguracionPeriodos:13:=-1
	[Actividades:29]Selección_por_sexo:6:=1
End if 


  //si la configuración de periodos asignada no es válida busco la configuración con el mayor numero de períodos
  // así se evita que se pierdan las información registrada en un período inexistente
$b_configuracionPeriodoValida:=(KRL_FindAndLoadRecordByIndex (->[xxSTR_Periodos:100]ID:1;->[Actividades:29]ID_ConfiguracionPeriodos:13)>No current record:K29:2)
$l_IdConfigPeriodo:=0
$l_numeroPeriodos:=0
If (Not:C34($b_configuracionPeriodoValida))
	QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1>=-1)
	ARRAY LONGINT:C221($al_RecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([xxSTR_Periodos:100];$al_RecNums;"")
	READ ONLY:C145([xxSTR_Periodos:100])
	For ($i;1;Size of array:C274($al_RecNums))
		GOTO RECORD:C242([xxSTR_Periodos:100];$al_RecNums{$i})
		PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
		If (viSTR_Periodos_NumeroPeriodos>$l_numeroPeriodos)
			$l_IdConfigPeriodo:=[xxSTR_Periodos:100]ID:1
		End if 
	End for 
	If ($l_IdConfigPeriodo=0)
		$l_IdConfigPeriodo:=-1
	End if 
	[Actividades:29]ID_ConfiguracionPeriodos:13:=$l_IdConfigPeriodo
End if 

$t_nombreConfigPeriodosActual:=KRL_GetTextFieldData (->[xxSTR_Periodos:100]ID:1;->[Actividades:29]ID_ConfiguracionPeriodos:13;->[xxSTR_Periodos:100]Nombre_Configuracion:2)
IT_PropiedadesBotonPopup ("configuracionPeriodos";$t_nombreConfigPeriodosActual;300)

IT_PropiedadesBotonPopup ("desdeNivel";[Actividades:29]Desde_NombreNivel:12;300)
IT_PropiedadesBotonPopup ("hastaNivel";[Actividades:29]Hasta_NombreNivel:11;300)
Case of 
	: ([Actividades:29]Selección_por_sexo:6=1)
		IT_PropiedadesBotonPopup ("restriccionSexo";__ ("Ambos sexos");300)
	: ([Actividades:29]Selección_por_sexo:6=2)
		IT_PropiedadesBotonPopup ("restriccionSexo";__ ("Femenino");300)
	: ([Actividades:29]Selección_por_sexo:6=3)
		IT_PropiedadesBotonPopup ("restriccionSexo";__ ("Masculino");300)
End case 

$y_periodoSeleccionado->:=-1
IT_PropiedadesBotonPopup ("seleccionAlumnos";__ ("Todos los alumnos inscritos");340)

OBJECT SET ENABLED:C1123(*;"retirar";False:C215)

$b_modXCRCondorActivo:=LICENCIA_VerificaModCondorAct ("Extracurriculares")
If ($b_modXCRCondorActivo)
	OBJECT SET ENABLED:C1123(*;"inscribir";False:C215)
Else 
	OBJECT SET ENABLED:C1123(*;"inscribir";USR_checkRights ("M";->[Actividades:29]))
End if 

vasgObjtMod:=False:C215
modNotas:=False:C215
RELATE ONE:C42([Actividades:29]No_Profesor:3)
$y_profesorJefe->:=[Profesores:4]Apellidos_y_nombres:28

XCR_ListaAlumnosInscritos 
PERIODOS_LoadData (0;[Actividades:29]ID_ConfiguracionPeriodos:13)

