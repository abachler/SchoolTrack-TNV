C_BLOB:C604($blob)
C_TEXT:C284($path)
C_TEXT:C284($name)
C_PICTURE:C286($imagen)
$name:="Documento"
$r:=CD_Dlog (0;__ ("Para este nuevo documento ¿Desea guardar una versión electrónica?");__ ("");__ ("Si");__ ("No"))
If ($r=1)
	$path:=xfGetFileName 
	If ($path#"")
		$name:=SYS_Path2FileName ($path)
	End if 
End if 
AT_Insert (0;1;->adADT_DFecha;->atADT_DNombre;->abADT_DRevisado;->atADT_DObs;->apADT_DVer;->atADT_DID;->abADT_DElectronico;->atADT_DPath;->apADT_DAbrir;->apADT_DEliminar)
atADT_DNombre{Size of array:C274(atADT_DNombre)}:=$name
adADT_DFecha{Size of array:C274(adADT_DFecha)}:=Current date:C33(*)
atADT_DObs{Size of array:C274(atADT_DObs)}:=""
atADT_DID{Size of array:C274(atADT_DID)}:=DTS_MakeFromDateTime +"_"+String:C10([Alumnos:2]numero:1)
_O_CREATE SUBRECORD:C72([ADT_Candidatos:49]Documentos:50)
[ADT_Candidatos]Documentos'Revisado:=False:C215
[ADT_Candidatos]Documentos'Nombre:=$name
[ADT_Candidatos]Documentos'Fecha:=adADT_DFecha{Size of array:C274(adADT_DFecha)}
[ADT_Candidatos]Documentos'Observaciones:=""
[ADT_Candidatos]Documentos'ID:=atADT_DID{Size of array:C274(atADT_DID)}
If ($path#"")
	[ADT_Candidatos]Documentos'path:=$name
	[ADT_Candidatos]Documentos'Electronico:=True:C214
	abADT_DElectronico{Size of array:C274(abADT_DElectronico)}:=True:C214
	atADT_DPath{Size of array:C274(atADT_DPath)}:=$name
	GET DOCUMENT ICON:C700($path;apADT_DAbrir{Size of array:C274(apADT_DAbrir)};16)
	GET PICTURE FROM LIBRARY:C565(2633;apADT_DVer{Size of array:C274(apADT_DVer)})
	GET PICTURE FROM LIBRARY:C565(19879;apADT_DEliminar{Size of array:C274(apADT_DEliminar)})
	[ADT_Candidatos]Documentos'icono:=apADT_DAbrir{Size of array:C274(apADT_DAbrir)}
	  //guardamos el documento
	$folder:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
	$p:=IT_UThermometer (1;0;__ ("Cargando archivo..."))
	DOCUMENT TO BLOB:C525($path;$blob)
	$err:=xDOC_StoreDocument ($folder+Folder separator:K24:12+$name;->$blob;False:C215;"";"")
	IT_UThermometer (-2;$p)
Else 
	GET PICTURE FROM LIBRARY:C565(27511;apADT_DAbrir{Size of array:C274(apADT_DAbrir)})
	$folder:=SYS_GetServerProperty (XS_DataFileFolder)+"Archivos"+Folder separator:K24:12+"DocsPost "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10([Alumnos:2]numero:1)
	SYS_CreateFolder ($folder)
End if 

AT_Initialize (->adADT_DFecha;->atADT_DNombre;->abADT_DRevisado;->atADT_DObs;->apADT_DVer;->atADT_DID;->abADT_DElectronico;->atADT_DPath;->apADT_DAbrir;->apADT_DEliminar)
_O_ALL SUBRECORDS:C109([ADT_Candidatos:49]Documentos:50)
AT_RedimArrays (_O_Records in subselection:C7([ADT_Candidatos:49]Documentos:50);->apADT_DVer;->apADT_DEliminar)
GET PICTURE FROM LIBRARY:C565(2633;$dummyPict)
AT_Populate (->apADT_DVer;->$dummyPict)
GET PICTURE FROM LIBRARY:C565(19879;$dummyPict)
AT_Populate (->apADT_DEliminar;->$dummyPict)
AT_Initialize (->abADT_DCertificado)
SF_Subtable2Array (->[ADT_Candidatos:49]Documentos:50;->[ADT_Candidatos]Documentos'Revisado;->abADT_DRevisado;->[ADT_Candidatos]Documentos'Nombre;->atADT_DNombre;->[ADT_Candidatos]Documentos'Fecha;->adADT_DFecha;->[ADT_Candidatos]Documentos'Observaciones;->atADT_DObs;->[ADT_Candidatos]Documentos'ID;->atADT_DID;->[ADT_Candidatos]Documentos'Electronico;->abADT_DElectronico;->[ADT_Candidatos]Documentos'path;->atADT_DPath;->[ADT_Candidatos]Documentos'icono;->apADT_DAbrir)
SORT ARRAY:C229(adADT_DFecha;atADT_DNombre;abADT_DRevisado;atADT_DObs;apADT_DVer;atADT_DID;abADT_DElectronico;atADT_DPath;apADT_DVer;apADT_DEliminar;>)
For ($i;1;Size of array:C274(abADT_DElectronico))
	
	If (Num:C11(atADT_DID{$i})<0)
		APPEND TO ARRAY:C911(abADT_DCertificado;True:C214)
	Else 
		APPEND TO ARRAY:C911(abADT_DCertificado;False:C215)
	End if 
	
	If (Not:C34(abADT_DElectronico{$i}))
		GET PICTURE FROM LIBRARY:C565(27511;apADT_DAbrir{$i})
		apADT_DVer{$i}:=apADT_DVer{$i}*0
		apADT_DEliminar{$i}:=apADT_DEliminar{$i}*0
	End if 
End for 

SAVE RECORD:C53([ADT_Candidatos:49])

LISTBOX SELECT ROW:C912(*;"documentos";Size of array:C274(adADT_DFecha);lk replace selection:K53:1)
_O_ENABLE BUTTON:C192(bDelDoc)
REDRAW WINDOW:C456
ARRAY PICTURE:C279(apADT_DTempIcono;0)
COPY ARRAY:C226(apADT_DAbrir;apADT_DTempIcono)