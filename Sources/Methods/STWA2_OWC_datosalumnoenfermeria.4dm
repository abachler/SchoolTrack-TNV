//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:58:58
  // ----------------------------------------------------
  // Método: STWA2_OWC_datosalumnoenfermeria
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
$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"alumno"))
If (KRL_GotoRecord (->[Alumnos:2];$rn;False:C215))
	LOC_LoadIdenNacionales 
	$nombre:=[Alumnos:2]apellidos_y_nombres:40
	$curso:=[Alumnos:2]curso:20
	$fechaNac:=STWA2_MakeDate4JS ([Alumnos:2]Fecha_de_nacimiento:7)
	$edad:=DT_Months2AgeLongString (DT_ReturnAgeInMonths ([Alumnos:2]Fecha_de_nacimiento:7))
	C_BLOB:C604($blob)
	C_TEXT:C284($text)
	PICT_ScalePicture (->[Alumnos:2]Fotografía:78;85;85)
	PICTURE TO BLOB:C692([Alumnos:2]Fotografía:78;$blob;".jpg")
	BASE64 ENCODE:C895($blob;$text)
	$fotobase64:=Replace string:C233($text;"\n";"")
	Case of 
		: (<>vtXS_CountryCode="cl")
			If ([Alumnos:2]RUT:5="")
				If ([Alumnos:2]Nacionalidad:8#"Chilen@")
					If ([Alumnos:2]NoPasaporte:87#"")
						$identificadorLabel:="Pasaporte"
						$identificador:=[Alumnos:2]NoPasaporte:87
					End if 
				End if 
			Else 
				$identificadorLabel:=<>at_IDNacional_Names{1}
				$identificador:=SR_FormatoRUT2 ([Alumnos:2]RUT:5)
			End if 
		Else 
			If ([Alumnos:2]Fecha_de_nacimiento:7#!00-00-00!)
				If (<>ai_IDNacional_LimiteEdad{1}=0)
					$identificadorLabel:=<>at_IDNacional_Names{1}
					$identificador:=[Alumnos:2]RUT:5
				Else 
					$age:=Int:C8(DT_ReturnAgeInMonths ([Alumnos:2]Fecha_de_nacimiento:7)/12)
					Case of 
						: ((<>ai_IDNacional_LimiteEdad{1}>=$age) | (<>ai_IDNacional_LimiteEdad{1}=0))
							$identificadorLabel:=<>at_IDNacional_Names{1}
							$identificador:=[Alumnos:2]RUT:5
						: ((<>ai_IDNacional_LimiteEdad{2}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
							$identificadorLabel:=<>at_IDNacional_Names{2}
							$identificador:=[Alumnos:2]IDNacional_2:71
						: ((<>ai_IDNacional_LimiteEdad{3}>=$age) | (<>ai_IDNacional_LimiteEdad{3}=0))
							$identificadorLabel:=<>at_IDNacional_Names{3}
							$identificador:=[Alumnos:2]IDNacional_3:70
						Else 
							$identificadorLabel:=<>at_IDNacional_Names{1}
							$identificador:=[Alumnos:2]RUT:5
					End case 
				End if 
			Else 
				Case of 
					: ([Alumnos:2]RUT:5#"")
						$identificadorLabel:=<>at_IDNacional_Names{1}
						$identificador:=[Alumnos:2]RUT:5
					: ([Alumnos:2]IDNacional_2:71#"")
						$identificadorLabel:=<>at_IDNacional_Names{2}
						$identificador:=[Alumnos:2]IDNacional_2:71
					: ([Alumnos:2]IDNacional_3:70#"")
						$identificadorLabel:=<>at_IDNacional_Names{3}
						$identificador:=[Alumnos:2]IDNacional_3:70
				End case 
			End if 
	End case 
	$factor:=KRL_GetTextFieldData (->[Alumnos_FichaMedica:13]Alumno_Numero:1;->[Alumnos:2]numero:1;->[Alumnos_FichaMedica:13]factor_riesgo:15)
	$embarazada:=KRL_GetBooleanFieldData (->[Alumnos_FichaMedica:13]Alumno_Numero:1;->[Alumnos:2]numero:1;->[Alumnos_FichaMedica:13]Alumna_embarazada:20)
	$ob_raiz:=OB_Create 
	OB_SET ($ob_raiz;->$nombre;"nombre")
	OB_SET ($ob_raiz;->$identificadorLabel;"identificadorlabel")
	OB_SET ($ob_raiz;->$identificador;"identificador")
	OB_SET ($ob_raiz;->$curso;"curso")
	OB_SET ($ob_raiz;->$fechaNac;"fechanac")
	OB_SET ($ob_raiz;->$edad;"edad")
	OB_SET ($ob_raiz;->$factor;"factorriesgo")
	OB_SET ($ob_raiz;->$fotobase64;"foto")
	OB_SET ($ob_raiz;->$embarazada;"embarazada")
	$mostraremb:=(([Alumnos:2]Sexo:49="F") & ([Alumnos:2]Fecha_de_nacimiento:7#!00-00-00!) & (<>gYear-Year of:C25([Alumnos:2]Fecha_de_nacimiento:7)>=13) & ([Alumnos:2]Status:50="Activo"))
	OB_SET ($ob_raiz;->$mostraremb;"mostraremb")
	$json:=OB_Object2Json ($ob_raiz)
	  //$jsonT:=JSON New 
	  //$node:=JSON Append text ($jsonT;"nombre";$nombre)
	  //$node:=JSON Append text ($jsonT;"identificadorlabel";$identificadorLabel)
	  //$node:=JSON Append text ($jsonT;"identificador";$identificador)
	  //$node:=JSON Append text ($jsonT;"curso";$curso)
	  //$node:=JSON Append text ($jsonT;"fechanac";$fechaNac)
	  //$node:=JSON Append text ($jsonT;"edad";$edad)
	  //$node:=JSON Append text ($jsonT;"factorriesgo";$factor)
	  //$node:=JSON Append text ($jsonT;"foto";$fotobase64)
	  //$node:=JSON Append bool ($jsonT;"embarazada";Num($embarazada))
	  //$mostraremb:=(([Alumnos]Sexo="F") & ([Alumnos]Fecha_de_nacimiento#!00-00-00!) & (<>gYear-Year of([Alumnos]Fecha_de_nacimiento)>=13) & ([Alumnos]Status="Activo"))
	  //$node:=JSON Append bool ($jsonT;"mostraremb";Num($mostraremb))
	  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
	  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
End if 

$0:=$json

