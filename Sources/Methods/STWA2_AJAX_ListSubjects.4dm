//%attributes = {}
  //  // STWA2_AJAX_ListSubjects()
  //  // 
  //  //
  //  // creado por: Alberto Bachler Klein: 29-12-15, 18:33:49
  //  // -----------------------------------------------------------

  //C_TEXT($uuid;$1)

  //$uuid:=$1
  //$profID:=STWA2_Session_GetProfID ($uuid)
  //$userID:=STWA2_Session_GetUserSTID ($uuid)
  //$admin:=USR_IsGroupMember_by_GrpID (-15001;$userID)

  //READ ONLY([Asignaturas])


  //  //Declaraciones (ABK 2011/01/08)
  //C_LONGINT(vCantidad;vInicial;vIDProfesor;vIDUsuario;vPrimeraColumnaOrden;vTotalAsignaturas)
  //C_TEXT(vColSTW;vDirSTW;vt_nombreColegio;vt_AgnoEscolar)
  //C_BOOLEAN($vbMostrarProfe)
  //  // Fin declaraciones (ABK 2011/01/08)




  //$currErrMethod:=Method called on error
  //ON ERR CALL("STWerr_DataErrorHandler")




  //vTotalAsignaturas:=Records in selection([Asignaturas])

  //ARRAY TEXT(aOrdenAS;0)
  //ARRAY TEXT(aAbrev;0)
  //ARRAY TEXT(aNivelNombre;0)
  //ARRAY TEXT(aCurso;0)
  //ARRAY TEXT(aNombre;0)
  //ARRAY INTEGER(aNumDeAlumnos;0)
  //ARRAY TEXT(aPromedio;0)
  //ARRAY TEXT(aPromOficial;0)
  //ARRAY REAL(aAprobacion;0)
  //ARRAY LONGINT(aRecNums;0)
  //ARRAY TEXT(aNombreProfesor;0)
  //ARRAY LONGINT(aIDMatriz;0)
  //ARRAY LONGINT(aAttMode;0)

  //ARRAY TEXT($aNombreProfesor;0)
  //ARRAY LONGINT($aNivelNumero;0)

  //ARRAY POINTER($aArrayPtrs;0)
  //ARRAY POINTER($aFieldPtrs;0)
  //ARRAY LONGINT($aOrdenador;0)
  //ARRAY TEXT($aNames;0)
  //ARRAY TEXT($aFormats;0)

  //APPEND TO ARRAY($aArrayPtrs;->aOrdenAS)
  //APPEND TO ARRAY($aArrayPtrs;->aAbrev)
  //APPEND TO ARRAY($aArrayPtrs;->aNivelNombre)
  //APPEND TO ARRAY($aArrayPtrs;->aCurso)
  //APPEND TO ARRAY($aArrayPtrs;->aNombre)
  //APPEND TO ARRAY($aArrayPtrs;->aNombreProfesor)
  //APPEND TO ARRAY($aArrayPtrs;->aNumDeAlumnos)
  //APPEND TO ARRAY($aArrayPtrs;->aPromedio)
  //APPEND TO ARRAY($aArrayPtrs;->aPromOficial)
  //APPEND TO ARRAY($aArrayPtrs;->aAprobacion)
  //APPEND TO ARRAY($aArrayPtrs;->aRecNums)
  //APPEND TO ARRAY($aArrayPtrs;->aIDMatriz)
  //APPEND TO ARRAY($aArrayPtrs;->aAttMode)

  //C_POINTER($vy_prueba)
  //APPEND TO ARRAY($aFieldPtrs;->[Asignaturas]OrdenGeneral)
  //APPEND TO ARRAY($aFieldPtrs;->[Asignaturas]Abreviación)
  //APPEND TO ARRAY($aFieldPtrs;->[Asignaturas]Nivel)
  //APPEND TO ARRAY($aFieldPtrs;->[Asignaturas]Curso)
  //APPEND TO ARRAY($aFieldPtrs;->[Asignaturas]Denominación_interna)
  //APPEND TO ARRAY($aFieldPtrs;->[Profesores]Apellidos_y_nombres)
  //APPEND TO ARRAY($aFieldPtrs;->[Asignaturas]Numero_de_alumnos)
  //APPEND TO ARRAY($aFieldPtrs;->[Asignaturas]PromedioFinal_texto)
  //APPEND TO ARRAY($aFieldPtrs;->[Asignaturas]PromedioFinalOficial_texto)
  //APPEND TO ARRAY($aFieldPtrs;->[Asignaturas]PorcentajeAprobados)
  //APPEND TO ARRAY($aFieldPtrs;$vy_prueba)
  //APPEND TO ARRAY($aFieldPtrs;->[Asignaturas]EVAPR_IdMatriz)
  //APPEND TO ARRAY($aFieldPtrs;$vy_prueba)

  //For ($i;1;Size of array($aArrayPtrs))
  //APPEND TO ARRAY($aOrdenador;$i)
  //End for 

  //APPEND TO ARRAY($aNames;"Orden")
  //APPEND TO ARRAY($aNames;"Abreviacion")
  //APPEND TO ARRAY($aNames;"Nivel")
  //APPEND TO ARRAY($aNames;"Curso")
  //APPEND TO ARRAY($aNames;"Nombre")
  //APPEND TO ARRAY($aNames;"Profesor")
  //APPEND TO ARRAY($aNames;"Alumnos")
  //APPEND TO ARRAY($aNames;"Promedio")
  //APPEND TO ARRAY($aNames;"PromedioOF")
  //APPEND TO ARRAY($aNames;"Aprobacion")
  //APPEND TO ARRAY($aNames;"RecNums")
  //APPEND TO ARRAY($aNames;"IDMatriz")
  //APPEND TO ARRAY($aNames;"AttMode")

  //yBWR_currentTable:=->[Asignaturas]
  //vlBWR_CurrentModuleRef:=SchoolTrack
  //BWR_InitArrays 
  //BWR_SetDataPointers 

  //For ($i;1;Size of array($aFieldPtrs))
  //$el:=Find in array(ayBWR_FieldPointers;$aFieldPtrs{$i})
  //If ($el#-1)
  //APPEND TO ARRAY($aFormats;atVS_BrowserFormat{$el})
  //Else 
  //If ($aNames{$i}="RecNums")
  //APPEND TO ARRAY($aFormats;"#############################0")
  //Else 
  //APPEND TO ARRAY($aFormats;"")
  //End if 
  //End if 
  //End for 

  //ORDER BY([Asignaturas];[Asignaturas]Posicion_en_Informes_de_Notas;>;[Asignaturas]Denominación_interna;>)

  //SET AUTOMATIC RELATIONS(True;False)
  //SELECTION TO ARRAY([Asignaturas]OrdenGeneral;aOrdenAS;[Asignaturas]Abreviación;aAbrev;[Asignaturas]Numero_del_Nivel;$aNivelNumero;[Asignaturas]Nivel;aNivelNombre;[Asignaturas]Curso;aCurso;[Asignaturas]Denominación_interna;aNombre;[Asignaturas]Numero_de_alumnos;aNumDeAlumnos)
  //SELECTION TO ARRAY([Asignaturas]PorcentajeAprobados;aAprobacion;[Asignaturas_SintesisAnual]PromedioFinal_Literal;aPromedio;[Asignaturas_SintesisAnual]PromedioOficial_Literal;aPromOficial;[Asignaturas]EVAPR_IdMatriz;aIDMatriz)
  //SELECTION TO ARRAY([Asignaturas];aRecNums;[Profesores]Apellidos_y_nombres;aNombreProfesor;[Profesores]Numero;$aIDProfesor)
  //SET AUTOMATIC RELATIONS(False;False)

  //For ($i;1;Size of array($aNivelNumero))
  //$nivelNumber:=$aNivelNumero{$i}
  //$attMode:=KRL_GetNumericFieldData (->[xxSTR_Niveles]NoNivel;->$nivelNumber;->[xxSTR_Niveles]AttendanceMode)
  //APPEND TO ARRAY(aAttMode;$attMode)
  //End for 

  //AT_DistinctsArrayValues (->$aIDProfesor)
  //If (Size of array($aIDProfesor)>1)
  //$vbMostrarProfe:=True
  //Else 
  //If (Size of array($aIDProfesor)=1)
  //If ($aIDProfesor{1}#$profID)
  //$vbMostrarProfe:=True
  //Else 
  //$vbMostrarProfe:=False
  //End if 
  //Else 
  //$vbMostrarProfe:=False
  //End if 
  //End if 

  //$sortString:=PREF_fGet ($userID;"OrdenamientoPanel#"+String(vlBWR_SelectedTableRef))

  //If ($sortString#"")
  //ARRAY LONGINT($aOrders;0)
  //ARRAY LONGINT($aOrders;Size of array($aFieldPtrs))
  //ARRAY LONGINT($ordenadora2;0)
  //ARRAY TEXT($sortCols;0)
  //AT_Text2Array (->$sortCols;$sortString;";")
  //For ($j;2;Size of array($sortCols))
  //$order2array:=Num($sortCols{$j})/Abs(Num($sortCols{$j}))
  //$orderArrayIndex:=Abs(Num($sortCols{$j}))
  //  //If ($orderArrayIndex>5)
  //  //  `$orderArrayIndex:=$orderArrayIndex-1
  //  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //End for 
  //AT_OrderArraysByArray (MAXINT;->$ordenadora2;->$aOrdenador;->$aArrayPtrs;->$aOrders;->$aNames;->$aFormats)
  //MULTI SORT ARRAY($aArrayPtrs;$aOrders)
  //Else 
  //$orderCriteria:=ST_CountWords (vtBWR_sortOrder;1;",")
  //Case of 
  //: ($ordercriteria>=6)
  //ARRAY LONGINT($ordenadora2;0)
  //ARRAY LONGINT($aOrders;0)
  //ARRAY LONGINT($aOrders;Size of array($aFieldPtrs))
  //$orden1:=Num(ST_GetWord (vtBWR_sortOrder;1;","))
  //$order2array:=$orden1/Abs($orden1)
  //$orderArrayIndex:=Abs($orden1)
  //If ($orden1>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden2:=Num(ST_GetWord (vtBWR_sortOrder;2;","))
  //$order2array:=$orden2/Abs($orden2)
  //$orderArrayIndex:=Abs($orden2)
  //If ($orden2>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden3:=Num(ST_GetWord (vtBWR_sortOrder;3;","))
  //$order2array:=$orden3/Abs($orden3)
  //$orderArrayIndex:=Abs($orden3)
  //If ($orden3>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden4:=Num(ST_GetWord (vtBWR_sortOrder;4;","))
  //$order2array:=$orden4/Abs($orden4)
  //$orderArrayIndex:=Abs($orden4)
  //If ($orden4>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden5:=Num(ST_GetWord (vtBWR_sortOrder;5;","))
  //$order2array:=$orden5/Abs($orden5)
  //$orderArrayIndex:=Abs($orden5)
  //If ($orden5>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden6:=Num(ST_GetWord (vtBWR_sortOrder;6;","))
  //$order2array:=$orden6/Abs($orden6)
  //$orderArrayIndex:=Abs($orden6)
  //If ($orden6>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //: ($ordercriteria=5)
  //ARRAY LONGINT($ordenadora2;0)
  //ARRAY LONGINT($aOrders;0)
  //ARRAY LONGINT($aOrders;Size of array($aFieldPtrs))
  //$orden1:=Num(ST_GetWord (vtBWR_sortOrder;1;","))
  //$order2array:=$orden1/Abs($orden1)
  //$orderArrayIndex:=Abs($orden1)
  //If ($orden1>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden2:=Num(ST_GetWord (vtBWR_sortOrder;2;","))
  //$order2array:=$orden2/Abs($orden2)
  //$orderArrayIndex:=Abs($orden2)
  //If ($orden2>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden3:=Num(ST_GetWord (vtBWR_sortOrder;3;","))
  //$order2array:=$orden3/Abs($orden3)
  //$orderArrayIndex:=Abs($orden3)
  //If ($orden3>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden4:=Num(ST_GetWord (vtBWR_sortOrder;4;","))
  //$order2array:=$orden4/Abs($orden4)
  //$orderArrayIndex:=Abs($orden4)
  //If ($orden4>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden5:=Num(ST_GetWord (vtBWR_sortOrder;5;","))
  //$order2array:=$orden5/Abs($orden5)
  //$orderArrayIndex:=Abs($orden5)
  //If ($orden5>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //: ($ordercriteria=4)
  //ARRAY LONGINT($ordenadora2;0)
  //ARRAY LONGINT($aOrders;0)
  //ARRAY LONGINT($aOrders;Size of array($aFieldPtrs))
  //$orden1:=Num(ST_GetWord (vtBWR_sortOrder;1;","))
  //$order2array:=$orden1/Abs($orden1)
  //$orderArrayIndex:=Abs($orden1)
  //If ($orden1>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden2:=Num(ST_GetWord (vtBWR_sortOrder;2;","))
  //$order2array:=$orden2/Abs($orden2)
  //$orderArrayIndex:=Abs($orden2)
  //If ($orden2>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden3:=Num(ST_GetWord (vtBWR_sortOrder;3;","))
  //$order2array:=$orden3/Abs($orden3)
  //$orderArrayIndex:=Abs($orden3)
  //If ($orden3>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden4:=Num(ST_GetWord (vtBWR_sortOrder;4;","))
  //$order2array:=$orden4/Abs($orden4)
  //$orderArrayIndex:=Abs($orden4)
  //If ($orden4>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //: ($ordercriteria=3)
  //ARRAY LONGINT($ordenadora2;0)
  //ARRAY LONGINT($aOrders;0)
  //ARRAY LONGINT($aOrders;Size of array($aFieldPtrs))
  //$orden1:=Num(ST_GetWord (vtBWR_sortOrder;1;","))
  //$order2array:=$orden1/Abs($orden1)
  //$orderArrayIndex:=Abs($orden1)
  //If ($orden1>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden2:=Num(ST_GetWord (vtBWR_sortOrder;2;","))
  //$order2array:=$orden2/Abs($orden2)
  //$orderArrayIndex:=Abs($orden2)
  //If ($orden2>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden3:=Num(ST_GetWord (vtBWR_sortOrder;3;","))
  //$order2array:=$orden3/Abs($orden3)
  //$orderArrayIndex:=Abs($orden3)
  //If ($orden3>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //: ($ordercriteria=2)
  //ARRAY LONGINT($ordenadora2;0)
  //ARRAY LONGINT($aOrders;0)
  //ARRAY LONGINT($aOrders;Size of array($aFieldPtrs))
  //$orden1:=Num(ST_GetWord (vtBWR_sortOrder;1;","))
  //$order2array:=$orden1/Abs($orden1)
  //$orderArrayIndex:=Abs($orden1)
  //If ($orden1>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //$orden2:=Num(ST_GetWord (vtBWR_sortOrder;2;","))
  //$order2array:=$orden2/Abs($orden2)
  //$orderArrayIndex:=Abs($orden2)
  //If ($orden2>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //: ($ordercriteria=1)
  //ARRAY LONGINT($ordenadora2;0)
  //ARRAY LONGINT($aOrders;0)
  //ARRAY LONGINT($aOrders;Size of array($aFieldPtrs))
  //$orden1:=Num(ST_GetWord (vtBWR_sortOrder;1;","))
  //$order2array:=$orden1/Abs($orden1)
  //$orderArrayIndex:=Abs($orden1)
  //If ($orden1>5)
  //$orderArrayIndex:=$orderArrayIndex-1
  //End if 
  //APPEND TO ARRAY($ordenadora2;$orderArrayIndex)
  //$aOrders{$orderArrayIndex}:=$order2array
  //End case 
  //AT_OrderArraysByArray (MAXINT;->$ordenadora2;->$aOrdenador;->$aArrayPtrs;->$aOrders;->$aNames;->$aFormats)
  //MULTI SORT ARRAY($aArrayPtrs;$aOrders)
  //End if 

  //$obj:=json_newObject
  //For ($i;1;Size of array($aArrayPtrs))
  //STWA2_json_array2json(->$obj;$aArrayPtrs{$i};$aNames{$i};$aFormats{$i})
  //End for 
  //json_addText(->$obj;ST_Qte (String(Num($vbMostrarProfe)));ST_Qte ("mostrarprofe"))

  //$rnAsig:=-1
  //If ($userID>0)
  //READ ONLY([TMT_Horario])
  //$fecha:=Current date
  //$hora:=Current time
  //QUERY([TMT_Horario];[TMT_Horario]ID_Teacher=$profID)
  //QUERY SELECTION([TMT_Horario];[TMT_Horario]SesionesDesde<=$fecha;*)
  //QUERY SELECTION([TMT_Horario]; & ;[TMT_Horario]SesionesHasta>=$fecha)
  //QUERY SELECTION([TMT_Horario];[TMT_Horario]NumeroDia=DT_GetDayNumber_ISO8601 ($fecha);*)
  //QUERY SELECTION([TMT_Horario]; & [TMT_Horario]Desde<=$hora;*)
  //QUERY SELECTION([TMT_Horario]; & [TMT_Horario]Hasta>=$hora)
  //If (Records in selection([TMT_Horario])>0)
  //FIRST RECORD([TMT_Horario])
  //$idAsig:=[TMT_Horario]ID_Asignatura
  //$rnAsig:=Find in field([Asignaturas]Numero;$idAsig)
  //End if 
  //KRL_UnloadReadOnly (->[TMT_Horario])
  //End if 
  //json_addText(->$obj;ST_Qte (String($rnAsig));ST_Qte ("currentAsig"))

  //$0:=$obj

  //ON ERR CALL($currErrMethod)