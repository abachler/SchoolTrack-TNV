//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:59:48
  // ----------------------------------------------------
  // Método: STWA2_OWC_datosfichamedica
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)
ARRAY OBJECT:C1221($aob_afeccion;0)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"alumno"))
If (KRL_GotoRecord (->[Alumnos:2];$rnAlumno;False:C215))
	READ ONLY:C145([Alumnos_FichaMedica:13])
	QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumno_Numero:1=[Alumnos:2]numero:1)
	READ ONLY:C145([Alumnos_FichaMedica_Enfermedade:224])
	QUERY:C277([Alumnos_FichaMedica_Enfermedade:224];[Alumnos_FichaMedica_Enfermedade:224]id_alumno:3=[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Enfermedade:224]Enfermedad:1;$aEnfermedad;[Alumnos_FichaMedica_Enfermedade:224];$aRNEnfermedades;[Alumnos_FichaMedica_Enfermedade:224]observacion:5;$aObsEnfermedad;[Alumnos_FichaMedica_Enfermedade:224]fecha:6;$ad_fechaEnfermedad)
	SORT ARRAY:C229($aEnfermedad;$aRNEnfermedades;>)
	READ ONLY:C145([Alumnos_FichaMedica_Alergias:223])
	QUERY:C277([Alumnos_FichaMedica_Alergias:223];[Alumnos_FichaMedica_Alergias:223]id_alumno:4=[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Alergias:223]Tipo_alergia:1;$aAlergiaTipo;[Alumnos_FichaMedica_Alergias:223]Alergeno:2;$aAlergeno;[Alumnos_FichaMedica_Alergias:223];$aRNAlergias)
	SORT ARRAY:C229($aAlergiaTipo;$aAlergeno;$aRNAlergias;>)
	READ ONLY:C145([Alumnos_FichaMedica_Hospitaliza:222])
	QUERY:C277([Alumnos_FichaMedica_Hospitaliza:222];[Alumnos_FichaMedica_Hospitaliza:222]Id_Alumno:5=[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Hospitaliza:222]Fecha:1;$aHospFecha;[Alumnos_FichaMedica_Hospitaliza:222]Diagnóstico:2;$aHospDiagnostico;[Alumnos_FichaMedica_Hospitaliza:222]Hasta:3;$aHospHasta;[Alumnos_FichaMedica_Hospitaliza:222];$aRNHospitalizaciones)
	SORT ARRAY:C229($aHospFecha;$aHospHasta;$aHospDiagnostico;$aRNHospitalizaciones;<)
	READ ONLY:C145([Alumnos_FichaMedica_Aparatos_pr:226])
	QUERY:C277([Alumnos_FichaMedica_Aparatos_pr:226];[Alumnos_FichaMedica_Aparatos_pr:226]Id_alumno:6=[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Aparatos_pr:226]Año:1;$aAparatos_Year;[Alumnos_FichaMedica_Aparatos_pr:226]Curso:3;$aAparatos_Curso;[Alumnos_FichaMedica_Aparatos_pr:226]Aparato:2;$aAparatos_Aparato;[Alumnos_FichaMedica_Aparatos_pr:226]NoNivel:4;$aAparatos_NoNivel;[Alumnos_FichaMedica_Aparatos_pr:226];$aRNAparatos)
	SORT ARRAY:C229($aAparatos_Year;$aAparatos_Curso;$aAparatos_Aparato;$aAparatos_NoNivel;$aRNAparatos;<)
	QUERY:C277([Alumnos_Vacunas:101];[Alumnos_Vacunas:101]Numero_Alumno:1=[Alumnos_FichaMedica:13]Alumno_Numero:1)
	SELECTION TO ARRAY:C260([Alumnos_Vacunas:101]Edad:2;$aVacuna_edad;[Alumnos_Vacunas:101]Enfermedad:3;$aVacuna_Enfermedad;[Alumnos_Vacunas:101]Vacunado:5;$aVacuna_SiNo;[Alumnos_Vacunas:101]Meses:4;$aVacuna_meses;[Alumnos_Vacunas:101];$aRNVacunas)
	MULTI SORT ARRAY:C718($aVacuna_meses;>;$aVacuna_Enfermedad;>;$aVacuna_SiNo;>;$aVacuna_edad;$aRNVacunas;>)
	QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos_ControlesMedicos:99]Numero_Alumno:1=[Alumnos_FichaMedica:13]Alumno_Numero:1)
	SELECTION TO ARRAY:C260([Alumnos_ControlesMedicos:99]Fecha:2;$aCMedico_Fecha;[Alumnos_ControlesMedicos:99]Curso:3;$aCMedico_Curso;[Alumnos_ControlesMedicos:99]Edad:4;$aCMedico_Edad;[Alumnos_ControlesMedicos:99]Talla_cm:5;$aCMedico_Talla;[Alumnos_ControlesMedicos:99]Peso_kg:6;$aCMedico_Peso;[Alumnos_ControlesMedicos:99]IMC:8;$aCMedico_IMC;[Alumnos_ControlesMedicos:99];$aRNControles)
	SORT ARRAY:C229($aCMedico_Fecha;$aCMedico_Curso;$aCMedico_Edad;$aCMedico_Talla;$aCMedico_Peso;$aCMedico_IMC;$aRNControles;<)
	QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Alumno_Numero:1=[Alumnos:2]numero:1)
	SELECTION TO ARRAY:C260([Alumnos_EventosEnfermeria:14]Fecha:2;$aDateCE;[Alumnos_EventosEnfermeria:14]Afeccion:6;$aMotCons;[Alumnos_EventosEnfermeria:14];$aRNEventosEnf;[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3;$aCEHora;[Alumnos_EventosEnfermeria:14]OB_Afeccion:20;$aob_afeccion;[Alumnos_EventosEnfermeria:14]OB_evolucion:21;$aob_evolucion;[Alumnos_EventosEnfermeria:14]OB_derivacion:23;$aob_derivacion)
	SORT ARRAY:C229($aDateCE;$aMotCons;$aRNEventosEnf;$aCEHora;$aob_afeccion;$aob_derivacion;$aob_evolucion;<)
	ARRAY TEXT:C222($aHospDesdeTXT;Size of array:C274($aHospFecha))
	ARRAY TEXT:C222($aHospHastaTXT;Size of array:C274($aHospHasta))
	For ($i;1;Size of array:C274($aHospFecha))
		$aHospDesdeTXT{$i}:=STWA2_MakeDate4JS ($aHospFecha{$i})
		$aHospHastaTXT{$i}:=STWA2_MakeDate4JS ($aHospHasta{$i})
	End for 
	ARRAY TEXT:C222($aContFechaTXT;Size of array:C274($aCMedico_Fecha))
	ARRAY LONGINT:C221($aContTallaLONG;Size of array:C274($aCMedico_Fecha))
	For ($i;1;Size of array:C274($aCMedico_Fecha))
		$aContFechaTXT{$i}:=STWA2_MakeDate4JS ($aCMedico_Fecha{$i})
		$aContTallaLONG{$i}:=$aCMedico_Talla{$i}
	End for 
	ARRAY TEXT:C222($aFechaVisitaTXT;Size of array:C274($aDateCE))
	ARRAY TEXT:C222($aHoraVisitaTXT;Size of array:C274($aDateCE))
	For ($i;1;Size of array:C274($aDateCE))
		$aFechaVisitaTXT{$i}:=STWA2_MakeDate4JS ($aDateCE{$i})
		$aHoraVisitaTXT{$i}:=String:C10(Time:C179(Time string:C180($aCEHora{$i}));HH MM:K7:2)
	End for 
	
	
	  //modifico fecha de Enfermedades
	ARRAY TEXT:C222($at_fechaEnfermedad;0)
	For ($i;1;Size of array:C274($ad_fechaEnfermedad))
		APPEND TO ARRAY:C911($at_fechaEnfermedad;String:C10($ad_fechaEnfermedad{$i}))
	End for 
	
	
	  //cargo las relaciones Familiares del alumno
	ARRAY TEXT:C222($at_nombreRelacion;0)
	ARRAY TEXT:C222($at_telefonoRelacion;0)
	ARRAY TEXT:C222($at_ParentescoRelacion;0)
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24)
	While (Not:C34(End selection:C36([Familia_RelacionesFamiliares:77])))
		QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
		If (Records in selection:C76([Personas:7])>0)
			APPEND TO ARRAY:C911($at_nombreRelacion;[Personas:7]Apellidos_y_nombres:30)
			APPEND TO ARRAY:C911($at_telefonoRelacion;[Personas:7]Telefono_domicilio:19)
			APPEND TO ARRAY:C911($at_ParentescoRelacion;[Familia_RelacionesFamiliares:77]Parentesco:6)
		End if 
		NEXT RECORD:C51([Familia_RelacionesFamiliares:77])
	End while 
	
	
	$ob_raiz:=OB_Create 
	
	OB_SET ($ob_raiz;->$at_nombreRelacion;"rel_nombre")
	OB_SET ($ob_raiz;->$at_telefonoRelacion;"rel_telefono")
	OB_SET ($ob_raiz;->$at_ParentescoRelacion;"rel_parentesco")
	
	
	
	
	OB_SET ($ob_raiz;->$aEnfermedad;"enfermedades")
	OB_SET ($ob_raiz;->$aRNEnfermedades;"enfermedadesid")
	OB_SET ($ob_raiz;->$aObsEnfermedad;"enfermedadesobs")
	OB_SET ($ob_raiz;->$at_fechaEnfermedad;"enfermedadesfecha")
	
	OB_SET ($ob_raiz;->$aAlergiaTipo;"alergias")
	OB_SET ($ob_raiz;->$aAlergeno;"alergenos")
	OB_SET ($ob_raiz;->$aRNAlergias;"alergiasid")
	OB_SET ($ob_raiz;->$aHospDesdeTXT;"hospdesde")
	OB_SET ($ob_raiz;->$aHospHastaTXT;"hosphasta")
	OB_SET ($ob_raiz;->$aHospDiagnostico;"hospdiagnostico")
	OB_SET ($ob_raiz;->$aRNHospitalizaciones;"hospid")
	OB_SET ($ob_raiz;->$aAparatos_Year;"apayear")
	OB_SET ($ob_raiz;->$aAparatos_Curso;"apacurso")
	OB_SET ($ob_raiz;->$aAparatos_Aparato;"apaaparato")
	OB_SET ($ob_raiz;->$aRNAparatos;"apaid")
	OB_SET ($ob_raiz;->$aVacuna_meses;"vacmeses")
	OB_SET ($ob_raiz;->$aVacuna_Enfermedad;"vacenfermedad")
	OB_SET ($ob_raiz;->$aVacuna_SiNo;"vacsino")
	OB_SET ($ob_raiz;->$aVacuna_edad;"vacedad")
	OB_SET ($ob_raiz;->$aRNVacunas;"vacid")
	OB_SET ($ob_raiz;->$aContFechaTXT;"contfecha")
	OB_SET ($ob_raiz;->$aCMedico_Curso;"contcurso")
	OB_SET ($ob_raiz;->$aCMedico_Edad;"contedad")
	OB_SET ($ob_raiz;->$aContTallaLONG;"conttalla")
	OB_SET ($ob_raiz;->$aCMedico_Peso;"contpeso")
	OB_SET ($ob_raiz;->$aCMedico_IMC;"contimc")
	OB_SET ($ob_raiz;->$aRNControles;"contid")
	OB_SET ($ob_raiz;->$aFechaVisitaTXT;"visitafecha")
	OB_SET ($ob_raiz;->$aMotCons;"visitaafeccion")
	OB_SET ($ob_raiz;->$aHoraVisitaTXT;"visitahora")
	OB_SET ($ob_raiz;->$aRNEventosEnf;"visitaid")
	OB_SET ($ob_raiz;->$aob_afeccion;"afeccionOB")
	OB_SET ($ob_raiz;->$aob_evolucion;"evolucion")
	OB_SET ($ob_raiz;->$aob_derivacion;"derivacion")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Observaciones:3;"observaciones")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Medicamentos_autorizados:11;"medautorizados")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Medicamentos_prohibidos:17;"medprohibidos")
	  //OB_SET ($ob_raiz;->[Alumnos_FichaMedica]Tratamientos;"tratamientos")
	
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]OB_tratamiento:23;"fichaTratamientos")
	
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Dieta:19;"dietas")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Alumna_embarazada:20;"embarazo")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]GrupoSanguineo:2;"gruposangre")
	OB_SET ($ob_raiz;->[Alumnos:2]Sexo:49;"sexo")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]IndiceMasaCorporal:21;"imc")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]factor_riesgo:15;"factorriesgo")
	$mostraremb:=(([Alumnos:2]Sexo:49="F") & ([Alumnos:2]Fecha_de_nacimiento:7#!00-00-00!) & (<>gYear-Year of:C25([Alumnos:2]Fecha_de_nacimiento:7)>=13) & ([Alumnos:2]Status:50="Activo"))
	OB_SET ($ob_raiz;->$mostraremb;"mostraremb")
	
	ARRAY TEXT:C222(aNombresMedicos;0)
	ARRAY TEXT:C222(aEspMedicos;0)
	ARRAY TEXT:C222(aTelMedicos;0)
	ARRAY TEXT:C222(aEMailMedicos;0)
	ARRAY LONGINT:C221(aIDMedico;0)
	ARRAY BOOLEAN:C223(aModMedico;0)
	ARRAY LONGINT:C221($al_IdMedicosInexistentes;0)
	  //20140711  ASM  Ticket 134693
	QUERY:C277([xxSTR_Link_AlumnosMedicos:237];[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2=[Alumnos:2]auto_uuid:72)
	KRL_RelateSelection (->[STR_Medicos:89]Auto_UUID:6;->[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3;"")
	SELECTION TO ARRAY:C260([STR_Medicos:89]ID:3;aIDMedico)
	AT_RedimArrays (Size of array:C274(aIDMedico);->aNombresMedicos;->aEspMedicos;->aTelMedicos;->aEMailMedicos;->aModMedico)
	For ($i;1;Size of array:C274(aIDMedico))
		$l_recNumMedicos:=Find in field:C653([STR_Medicos:89]ID:3;aIDMedico{$i})
		If ($l_recNumMedicos#-1)
			KRL_GotoRecord (->[STR_Medicos:89];$l_recNumMedicos;False:C215)
			aNombresMedicos{$i}:=[STR_Medicos:89]Nombres:1
			aEspMedicos{$i}:=[STR_Medicos:89]Especialidad:2
			aTelMedicos{$i}:=[STR_Medicos:89]Telefono_movil:4
			aEMailMedicos{$i}:=[STR_Medicos:89]eMail:5
		Else 
			APPEND TO ARRAY:C911($al_IdMedicosInexistentes;$i)
		End if 
	End for 
	If (Size of array:C274($al_IdMedicosInexistentes)>0)
		For ($i;Size of array:C274($al_IdMedicosInexistentes);1;-1)
			AT_Delete ($i;1;->aNombresMedicos;->aEspMedicos;->aTelMedicos;->aEMailMedicos;->aModMedico;->aIDMedico)
		End for 
	End if 
	OB_SET ($ob_raiz;->aNombresMedicos;"nombremedicos")
	OB_SET ($ob_raiz;->aIDMedico;"idmedicos")
	OB_SET ($ob_raiz;->aEMailMedicos;"emailmedicos")
	OB_SET ($ob_raiz;->aEspMedicos;"espmedicos")
	OB_SET ($ob_raiz;->aTelMedicos;"telmedicos")
	  //$node:=JSON Append text array ($jsonT;"nombremedicos";aNombresMedicos)
	  //$node:=JSON Append long array ($jsonT;"idmedicos";aIDMedico)
	  //$node:=JSON Append text array ($jsonT;"emailmedicos";aEMailMedicos)
	  //$node:=JSON Append text array ($jsonT;"espmedicos";aEspMedicos)
	  //$node:=JSON Append text array ($jsonT;"telmedicos";aTelMedicos)
	ARRAY TEXT:C222(aNombreContacto;0)
	ARRAY TEXT:C222(aTelContacto;0)
	ARRAY TEXT:C222(aRelacionContacto;0)
	$ref:="contactos.ALU."+String:C10([Alumnos:2]numero:1)
	$rn:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$ref)
	If ($rn#-1)
		KRL_GotoRecord (->[XShell_FatObjects:86];$rn;False:C215)
		BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
	Else 
		CREATE RECORD:C68([XShell_FatObjects:86])
		[XShell_FatObjects:86]FatObjectName:1:=$ref
		BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
		SAVE RECORD:C53([XShell_FatObjects:86])
	End if 
	OB_SET ($ob_raiz;->aNombreContacto;"nombrecontactos")
	OB_SET ($ob_raiz;->aRelacionContacto;"relacioncontactos")
	OB_SET ($ob_raiz;->aTelContacto;"telcontactos")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Urgencia_Contacto:4;"urcontacto")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Urgencia_Fonos:5;"urfonos")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Urgencia_Traslado:8;"urtraslado")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Urgencia_Convenio:6;"urconvenio")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Urgencia_Codigo_Convenio:7;"urcodconvenio")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Previsión_institución:9;"previnstitucion")
	OB_SET ($ob_raiz;->[Alumnos_FichaMedica:13]Prevision_Código:10;"prevcodigo")
	$json:=OB_Object2Json ($ob_raiz)
	
	KRL_UnloadReadOnly (->[Alumnos_FichaMedica:13])
End if 

$0:=$json
