//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:43:05
  // ----------------------------------------------------
  // Método: STWA2_OWC_verLicencia
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)
$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$profID:=STWA2_Session_GetProfID ($uuid)
$userID:=STWA2_Session_GetUserSTID ($uuid)
$lic:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"licencia"))
$rn:=Find in field:C653([Alumnos_Licencias:73]ID:6;$lic)
If (KRL_GotoRecord (->[Alumnos_Licencias:73];$rn;False:C215))
	$desde:=STWA2_MakeDate4JS ([Alumnos_Licencias:73]Desde:2)
	$hasta:=STWA2_MakeDate4JS ([Alumnos_Licencias:73]Hasta:3)
	$ob_raiz:=OB_Create 
	OB_SET ($ob_raiz;->$desde;"desde")
	OB_SET ($ob_raiz;->$hasta;"hasta")
	OB_SET ($ob_raiz;->[Alumnos_Licencias:73]Tipo_licencia:4;"tipo")
	OB_SET ($ob_raiz;->[Alumnos_Licencias:73]Observaciones:5;"obs")
	  //$jsonT:=JSON New 
	  //$node:=JSON Append text ($jsonT;"desde";STWA2_MakeDate4JS ([Alumnos_Licencias]Desde))
	  //$node:=JSON Append text ($jsonT;"hasta";STWA2_MakeDate4JS ([Alumnos_Licencias]Hasta))
	  //$node:=JSON Append text ($jsonT;"tipo";[Alumnos_Licencias]Tipo_licencia)
	  //$node:=JSON Append text ($jsonT;"obs";[Alumnos_Licencias]Observaciones)
	If (<>vb_BloquearModifSituacionFinal)
		$puedeEliminarLicencia:=False:C215
	Else 
		If ($userID<0)
			$puedeEliminarLicencia:=True:C214
		Else 
			$puedeEliminarLicencia:=False:C215
			$puedeEliminarLicencia:=$puedeEliminarLicencia | ([Alumnos:2]Tutor_numero:36=$profID)
			$puedeEliminarLicencia:=$puedeEliminarLicencia | (USR_checkRights ("D";->[Alumnos_Conducta:8];$userID))
			READ ONLY:C145([Cursos:3])
			QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=$profID)
			If (Records in selection:C76([Cursos:3])>0)
				ARRAY TEXT:C222($cursos;0)
				SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
				For ($i;1;Size of array:C274($cursos))
					If ($cursos{$i}=[Alumnos:2]curso:20)
						$puedeEliminarLicencia:=True:C214
						$i:=Size of array:C274($cursos)+1
					End if 
				End for 
			End if 
		End if 
	End if 
	  //$node:=JSON Append bool ($jsonT;"puedeeliminar";Num($puedeEliminarLicencia))
	  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
	  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	OB_SET_Boolean ($ob_raiz;$puedeEliminarLicencia;"puedeeliminar")
	$json:=OB_Object2Json ($ob_raiz)
Else 
	$json:=STWA2_JSON_SendError (-30000)
End if 


$0:=$json