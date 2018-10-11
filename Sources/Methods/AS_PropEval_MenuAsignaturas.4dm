//%attributes = {}
  // MÉTODO: AS_PropEval_MenuAsignaturas
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de rediseño: 24/08/11, 19:15:17
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //    Construye la lista desplegable de asignaturas disponibles para consolidación en la asignatura actual
  //    es utilizada al seleccionar un elemento en el area en que se establecen las propiedades de consolidación
  //
  // PARÁMETROS
  // AS_PropEval_MenuAsignaturas()
  // ----------------------------------------------------

  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($l_indexArray;$l_insertSeparatorAt;$l_ItemEncontrado;$l_RecNumAsignaturaMadre)
C_TEXT:C284($t_refPeriodo)
C_LONGINT:C283($i;0)
C_LONGINT:C283($k;0)
ARRAY LONGINT:C221($al_IDsAsignaturasExcluidas;0)
ARRAY LONGINT:C221($al_subAsignatura_ID;0)
ARRAY TEXT:C222($at_AS_EvalPropSourceName;0)
ARRAY TEXT:C222($at_AS_EvalPropSourceName0;0)
ARRAY REAL:C219($ar_AS_EvalPropPonderacion;0)
ARRAY TEXT:C222($at_AS_EvalPropClassName;0)
ARRAY LONGINT:C221($al_AS_EvalPropSourceID;0)
ARRAY LONGINT:C221($al_AS_EvalPropEnterable;0)
ARRAY REAL:C219($ar_AS_EvalPropPercent;0)
ARRAY REAL:C219($ar_AS_EvalPropCoefficient;0)
ARRAY BOOLEAN:C223($ab_AS_EvalPropPrintDetail;0)
ARRAY TEXT:C222($at_AS_EvalPropPrintName;0)
ARRAY TEXT:C222($at_AS_EvalPropDescription;0)
ARRAY TEXT:C222($at_subasignatura_Nombre;0)



  //ASM agrego para poder utilizar desde STWA
$b_SubTodas:=False:C215
If (Count parameters:C259=2)
	$b_SubTodas:=$2
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$1)
	lConsID:=[Asignaturas:18]Numero:1
	lConsNivel:=[Asignaturas:18]Numero_del_Nivel:6
	sConsClass:=[Asignaturas:18]Curso:5
End if 


  // CODIGO PRINCIPAL

  // PASO 1:
  //      CONSTRUCCION DE LA LISTA DE ASIGNATURAS A EXCLUIR DE LA LISTA DESPLEGABLE
  //      construir una lista de asignaturas relacionadas que deben ser excluidas de la lista desplegable:
  //      si la asignatura actual es hija de otra asignatura se debe evitar que se pueda asignar
  //      a la asignatura actual la hija de una asignatura hermana (hija de la misma madre)

  // en el arreglo $al_IDsAsignaturasExcluidas ponemos todas las madres relacionadas (incluyendo esta misma)
$l_RecNumAsignaturaMadre:=Record number:C243([Asignaturas:18])
APPEND TO ARRAY:C911($al_IDsAsignaturasExcluidas;[Asignaturas:18]Numero:1)

  //      agregamos al arreglo $al_IDsAsignaturasExcluidas todas las asignaturas madres en las que la asignatura actual puede consolidar (puede no haber ninguna)
