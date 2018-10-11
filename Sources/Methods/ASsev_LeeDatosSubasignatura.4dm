//%attributes = {}
  // MÉTODO: ASsev_LeeDatosSubasignatura
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 14:59:15
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // ASsev_LeeDatosSubasignatura()
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_convierteNotas)
C_LONGINT:C283($i;$j;$l_blobOffset;$l_Columna;$l_IdAlumno;$l_IdAsignaturaMadre;$l_Periodo;$l_recNumSubasignatura;$u)
C_TEXT:C284($t_referencia;$t_sexoAlumno;$t_nodo)
If (False:C215)
	C_LONGINT:C283(ASsev_LeeDatosSubasignatura ;$0)
	C_LONGINT:C283(ASsev_LeeDatosSubasignatura ;$1)
	C_LONGINT:C283(ASsev_LeeDatosSubasignatura ;$2)
	C_LONGINT:C283(ASsev_LeeDatosSubasignatura ;$3)
End if 



  // CODIGO PRINCIPAL
$0:=-1
$l_IdAsignaturaMadre:=$1
$l_Periodo:=$2
$l_Columna:=$3
$b_convierteNotas:=True:C214


  //ASM 20180725 Ticket 212507
QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_IdAsignaturaMadre)
If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
	$t_nodo:="P"+String:C10($l_Periodo)
Else 
	$t_nodo:="Anual"
End if 

AS_ReadEvalProperties ($t_nodo)


If (Count parameters:C259=4)
	$b_convierteNotas:=$4
End if 
$t_referencia:=String:C10($l_IdAsignaturaMadre)+"."+String:C10($l_Periodo)+"."+String:C10($l_Columna)
$l_recNumSubasignatura:=Find in field:C653([xxSTR_Subasignaturas:83]Referencia:11;$t_referencia)
If ($l_recNumSubasignatura<0)
	READ WRITE:C146([xxSTR_Subasignaturas:83])
	QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=$l_IdAsignaturaMadre;*)
	QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12=$l_Periodo;*)
	QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Name:2=atAS_EvalPropSourceName{$l_Columna})
	
	If ([xxSTR_Subasignaturas:83]Columna:13=0)
		[xxSTR_Subasignaturas:83]Columna:13:=$l_Columna
		SAVE RECORD:C53([xxSTR_Subasignaturas:83])
	End if 
	$t_referencia:=String:C10($l_IdAsignaturaMadre)+"."+String:C10($l_Periodo)+"."+String:C10($l_Columna)
	$l_recNumSubasignatura:=Find in field:C653([xxSTR_Subasignaturas:83]Referencia:11;$t_referencia)
End if 

If ($l_recNumSubasignatura>=0)
	READ ONLY:C145([xxSTR_Subasignaturas:83])
	KRL_GotoRecord (->[xxSTR_Subasignaturas:83];$l_recNumSubasignatura;False:C215)
	ASsev_InitArrays 
	<>crtSEvalPerPtr:=->aSubEvalP1
	ARRAY REAL:C219(aRealTemp;0)
	ARRAY POINTER:C280(aSubEvalArrPtr;12)
	ARRAY POINTER:C280(aRealSubEvalArrPtr;12)
	ARRAY TEXT:C222(aRealSubEvalArrNames;12)
	For ($i;1;12)
		aSubEvalArrPtr{$i}:=Get pointer:C304("aSubEval"+String:C10($i))
		aRealSubEvalArrPtr{$i}:=Get pointer:C304("aRealSubEval"+String:C10($i))
		aRealSubEvalArrNames{$i}:="aRealSubEval"+String:C10($i)
	End for 
	  //MONO TICKET 187315 
	  //$l_blobOffset:=0
	  //$l_blobOffset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$l_blobOffset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
	
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalID;"aSubEvalID")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStdNme;"aSubEvalStdNme")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalCurso;"aSubEvalCurso")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStatus;"aSubEvalStatus")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalOrden;"aSubEvalOrden")
	
	For ($j;1;Size of array:C274(aSubEvalArrPtr))
		  //$l_blobOffset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$l_blobOffset;aRealSubEvalArrPtr{$j})
		OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;aRealSubEvalArrPtr{$j};"aRealSubEval"+String:C10($j))
		If ($b_convierteNotas)
			NTA_PercentArray2StrGradeArray (aRealSubEvalArrPtr{$j};aSubEvalArrPtr{$j})
		End if 
	End for 
	  //$l_blobOffset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$l_blobOffset;->aRealSubEvalP1)
	  //$l_blobOffset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$l_blobOffset;->aRealSubEvalControles)
	  //$l_blobOffset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$l_blobOffset;->aRealSubEvalPresentacion)
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalP1;"aRealSubEvalP1")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalControles;"aRealSubEvalControles")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
	OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalNombreParciales;"aSubEvalNombreParciales")
	
	If ($b_convierteNotas)
		  //NTA_PercentArray2StrGradeArray (->aRealSubEvalP1;->aSubEvalP1)
		NTA_PercentArray2StrGradeArray (->aRealSubEvalP1;->aSubEvalP1;IViewMode;[Asignaturas:18]Numero_de_EstiloEvaluacion:39;iGradesDecPP)  //ASM ticket 216848
		NTA_PercentArray2StrGradeArray (->aRealSubEvalControles;->aSubEvalControles)
		NTA_PercentArray2StrGradeArray (->aRealSubEvalPresentacion;->aSubEvalPresentacion)
	End if 
	For ($u;1;Size of array:C274(aSubEvalID))
		$l_IdAlumno:=aSubEvalID{$u}
		$t_sexoAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_IdAlumno;->[Alumnos:2]Sexo:49)
		APPEND TO ARRAY:C911(aSubEvalSex;$t_sexoAlumno)
	End for 
	$0:=Record number:C243([xxSTR_Subasignaturas:83])
Else 
	  //subasignatura inexistente
	$0:=-1
	ASsev_InitArrays 
End if 

