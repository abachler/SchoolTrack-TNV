//%attributes = {}
  // MÉTODO: AS_PropEval_Configura
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 26/12/11, 11:14:46
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Abre el cuadro de diálogo de propiedades de evaluación
  // si las modificaciones intrioducidas demandan el recalculo de promedios se llama al método EV2dbu_Recalculos
  //
  // PARÁMETROS
  // AS_SetEvalProperties()
  // ----------------------------------------------------
C_BLOB:C604($x_RecNumsArray)
C_BOOLEAN:C305($b_consolida;$b_isReadWrite;$b_conSubasignaturas)
C_LONGINT:C283($l_Asignatura_ID)
C_LONGINT:C283($i;$j)
C_TEXT:C284($t_Profesor_NombreComun)
C_TEXT:C284($t_NombreRegistroPropiedades;$t_tituloVentana)

ARRAY LONGINT:C221($al_RecNumsAsignaturas;0)
  //MONO ticket 175179
C_OBJECT:C1216($o_opciones)
C_BOOLEAN:C305($b_blockPropEva)

  // CODIGO PRINCIPAL
ARRAY TEXT:C222(<>aSAsgName;0)  //source name
ARRAY TEXT:C222(<>aSAsgClass;0)  //source class
ARRAY TEXT:C222(aCsdPop;0)  //area list entry popup
ARRAY TEXT:C222(atSTR_EventLog;0)
ARRAY LONGINT:C221(aCsdPopID;0)  //area list entry popup
SAVE RECORD:C53([Asignaturas:18])

IT_MODIFIERS 
ARRAY TEXT:C222(atAS_EvalPropSourceName;0)  //destination name
ARRAY TEXT:C222(atAS_EvalPropClassName;0)  //destination class
ARRAY LONGINT:C221(alAS_EvalPropSourceID;0)  //id destination
ARRAY LONGINT:C221(aiAS_EvalPropEnterable;0)  //method
ARRAY REAL:C219(arAS_EvalPropPercent;0)  //grade weight
ARRAY REAL:C219(arAS_EvalPropCoefficient;0)  //coefficient
ARRAY BOOLEAN:C223(abAS_EvalPropPrintDetail;0)  //print on reports
ARRAY TEXT:C222(atAS_EvalPropPrintName;0)  //print as
ARRAY TEXT:C222(atAS_EvalPropDescription;0)  //description
ARRAY DATE:C224(adAS_EvalPropDueDate;0)  //due date  
ARRAY REAL:C219(arAS_EvalPropPonderacion;0)
ARRAY TEXT:C222(atAS_EvalPropSourceName;12)  //destination name
ARRAY TEXT:C222(atAS_EvalPropClassName;12)  //destination class
ARRAY LONGINT:C221(alAS_EvalPropSourceID;12)  //id destination
ARRAY LONGINT:C221(aiAS_EvalPropEnterable;12)  //method
ARRAY REAL:C219(arAS_EvalPropPercent;12)  //grade weight
ARRAY REAL:C219(arAS_EvalPropCoefficient;12)  //coefficient
ARRAY BOOLEAN:C223(abAS_EvalPropPrintDetail;12)  //print on reports
ARRAY TEXT:C222(atAS_EvalPropPrintName;12)  //print as
ARRAY TEXT:C222(atAS_EvalPropDescription;12)  //description
ARRAY DATE:C224(adAS_EvalPropDueDate;12)  //due date  
ARRAY REAL:C219(arAS_EvalPropPonderacion;12)

  //MONO- Bloqueo de Parciales
ARRAY DATE:C224(ad_BloqueoParcial_p1;0)
ARRAY DATE:C224(ad_BloqueoParcial_p2;0)
ARRAY DATE:C224(ad_BloqueoParcial_p3;0)
ARRAY DATE:C224(ad_BloqueoParcial_p4;0)
ARRAY DATE:C224(ad_BloqueoParcial_p5;0)

