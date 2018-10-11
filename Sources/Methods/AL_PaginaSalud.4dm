//%attributes = {}
  // MÉTODO: AL_PaginaSalud
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 11:07:15
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AL_PaginaSalud()
  // ----------------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($i;$l_IdObservacionesSalud;$l_modoVisualizacion;$l_PestañaObservacionPreferida;$l_recNumMedicosRelacionados)
C_TEXT:C284($t_registroMedicosRelacionados;$t_TituloObservacionesSalud)

ARRAY LONGINT:C221($al_IdMedicosInexistentes;0)
If (False:C215)
	C_LONGINT:C283(AL_PaginaSalud ;$0)
End if 

  // CODIGO PRINCIPAL
C_LONGINT:C283(tabSalud)
QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumno_Numero:1=[Alumnos:2]numero:1)
If (Not:C34(KRL_IsRecordLocked (->[Alumnos_FichaMedica:13])))
	vl_ModSalud:=0
	ARRAY TEXT:C222(aEnfermedad;0)
	ARRAY TEXT:C222(aHospDiagnostico;0)
	ARRAY DATE:C224(aHospFecha;0)
	ARRAY DATE:C224(aHospHasta;0)
	ARRAY TEXT:C222(aAlergiaTipo;0)
	ARRAY TEXT:C222(aAlergeno;0)
	ARRAY DATE:C224(aCMedico_Fecha;0)
	ARRAY TEXT:C222(aCMedico_Curso;0)
	ARRAY TEXT:C222(aCMedico_Edad;0)
	ARRAY INTEGER:C220(aCMedico_Talla;0)
	ARRAY REAL:C219(aCMedico_Peso;0)
	ARRAY TEXT:C222(aCMedico_IMC;0)
	ARRAY LONGINT:C221(aCMedico_ID;0)  //JHB
	ARRAY TEXT:C222(aVacuna_Edad;0)
	ARRAY TEXT:C222(aVacuna_Enfermedad;0)
	ARRAY BOOLEAN:C223(aVacuna_SiNo;0)
	ARRAY LONGINT:C221(aVacuna_meses;0)
	ARRAY LONGINT:C221(aAparatos_Year;0)
	ARRAY TEXT:C222(aAparatos_Curso;0)
	ARRAY TEXT:C222(aAparatos_Aparato;0)
	ARRAY LONGINT:C221(aAparatos_NoNivel;0)
	ARRAY TEXT:C222(at_obsEnfermedad;0)
	ARRAY DATE:C224(ad_fechaEnfermedad;0)
	ARRAY BOOLEAN:C223(ab_EliminarEnfermedad;0)
	ARRAY LONGINT:C221(al_idEnfermedad;0)
	ARRAY LONGINT:C221(al_EliminarEnfermedad;0)
	ARRAY OBJECT:C1221($aob_afeccion;0)
	
	ARRAY DATE:C224(aDateCE;0)
	ARRAY TEXT:C222(aMotCons;0)
	ARRAY LONGINT:C221(aCENo;0)
	ARRAY LONGINT:C221(aCEHora;0)
	
	vAge:=DT_ReturnAgeLongString ([Alumnos:2]Fecha_de_nacimiento:7)
	
	  //AL_UpdateArrays (xALP_Enfermedades;0)
	READ ONLY:C145([Alumnos_FichaMedica_Enfermedade:224])
	QUERY:C277([Alumnos_FichaMedica_Enfermedade:224];[Alumnos_FichaMedica_Enfermedade:224]id_alumno:3=[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Enfermedade:224]Enfermedad:1;aEnfermedad;[Alumnos_FichaMedica_Enfermedade:224]fecha:6;ad_fechaEnfermedad;[Alumnos_FichaMedica_Enfermedade:224]observacion:5;at_ObsEnfermedad;[Alumnos_FichaMedica_Enfermedade:224]ID:7;al_idEnfermedad)
	
	  //SORT ARRAY(aEnfermedad;>)
	  //AL_UpdateArrays (xALP_Enfermedades;-2)
	  //ALP_SetDefaultAppareance (xALP_Enfermedades;9;1;4;1;4)
	  //AL_SetLine (xALP_Enfermedades;0)
	SORT ARRAY:C229(<>aEnfermedades;>)
	
	
	AL_UpdateArrays (xALP_alergias;0)
	READ ONLY:C145([Alumnos_FichaMedica_Alergias:223])
	QUERY:C277([Alumnos_FichaMedica_Alergias:223];[Alumnos_FichaMedica_Alergias:223]id_alumno:4=[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Alergias:223]Tipo_alergia:1;aAlergiaTipo;[Alumnos_FichaMedica_Alergias:223]Alergeno:2;aAlergeno)
	SORT ARRAY:C229(aAlergiaTipo;aAlergeno;>)
	AL_UpdateArrays (xALP_alergias;-2)
	ALP_SetDefaultAppareance (xALP_alergias;9;1;4;1;4)
	AL_SetLine (xALP_alergias;0)
	
	
	AL_UpdateArrays (xALP_Hospitalizaciones;0)
	READ ONLY:C145([Alumnos_FichaMedica_Hospitaliza:222])
	QUERY:C277([Alumnos_FichaMedica_Hospitaliza:222];[Alumnos_FichaMedica_Hospitaliza:222]Id_Alumno:5=[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Hospitaliza:222]Fecha:1;aHospFecha;[Alumnos_FichaMedica_Hospitaliza:222]Diagnóstico:2;aHospDiagnostico;[Alumnos_FichaMedica_Hospitaliza:222]Hasta:3;aHospHasta)
	SORT ARRAY:C229(aHospFecha;aHospHasta;aHospDiagnostico;<)
	AL_UpdateArrays (xALP_Hospitalizaciones;-2)
	ALP_SetDefaultAppareance (xALP_Hospitalizaciones;9;1;4;1;4)
	AL_SetLine (xALP_Hospitalizaciones;0)
	
	
	AL_UpdateArrays (xALP_Aparatos;0)
	READ ONLY:C145([Alumnos_FichaMedica_Aparatos_pr:226])
	QUERY:C277([Alumnos_FichaMedica_Aparatos_pr:226];[Alumnos_FichaMedica_Aparatos_pr:226]Id_alumno:6=[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Aparatos_pr:226]Año:1;aAparatos_Year;[Alumnos_FichaMedica_Aparatos_pr:226]Curso:3;aAparatos_Curso;[Alumnos_FichaMedica_Aparatos_pr:226]Aparato:2;aAparatos_Aparato;[Alumnos_FichaMedica_Aparatos_pr:226]NoNivel:4;aAparatos_NoNivel)
	SORT ARRAY:C229(aAparatos_Year;aAparatos_Curso;aAparatos_Aparato;aAparatos_NoNivel;<)
	AL_UpdateArrays (xALP_Aparatos;-2)
	ALP_SetDefaultAppareance (xALP_Aparatos;9;4;1;4)
	AL_SetLine (xALP_Aparatos;0)
	
	
	AL_UpdateArrays (xALP_vacunas;0)
	QUERY:C277([Alumnos_Vacunas:101];[Alumnos_Vacunas:101]Numero_Alumno:1=[Alumnos_FichaMedica:13]Alumno_Numero:1)
	SELECTION TO ARRAY:C260([Alumnos_Vacunas:101]Edad:2;aVacuna_edad;[Alumnos_Vacunas:101]Enfermedad:3;aVacuna_Enfermedad;[Alumnos_Vacunas:101]Vacunado:5;aVacuna_SiNo;[Alumnos_Vacunas:101]Meses:4;aVacuna_meses)
	MULTI SORT ARRAY:C718(aVacuna_meses;>;aVacuna_Enfermedad;>;aVacuna_SiNo;>;aVacuna_edad;>)
	AL_UpdateArrays (xALP_vacunas;-2)
	  //ALP_SetDefaultAppareance (xALP_vacunas;9;1;4;1;4)//20140104 RCH Se paso a la configuracion del area ya que se cambiaba el formato Si/no
	AL_SetLine (xALP_vacunas;0)
	
	AL_UpdateArrays (xALP_ControlesMedicos;0)
	QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Numero_Alumno:1=[Alumnos_FichaMedica:13]Alumno_Numero:1)
	
	SELECTION TO ARRAY:C260([Alumnos_ControlesMedicos:99]Fecha:2;aCMedico_Fecha;[Alumnos_ControlesMedicos:99]Curso:3;aCMedico_Curso;[Alumnos_ControlesMedicos:99]Edad:4;aCMedico_Edad;[Alumnos_ControlesMedicos:99]Talla_cm:5;aCMedico_Talla;[Alumnos_ControlesMedicos:99]Peso_kg:6;aCMedico_Peso;[Alumnos_ControlesMedicos:99]IMC:8;aCMedico_IMC;[Alumnos_ControlesMedicos:99]ID:9;aCMedico_ID)
	SORT ARRAY:C229(aCMedico_Fecha;aCMedico_Curso;aCMedico_Edad;aCMedico_Talla;aCMedico_Peso;aCMedico_IMC;aCMedico_ID;<)
	
	If (Size of array:C274(aCMedico_IMC)>0)
		[Alumnos_FichaMedica:13]IndiceMasaCorporal:21:=aCMedico_IMC{1}
	End if 
	xALSet_AL_ControlesMedicos 
	
	
	ALP_SetDefaultAppareance (xALP_ControlesMedicos;9;1;4;1;4)
	AL_SetLine (xALP_ControlesMedicos;0)
	
	AL_UpdateArrays (xALP_ConsultasEnfermeria;0)
	QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Alumno_Numero:1=[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Fecha:2;aDateCE;[Alumnos_EventosEnfermeria:14];aCENo;[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3;aCEHora;[Alumnos_EventosEnfermeria:14]OB_Afeccion:20;$aob_afeccion)
	SORT ARRAY:C229(aDateCE;aMotCons;aCENo;aCEHora;$aob_afeccion;>)
	ARRAY TEXT:C222(aMotCons;0)
	ARRAY TEXT:C222($at_temporalAfeccion;0)
	For ($indice;1;Size of array:C274($aob_afeccion))
		OB_GET ($aob_afeccion{$indice};->$at_temporalAfeccion;"OB")
		APPEND TO ARRAY:C911(aMotCons;AT_array2text (->$at_temporalAfeccion))
	End for 
	AL_UpdateArrays (xALP_ConsultasEnfermeria;-2)
	AL_SetSort (xALP_ConsultasEnfermeria;1)
	ALP_SetDefaultAppareance (xALP_ConsultasEnfermeria;9;1;4;1;12)
	_O_DISABLE BUTTON:C193(bDelSalud_Consulta)
	AL_SetLine (xALP_ConsultasEnfermeria;0)
	
	If (USR_checkRights ("M";->[Alumnos_FichaMedica:13]))
		_O_ENABLE BUTTON:C192(*;"bAddSalud_@")
	Else 
		_O_DISABLE BUTTON:C193(*;"bAddSalud_@")
		AL_SetEnterable (xALP_ConsultasEnfermeria;0;0)
		AL_SetEnterable (xALP_ControlesMedicos;0;0)
		AL_SetEnterable (xALP_vacunas;0;0)
		AL_SetEnterable (xALP_Aparatos;0;0)
		AL_SetEnterable (xALP_Hospitalizaciones;0;0)
		AL_SetEnterable (xALP_Enfermedades;0;0)
		AL_SetEnterable (xALP_alergias;0;0)
	End if 
	
	READ ONLY:C145([STR_Medicos:89])
	QUERY:C277([xxSTR_Link_AlumnosMedicos:237];[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2=[Alumnos:2]auto_uuid:72)
	KRL_RelateSelection (->[STR_Medicos:89]Auto_UUID:6;->[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3)
	OBJECT SET RGB COLORS:C628(*;"listaMedicos";0;0x00FFFFFF;0x00F3F6FA)
	
	
	OBJECT SET VISIBLE:C603(*;"Observaciones_Salud@";False:C215)
	GET LIST ITEM:C378(tabSalud;Selected list items:C379(tabSalud);$l_IdObservacionesSalud;$t_TituloObservacionesSalud)
	If ($l_IdObservacionesSalud=0)
		If (vl_LastHealthItemSelected=0)
			$l_IdObservacionesSalud:=3
			SELECT LIST ITEMS BY REFERENCE:C630(tabSalud;3)
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(tabSalud;vl_LastHealthItemSelected)
			$l_IdObservacionesSalud:=vl_LastHealthItemSelected
		End if 
	End if 
	OBJECT SET VISIBLE:C603(*;"Observaciones_Salud@";False:C215)
	OBJECT SET VISIBLE:C603(*;"camposMedicos@";False:C215)
	OBJECT SET VISIBLE:C603(*;"buttonsTratamiento@";False:C215)
	OBJECT SET VISIBLE:C603(lb_tratamientos;False:C215)
	
	AL_TratamientoEnfermeria ("CargaTratamientos")
	
	Case of 
		: ($l_IdObservacionesSalud=-1)
			OBJECT SET VISIBLE:C603(xALP_Aparatos;True:C214)
			OBJECT SET VISIBLE:C603(*;"listaMedicos";False:C215)
			_O_DISABLE BUTTON:C193(bDelSalud_Aparato)
			IT_SetButtonState (USR_checkRights ("M";->[Alumnos_FichaMedica:13]);->bAddSalud_Aparato)
			AL_UpdateArrays (xALP_Aparatos;-2)
			AL_SetLine (xALP_Aparatos;0)
			OBJECT SET VISIBLE:C603(*;"buttonsAparatos@";True:C214)
			OBJECT SET VISIBLE:C603(*;"buttonsMedicos@";False:C215)
		: ($l_IdObservacionesSalud=-2)
			OBJECT SET VISIBLE:C603(xALP_Aparatos;False:C215)
			OBJECT SET VISIBLE:C603(*;"listaMedicos";True:C214)
			_O_DISABLE BUTTON:C193(bDelMedico)
			OBJECT SET VISIBLE:C603(*;"buttonsAparatos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"buttonsMedicos@";True:C214)
			OBJECT SET VISIBLE:C603(*;"camposMedicos@";True:C214)
		Else 
			AL_SetScroll (xALP_Aparatos;0;0)
			OBJECT SET VISIBLE:C603(xALP_Aparatos;False:C215)
			OBJECT SET VISIBLE:C603(*;"listaMedicos";False:C215)
			OBJECT SET VISIBLE:C603(*;"Observaciones_Salud@";False:C215)
			OBJECT SET VISIBLE:C603(bDelSalud_Aparato;False:C215)
			OBJECT SET VISIBLE:C603(bAddSalud_Aparato;False:C215)
			OBJECT SET VISIBLE:C603(*;"buttonsAparatos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"buttonsMedicos@";False:C215)
			If ($l_IdObservacionesSalud#0)
				OBJECT SET VISIBLE:C603(Field:C253(13;$l_IdObservacionesSalud)->;True:C214)
				GOTO OBJECT:C206(Field:C253(13;$l_IdObservacionesSalud)->)
			End if 
	End case 
End if 
vl_LastHealthItemSelected:=$l_IdObservacionesSalud


OBJECT SET VISIBLE:C603([Alumnos_FichaMedica:13]Alumna_embarazada:20;(([Alumnos:2]Sexo:49="F") & ([Alumnos:2]Fecha_de_nacimiento:7#!00-00-00!) & (<>gYear-Year of:C25([Alumnos:2]Fecha_de_nacimiento:7)>=13) & ([Alumnos:2]Status:50="Activo")))
IT_SetButtonState (USR_checkRights ("M";->[Alumnos_FichaMedica:13]);->bBWR_SaveRecord)
MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos_FichaMedica:13]);1;5)
If (USR_checkRights ("M";->[Alumnos_FichaMedica:13]))
	OBJECT SET ENTERABLE:C238(*;"@salud@";True:C214)
	OBJECT SET VISIBLE:C603(*;"ChoicesSalud@";True:C214)
Else 
	OBJECT SET ENTERABLE:C238(*;"@salud@";False:C215)
	OBJECT SET VISIBLE:C603(*;"ChoicesSalud@";False:C215)
End if 

$l_PestañaObservacionPreferida:=Num:C11(PREF_fGet (USR_GetUserID ;"lenguetaSalud";"3"))
SELECT LIST ITEMS BY REFERENCE:C630(tabSalud;$l_PestañaObservacionPreferida)
OBJECT SET VISIBLE:C603(*;"Observaciones_Salud@";False:C215)
OBJECT SET VISIBLE:C603(*;"camposMedicos@";False:C215)
Case of 
	: ($l_PestañaObservacionPreferida=-1)
		OBJECT SET VISIBLE:C603(xALP_Aparatos;True:C214)
		OBJECT SET VISIBLE:C603(*;"listaMedicos";False:C215)
		_O_DISABLE BUTTON:C193(bDelSalud_Aparato)
		IT_SetButtonState (USR_checkRights ("M";->[Alumnos_FichaMedica:13]);->bAddSalud_Aparato)
		AL_UpdateArrays (xALP_Aparatos;-2)
		AL_SetLine (xALP_Aparatos;0)
		OBJECT SET VISIBLE:C603(*;"buttonsAparatos@";True:C214)
		OBJECT SET VISIBLE:C603(*;"buttonsMedicos@";False:C215)
		
	: ($l_PestañaObservacionPreferida=-2)
		OBJECT SET VISIBLE:C603(*;"listaMedicos";True:C214)
		
		
		OBJECT SET VISIBLE:C603(xALP_Aparatos;False:C215)
		OBJECT SET VISIBLE:C603(*;"buttonsAparatos@";False:C215)
		
	Else 
		AL_SetScroll (xALP_Aparatos;0;0)
		OBJECT SET VISIBLE:C603(xALP_Aparatos;False:C215)
		OBJECT SET VISIBLE:C603(*;"listaMedicos";False:C215)
		OBJECT SET VISIBLE:C603(*;"Observaciones_Salud@";False:C215)
		OBJECT SET VISIBLE:C603(Field:C253(13;$l_PestañaObservacionPreferida)->;True:C214)
		OBJECT SET VISIBLE:C603(bDelSalud_Aparato;False:C215)
		OBJECT SET VISIBLE:C603(bAddSalud_Aparato;False:C215)
		OBJECT SET VISIBLE:C603(*;"buttonsAparatos@";False:C215)
		GOTO OBJECT:C206(Field:C253(13;$l_PestañaObservacionPreferida)->)
		
End case 
vl_LastHealthItemSelected:=$l_PestañaObservacionPreferida
  //REDRAW WINDOW
$0:=1