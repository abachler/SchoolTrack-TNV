//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 18-07-18, 16:06:32
  // ----------------------------------------------------
  // Método: UD_v20180718_ReparaObjMaterias
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



C_BOOLEAN:C305($b_guardar;$b_isFolder)
C_LONGINT:C283($l_categorias;$l_indice;$l_indiceAttr)
C_OBJECT:C1216($o_attr;$o_objeto)
C_TEXT:C284($t_isFolder)

ARRAY TEXT:C222($at_atribtutos;0)
ARRAY TEXT:C222($at_atributosCat;0)
ARRAY OBJECT:C1221($ao_categorias;0)

READ WRITE:C146([xxSTR_Materias:20])
ALL RECORDS:C47([xxSTR_Materias:20])


$b_isFolder:=True:C214

SELECTION TO ARRAY:C260([xxSTR_Materias:20];$al_recNumMaterias)
$l_progress:=IT_Progress (1;0;0;"Verificando observaciones predefinidas...")
For ($l_indice;1;Size of array:C274($al_recNumMaterias))
	$l_progress:=IT_Progress (0;$l_progress;$l_indice/Size of array:C274($al_recNumMaterias);"Verificando observaciones predefinidas...")
	GOTO RECORD:C242([xxSTR_Materias:20];$al_recNumMaterias{$l_indice})
	$o_objeto:=[xxSTR_Materias:20]ob_Observaciones:7
	OB GET PROPERTY NAMES:C1232($o_objeto;$at_atribtutos)
	$b_guardar:=False:C215
	
	For ($l_indiceAttr;1;Size of array:C274($at_atribtutos))
		$o_attr:=OB Get:C1224($o_objeto;$at_atribtutos{$l_indiceAttr})
		OB GET ARRAY:C1229($o_attr;"categorias";$ao_categorias)
		
		For ($l_categorias;1;Size of array:C274($ao_categorias))
			OB GET PROPERTY NAMES:C1232($ao_categorias{$l_categorias};$at_atributosCat)
			If (Find in array:C230($at_atributosCat;"is folder")#-1)
				$b_isFolder:=OB Get:C1224($ao_categorias{$l_categorias};"is folder")
				OB REMOVE:C1226($ao_categorias{$l_categorias};"is folder")
				OB SET:C1220($ao_categorias{$l_categorias};"isFolder";$b_isFolder)
				$b_guardar:=True:C214
			End if 
		End for 
		
		If ($b_guardar)  //MONO FIX 20180809
			OB SET ARRAY:C1227($o_attr;"categorias";$ao_categorias)
			OB SET:C1220($o_objeto;$at_atribtutos{$l_indiceAttr};$o_attr)
		End if 
		
	End for 
	
	If ($b_guardar)  //MONO FIX 20180809
		[xxSTR_Materias:20]ob_Observaciones:7:=$o_objeto
		SAVE RECORD:C53([xxSTR_Materias:20])
	End if 
	
End for 
IT_Progress (-1;$l_progress)
KRL_UnloadReadOnly (->[xxSTR_Materias:20])