vl_RecNumAsignatura:=Record number:C243([Asignaturas:18])
$b_isReadWrite:=Not:C34(Read only state:C362([Asignaturas:18]))

  //READ ONLY([Asignaturas])
  //QUERY([Asignaturas];[Asignaturas]No=◊L_ConsID)
lConsID:=[Asignaturas:18]Numero:1
sConsName:=[Asignaturas:18]denominacion_interna:16
vlSTR_IDProfesor:=[Asignaturas:18]profesor_numero:4
$t_Profesor_NombreComun:=[Profesores:4]Nombre_comun:21
$l_Asignatura_ID:=[Asignaturas:18]Numero:1
lConsNivel:=[Asignaturas:18]Numero_del_Nivel:6
vb_ConsSel:=[Asignaturas:18]Seleccion:17
sConsClass:=[Asignaturas:18]Curso:5
vi_Metodo:=[Asignaturas:18]Consolidacion_Metodo:55
vb_CsdVariable:=[Asignaturas:18]Consolidacion_PorPeriodo:58
vlAS_CalcMethod:=[Asignaturas:18]Consolidacion_TipoPonderacion:50

r1:=Num:C11(vb_CsdVariable=False:C215)
r2:=Num:C11(vb_CsdVariable=True:C214)

vt_UltimasPropiedadesLeidas:=""
AS_PropEval_Lectura ("";aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
AS_PropEval_MenuAsignaturas 
READ ONLY:C145([Asignaturas:18])
GOTO RECORD:C242([Asignaturas:18];vl_RecNumAsignatura)
AS_PropEval_Lectura ("";aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
vbRecalcPromedios:=False:C215
If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
End if 
$t_tituloVentana:="Propiedades de evaluación de "+sConsName+" ("+sConsClass+")"
START TRANSACTION:C239
If (Is compiled mode:C492)
	WDW_OpenFormWindow (->[Asignaturas:18];"Propiedades_Evaluación";-1;Movable form dialog box:K39:8;__ ("Propiedades de evaluación"))
Else 
	WDW_OpenFormWindow (->[Asignaturas:18];"Propiedades_Evaluación";-1;4;__ ("Propiedades de evaluación"))
End if 
DIALOG:C40([Asignaturas:18];"Propiedades_Evaluación")
CLOSE WINDOW:C154
  //WDW_OpenDialogInDrawer (->[Asignaturas];"Propiedades_Evaluación")

If (<>vb_BloquearModifSituacionFinal)
	CANCEL TRANSACTION:C241
Else 
	If (ok=1)
		VALIDATE TRANSACTION:C240
		KRL_GotoRecord (->[Asignaturas:18];vl_RecNumAsignatura;False:C215)
		EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		If (vb_CsdVariable)
			$b_consolida:=False:C215
			$b_conSubasignaturas:=False:C215
			For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
				  //MONO CAMBIO AS_PropEval_Lectura
				$t_NombreRegistroPropiedades:="P"+String:C10($i)
				AS_PropEval_Lectura ($t_NombreRegistroPropiedades)
				For ($j;1;Size of array:C274(alAS_EvalPropSourceID))
					Case of 
						: (alAS_EvalPropSourceID{$j}>0)
							$b_consolida:=True:C214
						: (alAS_EvalPropSourceID{$j}<0)
							$b_conSubasignaturas:=True:C214
					End case 
				End for 
			End for 
		Else 
			  //$t_NombreRegistroPropiedades:="Blob_ConfigNotas/"+String([Asignaturas]Numero)
			AS_PropEval_Lectura ("Anual")  //MONO CAMBIO AS_PropEval_Lectura
			$b_consolida:=False:C215
			$b_conSubasignaturas:=False:C215
			For ($j;1;Size of array:C274(alAS_EvalPropSourceID))
				Case of 
					: (alAS_EvalPropSourceID{$j}>0)
						$b_consolida:=True:C214
					: (alAS_EvalPropSourceID{$j}<0)
						$b_conSubasignaturas:=True:C214
				End case 
			End for 
		End if 
		
		READ WRITE:C146([Asignaturas:18])
		KRL_GotoRecord (->[Asignaturas:18];vl_RecNumAsignatura;True:C214)
		[Asignaturas:18]Consolidacion_EsConsolidante:35:=($b_consolida | $b_conSubasignaturas)
		[Asignaturas:18]Consolidacion_ConSubasignaturas:31:=$b_conSubasignaturas
		[Asignaturas:18]Consolidacion_Metodo:55:=vi_metodo
		[Asignaturas:18]Consolidacion_PorPeriodo:58:=vb_CsdVariable
		[Asignaturas:18]Consolidacion_TipoPonderacion:50:=vlAS_CalcMethod
		
		  //MONO ticket 175179
		$o_opciones:=[Asignaturas:18]Opciones:57
		$b_blockPropEva:=Choose:C955(cb_bloqueoPropDeEval=1;True:C214;False:C215)
		OB_SET ($o_opciones;->$b_blockPropEva;"BloqueoPropDeEval")
		[Asignaturas:18]Opciones:57:=$o_opciones
		  // 175179 Ticket 175179 Saúl Ponce, para almacenar si la asignatura está o no bloqueada
		  //[Asignaturas]BloqueoPropDeEval:=Choose(cb_bloqueoPropDeEval=1;True;False)
		
		Case of 
			: (w0iguales=1)
				[Asignaturas:18]Consolidacion_TipoPonderacion:50:=0
			: (w1coeficiente=1)
				[Asignaturas:18]Consolidacion_TipoPonderacion:50:=1
			: (w2porcentaje=1)
				[Asignaturas:18]Consolidacion_TipoPonderacion:50:=2
		End case 
		
		If (([Asignaturas:18]Consolidacion_EsConsolidante:35#Old:C35([Asignaturas:18]Consolidacion_EsConsolidante:35)) | ([Asignaturas:18]Consolidacion_ConSubasignaturas:31#Old:C35([Asignaturas:18]Consolidacion_ConSubasignaturas:31)) | ([Asignaturas:18]Consolidacion_Metodo:55#Old:C35([Asignaturas:18]Consolidacion_Metodo:55)) | ([Asignaturas:18]Consolidacion_PorPeriodo:58#Old:C35([Asignaturas:18]Consolidacion_PorPeriodo:58)) | ([Asignaturas:18]Consolidacion_TipoPonderacion:50#Old:C35([Asignaturas:18]Consolidacion_TipoPonderacion:50)))
			vbRecalcPromedios:=True:C214
		End if 
		
		If (Size of array:C274(atSTR_EventLog)>0)
			For ($i;1;Size of array:C274(atSTR_EventLog))
				  // Ticket 175179
				  // LOG_RegisterEvt ("Asignaturas - Modificación de las propiedades: "+[Asignaturas]Denominación_interna+", "+[Asignaturas]Curso+" - "+atSTR_EventLog{$i};Table(->[Asignaturas]);[Asignaturas]Numero)
				LOG_RegisterEvt (atSTR_EventLog{$i})
			End for 
		End if 
		
		SAVE RECORD:C53([Asignaturas:18])
		KRL_ReloadAsReadOnly (->[Asignaturas:18])
		
		EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
		vl_RecNumAsignatura:=Record number:C243([Asignaturas:18])
		If ((vbRecalcPromedios) & (Records in selection:C76([Alumnos_Calificaciones:208])>0))
			APPEND TO ARRAY:C911($al_RecNumsAsignaturas;Record number:C243([Asignaturas:18]))
			BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_RecNumsAsignaturas)
			EV2dbu_Recalculos ($x_RecNumsArray)
		End if 
		
		AS_FijaNivelJeraquicoHijas (vl_RecNumAsignatura)
		
		KRL_GotoRecord (->[Asignaturas:18];vl_RecNumAsignatura;$b_isReadWrite)
		EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
		
	Else 
		CANCEL TRANSACTION:C241
		KRL_GotoRecord (->[Asignaturas:18];vl_RecNumAsignatura;$b_isReadWrite)
	End if 
End if 

