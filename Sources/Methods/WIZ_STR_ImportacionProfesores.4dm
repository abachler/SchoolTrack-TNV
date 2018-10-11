//%attributes = {}
  //WIZ_STR_ImportacionProfesores

IT_MODIFIERS 
C_POINTER:C301($y_nil)
C_LONGINT:C283(viIOstr_PlatFormSource)
C_TEXT:C284(vtIOstr_FilePath;vt_subjects)

ARRAY PICTURE:C279(aRecordFieldKey;0)
ARRAY PICTURE:C279(aRecordFieldModifiable;0)
ARRAY TEXT:C222(aRecordLine;0)
ARRAY LONGINT:C221(aRecordLineElement;0)
ARRAY TEXT:C222(aRecordFieldNames;0)
ARRAY POINTER:C280(aRecordFieldPointers;0)
ARRAY INTEGER:C220(aRecordFieldModAtt;0)
ARRAY TEXT:C222(aSourceDataName;0)
ARRAY LONGINT:C221(aSourceDataElement;0)
document:=""

READ ONLY:C145([xShell_Fields:52])
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=Table:C252(->[Profesores:4]);*)
QUERY:C277([xShell_Fields:52]; & [xShell_Fields:52]EsImportable:13#0)
SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroTabla:1;$ai_numeroTabla;[xShell_Fields:52]NumeroCampo:2;$ai_numeroCampo;[xShell_Fields:52]EsImportable:13;$ai_CampoEsImportable;[xShell_Fields:52]NombreCampo:3;$at_alias)
For ($i;1;Size of array:C274($ai_numeroCampo))
	$at_alias{$i}:=XSvs_nombreCampoLocal_Numero ($ai_numeroTabla{$i};$ai_numeroCampo{$i})
End for 
SORT ARRAY:C229($at_alias;$ai_numeroTabla;$ai_numeroCampo;$ai_CampoEsImportable;>)
For ($i;1;Size of array:C274($ai_numeroCampo))
	APPEND TO ARRAY:C911(aRecordFieldNames;"[Profesor]"+$at_alias{$i})
	APPEND TO ARRAY:C911(aRecordFieldPointers;Field:C253($ai_numeroTabla{$i};$ai_numeroCampo{$i}))
	APPEND TO ARRAY:C911(aRecordFieldModAtt;$ai_CampoEsImportable{$i})
End for 

QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FileNo:6=Table:C252(->[Profesores:4]))
While (Not:C34(End selection:C36([xShell_Userfields:76])))
	APPEND TO ARRAY:C911(aRecordFieldNames;"[Profesor]"+[xShell_Userfields:76]UserFieldName:1)
	APPEND TO ARRAY:C911(aRecordFieldModAtt;1)
	APPEND TO ARRAY:C911(aRecordFieldPointers;$y_Nil)
	NEXT RECORD:C51([xShell_Userfields:76])
End while 



APPEND TO ARRAY:C911(aRecordFieldPointers;->vt_subjects)
APPEND TO ARRAY:C911(aRecordFieldNames;"[Profesor]Subsectores autorizados")
APPEND TO ARRAY:C911(aRecordFieldModAtt;1)


ARRAY TEXT:C222(aSourceDataName;Size of array:C274(aRecordFieldNames))
ARRAY LONGINT:C221(aSourceDataElement;Size of array:C274(aRecordFieldNames))
ARRAY PICTURE:C279(aRecordFieldKey;Size of array:C274(aRecordFieldNames))
ARRAY PICTURE:C279(aRecordFieldModifiable;Size of array:C274(aRecordFieldNames))

GET PICTURE FROM LIBRARY:C565(30215;$pict)
GET PICTURE FROM LIBRARY:C565(24456;$pen)
GET PICTURE FROM LIBRARY:C565(5381;$barredPen)
$el:=Find in array:C230(aRecordFieldNames;"[Profesores]RUT")
If ($el>0)
	aRecordFieldKey{$el}:=$pict
End if 


For ($i;1;Size of array:C274(aRecordFieldNames))
	Case of 
		: ((aRecordFieldModAtt{$i}=-1) | (Picture size:C356(aRecordFieldKey{$i})>0))
			aRecordFieldModifiable{$i}:=$barredPen
		: (aRecordFieldModAtt{$i}=1)
			aRecordFieldModifiable{$i}:=$pen
	End case 
End for 

If (<>shift)  //guarda en un archivo texto los nombres de los campos 
	$text:=AT_array2text (->aRecordFieldNames;"\t")
	$ref:=Create document:C266("";"TEXT")
	SEND PACKET:C103($ref;$text)
	CLOSE DOCUMENT:C267($ref)
End if 

WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_Asistente_ImportaProfes";-1;4;__ ("Asistentes"))
DIALOG:C40([xxSTR_Constants:1];"STR_Asistente_ImportaProfes")
CLOSE WINDOW:C154


If (ok=1)
	IOstr_importTeachersData (vtIOstr_FilePath)
	FLUSH CACHE:C297
End if 