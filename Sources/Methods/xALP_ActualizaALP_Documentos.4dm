//%attributes = {}
  //xALP_ActualizaALP_Documentos

_O_C_INTEGER:C282($row;$col;$idForm)
C_TEXT:C284($idFormText)
ARRAY LONGINT:C221($IdsDocumentos;0)
_O_C_INTEGER:C282($indice)

ARRAY TEXT:C222(atNombresDocumentos;0)
ARRAY TEXT:C222(atTagDocumentos;0)
ARRAY LONGINT:C221(aiIDDocumentos;0)
ARRAY PICTURE:C279(apIncluirEnFormulario;0)
ARRAY BOOLEAN:C223(abIncluirEnFormulario;0)
ARRAY BOOLEAN:C223(abSiObligatorio;0)
ARRAY TEXT:C222(atEtiqueta;0)

AT_Initialize (->apIncluirEnFormulario;->atNombresDocumentos;->abSiObligatorio;->aiIDDocumentos;->abIncluirEnFormulario;->aiCrearDocumento)

$col:=AL_GetColumn (xALP_FormulariosOpciones)
$row:=AL_GetLine (xALP_FormulariosOpciones)

AL_GetCellValue (xALP_FormulariosOpciones;$row;1;$idFormText)
$idForm:=Num:C11($idFormText)

GET PICTURE FROM LIBRARY:C565(12096;imgSi)
GET PICTURE FROM LIBRARY:C565(19879;imgNo)

If ($idForm=0)
	$idForm:=-1
End if 

  //QUERY([xxADT_DocumentosFormulario];[xxADT_DocumentosFormulario]ID_Formulario=$idForm)
  //SELECTION TO ARRAY([xxADT_DocumentosFormulario]Es_Obligatorio;abSiObligatorio)

QUERY:C277([xxADT_DocumentosFormulario:260];[xxADT_DocumentosFormulario:260]ID_Formulario:2=$idForm;*)
QUERY:C277([xxADT_DocumentosFormulario:260]; & ;[xxADT_DocumentosFormulario:260]Documento_presente:3=True:C214)
SELECTION TO ARRAY:C260([xxADT_DocumentosFormulario:260]ID_Documento:1;$IdsDocumentos)

READ ONLY:C145([xxADT_Documentos:261])
ALL RECORDS:C47([xxADT_Documentos:261])
SELECTION TO ARRAY:C260([xxADT_Documentos:261]ID_Documento:1;aiIDDocumentos;[xxADT_Documentos:261]Nombre_Documento:2;atNombresDocumentos)


For ($i;1;Size of array:C274(aiIDDocumentos))
	
	QUERY:C277([xxADT_DocumentosFormulario:260];[xxADT_DocumentosFormulario:260]ID_Formulario:2=$idForm)
	
	If (Records in selection:C76([xxADT_DocumentosFormulario:260])>0)
		APPEND TO ARRAY:C911(abSiObligatorio;[xxADT_DocumentosFormulario:260]Es_Obligatorio:5)
	Else 
		APPEND TO ARRAY:C911(abSiObligatorio;False:C215)
	End if 
	
	$indice:=0
	$indice:=Find in array:C230($IdsDocumentos;aiIDDocumentos{$i})
	
	If ($indice#-1)  //loo encontro
		APPEND TO ARRAY:C911(apIncluirEnFormulario;imgSi)
		APPEND TO ARRAY:C911(abIncluirEnFormulario;True:C214)
	Else 
		APPEND TO ARRAY:C911(apIncluirEnFormulario;imgNo)
		APPEND TO ARRAY:C911(abIncluirEnFormulario;False:C215)
	End if 
	
	APPEND TO ARRAY:C911(aiCrearDocumento;0)
End for 

  //para las etiquetas
QUERY:C277([xxADT_CamposFormIdioma:258];[xxADT_CamposFormIdioma:258]ID_Formulario:3=$idForm;*)
QUERY:C277([xxADT_CamposFormIdioma:258]; & ;[xxADT_CamposFormIdioma:258]ID_Idioma:5=idIdiomaActual)
$identificador:=[xxADT_CamposFormIdioma:258]Identificador:1

For ($i;1;Size of array:C274(aiIDDocumentos))
	QUERY:C277([xxADT_EtiquetasDocumentos:259];[xxADT_EtiquetasDocumentos:259]ID_Documento:2=aiIDDocumentos{$i};*)
	QUERY:C277([xxADT_EtiquetasDocumentos:259]; & ;[xxADT_EtiquetasDocumentos:259]Identificador:1=$identificador)
	APPEND TO ARRAY:C911(atEtiqueta;[xxADT_EtiquetasDocumentos:259]Etiqueta:3)
End for 


AL_UpdateArrays (xALP_Documentos;-2)