AScsd_LeeReferencias ([Asignaturas:18]Numero:1)
$n:=Records in selection:C76([Asignaturas_Consolidantes:231])
While (Not:C34(End selection:C36([Asignaturas_Consolidantes:231])))
	$fia:=Find in array:C230($al_IDsAsignaturasExcluidas;[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1)
	If ($fia=-1)
		APPEND TO ARRAY:C911($al_IDsAsignaturasExcluidas;[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1)
	End if 
	NEXT RECORD:C51([Asignaturas_Consolidantes:231])
End while 

  //      copiamos los arreglos de propiedades de evaluación de la asignatura actual para
  //      poder reestablecerlos al terminar el análisis de asignaturas relacionadas
COPY ARRAY:C226(atAS_EvalPropSourceName;$at_AS_EvalPropSourceName)
COPY ARRAY:C226(atAS_EvalPropClassName;$at_AS_EvalPropClassName)  //destination class
COPY ARRAY:C226(alAS_EvalPropSourceID;$al_AS_EvalPropSourceID)  //id destination
COPY ARRAY:C226(aiAS_EvalPropEnterable;$al_AS_EvalPropEnterable)  //method
COPY ARRAY:C226(arAS_EvalPropPercent;$ar_AS_EvalPropPercent)  //grade weight
COPY ARRAY:C226(arAS_EvalPropCoefficient;$ar_AS_EvalPropCoefficient)  //coefficient
COPY ARRAY:C226(abAS_EvalPropPrintDetail;$ab_AS_EvalPropPrintDetail)  //print on reports
COPY ARRAY:C226(atAS_EvalPropPrintName;$at_AS_EvalPropPrintName)  //print as
COPY ARRAY:C226(atAS_EvalPropDescription;$at_AS_EvalPropDescription)  //description
COPY ARRAY:C226(adAS_EvalPropDueDate;$ad_AS_EvalPropDueDate)  //due date  
COPY ARRAY:C226(arAS_EvalPropPonderacion;$ar_AS_EvalPropPonderacion)


  //      para cada una de las eventuales madres que pueden estar relacionadas como hermanas
  //      leemos las propiedades de evaluación y ponemos todas sus hijas en la lista de exclusiones
$l_indexArray:=1  //aclarar con Daniel porque usa este contador 
For ($i;1;Size of array:C274($al_IDsAsignaturasExcluidas))
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_IDsAsignaturasExcluidas{$l_indexArray})
	
	If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
		AS_PropEval_Lectura ("";aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
		For ($k;1;Size of array:C274(alAS_EvalPropSourceID))
			If (alAS_EvalPropSourceID{$k}>0)
				$l_ItemEncontrado:=Find in array:C230($al_IDsAsignaturasExcluidas;alAS_EvalPropSourceID{$k})
				If ($l_ItemEncontrado=-1)
					APPEND TO ARRAY:C911($al_IDsAsignaturasExcluidas;alAS_EvalPropSourceID{$k})
					$i:=$i-1
				End if 
			End if 
		End for 
		
	Else 
		AS_PropEval_Lectura 
		For ($k;1;Size of array:C274(alAS_EvalPropSourceID))
			If (alAS_EvalPropSourceID{$k}>0)
				$l_ItemEncontrado:=Find in array:C230($al_IDsAsignaturasExcluidas;alAS_EvalPropSourceID{$k})
				If ($l_ItemEncontrado=-1)
					APPEND TO ARRAY:C911($al_IDsAsignaturasExcluidas;alAS_EvalPropSourceID{$k})
					$i:=$i-1
				End if 
			End if 
		End for 
	End if 
	
	$l_indexArray:=$l_indexArray+1
End for 
  // Fin PASO 1

  // PASO 2
  //      BUSCAMOS LAS ASIGNATURAS QUE PODRIAN CONSOLIDAR EN LA ASIGNATURA ACTUAL
GOTO RECORD:C242([Asignaturas:18];$l_RecNumAsignaturaMadre)
If (Not:C34(Shift down:C543))
	Case of 
			
			  //      si la asignatura est limitada a los alumnos del curso y no es electiva retenemos solo las
			  //      asignaturas del curso o asignaturas no limitadas comunes en el nivel ([Asignaturas]Seleccion=True)
		: (([Asignaturas:18]Seleccion:17=False:C215) & ([Asignaturas:18]Electiva:11=False:C215))
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1#lConsID;*)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Seleccion:17=True:C214;*)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=lConsNivel)
			CREATE SET:C116([Asignaturas:18];"asigs")
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1#lConsID;*)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Curso:5=sConsClass;*)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=lConsNivel)
			CREATE SET:C116([Asignaturas:18];"asigs2")
			UNION:C120("asigs";"asigs2";"asigs")
			USE SET:C118("asigs")
			CLEAR SET:C117("asigs")
			CLEAR SET:C117("asigs2")
			
			  //      si la madre es electiva, las hijas solo pueden ser electivas
			  //      (podria ser necesario que no fuera asi, lo dejo por ahora)
		: ([Asignaturas:18]Electiva:11=True:C214)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=lConsNivel;*)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Electiva:11=True:C214)
			
			
		: ([Asignaturas:18]Seleccion:17=True:C214)
			QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=lConsNivel)
			  //QUERY SELECTION([Asignaturas];[Asignaturas]Seleccion=True)
	End case 
	
Else 
	
	  //si el usuario mantiene presionada la tecla shift ponemos todas las asignaturas del nivel en la lista
	  // solo debiera utilizarse cuando sea necesario corregir errores de asignacion
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1#lConsID)
	QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero_del_Nivel:6=lConsNivel)
	
