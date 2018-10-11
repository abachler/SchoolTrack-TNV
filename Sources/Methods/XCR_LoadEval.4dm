//%attributes = {}
  //XCR_LoadEval

If (False:C215)
	<>ST_v461:=False:C215  //10/8/98 at 16:53:36 by: Alberto Bachler
	  //implementación de bimestres
End if 

ARRAY TEXT:C222(aAEXObs;0)
_O_ARRAY STRING:C218(5;aAEXEv1;0)
_O_ARRAY STRING:C218(5;aAEXEv2;0)
_O_ARRAY STRING:C218(5;aAEXEv3;0)
_O_ARRAY STRING:C218(5;aAEXEv4;0)
_O_ARRAY STRING:C218(5;aAEXEv5;0)
_O_ARRAY STRING:C218(5;aAEXEv6;0)
_O_ARRAY STRING:C218(5;aAEXEvF;0)
ARRAY INTEGER:C220(aExIn;0)
ARRAY LONGINT:C221(aAERNs;0)
ARRAY LONGINT:C221(aAEXIDs;0)
C_BOOLEAN:C305($b_modXCRCondorActivo;$permiso)

modXCR:=False:C215
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
READ ONLY:C145([Alumnos_Actividades:28])
QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
QUERY:C277([Alumnos_Actividades:28]; & [Alumnos_Actividades:28]Año:3=<>gYear;*)
QUERY:C277([Alumnos_Actividades:28]; & [Alumnos:2]ocultoEnNominas:89=False:C215)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)


If (Records in selection:C76([Alumnos_Actividades:28])>0)
	QUERY SELECTION BY FORMULA:C207([Alumnos_Actividades:28];(([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0) | ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? vl_PeriodoSeleccionadoActividad)))
	ORDER BY:C49([Alumnos_Actividades:28];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_Actividades:28];aAERNs)
End if 
AL_RemoveArrays (xALP_ActividadesExtra;1;12)
Case of 
	: (atSTR_Periodos_Nombre=1)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]ID:63;aAEXIDs;[Alumnos_Actividades:28]Alumno_Numero:1;$Id;[Alumnos:2]apellidos_y_nombres:40;aAEXName;[Alumnos:2]curso:20;aAEXCso;[Alumnos_Actividades:28]Evaluación_Final_P1:7;aEXEvF;[Alumnos_Actividades:28]Periodo1_Evaluación1:15;aAEXEv1;[Alumnos_Actividades:28]Periodo1_Evaluación2:16;aAEXEv2;[Alumnos_Actividades:28]Periodo1_Evaluación3:17;aAEXEv3;[Alumnos_Actividades:28]Periodo1_Evaluación4:18;aAEXEv4;[Alumnos_Actividades:28]Periodo1_Evaluación5:19;aAEXEv5;[Alumnos_Actividades:28]Periodo1_Evaluación6:20;aAEXEv6;[Alumnos_Actividades:28]Inasistencia_P1:10;aAEXIn;[Alumnos_Actividades:28]Comentarios_P1:6;aAExObs)
	: (atSTR_Periodos_Nombre=2)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]ID:63;aAEXIDs;[Alumnos_Actividades:28]Alumno_Numero:1;$Id;[Alumnos:2]apellidos_y_nombres:40;aAEXName;[Alumnos:2]curso:20;aAEXCso;[Alumnos_Actividades:28]Evaluación_Final_P2:8;aEXEvF;[Alumnos_Actividades:28]Periodo2_Evaluación1:21;aAEXEv1;[Alumnos_Actividades:28]Periodo2_Evaluación2:22;aAEXEv2;[Alumnos_Actividades:28]Periodo2_Evaluación3:23;aAEXEv3;[Alumnos_Actividades:28]Periodo2_Evaluación4:24;aAEXEv4;[Alumnos_Actividades:28]Periodo2_Evaluación5:25;aAEXEv5;[Alumnos_Actividades:28]Periodo2_Evaluación6:26;aAEXEv6;[Alumnos_Actividades:28]Inasistencia_P2:11;aAEXIn;[Alumnos_Actividades:28]Comentarios_P2:13;aAExObs)
	: (atSTR_Periodos_Nombre=3)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]ID:63;aAEXIDs;[Alumnos_Actividades:28]Alumno_Numero:1;$Id;[Alumnos:2]apellidos_y_nombres:40;aAEXName;[Alumnos:2]curso:20;aAEXCso;[Alumnos_Actividades:28]Evaluación_Final_P3:9;aEXEvF;[Alumnos_Actividades:28]Periodo3_Evaluación1:27;aAEXEv1;[Alumnos_Actividades:28]Periodo3_Evaluación2:28;aAEXEv2;[Alumnos_Actividades:28]Periodo3_Evaluación3:29;aAEXEv3;[Alumnos_Actividades:28]Periodo3_Evaluación4:30;aAEXEv4;[Alumnos_Actividades:28]Periodo3_Evaluación5:31;aAEXEv5;[Alumnos_Actividades:28]Periodo3_Evaluación6:32;aAEXEv6;[Alumnos_Actividades:28]Inasistencia_P3:12;aAEXIn;[Alumnos_Actividades:28]Comentarios_P3:14;aAExObs)
	: (atSTR_Periodos_Nombre=4)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]ID:63;aAEXIDs;[Alumnos_Actividades:28]Alumno_Numero:1;$Id;[Alumnos:2]apellidos_y_nombres:40;aAEXName;[Alumnos:2]curso:20;aAEXCso;[Alumnos_Actividades:28]Evaluación_Final_P4:39;aEXEvF;[Alumnos_Actividades:28]Periodo4_Evaluación1:33;aAEXEv1;[Alumnos_Actividades:28]Periodo4_Evaluación2:34;aAEXEv2;[Alumnos_Actividades:28]Periodo4_Evaluación3:35;aAEXEv3;[Alumnos_Actividades:28]Periodo4_Evaluación4:36;aAEXEv4;[Alumnos_Actividades:28]Periodo4_Evaluación5:37;aAEXEv5;[Alumnos_Actividades:28]Periodo4_Evaluación6:38;aAEXEv6;[Alumnos_Actividades:28]Inasistencia_P4:42;aAEXIn;[Alumnos_Actividades:28]Comentarios_P4:41;aAExObs)
	: (atSTR_Periodos_Nombre=5)
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]ID:63;aAEXIDs;[Alumnos_Actividades:28]Alumno_Numero:1;$Id;[Alumnos:2]apellidos_y_nombres:40;aAEXName;[Alumnos:2]curso:20;aAEXCso;[Alumnos_Actividades:28]Evaluacion_Final_P5:51;aEXEvF;[Alumnos_Actividades:28]Periodo5_Evaluacion1:45;aAEXEv1;[Alumnos_Actividades:28]Periodo5_Evaluacion2:46;aAEXEv2;[Alumnos_Actividades:28]Periodo5_Evaluacion3:47;aAEXEv3;[Alumnos_Actividades:28]Periodo5_Evaluacion4:48;aAEXEv4;[Alumnos_Actividades:28]Periodo5_Evaluacion5:49;aAEXEv5;[Alumnos_Actividades:28]Periodo5_Evaluacion6:50;aAEXEv6;[Alumnos_Actividades:28]Inasistencia_P5:52;aAEXIn;[Alumnos_Actividades:28]Comentarios_P5:53;aAExObs)
End case 

