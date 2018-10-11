//%attributes = {}
C_LONGINT:C283($i;$l_recNumAsig)
C_TEXT:C284($jsonT;$node;$t_json)
C_BOOLEAN:C305($b_conUrl)

ARRAY LONGINT:C221($al_RecNumAdjunto;0)
ARRAY LONGINT:C221($al_IdProfesor;0)
ARRAY TEXT:C222($at_NombreAdjunto;0)
ARRAY TEXT:C222($at_profesorNombre;0)
ARRAY TEXT:C222($at_UUIDAdjunto;0)
ARRAY LONGINT:C221($al_RecNumArchivo;0)
ARRAY TEXT:C222($at_descripcion;0)
ARRAY TEXT:C222($at_URL;0)

$l_recNumAsig:=$1

KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsig;False:C215)
QUERY:C277([Asignaturas_Adjuntos:230];[Asignaturas_Adjuntos:230]id_asignatura:7=[Asignaturas:18]Numero:1)
SELECTION TO ARRAY:C260([Asignaturas_Adjuntos:230];$al_RecNumAdjunto;[Asignaturas_Adjuntos:230]nombre_adjunto:10;$at_NombreAdjunto;*)
SELECTION TO ARRAY:C260([Asignaturas_Adjuntos:230]Auto_UUID:2;$at_UUIDAdjunto;[Asignaturas_Adjuntos:230]id_profesor:9;$al_IdProfesor;[Asignaturas_Adjuntos:230]descripcion:3;$at_descripcion;*)
SELECTION TO ARRAY:C260

ARRAY TEXT:C222($at_profesorNombre;Size of array:C274($al_IdProfesor))
For ($i;1;Size of array:C274($al_IdProfesor))
	QUERY:C277([Profesores:4];[Profesores:4]Numero:1=$al_IdProfesor{$i})
	$at_profesorNombre{$i}:=[Profesores:4]Nombre_comun:21
End for 

  //cargo los recnum de los archivos
AT_RedimArrays (Size of array:C274($al_RecNumAdjunto);->$al_RecNumArchivo;->$at_URL)
For ($i;1;Size of array:C274($al_RecNumAdjunto))
	GOTO RECORD:C242([Asignaturas_Adjuntos:230];$al_RecNumAdjunto{$i})
	QUERY:C277([xShell_Documents:91];[xShell_Documents:91]RelatedID:2=[Asignaturas_Adjuntos:230]ID:1;*)
	QUERY:C277([xShell_Documents:91]; & ;[xShell_Documents:91]RelatedTable:1=Table:C252(->[Asignaturas_Adjuntos:230]))
	$al_RecNumArchivo{$i}:=Record number:C243([xShell_Documents:91])
	$at_URL{$i}:=[xShell_Documents:91]URL:11
	If ($at_URL{$i}#"")
		$b_conUrl:=True:C214
	End if 
End for 


C_OBJECT:C1216($ob_raiz)

OB SET ARRAY:C1227($ob_raiz;"NombreAdjunto";$at_NombreAdjunto)
OB SET ARRAY:C1227($ob_raiz;"UUIDAdjunto";$at_UUIDAdjunto)
OB SET ARRAY:C1227($ob_raiz;"RecNumAdjunto";$al_RecNumAdjunto)
OB SET ARRAY:C1227($ob_raiz;"ProfesorID";$al_IdProfesor)
OB SET ARRAY:C1227($ob_raiz;"ProfesorNombre";$at_profesorNombre)
OB SET ARRAY:C1227($ob_raiz;"descripcion";$at_descripcion)
OB SET ARRAY:C1227($ob_raiz;"rn";$al_RecNumArchivo)
OB SET ARRAY:C1227($ob_raiz;"url";$at_URL)
OB SET:C1220($ob_raiz;"conURL";$b_conUrl)
$json:=JSON Stringify:C1217($ob_raiz)
$0:=$json
