//%attributes = {}
  // Método: xALP_ACT_CB_Pagares
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 17:04:36
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal


  //xALP_ACT_CB_Pagares

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (ALP_Carreras;$vl_column;$vl_line)
	Case of 
		: ($vl_column=5)
			$choice:=Find in array:C230(atACT_Matrices;atACTp_Matrices{$vl_line})
			If ($choice>0)
				atACTp_Matrices{$vl_line}:=atACT_Matrices{$choice}
				alACTp_Matrices{$vl_line}:=alACT_Matrices{$choice}
				arACTp_Montos{$vl_line}:=arACT_Montos{$choice}
			End if 
	End case 
End if 

