//%attributes = {}
  //ACTdc_OnExplorerLoad

C_POINTER:C301($2;$ptr)
C_LONGINT:C283($1;$vl_area;$recs;$i)

$vl_area:=$1
$ptr:=$2
  //$recs:=Size of array($ptr->)
READ ONLY:C145([ACT_Documentos_en_Cartera:182])
$arrayApdo:=Get pointer:C304(atBWR_ArrayNames{1})

ARRAY BOOLEAN:C223($abACT_reemplazado;0)
ARRAY BOOLEAN:C223($abACT_nulo;0)
ARRAY LONGINT:C221($alACT_idsTerceros;0)

CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_en_Cartera:182];$ptr->;"")
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182]Reemplazado:14;$abACT_reemplazado;[ACT_Documentos_de_Pago:176]Nulo:37;$abACT_nulo;\
[ACT_Documentos_en_Cartera:182]ID_Tercero:18;$alACT_idsTerceros)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
For ($i;1;Size of array:C274($abACT_reemplazado))
	  //GOTO RECORD([ACT_Documentos_en_Cartera];$ptr->{$i})
	Case of 
		: (($abACT_reemplazado{$i}) | ($abACT_nulo{$i}))
			AL_SetRowColor ($vl_area;$i;"";15*16+8)
			AL_SetRowStyle ($vl_area;$i;2)
		Else 
			AL_SetRowColor ($vl_area;$i;"";16)
			AL_SetRowStyle ($vl_area;$i;0)
	End case 
	If ($alACT_idsTerceros{$i}#0) & (Table:C252(yBWR_currentTable)#Table:C252(->[ACT_Terceros:138]))
		$arrayApdo->{$i}:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->$alACT_idsTerceros{$i};->[ACT_Terceros:138]Nombre_Completo:9)
	End if 
End for 

  //For ($i;1;$recs)
  //GOTO RECORD([ACT_Documentos_en_Cartera];$ptr->{$i})
  //Case of 
  //: (([ACT_Documentos_en_Cartera]Reemplazado=True) | ([ACT_Documentos_en_Cartera]Estado="Nulo@"))
  //AL_SetRowColor ($vl_area;$i;"";15*16+8)
  //AL_SetRowStyle ($vl_area;$i;2)
  //Else 
  //AL_SetRowColor ($vl_area;$i;"";16)
  //AL_SetRowStyle ($vl_area;$i;0)
  //End case 
  //  //If ([ACT_Documentos_en_Cartera]ID_Tercero#0)
  //If ([ACT_Documentos_en_Cartera]ID_Tercero#0) & (Table(yBWR_currentTable)#Table(->[ACT_Terceros]))
  //$arrayApdo->{$i}:=KRL_GetTextFieldData (->[ACT_Terceros]Id;->[ACT_Documentos_en_Cartera]ID_Tercero;->[ACT_Terceros]Nombre_Completo)
  //End if 
  //End for 
REDUCE SELECTION:C351([ACT_Documentos_en_Cartera:182];0)