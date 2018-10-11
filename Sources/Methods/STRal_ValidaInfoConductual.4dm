//%attributes = {}
  //STRal_ValidaInfoConductual


_O_C_INTEGER:C282($0)
C_LONGINT:C283($1;$cantidad)
C_DATE:C307($2;$fechaIngreso)
C_BOOLEAN:C305($continuarValidacion;$aliminarHistoricos)
$continuarValidacion:=True:C214
$0:=1
$numeroAlumno:=$1
$fechaIngreso:=$2
$aliminarHistoricos:=False:C215
If (Count parameters:C259=3)
	$aliminarHistoricos:=$3
End if 

$fechaIngresoOld:=Old:C35([Alumnos:2]Fecha_de_Ingreso:41)
$fechaIngreso:=[Alumnos:2]Fecha_de_Ingreso:41
READ ONLY:C145([xxSTR_Niveles:6])
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Alumnos:2]nivel_numero:29)

$r:=CD_Dlog (1;__ ("Se eliminarán  registros de inasistencias, atrasos, Licencias, anotaciones, castigos y suspensiones para el alumno anterior a ")+String:C10([Alumnos:2]Fecha_de_Ingreso:41)+__ (", Este proceso es irreversible.")+"\r\r"+__ (" ¿Desea continuar?");__ ("");__ ("Si");__ ("No"))
If ($r=1)
	  //inasistencias
	$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
	Case of 
		: ($modoRegistroAsistencia=1)  //inasistencias diarias
			READ ONLY:C145([Alumnos_Inasistencias:10])
			QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
			QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1<$fechaIngreso;*)
			If ($aliminarHistoricos)
				QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Año:8<=<>gyear)
			Else 
				QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Año:8=<>gyear)
			End if 
			
			KRL_ReloadInReadWriteMode (->[Alumnos_Inasistencias:10])
			KRL_DeleteSelection (->[Alumnos_Inasistencias:10])
			KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
			LOG_RegisterEvt ("Registros de inasistencias eliminados para el alumno "+[Alumnos:2]Nombre_Común:30+" por cambio en la fecha de ingreso")
			
		: ($modoRegistroAsistencia=2)  //inasistencias por hora detallado
			
			READ ONLY:C145([Asignaturas_Inasistencias:125])
			QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1;*)
			QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<$fechaIngreso)
			If ($aliminarHistoricos)
				QUERY SELECTION BY FORMULA:C207([Asignaturas_Inasistencias:125];Year of:C25([Asignaturas_Inasistencias:125]dateSesion:4)<=<>gyear)
			Else 
				QUERY SELECTION BY FORMULA:C207([Asignaturas_Inasistencias:125];Year of:C25([Asignaturas_Inasistencias:125]dateSesion:4)=<>gyear)
			End if 
			KRL_ReloadInReadWriteMode (->[Asignaturas_Inasistencias:125])
			KRL_DeleteSelection (->[Asignaturas_Inasistencias:125])
			KRL_UnloadReadOnly (->[Asignaturas_Inasistencias:125])
			
			  //Elimino asistencias diarias, para cuando se generan-
			READ ONLY:C145([Alumnos_Inasistencias:10])
			QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
			QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1<$fechaIngreso;*)
			If ($aliminarHistoricos)
				QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Año:8<=<>gyear)
			Else 
				QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Año:8=<>gyear)
			End if 
			
			KRL_ReloadInReadWriteMode (->[Alumnos_Inasistencias:10])
			KRL_DeleteSelection (->[Alumnos_Inasistencias:10])
			KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
			
			LOG_RegisterEvt ("Registros de inasistencias eliminados para el alumno "+[Alumnos:2]Nombre_Común:30+" por cambio en la fecha de ingreso")
			
	End case 
	  //Atrasos
	$modoRegistroAtrasos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Lates_Mode:16)
	Case of 
		: ($modoRegistroAtrasos=1)  //diario
			READ ONLY:C145([Alumnos_Atrasos:55])
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
			QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2<$fechaIngreso;*)
			If ($aliminarHistoricos)
				QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Año:6<=<>gyear)
			Else 
				QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Año:6=<>gyear)
			End if 
			
			KRL_ReloadInReadWriteMode (->[Alumnos_Atrasos:55])
			KRL_DeleteSelection (->[Alumnos_Atrasos:55])
			KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
			LOG_RegisterEvt ("Registros de atrasos eliminados para el alumno "+[Alumnos:2]Nombre_Común:30+" por cambio en la fecha de ingreso")
		: ($modoRegistroAtrasos=2)  // averiguar que hacer con otros atrasos 
			
	End case 
	
	READ ONLY:C145([Alumnos_Licencias:73])
	QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Desde:2<$fechaIngreso;*)
	If ($aliminarHistoricos)
		QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Año:9<=<>gyear)
	Else 
		QUERY:C277([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Año:9=<>gyear)
	End if 
	KRL_ReloadInReadWriteMode (->[Alumnos_Licencias:73])
	KRL_DeleteSelection (->[Alumnos_Licencias:73])
	KRL_UnloadReadOnly (->[Alumnos_Licencias:73])
	LOG_RegisterEvt ("Registros de licencias eliminados para el alumno "+[Alumnos:2]Nombre_Común:30+" por cambio en la fecha de ingreso")
	
	
	READ ONLY:C145([Alumnos_Anotaciones:11])
	QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Fecha:1<$fechaIngreso;*)
	If ($aliminarHistoricos)
		QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11<=<>gyear)
	Else 
		QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11=<>gyear)
	End if 
	KRL_ReloadInReadWriteMode (->[Alumnos_Anotaciones:11])
	KRL_DeleteSelection (->[Alumnos_Anotaciones:11])
	KRL_UnloadReadOnly (->[Alumnos_Anotaciones:11])
	LOG_RegisterEvt ("Registros de anotaciones eliminados para el alumno "+[Alumnos:2]Nombre_Común:30+" por cambio en la fecha de ingreso")
	
	READ ONLY:C145([Alumnos_Castigos:9])
	QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Alumno_Numero:8=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Fecha:9<$fechaIngreso;*)
	If ($aliminarHistoricos)
		QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Año:5<=<>gyear)
	Else 
		QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Año:5=<>gyear)
	End if 
	
	KRL_ReloadInReadWriteMode (->[Alumnos_Castigos:9])
	KRL_DeleteSelection (->[Alumnos_Castigos:9])
	KRL_UnloadReadOnly (->[Alumnos_Castigos:9])
	LOG_RegisterEvt ("Registros de castigos eliminados para el alumno "+[Alumnos:2]Nombre_Común:30+" por cambio en la fecha de ingreso")
	$0:=1
	
	READ ONLY:C145([Alumnos_Suspensiones:12])
	QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Alumno_Numero:7=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Suspensiones:12]; & ;[Alumnos_Suspensiones:12]Desde:5<$fechaIngreso;*)
	If ($aliminarHistoricos)
		QUERY:C277([Alumnos_Suspensiones:12]; & ;[Alumnos_Suspensiones:12]Año:1<=<>gyear)
	Else 
		QUERY:C277([Alumnos_Suspensiones:12]; & ;[Alumnos_Suspensiones:12]Año:1=<>gyear)
	End if 
	KRL_ReloadInReadWriteMode (->[Alumnos_Suspensiones:12])
	KRL_DeleteSelection (->[Alumnos_Suspensiones:12])
	KRL_UnloadReadOnly (->[Alumnos_Suspensiones:12])
	LOG_RegisterEvt ("Registros de suspensiones eliminados para el alumno "+[Alumnos:2]Nombre_Común:30+" por cambio en la fecha de ingreso")
	$0:=1
Else 
	[Alumnos:2]Fecha_de_Ingreso:41:=$fechaIngresoOld
	$0:=-1
End if 
