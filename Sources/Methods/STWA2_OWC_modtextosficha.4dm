//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:30:48
  // ----------------------------------------------------
  // Método: STWA2_OWC_modtextosficha
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid;$valor)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues;$fieldPtr)
C_BOOLEAN:C305($b_esObservacion)
C_LONGINT:C283($l_IDTrata)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$idycampo:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"id")
$valor:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"val")
$t_observacion:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"observacion")
$t_fecha:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"fecha")
$rnalumno:=Num:C11(ST_GetWord ($idycampo;2;"_"))
$tabname:=ST_GetWord ($idycampo;1;"_")
$tratID:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"tratID"))
$b_esObservacion:=Choose:C955(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"es_observacion")="true";True:C214;False:C215)

If (KRL_GotoRecord (->[Alumnos:2];$rnalumno;False:C215))
	If (KRL_FindAndLoadRecordByIndex (->[Alumnos_FichaMedica:13]Alumno_Numero:1;->[Alumnos:2]numero:1;True:C214)>-1)
		$errL:=1
		Case of 
			: ($tabname="observacionesf")
				$fieldPtr:=->[Alumnos_FichaMedica:13]Observaciones:3
			: ($tabname="medaf")
				$fieldPtr:=->[Alumnos_FichaMedica:13]Medicamentos_autorizados:11
			: ($tabname="medpf")
				$fieldPtr:=->[Alumnos_FichaMedica:13]Medicamentos_prohibidos:17
				  //: ($tabname="tratamientosf")
				  //$fieldPtr:=->[Alumnos_FichaMedica]Tratamientos
			: ($tabname="tratamiento")
				
				KRL_ReloadInReadWriteMode (->[Alumnos_FichaMedica:13])
				If ($tratID>0)
					C_OBJECT:C1216($ob_objeto;$ob_tratamiento)
					$ob_tratamiento:=OB_Create 
					$ob_tratamiento:=[Alumnos_FichaMedica:13]OB_tratamiento:23
					OB_GET ($ob_tratamiento;->$ob_objeto;String:C10($tratID))
					OB_SET ($ob_objeto;->$t_observacion;"tratObservacion")
					OB_SET ($ob_objeto;->$t_fecha;"tratNotificacion")
					OB_SET ($ob_tratamiento;->$ob_objeto;String:C10($tratID))
					[Alumnos_FichaMedica:13]OB_tratamiento:23:=$ob_tratamiento
					$l_IDTrata:=$tratID
					SAVE RECORD:C53([Alumnos_FichaMedica:13])
				Else 
					C_OBJECT:C1216($ob_temporalTrat;$ob_tratamiento)
					$ob_temporalTrat:=OB_Create 
					$ob_tratamiento:=OB_Create 
					$ob_tratamiento:=[Alumnos_FichaMedica:13]OB_tratamiento:23
					$l_IDTrata:=ST_ObtieneID ("obtieneID")
					OB_SET ($ob_temporalTrat;->$l_IDTrata;"tratID")
					OB_SET ($ob_temporalTrat;->$t_observacion;"tratObservacion")
					OB_SET ($ob_temporalTrat;->$t_fecha;"tratNotificacion")
					OB_SET ($ob_tratamiento;->$ob_temporalTrat;String:C10($l_IDTrata))
					[Alumnos_FichaMedica:13]OB_tratamiento:23:=$ob_tratamiento
					SAVE RECORD:C53([Alumnos_FichaMedica:13])
					KRL_ReloadAsReadOnly (->[Alumnos_FichaMedica:13])
				End if 
			: ($tabname="dietasf")
				$fieldPtr:=->[Alumnos_FichaMedica:13]Dieta:19
			: ($tabname="urcontacto")
				$fieldPtr:=->[Alumnos_FichaMedica:13]Urgencia_Contacto:4
			: ($tabname="urfonos")
				$fieldPtr:=->[Alumnos_FichaMedica:13]Urgencia_Fonos:5
			: ($tabname="urconvenio")
				$fieldPtr:=->[Alumnos_FichaMedica:13]Urgencia_Convenio:6
			: ($tabname="urtraslado")
				$fieldPtr:=->[Alumnos_FichaMedica:13]Urgencia_Traslado:8
			: ($tabname="sangre")
				$fieldPtr:=->[Alumnos_FichaMedica:13]GrupoSanguineo:2
			: ($tabname="previnstitucion")
				$fieldPtr:=->[Alumnos_FichaMedica:13]Previsión_institución:9
			: ($tabname="prevcodigo")
				$fieldPtr:=->[Alumnos_FichaMedica:13]Prevision_Código:10
			: ($tabname="embarazada")
				$fieldPtr:=->[Alumnos_FichaMedica:13]Alumna_embarazada:20
			: ($tabname="factor")
				$fieldPtr:=->[Alumnos_FichaMedica:13]factor_riesgo:15
		End case 
		If ($tabname="embarazada")
			$fieldPtr->:=($valor="true")
		Else 
			If (Not:C34(Is nil pointer:C315($fieldPtr)))
				$fieldPtr->:=$valor
			End if 
		End if 
		SAVE RECORD:C53([Alumnos_FichaMedica:13])
	Else 
		$errL:=0
	End if 
Else 
	$errL:=0
End if 
KRL_UnloadReadOnly (->[Alumnos_FichaMedica:13])

C_OBJECT:C1216($ob_raiz)
$ob_raiz:=OB_Create 
OB_SET_Text ($ob_raiz;String:C10($errL);"resultado")
OB_SET ($ob_raiz;->$l_IDTrata;"tratID")
$json:=OB_Object2Json ($ob_raiz)
  //$jsonT:=JSON New 
  //$node:=JSON Append text ($jsonT;"resultado";String($errL))
  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre

$0:=$json