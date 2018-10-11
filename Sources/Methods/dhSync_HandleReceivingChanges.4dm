//%attributes = {}
C_PICTURE:C286($picture)
C_BLOB:C604($blob)

$pictureFormat:=PICT_GetDefaultFormat 
$extension:=PICT_GetDefaultExtension 

$y_campo:=$1
$valor:=$2

$marcar:=False:C215

$0:=True:C214

Case of 
	: (<>tXS_RS_DateFormat="D@")
		$dateFormat:="DD"+<>tXS_RS_DateSeparator+"MM"+<>tXS_RS_DateSeparator+"YYYY"
	: (<>tXS_RS_DateFormat="M@")
		$dateFormat:="MM"+<>tXS_RS_DateSeparator+"DD"+<>tXS_RS_DateSeparator+"YYYY"
End case 

Case of 
	: (KRL_isSameField ($y_campo;->[xShell_Users:47]xPass:13))
		BASE64 DECODE:C896($valor->;$blob)
		$pass:=BLOB to text:C555($blob;UTF8 text without length:K22:17)
		$blob:=USR_EncryptPassWord ($pass)
		BASE64 ENCODE:C895($blob;$valor->)
	: (KRL_isSameField ($y_campo;->[Alumnos:2]Familia_Número:24))
		KRL_UnloadReadOnly (->[Familia:78])
		$valor->:=String:C10(KRL_GetNumericFieldData (->[Familia:78]Auto_UUID:23;$valor;->[Familia:78]Numero:1))
		
	: (KRL_isSameField ($y_campo;->[Alumnos:2]Apoderado_académico_Número:27))
		KRL_UnloadReadOnly (->[Personas:7])
		$valor->:=String:C10(KRL_GetNumericFieldData (->[Personas:7]Auto_UUID:36;$valor;->[Personas:7]No:1))
		
	: (KRL_isSameField ($y_campo;->[Alumnos:2]Apoderado_Cuentas_Número:28))
		KRL_UnloadReadOnly (->[Personas:7])
		$valor->:=String:C10(KRL_GetNumericFieldData (->[Personas:7]Auto_UUID:36;$valor;->[Personas:7]No:1))
		  //: (KRL_isSameField ($y_campo;->[Profesores]Inactivo))
		  //$valor->:=String(Num(($valor->="0")))
	: (KRL_isSameField ($y_campo;->[Familia:78]Fecha_Matrimonio_Civil:37))
		$testDate:=$valor->
		If ($testDate#"")
			$testDate:=$testDate+"T00:00:00"
			If (Date:C102($testDate)#!00-00-00!)
				[Familia:78]Matrimonio_Civil:36:=True:C214
			Else 
				[Familia:78]Matrimonio_Civil:36:=False:C215
			End if 
		Else 
			[Familia:78]Matrimonio_Civil:36:=False:C215
		End if 
	: (KRL_isSameField ($y_campo;->[Familia:78]Fecha_Matrimonio_Religioso:39))
		$testDate:=$valor->
		If ($testDate#"")
			$testDate:=$testDate+"T00:00:00"
			If (Date:C102($testDate)#!00-00-00!)
				[Familia:78]Matrimonio_Religioso:38:=True:C214
			Else 
				[Familia:78]Matrimonio_Religioso:38:=False:C215
			End if 
		Else 
			[Familia:78]Matrimonio_Religioso:38:=False:C215
		End if 
	: (KRL_isSameField ($y_campo;->[Alumnos:2]Fecha_PrimeraMatricula:86))
		$ds:=$valor->+"T00:00:00"
		$valor->:=String:C10(Date:C102($ds);$dateFormat)
		
	: (KRL_isSameField ($y_campo;->[Familia:78]Padre_Número:5))
		KRL_UnloadReadOnly (->[Personas:7])
		$valor->:=String:C10(KRL_GetNumericFieldData (->[Personas:7]Auto_UUID:36;$valor;->[Personas:7]No:1))
		
	: (KRL_isSameField ($y_campo;->[Familia:78]Madre_Número:6))
		KRL_UnloadReadOnly (->[Personas:7])
		$valor->:=String:C10(KRL_GetNumericFieldData (->[Personas:7]Auto_UUID:36;$valor;->[Personas:7]No:1))
		
		  //: (KRL_isSameField ($y_campo;->[Familia]Inactiva))
		  //$valor->:=String(Num(($valor->="0")))
	: (KRL_isSameField ($y_campo;->[Familia_RelacionesFamiliares:77]ID_Familia:2))
		KRL_UnloadReadOnly (->[Familia:78])
		$valor->:=String:C10(KRL_GetNumericFieldData (->[Familia:78]Auto_UUID:23;$valor;->[Familia:78]Numero:1))
		
	: (KRL_isSameField ($y_campo;->[Familia_RelacionesFamiliares:77]ID_Persona:3))
		KRL_UnloadReadOnly (->[Personas:7])
		$valor->:=String:C10(KRL_GetNumericFieldData (->[Personas:7]Auto_UUID:36;$valor;->[Personas:7]No:1))
		
	: (KRL_isSameField ($y_campo;->[Familia:78]Fotografia:35))
		BASE64 DECODE:C896($valor->;$blob)
		BLOB TO PICTURE:C682($blob;$picture)
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10(Table:C252(->[Familia:78]);"0000")
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Familia:78]Numero:1)+$extension
		xDOC_Picture_SetMaxSize (->$picture;768)
		xDOC_WriteExternalPicture ($picture;$folder;$fileName;$pictureFormat;True:C214)
		CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
		PICTURE TO BLOB:C692($thumbnail;$blob;".jpg")
		BASE64 ENCODE:C895($blob;$valor->)
	: (KRL_isSameField ($y_campo;->[Profesores:4]Firma:15))
		BASE64 DECODE:C896($valor->;$blob)
		BLOB TO PICTURE:C682($blob;$picture)
		If (Picture size:C356($picture)>0)
			PICTURE PROPERTIES:C457($picture;$l_anchoImagen;$l_altoImagen)
			If ($l_anchoImagen>240)
				$r_factor:=240/$l_anchoImagen
				TRANSFORM PICTURE:C988($picture;Scale:K61:2;$r_factor;$r_Factor)
			End if 
			PICTURE PROPERTIES:C457($picture;$l_anchoImagen;$l_altoImagen)
			If ($l_altoImagen>80)
				$r_factor:=80/$l_altoImagen
				TRANSFORM PICTURE:C988($picture;Scale:K61:2;$r_factor;$r_Factor)
			End if 
		End if 
		PICTURE TO BLOB:C692($picture;$blob;".jpg")
		BASE64 ENCODE:C895($blob;$valor->)
	: (KRL_isSameField ($y_campo;->[Profesores:4]Fotografia:59))
		BASE64 DECODE:C896($valor->;$blob)
		BLOB TO PICTURE:C682($blob;$picture)
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10(Table:C252(->[Profesores:4]);"0000")
		$fileName:=<>gCountryCode+"."+<>gRolBD+String:C10([Profesores:4]Numero:1)+$extension
		xDOC_Picture_SetMaxSize (->$picture;768)
		xDOC_WriteExternalPicture ($picture;$folder;$fileName;$pictureFormat;True:C214)
		CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
		PICTURE TO BLOB:C692($thumbnail;$blob;".jpg")
		BASE64 ENCODE:C895($blob;$valor->)
		$id:=[Profesores:4]Numero:1
		$data:=SN3_DTi_Profesores
		$marcar:=True:C214
	: (KRL_isSameField ($y_campo;->[Personas:7]Fotografia:43))
		BASE64 DECODE:C896($valor->;$blob)
		BLOB TO PICTURE:C682($blob;$picture)
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10(Table:C252(->[Personas:7]);"0000")
		$fileName:=<>gCountryCode+"."+<>gRolBD+String:C10([Personas:7]No:1)+$extension
		xDOC_Picture_SetMaxSize (->$picture;768)
		xDOC_WriteExternalPicture ($picture;$folder;$fileName;$pictureFormat;True:C214)
		CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
		PICTURE TO BLOB:C692($thumbnail;$blob;".jpg")
		BASE64 ENCODE:C895($blob;$valor->)
		$id:=[Personas:7]No:1
		$marcar:=True:C214
		$data:=SN3_DTi_RelacionesFamiliares
	: (KRL_isSameField ($y_campo;->[Alumnos:2]Fotografía:78))
		BASE64 DECODE:C896($valor->;$blob)
		BLOB TO PICTURE:C682($blob;$picture)
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10(Table:C252(->[Alumnos:2]);"0000")
		$fileName:=<>gCountryCode+"."+<>gRolBD+String:C10([Alumnos:2]numero:1)+$extension
		xDOC_Picture_SetMaxSize (->$picture;768)
		xDOC_WriteExternalPicture ($picture;$folder;$fileName;$pictureFormat;True:C214)
		CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
		PICTURE TO BLOB:C692($thumbnail;$blob;".jpg")
		BASE64 ENCODE:C895($blob;$valor->)
		$id:=[Alumnos:2]numero:1
		$data:=SN3_DTi_Alumnos
		$marcar:=True:C214
	: (KRL_isSameField ($y_campo;->[Familia_RelacionesFamiliares:77]Tipo_Relación:4))
		Case of 
			: ($valor->="Sin Información")
				$valor->:="0"
			: (Find in array:C230(<>APARENTESCO;$valor->)>-1)
				$el:=Find in array:C230(<>APARENTESCO;$valor->)
				If ($el=11)
					[Familia_RelacionesFamiliares:77]Parentesco:6:=$valor->
					$valor->:="11"
				Else 
					$valor->:=String:C10($el)
				End if 
		End case 
	Else 
		$0:=False:C215
End case 
If ($marcar)
	SN3_MarcarRegistros ($data;0;$id)
End if 
