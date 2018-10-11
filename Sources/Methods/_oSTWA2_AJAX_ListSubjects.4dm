//%attributes = {}
C_TEXT:C284($uuid;$1)
C_LONGINT:C283($profID;$userID)

$uuid:=$1
If (Util_isValidUUID ($uuid))
	$profID:=STWA2_Session_GetProfID ($uuid)
	$userID:=STWA2_Session_GetUserSTID ($uuid)
	$admin:=USR_IsGroupMember_by_GrpID (-15001;$userID)
End if 

READ ONLY:C145([Asignaturas:18])
  //ALL RECORDS([Asignaturas])

$currErrMethod:=Method called on error:C704
ON ERR CALL:C155("STWerr_DataErrorHandler")


ARRAY TEXT:C222(aOrdenAS;0)
ARRAY TEXT:C222(aAbrev;0)
ARRAY TEXT:C222(aNivelNombre;0)
ARRAY TEXT:C222(aCurso;0)
ARRAY TEXT:C222(aNombre;0)
ARRAY INTEGER:C220(aNumDeAlumnos;0)
ARRAY TEXT:C222(aPromedio;0)
ARRAY TEXT:C222(aPromOficial;0)
ARRAY REAL:C219(aAprobacion;0)
ARRAY LONGINT:C221(aRecNums;0)
ARRAY TEXT:C222(aNombreProfesor;0)
ARRAY LONGINT:C221(aIDMatriz;0)
ARRAY LONGINT:C221(aAttMode;0)

ARRAY TEXT:C222($aNombreProfesor;0)
ARRAY LONGINT:C221($aNivelNumero;0)

ARRAY POINTER:C280($aArrayPtrs;0)
ARRAY POINTER:C280($aFieldPtrs;0)
ARRAY LONGINT:C221($aOrdenador;0)
ARRAY TEXT:C222($aNames;0)
ARRAY TEXT:C222($aFormats;0)

APPEND TO ARRAY:C911($aArrayPtrs;->aOrdenAS)
APPEND TO ARRAY:C911($aArrayPtrs;->aAbrev)
APPEND TO ARRAY:C911($aArrayPtrs;->aNivelNombre)
APPEND TO ARRAY:C911($aArrayPtrs;->aCurso)
APPEND TO ARRAY:C911($aArrayPtrs;->aNombre)
APPEND TO ARRAY:C911($aArrayPtrs;->aNombreProfesor)
APPEND TO ARRAY:C911($aArrayPtrs;->aNumDeAlumnos)
APPEND TO ARRAY:C911($aArrayPtrs;->aPromedio)
APPEND TO ARRAY:C911($aArrayPtrs;->aPromOficial)
APPEND TO ARRAY:C911($aArrayPtrs;->aAprobacion)
APPEND TO ARRAY:C911($aArrayPtrs;->aRecNums)
APPEND TO ARRAY:C911($aArrayPtrs;->aIDMatriz)
APPEND TO ARRAY:C911($aArrayPtrs;->aAttMode)

C_POINTER:C301($vy_prueba)
APPEND TO ARRAY:C911($aFieldPtrs;->[Asignaturas:18]ordenGeneral:105)
APPEND TO ARRAY:C911($aFieldPtrs;->[Asignaturas:18]Abreviación:26)
APPEND TO ARRAY:C911($aFieldPtrs;->[Asignaturas:18]Nivel:30)
APPEND TO ARRAY:C911($aFieldPtrs;->[Asignaturas:18]Curso:5)
APPEND TO ARRAY:C911($aFieldPtrs;->[Asignaturas:18]denominacion_interna:16)
APPEND TO ARRAY:C911($aFieldPtrs;->[Profesores:4]Apellidos_y_nombres:28)
APPEND TO ARRAY:C911($aFieldPtrs;->[Asignaturas:18]Numero_de_alumnos:49)
APPEND TO ARRAY:C911($aFieldPtrs;->[Asignaturas:18]PromedioFinal_texto:53)
APPEND TO ARRAY:C911($aFieldPtrs;->[Asignaturas:18]PromedioFinalOficial_texto:67)
APPEND TO ARRAY:C911($aFieldPtrs;->[Asignaturas:18]PorcentajeAprobados:103)
APPEND TO ARRAY:C911($aFieldPtrs;$vy_prueba)
APPEND TO ARRAY:C911($aFieldPtrs;->[Asignaturas:18]EVAPR_IdMatriz:91)
APPEND TO ARRAY:C911($aFieldPtrs;$vy_prueba)

For ($i;1;Size of array:C274($aArrayPtrs))
	APPEND TO ARRAY:C911($aOrdenador;$i)
End for 