End if 

  // FIN PASO 2

  //PASO 3
  //      EXCLUIMOS LAS ASIGNATURAS RELACIONADAS DE LA LISTA DE DE ASIGNATURAS DISPONIBLES PARA CONSOLIDACION
CREATE SET:C116([Asignaturas:18];"a1")
QRY_QueryWithArray (->[Asignaturas:18]Numero:1;->$al_IDsAsignaturasExcluidas;True:C214)
CREATE SET:C116([Asignaturas:18];"a2")
DIFFERENCE:C122("a1";"a2";"a3")
USE SET:C118("a3")
SET_ClearSets ("a1";"a2";"a3")

  //      creamos los arreglos para construir la lista desplegable
SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;<>aSAsgName;[Asignaturas:18]Curso:5;<>aSAsgClass;[Asignaturas:18]Numero:1;<>aSAsgID)

  //      remplazo de caracteres invalidos en la lista desplegable
For ($i;1;Size of array:C274(<>aSAsgName))
	<>aSAsgName{$i}:=Replace string:C233(<>aSAsgName{$i};"/";" | ")
	<>aSAsgName{$i}:=Replace string:C233(<>aSAsgName{$i};"(";"[")
	<>aSAsgName{$i}:=Replace string:C233(<>aSAsgName{$i};")";"]")
	<>aSAsgName{$i}:=Replace string:C233(<>aSAsgName{$i};"\r";"")
	<>aSAsgName{$i}:=Replace string:C233(<>aSAsgName{$i};"-";"–")
	<>aSAsgClass{$i}:=Replace string:C233(<>aSAsgClass{$i};"/";" | ")
	<>aSAsgClass{$i}:=Replace string:C233(<>aSAsgClass{$i};"(";"[")
	<>aSAsgClass{$i}:=Replace string:C233(<>aSAsgClass{$i};")";"]")
	<>aSAsgClass{$i}:=Replace string:C233(<>aSAsgClass{$i};"\r";"")
	If (<>aSAsgClass{$i}#[Asignaturas:18]Curso:5)
		<>aSAsgName{$i}:=<>aSAsgName{$i}+" ["+<>aSAsgClass{$i}+"]"
	End if 
	If (<>aSAsgID{$i}=lConsID)
		<>aSAsgName{$i}:="("+<>aSAsgName{$i}
	End if 
End for 
SORT ARRAY:C229(<>aSAsgName;<>aSAsgClass;<>aSAsgID;>)

  //  // excluyo las asignaturas que consolidan en otras asignaturas
  //For ($i;Size of array(<>aSAsgID);1;-1)
  //READ ONLY([Asignaturas_Consolidantes])
  //QUERY([Asignaturas_Consolidantes];[Asignaturas_Consolidantes]ID_ParentRecord;=;<>aSAsgID{$i})
  //If (vb_CsdVariable)
  //QUERY SELECTION([Asignaturas_Consolidantes];[Asignaturas_Consolidantes]Periodo;=;String(vlSTR_PeriodoSeleccionado);*)
  //QUERY SELECTION([Asignaturas_Consolidantes]; | [Asignaturas_Consolidantes]Periodo;=;"";*)
  //QUERY SELECTION([Asignaturas_Consolidantes]; | [Asignaturas_Consolidantes]Periodo;=;"0")
  //Else 
  //QUERY SELECTION([Asignaturas_Consolidantes];[Asignaturas_Consolidantes]Periodo="";*)
  //QUERY SELECTION([Asignaturas_Consolidantes]; | [Asignaturas_Consolidantes]Periodo="0";*)
  //QUERY SELECTION([Asignaturas_Consolidantes]; | [Asignaturas_Consolidantes]Periodo#"")
  //End if 
  //If (Records in selection([Asignaturas_Consolidantes])>0)
  //AT_Delete ($i;1;-><>aSAsgName;-><>aSAsgClass;-><>aSAsgID)
  //End if 
  //End for 


vt_MenuAsignaturasConsolidables:=Create menu:C408
ORDER BY:C49([Asignaturas:18];[Asignaturas:18]denominacion_interna:16;>;[Asignaturas:18]Curso:5)
SELECTION TO ARRAY:C260([Asignaturas:18]denominacion_interna:16;$at_NombreInterno;[Asignaturas:18]Curso:5;$at_Curso;[Asignaturas:18]Numero:1;$al_IdAsignatura)
For ($i;1;Size of array:C274($at_NombreInterno))
	$t_itemMenu:=Replace string:C233($at_NombreInterno{$i};"-";"")+", "+$at_Curso{$i}
	APPEND MENU ITEM:C411(vt_MenuAsignaturasConsolidables;$t_itemMenu;*)
	SET MENU ITEM PARAMETER:C1004(vt_MenuAsignaturasConsolidables;-1;"AS"+String:C10($al_IdAsignatura{$i}))
End for 




  // Fin PASO 3

  // PASO 4
  //      ANADIMOS A LA LISTA DESPLEGABLES LAS EVENTUALES SUBASIGNATURAS DE LA ASIGNATURA
$l_insertSeparatorAt:=0
QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=lConsID)

  //MONO 148395  este código no dejaba disponibles las subasignaturas que se quitaron y fueron conservadas.
  //If (vb_CsdVariable)
  //$t_refPeriodo:="@/"+String(atSTR_Periodos_Nombre)
  //QUERY SELECTION([xxSTR_Subasignaturas]; & [xxSTR_Subasignaturas]Periodo=$t_refPeriodo)
  //Else 
  //REDUCE SELECTION([xxSTR_Subasignaturas];1)
  //End if 

  // ASM Verifico las SubAsignaturas que se pueden utilizar
  //CREATE SET([xxSTR_Subasignaturas];"TodasSubasignaturas")
  //QRY_QueryWithArray (->[xxSTR_Subasignaturas]LongID;->$al_AS_EvalPropSourceID;True)
  //CREATE SET([xxSTR_Subasignaturas];"QuitarSubasignaturas")

  //DIFFERENCE("TodasSubasignaturas";"QuitarSubasignaturas";"SubAsigUtilizar")
  //USE SET("SubAsigUtilizar")

  //MONO corrección 148395 
