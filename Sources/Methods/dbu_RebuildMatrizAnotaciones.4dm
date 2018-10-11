//%attributes = {}
  //dbu_RebuildMatrizAnotaciones

ARRAY TEXT:C222(<>atSTR_Anotaciones_categorias;0)
ARRAY TEXT:C222(<>atSTR_Anotaciones_motivo;0)
ARRAY LONGINT:C221(<>aiSTR_Anotaciones_puntaje;0)
ARRAY LONGINT:C221(<>aiID_Matriz;0)
ARRAY LONGINT:C221(<>aiSTR_Anotaciones_motivo_puntaj;0)
ARRAY TEXT:C222(at_STR_CategoriasAnot_Nombres;0)
ARRAY LONGINT:C221(ai_STR_CategoriasAnot_Puntaje;0)
ARRAY TEXT:C222(atSTR_Anotaciones_motivo;0)
ARRAY LONGINT:C221(aiSTR_Anotaciones_puntaje;0)
ARRAY LONGINT:C221(aiSTR_IDCategoria;0)
ARRAY INTEGER:C220(ai_TipoAnotacion;0)
ARRAY PICTURE:C279(ap_TipoAnotacion;0)
C_BLOB:C604(xBlob)

MESSAGES ON:C181
  //conversion de las anotaciones existentes (versión 5)
QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8="";*)
QUERY:C277([Alumnos_Anotaciones:11]; & [Alumnos_Anotaciones:11]Es_Positiva:2=True:C214)
APPLY TO SELECTION:C70([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Signo:7:="+")
APPLY TO SELECTION:C70([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Puntos:9:=1)
APPLY TO SELECTION:C70([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8:="Positivas")

QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8="";*)
QUERY:C277([Alumnos_Anotaciones:11]; & [Alumnos_Anotaciones:11]Es_Positiva:2=False:C215)
APPLY TO SELECTION:C70([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Signo:7:="-")
APPLY TO SELECTION:C70([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Puntos:9:=-1)
APPLY TO SELECTION:C70([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8:="Negativas")
  //-----------------------------------
MESSAGES OFF:C175

ALL RECORDS:C47([Alumnos_Anotaciones:11])
DISTINCT VALUES:C339([Alumnos_Anotaciones:11]Categoria:8;at_STR_CategoriasAnot_Nombres)
AT_RedimArrays (Size of array:C274(at_STR_CategoriasAnot_Nombres);->ai_STR_CategoriasAnot_Puntaje;->aiSTR_IDCategoria;->ap_TipoAnotacion;->ai_TipoAnotacion)
For ($i;1;Size of array:C274(at_STR_CategoriasAnot_Nombres))
	aiSTR_IDCategoria{$i}:=$i
	QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8=at_STR_CategoriasAnot_Nombres{$i})
	ORDER BY:C49([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Puntos:9;>)
	ai_STR_CategoriasAnot_Puntaje{$i}:=Abs:C99([Alumnos_Anotaciones:11]Puntos:9)
	Case of 
		: ([Alumnos_Anotaciones:11]Signo:7="+")
			ai_TipoAnotacion{$i}:=1
			GET PICTURE FROM LIBRARY:C565("Icono_AnotacionPositiva";$icon)
		: ([Alumnos_Anotaciones:11]Signo:7="=")
			ai_TipoAnotacion{$i}:=0
			GET PICTURE FROM LIBRARY:C565("Icono_AnotacionNeutra";$icon)
		: ([Alumnos_Anotaciones:11]Signo:7="-")
			ai_TipoAnotacion{$i}:=-1
			GET PICTURE FROM LIBRARY:C565("Icono_AnotacionNegativa";$icon)
		: ([Alumnos_Anotaciones:11]Es_Positiva:2)
			ai_TipoAnotacion{$i}:=1
			GET PICTURE FROM LIBRARY:C565("Icono_AnotacionPositiva";$icon)
		: (Not:C34([Alumnos_Anotaciones:11]Es_Positiva:2))
			ai_TipoAnotacion{$i}:=-1
			GET PICTURE FROM LIBRARY:C565("Icono_AnotacionNegativa";$icon)
	End case 
	ap_TipoAnotacion{$i}:=$icon
End for 

ALL RECORDS:C47([Alumnos_Anotaciones:11])
DISTINCT VALUES:C339([Alumnos_Anotaciones:11]Motivo:3;<>atSTR_Anotaciones_motivo)
AT_RedimArrays (Size of array:C274(<>atSTR_Anotaciones_motivo);-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
For ($i;1;Size of array:C274(<>atSTR_Anotaciones_motivo))
	QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Motivo:3=<>atSTR_Anotaciones_motivo{$i})
	<>atSTR_Anotaciones_categorias{$i}:=[Alumnos_Anotaciones:11]Categoria:8
	$pos:=Find in array:C230(at_STR_CategoriasAnot_Nombres;[Alumnos_Anotaciones:11]Categoria:8)
	<>aiID_Matriz{$i}:=aiSTR_IDCategoria{$pos}
	<>aiSTR_Anotaciones_puntaje{$i}:=ai_STR_CategoriasAnot_Puntaje{$pos}
	<>aiSTR_Anotaciones_motivo_puntaj{$i}:=Abs:C99([Alumnos_Anotaciones:11]Puntos:9)
End for 

For ($i;Size of array:C274(at_STR_CategoriasAnot_Nombres);1;-1)
	If (at_STR_CategoriasAnot_Nombres{$i}="")
		AT_Delete ($i;1;->at_STR_CategoriasAnot_Nombres;->ai_STR_CategoriasAnot_Puntaje;->aiSTR_IDCategoria;->ap_TipoAnotacion;->ai_TipoAnotacion)
	End if 
End for 
For ($i;Size of array:C274(<>aiID_Matriz);1;-1)
	If (<>atSTR_Anotaciones_motivo{$i}="")
		AT_Delete ($i;1;-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
	End if 
End for 
SET BLOB SIZE:C606(xBlob;0)
BLOB_Variables2Blob (->xBlob;0;->at_STR_CategoriasAnot_Nombres;->ai_STR_CategoriasAnot_Puntaje;->aiSTR_IDCategoria;->ap_TipoAnotacion;->ai_TipoAnotacion)
PREF_SetBlob (0;"STR_CategoriaAnotaciones";xBlob)
SET BLOB SIZE:C606(xBlob;0)
BLOB_Variables2Blob (->xBlob;0;-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
PREF_SetBlob (0;"STR_MatrizAnotaciones";xBlob)