APPEND TO ARRAY:C911($aNames;"Orden")
APPEND TO ARRAY:C911($aNames;"Abreviacion")
APPEND TO ARRAY:C911($aNames;"Nivel")
APPEND TO ARRAY:C911($aNames;"Curso")
APPEND TO ARRAY:C911($aNames;"Nombre")
APPEND TO ARRAY:C911($aNames;"Profesor")
APPEND TO ARRAY:C911($aNames;"Alumnos")
APPEND TO ARRAY:C911($aNames;"Promedio")
APPEND TO ARRAY:C911($aNames;"PromedioOF")
APPEND TO ARRAY:C911($aNames;"Aprobacion")
APPEND TO ARRAY:C911($aNames;"RecNums")
APPEND TO ARRAY:C911($aNames;"IDMatriz")
APPEND TO ARRAY:C911($aNames;"AttMode")

yBWR_currentTable:=->[Asignaturas:18]
vlBWR_CurrentModuleRef:=SchoolTrack
BWR_InitArrays 
BWR_SetDataPointers 

For ($i;1;Size of array:C274($aFieldPtrs))
	$el:=Find in array:C230(ayBWR_FieldPointers;$aFieldPtrs{$i})
	If ($el#-1)
		APPEND TO ARRAY:C911($aFormats;atVS_BrowserFormat{$el})
	Else 
		If ($aNames{$i}="RecNums")
			APPEND TO ARRAY:C911($aFormats;"#############################0")
		Else 
			APPEND TO ARRAY:C911($aFormats;"")
		End if 
	End if 
End for 

ORDER BY:C49([Asignaturas:18];[Asignaturas:18]posicion_en_informes_de_notas:36;>;[Asignaturas:18]denominacion_interna:16;>)

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Asignaturas:18]ordenGeneral:105;aOrdenAS;[Asignaturas:18]Abreviación:26;aAbrev;[Asignaturas:18]Numero_del_Nivel:6;$aNivelNumero;[Asignaturas:18]Nivel:30;aNivelNombre;[Asignaturas:18]Curso:5;aCurso;[Asignaturas:18]denominacion_interna:16;aNombre;[Asignaturas:18]Numero_de_alumnos:49;aNumDeAlumnos)
SELECTION TO ARRAY:C260([Asignaturas:18]PorcentajeAprobados:103;aAprobacion;[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19;aPromedio;[Asignaturas_SintesisAnual:202]PromedioOficial_Literal:24;aPromOficial;[Asignaturas:18]EVAPR_IdMatriz:91;aIDMatriz)
SELECTION TO ARRAY:C260([Asignaturas:18];aRecNums;[Profesores:4]Apellidos_y_nombres:28;aNombreProfesor;[Profesores:4]Numero:1;$aIDProfesor)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

For ($i;1;Size of array:C274($aNivelNumero))
	$nivelNumber:=$aNivelNumero{$i}
	$attMode:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelNumber;->[xxSTR_Niveles:6]AttendanceMode:3)
	APPEND TO ARRAY:C911(aAttMode;$attMode)
End for 

AT_DistinctsArrayValues (->$aIDProfesor)
If (Size of array:C274($aIDProfesor)>1)
	$vbMostrarProfe:=True:C214