If (Not:C34($b_SubTodas))
	$t_refPeriodo:="@/"+String:C10(atSTR_Periodos_Nombre)
	QUERY SELECTION:C341([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Periodo:12=$t_refPeriodo)  //siempre filtro por el periodo por que si no muestra n asignaturas por todos los periodos
End if 
QUERY SELECTION:C341([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Columna:13=0)  // las subasignaturas con columna 0 son las no asignadas.
CREATE SET:C116([xxSTR_Subasignaturas:83];"SubAsigUtilizar")
USE SET:C118("SubAsigUtilizar")


  //ASM comento el código porque no es necesario utilizar submenu

  //vt_MenuSubasignaturas:=Create menu
  //APPEND MENU ITEM(vt_MenuSubasignaturas;"Nueva subasignatura...";*)
  //SET MENU ITEM PARAMETER(vt_MenuSubasignaturas;-1;"NuevaSubasignatura")
  //
  //If (Records in selection([xxSTR_Subasignaturas])>0)
  //APPEND MENU ITEM(vt_MenuSubasignaturas;"-")
  //
  //$l_insertSeparatorAt:=Size of array(<>aSAsgName)+1  // Size of array(aCsdPop)
  //SELECTION TO ARRAY([xxSTR_Subasignaturas]LongID;$al_subAsignatura_ID;[xxSTR_Subasignaturas]Name;$at_subasignatura_Nombre)
  //SORT ARRAY($at_subasignatura_Nombre;$al_subAsignatura_ID;>)
  //
  //For ($i;Size of array($at_subasignatura_Nombre);1;-1)
  //If ($at_subasignatura_Nombre{$i}=$at_subasignatura_Nombre{$i-1})
  //AT_Delete ($i;1;->$at_subasignatura_Nombre;->$al_subAsignatura_ID)
  //End if 
  //End for 
  //
  //For ($i_Items;1;Size of array($at_subasignatura_Nombre))
  //APPEND MENU ITEM(vt_MenuSubasignaturas;$at_subasignatura_Nombre{$i_Items};*)
  //SET MENU ITEM PARAMETER(vt_MenuSubasignaturas;-1;"SUB"+String($al_subAsignatura_ID{$i_Items}))
  //End for 
  //End if 



vt_MenuConsolidacion:=Create menu:C408
APPEND MENU ITEM:C411(vt_MenuConsolidacion;__ ("Evaluación ingresable"))
SET MENU ITEM PARAMETER:C1004(vt_MenuConsolidacion;-1;"1")
APPEND MENU ITEM:C411(vt_MenuConsolidacion;__ ("No Ingresable"))
SET MENU ITEM PARAMETER:C1004(vt_MenuConsolidacion;-1;"0")
APPEND MENU ITEM:C411(vt_MenuConsolidacion;"-")
APPEND MENU ITEM:C411(vt_MenuConsolidacion;"Asignaturas consolidables";vt_MenuAsignaturasConsolidables)
  //APPEND MENU ITEM(vt_MenuConsolidacion;"Subasignaturas";vt_MenuSubasignaturas)



  // PASO 5
  //      AGREGAMOS ALGUNAS OPCIONES ADICIONALES A LA LISTA DESPLEGABLE DE ASIGNATURAS
ARRAY TEXT:C222(aRefSubAsignatura;0)
COPY ARRAY:C226(<>aSAsgID;aCsdPopID)
COPY ARRAY:C226(<>aSAsgName;aCsdPop)
AT_RedimArrays (Size of array:C274(aCsdPopID);->aRefSubAsignatura)
  //If ($l_insertSeparatorAt>0)
If (Records in set:C195("SubAsigUtilizar")>0)
	  //AT_Insert ($l_insertSeparatorAt;2;->aCsdPop;->aCsdPopID)
	  //aCsdPop{$l_insertSeparatorAt}:="-"
	  //aCsdPopID{$l_insertSeparatorAt}:=0
	  //aCsdPop{$l_insertSeparatorAt+1}:="(Subasignaturas"
	  //aCsdPopID{$l_insertSeparatorAt+1}:=0
	
	APPEND TO ARRAY:C911(aCsdPop;"-")
	APPEND TO ARRAY:C911(aCsdPopID;0)
	APPEND TO ARRAY:C911(aCsdPop;"(Subasignaturas")
	APPEND TO ARRAY:C911(aCsdPopID;0)
	
	
	  // ASM Agrego al menu las subAsignaturas seleccionables.
	USE SET:C118("SubAsigUtilizar")
	AT_RedimArrays (Size of array:C274(aCsdPopID);->aRefSubAsignatura)
	While (Not:C34(End selection:C36([xxSTR_Subasignaturas:83])))
		APPEND TO ARRAY:C911(aCsdPopID;[xxSTR_Subasignaturas:83]LongID:7)
		APPEND TO ARRAY:C911(aCsdPop;[xxSTR_Subasignaturas:83]Name:2)
		APPEND TO ARRAY:C911(aRefSubAsignatura;[xxSTR_Subasignaturas:83]Referencia:11)  //Para STWA
		APPEND TO ARRAY:C911(<>aSAsgID;[xxSTR_Subasignaturas:83]LongID:7)
		APPEND TO ARRAY:C911(<>aSAsgName;[xxSTR_Subasignaturas:83]Name:2)
		APPEND TO ARRAY:C911(<>aSAsgClass;"")
		NEXT RECORD:C51([xxSTR_Subasignaturas:83])
	End while 
	
End if 

AT_Insert (1;6;->aCsdPop;->aCsdPopID;->aRefSubAsignatura)
aCsdPop{1}:="Evaluación ingresable"
aCsdPop{2}:="-"
aCsdPop{3}:=__ ("No ingresable")
aCsdPop{4}:="-"
aCsdPop{5}:=__ ("Nueva Sub-asignatura...")
aCsdPop{6}:="-"

GOTO RECORD:C242([Asignaturas:18];$l_RecNumAsignaturaMadre)
  //      Restablecemos los arreglos con las propiedades de evaluación de la asignatura actual
COPY ARRAY:C226($at_AS_EvalPropSourceName;atAS_EvalPropSourceName)
COPY ARRAY:C226($at_AS_EvalPropClassName;atAS_EvalPropClassName)  //destination class
COPY ARRAY:C226($al_AS_EvalPropSourceID;alAS_EvalPropSourceID)  //id destination
COPY ARRAY:C226($al_AS_EvalPropEnterable;aiAS_EvalPropEnterable)  //method
COPY ARRAY:C226($ar_AS_EvalPropPercent;arAS_EvalPropPercent)  //grade weight
COPY ARRAY:C226($ar_AS_EvalPropCoefficient;arAS_EvalPropCoefficient)  //coefficient
COPY ARRAY:C226($ab_AS_EvalPropPrintDetail;abAS_EvalPropPrintDetail)  //print on reports
COPY ARRAY:C226($at_AS_EvalPropPrintName;atAS_EvalPropPrintName)  //print as
COPY ARRAY:C226($at_AS_EvalPropDescription;atAS_EvalPropDescription)  //description
COPY ARRAY:C226($ad_AS_EvalPropDueDate;adAS_EvalPropDueDate)  //due date  
COPY ARRAY:C226($ar_AS_EvalPropPonderacion;arAS_EvalPropPonderacion)

SET_ClearSets ("TodasSubasignaturas";"QuitarSubasignaturas";"SubAsigUtilizar")
