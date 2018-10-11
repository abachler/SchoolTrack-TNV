//%attributes = {}
  //STR_LeePreferenciasConducta2
  //para poder manejar el list variable


  //ànotaciones
ARRAY TEXT:C222(<>atSTR_Anotaciones_categorias;0)
ARRAY TEXT:C222(<>atSTR_Anotaciones_motivo;0)
ARRAY LONGINT:C221(<>aiSTR_Anotaciones_puntaje;0)
ARRAY LONGINT:C221(<>aiID_Matriz;0)
ARRAY LONGINT:C221(<>aiSTR_Anotaciones_motivo_puntaj;0)

  //medidas disciplinarias
  //ticket 149034  27-08-2015
ARRAY TEXT:C222(<>atSTRal_MotivosCastigo;0)

ARRAY LONGINT:C221(aiSTR_Anotaciones_Registradas;0)
ARRAY TEXT:C222(at_STR_CategoriasAnot_Nombres;0)
ARRAY LONGINT:C221(ai_STR_CategoriasAnot_Puntaje;0)
ARRAY TEXT:C222(atSTR_Anotaciones_motivo;0)
ARRAY LONGINT:C221(aiSTR_Anotaciones_puntaje;0)
ARRAY LONGINT:C221(aiSTR_IDCategoria;0)
ARRAY INTEGER:C220(ai_TipoAnotacion;0)
ARRAY PICTURE:C279(ap_TipoAnotacion;0)
C_BLOB:C604(xBlob)

SET BLOB SIZE:C606(xBlob;0)
xBlob:=PREF_fGetBlob (0;"STR_CategoriaAnotaciones";xBlob)
If (BLOB size:C605(xBlob)#0)
	BLOB_Blob2Vars (->xBlob;0;->at_STR_CategoriasAnot_Nombres;->ai_STR_CategoriasAnot_Puntaje;->aiSTR_IDCategoria;->ap_TipoAnotacion;->ai_TipoAnotacion)
End if 
SORT ARRAY:C229(aiSTR_IDCategoria;at_STR_CategoriasAnot_Nombres;ai_STR_CategoriasAnot_Puntaje;ap_TipoAnotacion;ai_TipoAnotacion;>)
$maxID:=aiSTR_IDCategoria{Size of array:C274(aiSTR_IDCategoria)}
For ($i;Size of array:C274(aiSTR_IDCategoria);1;-1)
	If (aiSTR_IDCategoria{$i}=aiSTR_IDCategoria{$i-1})
		aiSTR_IDCategoria{$i}:=$maxID+1
		$maxID:=aiSTR_IDCategoria{$i}
	End if 
End for 



SET BLOB SIZE:C606(xBlob;0)
xBlob:=PREF_fGetBlob (0;"STR_MatrizAnotaciones";xBlob)
If (BLOB size:C605(xBlob)#0)
	BLOB_Blob2Vars (->xBlob;0;-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
End if 


  // eliminamos eventuales duplicados
SORT ARRAY:C229(<>atSTR_Anotaciones_motivo;<>aiID_Matriz;<>atSTR_Anotaciones_categorias;<>aiSTR_Anotaciones_puntaje;<>aiSTR_Anotaciones_motivo_puntaj;>)
$originalSize:=Size of array:C274(<>atSTR_Anotaciones_motivo)
For ($i;Size of array:C274(<>atSTR_Anotaciones_motivo);1;-1)
	If (<>atSTR_Anotaciones_motivo{$i}=<>atSTR_Anotaciones_motivo{$i-1})
		AT_Delete ($i;1;-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
	End if 
End for 
If (Size of array:C274(<>atSTR_Anotaciones_motivo)<$originalSize)
	BLOB_Variables2Blob (->xBlob;0;-><>aiID_Matriz;-><>atSTR_Anotaciones_categorias;-><>atSTR_Anotaciones_motivo;-><>aiSTR_Anotaciones_puntaje;-><>aiSTR_Anotaciones_motivo_puntaj)
	PREF_SetBlob (0;"STR_MatrizAnotaciones";xBlob)
End if 
SORT ARRAY:C229(<>aiID_Matriz;<>atSTR_Anotaciones_categorias;<>atSTR_Anotaciones_motivo;<>aiSTR_Anotaciones_puntaje;<>aiSTR_Anotaciones_motivo_puntaj;>)


For ($i;1;Size of array:C274(<>aiID_Matriz))
	If (<>atSTR_Anotaciones_categorias{$i}="")
		$el:=Find in array:C230(aiSTR_IDCategoria;<>aiID_Matriz{$i})
		If ($el>0)
			<>atSTR_Anotaciones_categorias{$i}:=at_STR_CategoriasAnot_Nombres{$el}
		End if 
	End if 
End for 

SET BLOB SIZE:C606(xBlob;0)

  //BLOQUEO DE INGRESO DE ANOTACIONES
_O_C_INTEGER:C282(<>vi_nd_reg_anotacion)
<>vi_nd_reg_anotacion:=Num:C11(PREF_fGet (0;"ST_BloqueoAnotacionDias";"0"))


  //castigos
ARRAY TEXT:C222(atSTRal_MotivosCastigo;0)
BLOB_Variables2Blob (->xblob;0;->atSTRal_MotivosCastigo)
xblob:=PREF_fGetBlob (0;"MotivosCastigo";xblob)
BLOB_Blob2Vars (->xblob;0;->atSTRal_MotivosCastigo)

  //cargo el arreglo con las medidas
  //ticket 149034  27-08-2015
For ($i;1;Size of array:C274(atSTRal_MotivosCastigo))
	APPEND TO ARRAY:C911(<>atSTRal_MotivosCastigo;atSTRal_MotivosCastigo{$i})
End for 


  //suspensiones
ARRAY TEXT:C222(atSTRal_MotivosSuspension;0)
BLOB_Variables2Blob (->xblob;0;->atSTRal_MotivosSuspension)
xblob:=PREF_fGetBlob (0;"MotivosSuspension";xblob)
BLOB_Blob2Vars (->xblob;0;->atSTRal_MotivosSuspension)

SET BLOB SIZE:C606(xBlob;0)

  //atrasos
STR_LeePreferenciasAtrasos2 



  // ==========================================
  // ABK: 01/05/201
  //  inicializo el elemento 0 de los arreglos que podrían haber 
  //  quedado asignados después de la edición en configuración
  // ==========================================
  // STR_CategoriaAnotaciones
at_STR_CategoriasAnot_Nombres{0}:=""
ai_STR_CategoriasAnot_Puntaje{0}:=0
aiSTR_IDCategoria{0}:=0
ai_TipoAnotacion{0}:=0

  // STR_MatrizAnotaciones
<>atSTR_Anotaciones_motivo{0}:=""
<>atSTR_Anotaciones_categorias{0}:=""
<>aiID_Matriz{0}:=0
<>aiSTR_Anotaciones_puntaje{0}:=0
<>aiSTR_Anotaciones_motivo_puntaj{0}:=0

  //MotivosCastigo
atSTRal_MotivosCastigo{0}:=""

  //MotivosSuspension
atSTRal_MotivosSuspension{0}:=""