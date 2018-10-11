//%attributes = {}
$periodo:=$1
$columna:=$2
$profID:=$3
$userID:=$4

PERIODOS_Init 
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)

If ($periodo=0)
	$periodo:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
End if 

EVS_initialize 
EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)

EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$periodo)

$subEvalRecNum:=ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$periodo;$columna)
ASsev_UpdateList ($subEvalRecNum)

  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
$o_obj:=STR_ordenNominas ("query";$o_in)
Case of 
	: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
		ARRAY TEXT:C222($sexo;0)
		For ($i;1;Size of array:C274(aSubEvalId))
			$id:=aSubEvalId{$i}
			$sex:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$id;->[Alumnos:2]Sexo:49)
			APPEND TO ARRAY:C911($sexo;$sex)
		End for 
		Case of 
			: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					AT_MultiLevelSort ("<>";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
				Else 
					AT_MultiLevelSort (">>";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
				End if 
			: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						AT_MultiLevelSort ("< >>";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
					Else 
						AT_MultiLevelSort ("<  >";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
					End if 
				Else 
					If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
						AT_MultiLevelSort ("> >>";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
					Else 
						AT_MultiLevelSort (">  >";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
					End if 
				End if 
			: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
				If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
					AT_MultiLevelSort ("<  >";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
				Else 
					AT_MultiLevelSort (">  >";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
				End if 
		End case 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		SORT ARRAY:C229(aSubEvalOrden;aSubEvalStdNme;aSubEvalCurso;aSubEvalP1;aSubEvalControles;aSubEval1;aSubEval2;aSubEval3;aSubEval4;aSubEval5;aSubEval6;aSubEval7;aSubEval8;aSubEval9;aSubEval10;aSubEval11;aSubEval12;aSubEvalStatus;aSubEvalId)
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
			AT_MultiLevelSort (" >>";->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
		Else 
			SORT ARRAY:C229(aSubEvalStdNme;aSubEvalOrden;aSubEvalCurso;aSubEvalP1;aSubEvalControles;aSubEval1;aSubEval2;aSubEval3;aSubEval4;aSubEval5;aSubEval6;aSubEval7;aSubEval8;aSubEval9;aSubEval10;aSubEval11;aSubEval12;aSubEvalStatus;aSubEvalId)
		End if 
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		SORT ARRAY:C229(aSubEvalStdNme;aSubEvalOrden;aSubEvalCurso;aSubEvalP1;aSubEvalControles;aSubEval1;aSubEval2;aSubEval3;aSubEval4;aSubEval5;aSubEval6;aSubEval7;aSubEval8;aSubEval9;aSubEval10;aSubEval11;aSubEval12;aSubEvalStatus;aSubEvalId)
End case 

  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //AT_MultiLevelSort (" >>";->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
  //Else 
  //SORT ARRAY(aSubEvalStdNme;aSubEvalOrden;aSubEvalCurso;aSubEvalP1;aSubEvalControles;aSubEval1;aSubEval2;aSubEval3;aSubEval4;aSubEval5;aSubEval6;aSubEval7;aSubEval8;aSubEval9;aSubEval10;aSubEval11;aSubEval12;aSubEvalStatus;aSubEvalId)
  //End if 
  //: (<>gOrdenNta=1)
  //SORT ARRAY(aSubEvalOrden;aSubEvalStdNme;aSubEvalCurso;aSubEvalP1;aSubEvalControles;aSubEval1;aSubEval2;aSubEval3;aSubEval4;aSubEval5;aSubEval6;aSubEval7;aSubEval8;aSubEval9;aSubEval10;aSubEval11;aSubEval12;aSubEvalStatus;aSubEvalId)
  //: (<>gOrdenNta=2)
  //SORT ARRAY(aSubEvalStdNme;aSubEvalOrden;aSubEvalCurso;aSubEvalP1;aSubEvalControles;aSubEval1;aSubEval2;aSubEval3;aSubEval4;aSubEval5;aSubEval6;aSubEval7;aSubEval8;aSubEval9;aSubEval10;aSubEval11;aSubEval12;aSubEvalStatus;aSubEvalId)
  //End case 
  //Else 
  //ARRAY TEXT($sexo;0)
  //For ($i;1;Size of array(aSubEvalId))
  //$id:=aSubEvalId{$i}
  //$sex:=KRL_GetTextFieldData (->[Alumnos]numero;->$id;->[Alumnos]Sexo)
  //APPEND TO ARRAY($sexo;$sex)
  //End for 
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //AT_MultiLevelSort ("< >>";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
  //Else 
  //AT_MultiLevelSort ("<  >";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
  //End if 
  //: (<>gOrdenNta=1)
  //AT_MultiLevelSort ("<>";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
  //: (<>gOrdenNta=2)
  //AT_MultiLevelSort ("<  >";->$sexo;->aSubEvalOrden;->aSubEvalCurso;->aSubEvalStdNme;->aSubEvalP1;->aSubEvalControles;->aSubEval1;->aSubEval2;->aSubEval3;->aSubEval4;->aSubEval5;->aSubEval6;->aSubEval7;->aSubEval8;->aSubEval9;->aSubEval10;->aSubEval11;->aSubEval12;->aSubEvalStatus;->aSubEvalId)
  //End case 
  //End if 

ARRAY TEXT:C222($aIcono;0)
ARRAY LONGINT:C221($aEnterable;0)

C_BLOB:C604($blob)
C_TEXT:C284($text)
GET PICTURE FROM LIBRARY:C565(5006;$nonEnterableIconP)
GET PICTURE FROM LIBRARY:C565(5005;$enterableIconP)
$text:=""
SET BLOB SIZE:C606($blob;0)
PICTURE TO BLOB:C692($nonEnterableIconP;$blob;".jpg")
BASE64 ENCODE:C895($blob;$text)
$nonEnterableIconDEF:=Replace string:C233($text;"\n";"")
$text:=""
SET BLOB SIZE:C606($blob;0)
PICTURE TO BLOB:C692($enterableIconP;$blob;".jpg")
BASE64 ENCODE:C895($blob;$text)
$enterableIconDEF:=Replace string:C233($text;"\n";"")
$text:=""

$nonEnterableIcon:="noingresable"
$enterableIcon:="ingresable"

$vb_CanModify:=((((<>viSTR_FirmantesAutorizados=1) & ($profID=[Asignaturas:18]profesor_firmante_numero:33)) | ($profID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208];$userID))) & ((adSTR_Periodos_Cierre{$periodo}>Current date:C33(*)) | (adSTR_Periodos_Cierre{$periodo}=!00-00-00!)))
$vb_CanModify:=(($vb_canModify) | (USR_IsGroupMember_by_GrpID (-15001;$userID)))

If ($vb_CanModify)
	$icono:=$enterableIcon
	$enterableGrades:=1
Else 
	$icono:=$nonEnterableIcon
	$enterableGrades:=0
End if 

If (<>vb_BloquearModifSituacionFinal)
	$enterableGrades:=0
	$icono:=$nonEnterableIcon
End if 

C_OBJECT:C1216($ob_raiz)
$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->aSubEvalP1;"p1")

  //$t_raizJson:=JSON New 
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEvalP1;"p1";"")
APPEND TO ARRAY:C911($aEnterable;0)
APPEND TO ARRAY:C911($aIcono;"")
If ([xxSTR_Subasignaturas:83]ModoControles:5>0)
	  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEvalControles;"controles";"")
	OB_SET ($ob_raiz;->aSubEvalControles;"controles")
	APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
	APPEND TO ARRAY:C911($aIcono;$icono)
End if 
OB_SET ($ob_raiz;->aSubEval1;"par1")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval1;"par1";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)
OB_SET ($ob_raiz;->aSubEval2;"par2")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval2;"par2";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)
OB_SET ($ob_raiz;->aSubEval3;"par3")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval3;"par3";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)
OB_SET ($ob_raiz;->aSubEval4;"par4")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval4;"par4";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)
OB_SET ($ob_raiz;->aSubEval5;"par5")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval5;"par5";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)
OB_SET ($ob_raiz;->aSubEval6;"par6")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval6;"par6";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)
OB_SET ($ob_raiz;->aSubEval7;"par7")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval7;"par7";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)
OB_SET ($ob_raiz;->aSubEval8;"par8")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval8;"par8";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)
OB_SET ($ob_raiz;->aSubEval9;"par9")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval9;"par9";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)
OB_SET ($ob_raiz;->aSubEval10;"par10")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval10;"par10";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)
OB_SET ($ob_raiz;->aSubEval11;"par11")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval11;"par11";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)
OB_SET ($ob_raiz;->aSubEval12;"par12")
  //STWA2_Arreglo_a_json ($t_raizJson;->aSubEval12;"par12";"")
APPEND TO ARRAY:C911($aEnterable;$enterableGrades)
APPEND TO ARRAY:C911($aIcono;$icono)

OB_SET ($ob_raiz;->$aEnterable;"ingresable")
OB_SET ($ob_raiz;->$aIcono;"iconos")
OB_SET ($ob_raiz;->aSubEvalId;"idalumno")
OB_SET ($ob_raiz;->aSubEvalNombreParciales;"nombreParciales")  //MONO Ticket 187315
$0:=OB_Object2Json ($ob_raiz)

