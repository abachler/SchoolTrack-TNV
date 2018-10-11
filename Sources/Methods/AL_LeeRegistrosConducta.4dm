//%attributes = {}
  //AL_LeeRegistrosConducta


C_LONGINT:C283($page;vl_year;$itemRef)


C_BLOB:C604($blob)
C_LONGINT:C283($otRef;$vlCompressed;$vlExpandedSize;$vlCurrentSize)
$page:=Selected list items:C379(vlTab_Conducta)
GET LIST ITEM:C378(vlTab_Conducta;*;$itemRef;$tabLabel)
vl_yearName:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->vl_Year;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)


AL_LeeSintesisConducta ([Alumnos:2]numero:1;vl_Year;vl_NivelSeleccionado;vl_PeriodoSeleccionado)
If (vl_year<<>gYear)
	$keyAlumno:=String:C10([Alumnos:2]numero:1)+"."+String:C10(vl_year)
	$nivel:=KRL_GetNumericFieldData (->[Alumnos_Historico:25]Llave:42;->$keyAlumno;->[Alumnos_Historico:25]Nivel:11)
	PERIODOS_LeeDatosHistoricos (vl_NivelSeleccionado;vl_year)
Else 
	PERIODOS_LoadData (vl_NivelSeleccionado)
End if 

AL_ExitCell (xALP_ConductaAlumnos)
AL_UpdateArrays (xALP_ConductaAlumnos;0)
AL_InitCdtaArr 

If ($page>0)
	AL_ExitCell (xALP_ConductaAlumnos)
	AL_UpdateArrays (xALP_ConductaAlumnos;0)
	  //preservando referencia del registro de conducta para releerlo cuando al cargar detalles pueda perderse
	$recNum:=Record number:C243([Alumnos_Conducta:8])
	onScreen:=False:C215
	lastCdcta:=$page
	OBJECT SET VISIBLE:C603(*;"buttons@";True:C214)
	AL_InitCdtaArr 
	
	OBJECT SET VISIBLE:C603(hl_CiclosEscolares_Completo;True:C214)
	_O_ENABLE BUTTON:C192(hl_CiclosEscolares_Completo)
	OBJECT SET VISIBLE:C603(*;"vi_incidePO";False:C215)
	Case of 
		: ((vl_year=<>gYear) | (vl_year>=2000))
			Case of 
				: ($page=1)  //inasistencias
					AL_LoadAbs 
					
				: ($page=2)  //inasistencias a clases
					OBJECT SET VISIBLE:C603(*;"Back2Now@";False:C215)
					OBJECT SET VISIBLE:C603(*;"vi_incidePO";True:C214)
					OBJECT SET ENABLED:C1123(*;"vi_incidePO";(vl_year>=2012))
					vl_PeriodoSeleccionado:=0
					AL_LeeInasistencia_a_clases ([Alumnos:2]numero:1;vl_Year;vl_NivelSeleccionado)  //20120327 AS.Se agrega metodo en reemplazo de AL_LoadSesionsAttendance para considerar los historicos.
					AL_LeeSintesisConducta ([Alumnos:2]numero:1;vl_Year;vl_NivelSeleccionado;vl_PeriodoSeleccionado)
					AL_CdtaBehaviourFilter ("createListSessAte")
					xALSet_AL_AsistenciaClases (viSTR_Periodos_NumeroPeriodos;vl_Year)
					OBJECT SET VISIBLE:C603(*;"buttons@";False:C215)
					vt_alerta:=""
					  //vl_referenciaCicloCompleto:=-Num(String(vl_year;"0000")+String(vl_NivelSeleccionado;"00")+"0")
					
				: ($page=3)  //licencias
					AL_LoadLic 
					
				: ($page=4)  //atrasos
					AL_LoadLte 
					
				: ($page=5)  //anotaciones
					AL_LoadAnt 
					
				: ($page=6)  //castigos
					AL_LoadDtn 
					
				: ($page=7)  //suspensiones
					AL_LoadSpn 
					
			End case 
			OBJECT SET VISIBLE:C603(*;"filtroCdta@";AL_CdtaBehaviourFilter ("mostrarFiltro"))
			REDRAW WINDOW:C456
			
	End case 
Else 
	$page:=lastCdcta
End if 


AL_SetInterface (xALP_ConductaAlumnos;-1;1;1;0;0;1;0;0)

If (ALP_CountElements (xALP_ConductaAlumnos)=0)
	vt_textMessage:="No hay registro detallado de "+$tabLabel+" para el ciclo escolar "+vl_yearName
Else 
	vt_textMessage:=""
End if 

If (vl_Year#<>gYear)
	_O_DISABLE BUTTON:C193(bAddLine)
	_O_DISABLE BUTTON:C193(bdelLine)
	_O_DISABLE BUTTON:C193(*;"atSTR_SeleccionConducta")
	OBJECT SET VISIBLE:C603(bRecalc;False:C215)
	OBJECT SET VISIBLE:C603(*;"asistenciahoraria@";False:C215)
	OBJECT SET VISIBLE:C603(vt_textMessage;True:C214)
Else 
	_O_ENABLE BUTTON:C192(bAddLine)
	_O_ENABLE BUTTON:C192(bdelLine)
	_O_ENABLE BUTTON:C192(*;"atSTR_SeleccionConducta")
	If ($page=2)
		OBJECT SET VISIBLE:C603(*;"asistenciahoraria@";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"asistenciahoraria@";False:C215)
	End if 
	OBJECT SET VISIBLE:C603(bRecalc;True:C214)
	OBJECT SET VISIBLE:C603(vt_textMessage;False:C215)
End if 

OBJECT SET VISIBLE:C603(*;"filtroCdta@";AL_CdtaBehaviourFilter ("mostrarFiltro"))

IT_SetButtonState (((USR_checkRights ("A";->[Alumnos_Conducta:8]) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36) & (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite")) & (vl_Year=<>gYear)));->bAddLine)
_O_DISABLE BUTTON:C193(bdelLine)

$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
If ($l_modoRegistroAsistencia=2)
	If (($page=1) | ($page=2))
		OBJECT SET VISIBLE:C603(bdelLine;False:C215)
		OBJECT SET VISIBLE:C603(bAddLine;False:C215)
	Else 
		OBJECT SET VISIBLE:C603(bdelLine;True:C214)
		OBJECT SET VISIBLE:C603(bAddLine;True:C214)
	End if 
End if 
