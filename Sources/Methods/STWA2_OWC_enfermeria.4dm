//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:56:06
  // ----------------------------------------------------
  // Método: STWA2_OWC_enfermeria
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$userID:=STWA2_Session_GetUserSTID ($uuid)
$priv:=USR_checkRights ("A";->[Alumnos_EventosEnfermeria:14];$userID)

If (Not:C34($priv))
	OB SET:C1220($ob_raiz;"nopermiso";$priv)
	
Else 
	
	QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
	KRL_RelateSelection (->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]NoNivel:5;"")
	QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
	ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
	SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursosEnfermeria)
	
	NIV_LoadArrays 
	OB SET ARRAY:C1227($ob_raiz;"procedencia";<>aProced)
	OB SET ARRAY:C1227($ob_raiz;"afeccion";<>aAfect)
	OB SET ARRAY:C1227($ob_raiz;"tratamiento";<>aTrto)
	OB SET ARRAY:C1227($ob_raiz;"destino";<>aDest)
	OB SET ARRAY:C1227($ob_raiz;"recomendaciones";<>recomendacionesEnfermeria)
	OB SET ARRAY:C1227($ob_raiz;"protesis";<>at_Protesis)
	OB SET ARRAY:C1227($ob_raiz;"alergias";<>aTipoAlergia)
	OB SET ARRAY:C1227($ob_raiz;"enfermedades";<>aEnfermedades)
	OB SET ARRAY:C1227($ob_raiz;"gruposangre";<>aBlood)
	OB SET ARRAY:C1227($ob_raiz;"niveles";<>at_NombreNivelesActivos)
	OB SET ARRAY:C1227($ob_raiz;"especialidades";<>AT_ESPMEDICAS)
	OB SET ARRAY:C1227($ob_raiz;"factores";<>at_FactoresdeRiesgo)
	OB SET ARRAY:C1227($ob_raiz;"insumos";<>insumos)
	OB SET ARRAY:C1227($ob_raiz;"medicamentos";<>medicamentos)
	OB SET ARRAY:C1227($ob_raiz;"cursosEnfermeria";$at_cursosEnfermeria)
	
	ARRAY TEXT:C222($asSTK_DVVacunas;0)
	For ($i;1;Size of array:C274(<>atSTK_Vacunas))
		APPEND TO ARRAY:C911($asSTK_DVVacunas;Substring:C12(<>atSTK_Vacunas{$i};1;80))
	End for 
	
	AT_DistinctsArrayValues (->$asSTK_DVVacunas)
	OB SET ARRAY:C1227($ob_raiz;"vacunas";$asSTK_DVVacunas)
	READ ONLY:C145([xShell_List:39])
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Enfermería: Recomendaciones")
	OB SET:C1220($ob_raiz;"recomenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Enfermería: Afecciones")
	OB SET:C1220($ob_raiz;"afeccionesenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Enfermería: Tratamientos")
	OB SET:C1220($ob_raiz;"trataenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Enfermería: Destino")
	OB SET:C1220($ob_raiz;"destinoenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Enfermería: Procedencia")
	OB SET:C1220($ob_raiz;"procenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Ficha Médica: Aparatos y Prótesis")
	OB SET:C1220($ob_raiz;"protesisenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Ficha Médica: Alergias")
	OB SET:C1220($ob_raiz;"alergiasenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Ficha Médica: Enfermedades")
	OB SET:C1220($ob_raiz;"enfermedadesenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Ficha Médica: Grupos Sanguíneos")
	OB SET:C1220($ob_raiz;"sangreenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Ficha Médica: Especialidades Médicas")
	OB SET:C1220($ob_raiz;"especialidadesenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Ficha Médica: Factores de Riesgo")
	OB SET:C1220($ob_raiz;"factoresenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Enfermería: insumos")
	OB SET:C1220($ob_raiz;"insumosenriquecible";[xShell_List:39]Enriquecible:8)
	QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1="Enfermería: medicamentos")
	OB SET:C1220($ob_raiz;"medicamentosenriquecible";[xShell_List:39]Enriquecible:8)
	
	ARRAY TEXT:C222($atSTR_ModelosEnfermeria;0)
	ARRAY LONGINT:C221($alSTR_ModelosEnfermeria;0)
	READ ONLY:C145([xShell_Reports:54])
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[Alumnos:2]);*)
	QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26="Ticket de Enfermería@")
	QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]isOneRecordReport:11;=;True:C214)
	SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;$atSTR_ModelosEnfermeria;[xShell_Reports:54]ID:7;$alSTR_ModelosEnfermeria)
	
	OB SET ARRAY:C1227($ob_raiz;"modelos";$atSTR_ModelosEnfermeria)
	OB SET ARRAY:C1227($ob_raiz;"modelosid";$alSTR_ModelosEnfermeria)
	
	STRmed_LoadMedicos 
	
	OB SET ARRAY:C1227($ob_raiz;"nombremedicos";aMedNombre)
	OB SET ARRAY:C1227($ob_raiz;"idmedicos";aMedID)
	OB SET ARRAY:C1227($ob_raiz;"emailmedicos";aMedEMail)
	OB SET ARRAY:C1227($ob_raiz;"espmedicos";aMedEspecialidad)
	OB SET ARRAY:C1227($ob_raiz;"telmedicos";aMedTelefonos)
	$priv1:=USR_checkRights ("A";->[Alumnos_EventosEnfermeria:14];$userID)
	$priv2:=USR_checkRights ("L";->[Alumnos_EventosEnfermeria:14];$userID)
	$priv3:=USR_checkRights ("D";->[Alumnos_EventosEnfermeria:14];$userID)
	$priv4:=USR_checkRights ("L";->[Alumnos_FichaMedica:13];$userID)
	$priv5:=USR_checkRights ("M";->[Alumnos_FichaMedica:13];$userID)
	OB SET:C1220($ob_raiz;"AEE";$priv1)
	OB SET:C1220($ob_raiz;"LEE";$priv2)
	OB SET:C1220($ob_raiz;"DEE";$priv3)
	OB SET:C1220($ob_raiz;"LFM";$priv4)
	OB SET:C1220($ob_raiz;"MFM";$priv5)
	
End if 
$json:=JSON Stringify:C1217($ob_raiz)
$0:=$json
