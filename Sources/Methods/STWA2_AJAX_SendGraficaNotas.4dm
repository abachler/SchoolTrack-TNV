//%attributes = {}
  // STWA2_AJAX_SendGraficaNotas()
  //
  //
  // modificado y normalizado por: Alberto Bachler Klein: 27-11-15, 19:52:31
  // -----------------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($el;$i;$l_campo;$l_periodo;$l_tabla)
C_POINTER:C301($y_campo;$y_tabla)
C_REAL:C285($r_numero)
C_OBJECT:C1216($ob_nodoEstiloEvaluacion;$ob_nodoParametros;$ob_ObjetoRaiz)

ARRAY INTEGER:C220($ai_numeroLista;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY REAL:C219($ar_notas;0)
ARRAY TEXT:C222($at_Curso;0)
ARRAY TEXT:C222($at_esfuerzo;0)
ARRAY TEXT:C222($at_NombreAlumno;0)
ARRAY TEXT:C222($at_sexo;0)


If (False:C215)
	C_LONGINT:C283(STWA2_AJAX_SendGraficaNotas ;$1)
	C_LONGINT:C283(STWA2_AJAX_SendGraficaNotas ;$2)
	C_LONGINT:C283(STWA2_AJAX_SendGraficaNotas ;$3)
End if 

$l_periodo:=$1
$l_tabla:=$2
$l_campo:=$3

$y_campo:=Field:C253($l_tabla;$l_campo)

EVS_initialize 
EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)

EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];$al_recNums;[Alumnos:2]Sexo:49;$at_sexo;[Alumnos:2]apellidos_y_nombres:40;$at_NombreAlumno;[Alumnos:2]curso:20;$at_Curso;[Alumnos_Calificaciones:208]NoDeLista:10;$ai_numeroLista)
If (($l_tabla=209) & (($l_campo=16) | ($l_campo=21) | ($l_campo=26) | ($l_campo=31) | ($l_campo=36)))
	SELECTION TO ARRAY:C260($y_campo->;$at_esfuerzo)
	For ($i;1;Size of array:C274($at_esfuerzo))
		$el:=Find in array:C230(aIndEsfuerzo;$at_esfuerzo{$i})
		If ($el=-1)
			$el:=0
		End if 
		APPEND TO ARRAY:C911($ar_notas;$el)
	End for 
Else 
	SELECTION TO ARRAY:C260($y_campo->;$ar_notas)
End if 
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
$o_obj:=STR_ordenNominas ("query";$o_in)
Case of 
	: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
		Case of 
			: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					AT_MultiLevelSort ("<>  ";->$at_sexo;->$ai_numeroLista;->$at_NombreAlumno;->$ar_notas)
				Else 
					AT_MultiLevelSort (">>  ";->$at_sexo;->$ai_numeroLista;->$at_NombreAlumno;->$ar_notas)
				End if 
			: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						AT_MultiLevelSort ("<>> ";->$at_sexo;->$at_Curso;->$at_NombreAlumno;->$ar_notas)
					Else 
						AT_MultiLevelSort ("<> ";->$at_sexo;->$at_NombreAlumno;->$ar_notas)
					End if 
				Else 
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						AT_MultiLevelSort (">>> ";->$at_sexo;->$at_Curso;->$at_NombreAlumno;->$ar_notas)
					Else 
						AT_MultiLevelSort (">> ";->$at_sexo;->$at_NombreAlumno;->$ar_notas)
					End if 
				End if 
			: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					AT_MultiLevelSort ("<> ";->$at_sexo;->$at_NombreAlumno;->$ar_notas)
				Else 
					AT_MultiLevelSort (">> ";->$at_sexo;->$at_NombreAlumno;->$ar_notas)
				End if 
		End case 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		AT_MultiLevelSort (">  ";->$ai_numeroLista;->$at_NombreAlumno;->$ar_notas)
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
			AT_MultiLevelSort (">> ";->$at_Curso;->$at_NombreAlumno;->$ar_notas)
		Else 
			AT_MultiLevelSort ("> ";->$at_NombreAlumno;->$ar_notas)
		End if 
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		AT_MultiLevelSort ("> ";->$at_NombreAlumno;->$ar_notas)
End case 
  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //AT_MultiLevelSort (">>";->$at_Curso;->$at_NombreAlumno;->$ar_notas)
  //Else 
  //SORT ARRAY($at_NombreAlumno;$ar_notas)
  //End if 
  //: (<>gOrdenNta=1)
  //SORT ARRAY($ai_numeroLista;$at_NombreAlumno;$ar_notas)
  //: (<>gOrdenNta=2)
  //SORT ARRAY($at_NombreAlumno;$ar_notas)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //AT_MultiLevelSort ("<>>";->$at_sexo;->$at_Curso;->$at_NombreAlumno;->$ar_notas)
  //Else 
  //AT_MultiLevelSort ("<>";->$at_sexo;->$at_NombreAlumno;->$ar_notas)
  //End if 
  //: (<>gOrdenNta=1)
  //AT_MultiLevelSort ("<>";->$at_sexo;->$ai_numeroLista;->$at_NombreAlumno;->$ar_notas)
  //: (<>gOrdenNta=2)
  //AT_MultiLevelSort ("<>";->$at_sexo;->$at_NombreAlumno;->$ar_notas)
  //End case 
  //End if 