$err:=AL_SetArraysNam (xALP_ActividadesExtra;1;12;"aAEXName";"aAEXCso";"aAEXEv1";"aAEXEv2";"aAEXEv3";"aAEXEv4";"aAEXEv5";"aAEXEv6";"aExEvF";"aAEXIn";"aAEXObs";"aAERNs")
AL_SetHeaders (xALP_ActividadesExtra;1;12;"Alumnos";"Curso";<>aXCRAbrv{1};<>aXCRAbrv{2};<>aXCRAbrv{3};<>aXCRAbrv{4};<>aXCRAbrv{5};<>aXCRAbrv{6};__ ("Final");__ ("Inasist.");__ ("Observaciones");"RNs")
AL_SetWidths (xALP_ActividadesExtra;1;12;192;45;30;30;30;30;30;30;50;50;225;0)

ALP_SetDefaultAppareance (xALP_ActividadesExtra;9;2;6;2;8)
AL_SetColLock (xALP_ActividadesExtra;2)
AL_SetColOpts (xALP_ActividadesExtra;0;0;0;1;0;0;0)
AL_SetMiscOpts (xALP_ActividadesExtra;0;0;"\\";0;1)
AL_SetRowOpts (xALP_ActividadesExtra;1;0;0;0;0)

  //MONO TICKET 179875
$b_modXCRCondorActivo:=LICENCIA_VerificaModCondorAct ("Extracurriculares")

If ($b_modXCRCondorActivo)
	CD_Dlog (0;__ ("El Colegio tiene activo el módulo Web Extracurriculares. Las acciones dentro de la ficha de las actividades están bloqueadas"))
Else 
	$permiso:=(USR_checkRights ("M";->[Alumnos_Actividades:28])) | (<>lUSR_RelatedTableUserID=[Actividades:29]No_Profesor:3)
End if 

If ($permiso)
	AL_SetEntryOpts (xALP_ActividadesExtra;2;0;0;0;2;<>tXS_RS_DecimalSeparator)
	AL_SetEnterable (xALP_ActividadesExtra;1;0)
	AL_SetEnterable (xALP_ActividadesExtra;2;0)
	For ($i;3;11)
		AL_SetEnterable (xALP_ActividadesExtra;$i;1)
	End for 
	AL_SetFilter (xALP_ActividadesExtra;10;"&9")
	AL_SetFormat (xALP_ActividadesExtra;10;"##0")
	AL_SetCallbacks (xALP_ActividadesExtra;"";"xALCB_EX_EvaluacionActividades")
End if 
AL_SetSort (xALP_ActividadesExtra;1)