Else 
	If (Size of array:C274($aIDProfesor)=1)
		If ($aIDProfesor{1}#$profID)
			$vbMostrarProfe:=True:C214
		Else 
			$vbMostrarProfe:=False:C215
		End if 
	Else 
		$vbMostrarProfe:=False:C215
	End if 
End if 

  //$sortString:=PREF_fGet ($userID;"OrdenamientoPanel#"+String(vlBWR_SelectedTableRef))
$sortString:=""

If ($sortString#"")
	ARRAY LONGINT:C221($aOrders;0)
	ARRAY LONGINT:C221($aOrders;Size of array:C274($aFieldPtrs))
	ARRAY LONGINT:C221($ordenadora2;0)
	ARRAY TEXT:C222($sortCols;0)
	AT_Text2Array (->$sortCols;$sortString;";")
	For ($j;2;Size of array:C274($sortCols))
		$order2array:=Num:C11($sortCols{$j})/Abs:C99(Num:C11($sortCols{$j}))
		$orderArrayIndex:=Abs:C99(Num:C11($sortCols{$j}))
		  //If ($orderArrayIndex>5)
		  //  `$orderArrayIndex:=$orderArrayIndex-1
		  //End if 
		APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
		$aOrders{$orderArrayIndex}:=$order2array
	End for 
	AT_OrderArraysByArray (MAXINT:K35:1;->$ordenadora2;->$aOrdenador;->$aArrayPtrs;->$aOrders;->$aNames;->$aFormats)
	MULTI SORT ARRAY:C718($aArrayPtrs;$aOrders)
Else 
	$orderCriteria:=ST_CountWords (vtBWR_sortOrder;1;",")
	Case of 
		: ($ordercriteria>=6)
			ARRAY LONGINT:C221($ordenadora2;0)
			ARRAY LONGINT:C221($aOrders;0)
			ARRAY LONGINT:C221($aOrders;Size of array:C274($aFieldPtrs))
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$order2array:=$orden1/Abs:C99($orden1)
			$orderArrayIndex:=Abs:C99($orden1)
			If ($orden1>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden2:=Num:C11(ST_GetWord (vtBWR_sortOrder;2;","))
			$order2array:=$orden2/Abs:C99($orden2)
			$orderArrayIndex:=Abs:C99($orden2)
			If ($orden2>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden3:=Num:C11(ST_GetWord (vtBWR_sortOrder;3;","))
			$order2array:=$orden3/Abs:C99($orden3)
			$orderArrayIndex:=Abs:C99($orden3)
			If ($orden3>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden4:=Num:C11(ST_GetWord (vtBWR_sortOrder;4;","))
			$order2array:=$orden4/Abs:C99($orden4)
			$orderArrayIndex:=Abs:C99($orden4)
			If ($orden4>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden5:=Num:C11(ST_GetWord (vtBWR_sortOrder;5;","))
			$order2array:=$orden5/Abs:C99($orden5)
			$orderArrayIndex:=Abs:C99($orden5)
			If ($orden5>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden6:=Num:C11(ST_GetWord (vtBWR_sortOrder;6;","))
			$order2array:=$orden6/Abs:C99($orden6)
			$orderArrayIndex:=Abs:C99($orden6)
			If ($orden6>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
		: ($ordercriteria=5)
			ARRAY LONGINT:C221($ordenadora2;0)
			ARRAY LONGINT:C221($aOrders;0)
			ARRAY LONGINT:C221($aOrders;Size of array:C274($aFieldPtrs))
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$order2array:=$orden1/Abs:C99($orden1)
			$orderArrayIndex:=Abs:C99($orden1)
			If ($orden1>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden2:=Num:C11(ST_GetWord (vtBWR_sortOrder;2;","))
			$order2array:=$orden2/Abs:C99($orden2)
			$orderArrayIndex:=Abs:C99($orden2)
			If ($orden2>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden3:=Num:C11(ST_GetWord (vtBWR_sortOrder;3;","))
			$order2array:=$orden3/Abs:C99($orden3)
			$orderArrayIndex:=Abs:C99($orden3)
			If ($orden3>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden4:=Num:C11(ST_GetWord (vtBWR_sortOrder;4;","))
			$order2array:=$orden4/Abs:C99($orden4)
			$orderArrayIndex:=Abs:C99($orden4)
			If ($orden4>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden5:=Num:C11(ST_GetWord (vtBWR_sortOrder;5;","))
			$order2array:=$orden5/Abs:C99($orden5)
			$orderArrayIndex:=Abs:C99($orden5)
			If ($orden5>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
		: ($ordercriteria=4)
			ARRAY LONGINT:C221($ordenadora2;0)
			ARRAY LONGINT:C221($aOrders;0)
			ARRAY LONGINT:C221($aOrders;Size of array:C274($aFieldPtrs))
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$order2array:=$orden1/Abs:C99($orden1)
			$orderArrayIndex:=Abs:C99($orden1)
			If ($orden1>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden2:=Num:C11(ST_GetWord (vtBWR_sortOrder;2;","))
			$order2array:=$orden2/Abs:C99($orden2)
			$orderArrayIndex:=Abs:C99($orden2)
			If ($orden2>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden3:=Num:C11(ST_GetWord (vtBWR_sortOrder;3;","))
			$order2array:=$orden3/Abs:C99($orden3)
			$orderArrayIndex:=Abs:C99($orden3)
			If ($orden3>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden4:=Num:C11(ST_GetWord (vtBWR_sortOrder;4;","))
			$order2array:=$orden4/Abs:C99($orden4)
			$orderArrayIndex:=Abs:C99($orden4)
			If ($orden4>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
		: ($ordercriteria=3)
			ARRAY LONGINT:C221($ordenadora2;0)
			ARRAY LONGINT:C221($aOrders;0)
			ARRAY LONGINT:C221($aOrders;Size of array:C274($aFieldPtrs))
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$order2array:=$orden1/Abs:C99($orden1)
			$orderArrayIndex:=Abs:C99($orden1)
			If ($orden1>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden2:=Num:C11(ST_GetWord (vtBWR_sortOrder;2;","))
			$order2array:=$orden2/Abs:C99($orden2)
			$orderArrayIndex:=Abs:C99($orden2)
			If ($orden2>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden3:=Num:C11(ST_GetWord (vtBWR_sortOrder;3;","))
			$order2array:=$orden3/Abs:C99($orden3)
			$orderArrayIndex:=Abs:C99($orden3)
			If ($orden3>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
		: ($ordercriteria=2)
			ARRAY LONGINT:C221($ordenadora2;0)
			ARRAY LONGINT:C221($aOrders;0)
			ARRAY LONGINT:C221($aOrders;Size of array:C274($aFieldPtrs))
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$order2array:=$orden1/Abs:C99($orden1)
			$orderArrayIndex:=Abs:C99($orden1)
			If ($orden1>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
			$orden2:=Num:C11(ST_GetWord (vtBWR_sortOrder;2;","))
			$order2array:=$orden2/Abs:C99($orden2)
			$orderArrayIndex:=Abs:C99($orden2)
			If ($orden2>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
		: ($ordercriteria=1)
			ARRAY LONGINT:C221($ordenadora2;0)
			ARRAY LONGINT:C221($aOrders;0)
			ARRAY LONGINT:C221($aOrders;Size of array:C274($aFieldPtrs))
			$orden1:=Num:C11(ST_GetWord (vtBWR_sortOrder;1;","))
			$order2array:=$orden1/Abs:C99($orden1)
			$orderArrayIndex:=Abs:C99($orden1)
			If ($orden1>5)
				$orderArrayIndex:=$orderArrayIndex-1
			End if 
			APPEND TO ARRAY:C911($ordenadora2;$orderArrayIndex)
			$aOrders{$orderArrayIndex}:=$order2array
	End case 
	AT_OrderArraysByArray (MAXINT:K35:1;->$ordenadora2;->$aOrdenador;->$aArrayPtrs;->$aOrders;->$aNames;->$aFormats)
	MULTI SORT ARRAY:C718($aArrayPtrs;$aOrders)
End if 

$rnAsig:=-1
If ($userID>0)
	READ ONLY:C145([TMT_Horario:166])
	$fecha:=Current date:C33
	$hora:=Current time:C178
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Teacher:9=$profID)
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12<=$fecha;*)
	QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$fecha)
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=DT_GetDayNumber_ISO8601 ($fecha);*)
	QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Desde:3<=$hora;*)
	QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Hasta:4>=$hora)
	If (Records in selection:C76([TMT_Horario:166])>0)
		FIRST RECORD:C50([TMT_Horario:166])
		$idAsig:=[TMT_Horario:166]ID_Asignatura:5
		$rnAsig:=Find in field:C653([Asignaturas:18]Numero:1;$idAsig)
	End if 
	KRL_UnloadReadOnly (->[TMT_Horario:166])
End if 


ON ERR CALL:C155($currErrMethod)
C_OBJECT:C1216($ob_raiz)
  //$t_raizJson:=JSON New 
For ($i;1;Size of array:C274($aArrayPtrs))
	OB_SET ($ob_raiz;->$aArrayPtrs{$i};$aNames{$i};$aFormats{$i})
	  //STWA2_Arreglo_a_json ($t_raizJson;$aArrayPtrs{$i};$aNames{$i};$aFormats{$i})
End for 
  //JSON_AgregaTexto ($t_raizJson;ST_Qte (String(Num($vbMostrarProfe)));ST_Qte ("mostrarprofe"))
  //JSON_AgregaTexto ($t_raizJson;ST_Qte (String($rnAsig));ST_Qte ("currentAsig"))
JSON_AgregaTexto ($ob_raiz;String:C10(Num:C11($vbMostrarProfe));"mostrarprofe")
JSON_AgregaTexto ($ob_raiz;String:C10($rnAsig);"currentAsig")
$t_json:=OB_Object2Json ($ob_raiz)
  //$t_json:=JSON Export to text ($t_raizJson;JSON_WITH_WHITE_SPACE)
  //JSON CLOSE 
  //TEXT TO BLOB($t_json;$x_blob;UTF8 text without length)
  //BLOB TO DOCUMENT("Asignaturas [plugin].json";$x_blob)


  //C_OBJECT($o_json)
  //For ($i;1;Size of array($aArrayPtrs))
  //OB SET ARRAY($o_json;$aNames{$i};$aArrayPtrs{$i}->)
  //End for 
  //OB SET($o_json;"mostrarprofe";String(Num($vbMostrarProfe)))
  //OB SET($o_json;"currentAsig";String($rnAsig))
  //$t_json:=JSON Stringify($o_json;*)
  //TEXT TO BLOB($t_json;$x_blob;UTF8 text without length)
  //BLOB TO DOCUMENT("Asignaturas [object].json";$x_blob)

  //ON ERR CALL($currErrMethod)

$0:=$t_json