$ob_ObjetoRaiz:=OB_Create 
OB_SET ($ob_ObjetoRaiz;->$at_NombreAlumno;"alumnos";"")
OB_SET ($ob_ObjetoRaiz;->$ar_notas;"notas")

$ob_nodoParametros:=OB_Create 
Case of 
	: ($y_campo=(->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32))
		OB_SET ($ob_nodoParametros;->[Asignaturas_SintesisAnual:202]PromedioOficial_Real:20;"promedio")
	: ($y_campo=(->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26))
		OB_SET ($ob_nodoParametros;->[Asignaturas_SintesisAnual:202]PromedioFinal_Real:15;"promedio")
	: ($y_campo=(->[Alumnos_Calificaciones:208]Anual_Real:11))
		OB_SET ($ob_nodoParametros;->[Asignaturas_SintesisAnual:202]PromedioAnual_Real:10;"promedio")
	: ($y_campo=(->[Alumnos_Calificaciones:208]P01_Final_Real:112))
		OB_SET ($ob_nodoParametros;->[Asignaturas_SintesisAnual:202]P01_Promedio_Real:25;"promedio")
	: ($y_campo=(->[Alumnos_Calificaciones:208]P02_Final_Real:187))
		OB_SET ($ob_nodoParametros;->[Asignaturas_SintesisAnual:202]P02_Promedio_Real:30;"promedio")
	: ($y_campo=(->[Alumnos_Calificaciones:208]P03_Final_Real:262))
		OB_SET ($ob_nodoParametros;->[Asignaturas_SintesisAnual:202]P03_Promedio_Real:35;"promedio")
	: ($y_campo=(->[Alumnos_Calificaciones:208]P04_Final_Real:337))
		OB_SET ($ob_nodoParametros;->[Asignaturas_SintesisAnual:202]P04_Promedio_Real:40;"promedio")
	: ($y_campo=(->[Alumnos_Calificaciones:208]P05_Final_Real:412))
		OB_SET ($ob_nodoParametros;->[Asignaturas_SintesisAnual:202]P05_Promedio_Real:45;"promedio")
End case 
OB_SET ($ob_nodoParametros;->$l_tabla;"tabla")
OB_SET ($ob_nodoParametros;->$l_campo;"campo")
OB_SET ($ob_nodoParametros;->aIndEsfuerzo;"ejey")
OB_SET ($ob_ObjetoRaiz;->$ob_nodoParametros;"parametros")

$ob_nodoEstiloEvaluacion:=OB_Create 
$r_numero:=Round:C94(rPctMinimum;11)
OB_SET ($ob_nodoEstiloEvaluacion;->$r_numero;"minimoaprobacion")
OB_SET ($ob_ObjetoRaiz;->$ob_nodoEstiloEvaluacion;"estiloEV")


$0:=OB_Object2Json ($ob_ObjetoRaiz)


