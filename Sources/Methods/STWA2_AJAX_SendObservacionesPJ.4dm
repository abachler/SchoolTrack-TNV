//%attributes = {}


  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 05-09-17, 16:56:55
  // ----------------------------------------------------
  // Método: STWA2_AJAX_SendObservacionesPJ
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



$periodo:=$1
$curso:=$2
$profID:=$3
$userID:=$4

ARRAY TEXT:C222($aNombres;0)
ARRAY INTEGER:C220($aNoLista;0)
ARRAY LONGINT:C221($aNoListaLONG;0)
ARRAY TEXT:C222($aStatus;0)
ARRAY LONGINT:C221($aRN;0)
ARRAY TEXT:C222($aObs;0)

ARRAY LONGINT:C221($aNumero;0)
ARRAY LONGINT:C221($aNivel;0)
ARRAY LONGINT:C221($aTutor;0)
ARRAY BOOLEAN:C223($ab_condicional;0)

$cursoNivNum:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$curso;->[Cursos:3]Nivel_Numero:7)
$cursoPJ:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->$curso;->[Cursos:3]Numero_del_profesor_jefe:2)

PERIODOS_Init 
PERIODOS_LoadData ($cursoNivNum)

If ($periodo=0)
	$periodo:=viSTR_PeriodoActual_Numero
End if 
If ($periodo>aiSTR_Periodos_Numero{Size of array:C274(aiSTR_Periodos_Numero)})
	$periodo:=Size of array:C274(aiSTR_Periodos_Numero)
End if 

READ ONLY:C145([Alumnos:2])
QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
SELECTION TO ARRAY:C260([Alumnos:2];$aRN;[Alumnos:2]apellidos_y_nombres:40;$aNombres;[Alumnos:2]no_de_lista:53;$aNoLista;[Alumnos:2]Status:50;$aStatus)
SELECTION TO ARRAY:C260([Alumnos:2]nivel_numero:29;$aNivel;[Alumnos:2]numero:1;$aNumero)


For ($i;1;Size of array:C274($aRN))
	$t_llaveSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($aNivel{$i})+"."+String:C10($aNumero{$i})
	$l_recNumSintesisAnual:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveSintesisAnual;False:C215)
	APPEND TO ARRAY:C911($ab_condicional;[Alumnos_SintesisAnual:210]Condicionalidad_Activada:57)
	Case of 
		: ($periodo=-1)
			APPEND TO ARRAY:C911($aObs;[Alumnos_SintesisAnual:210]Observaciones_Academicas:47)
		: ($periodo=1)
			APPEND TO ARRAY:C911($aObs;[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114)
		: ($periodo=2)
			APPEND TO ARRAY:C911($aObs;[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143)
		: ($periodo=3)
			APPEND TO ARRAY:C911($aObs;[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172)
		: ($periodo=4)
			APPEND TO ARRAY:C911($aObs;[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201)
		: ($periodo=5)
			APPEND TO ARRAY:C911($aObs;[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230)
	End case 
	APPEND TO ARRAY:C911($aNoListaLONG;$aNoLista{$i})
End for 

Case of 
	: (<>gOrdenNta=0)
		SORT ARRAY:C229($aNombres;$aNoListaLONG;$aRN;$aStatus;$aObs;$ab_condicional;>)
	: (<>gOrdenNta=1)
		SORT ARRAY:C229($aNoListaLONG;$aNombres;$aRN;$aStatus;$aObs;$ab_condicional;>)
	: (<>gOrdenNta=2)
		SORT ARRAY:C229($aNombres;$aNoListaLONG;$aRN;$aStatus;$aObs;$ab_condicional;>)
End case 

$b_edicionAutorizada:=(($profID=$cursoPJ) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)))

C_OBJECT:C1216($ob_raiz)
$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$b_edicionAutorizada;"ingresopermitido")
OB_SET ($ob_raiz;->$aNoListaLONG;"ordenes")
OB_SET ($ob_raiz;->$aNombres;"alumnos")
OB_SET ($ob_raiz;->$aObs;"observaciones")
OB_SET ($ob_raiz;->$aRN;"recnums")
OB_SET ($ob_raiz;->$aStatus;"status")
OB_SET ($ob_raiz;->$ab_condicional;"cond")

C_OBJECT:C1216($ob_parametros)
$ob_parametros:=OB_Create 
OB_SET_Text ($ob_parametros;String:C10($periodo);"periodo")
OB_SET_Text ($ob_parametros;String:C10(PERIODOS_PeriodosActuales (Current date:C33(*);True:C214));"periodoactual")
OB_SET ($ob_raiz;->$ob_parametros;"parametros")

ARRAY TEXT:C222($aCierre4JS;0)
ARRAY TEXT:C222($aDesde4JS;0)
ARRAY TEXT:C222($aHasta4JS;0)
ARRAY TEXT:C222($aPeriodosNumsText;0)
For ($i;1;Size of array:C274(adSTR_Periodos_Cierre))
	APPEND TO ARRAY:C911($aCierre4JS;STWA2_MakeDate4JS (adSTR_Periodos_Cierre{$i}))
	APPEND TO ARRAY:C911($aDesde4JS;STWA2_MakeDate4JS (adSTR_Periodos_Desde{$i}))
	APPEND TO ARRAY:C911($aHasta4JS;STWA2_MakeDate4JS (adSTR_Periodos_Hasta{$i}))
	APPEND TO ARRAY:C911($aPeriodosNumsText;String:C10(aiSTR_Periodos_Numero{$i}))
End for 

C_OBJECT:C1216($ob_periodos)
$ob_periodos:=OB_Create 
OB_SET ($ob_periodos;->atSTR_Periodos_Nombre;"nombres")
OB_SET ($ob_periodos;->$aPeriodosNumsText;"numeros")
OB_SET ($ob_periodos;->$aDesde4JS;"desde")
OB_SET ($ob_periodos;->$aHasta4JS;"hasta")
OB_SET ($ob_periodos;->$aCierre4JS;"cierre")
OB_SET ($ob_raiz;->$ob_periodos;"periodos")

$json:=OB_Object2Json ($ob_raiz)
$0:=$json
