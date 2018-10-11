//%attributes = {}
  //xALSet_CU_AreaAlumnos



  //Configuration commands for ALP object xAL_StdList
$err:=AL_SetArraysNam (xALP_StdList;1;3;"◊aStdNo";"◊aStdWhNme";"◊aStdId")
AL_SetSort (xALP_StdList;1)
AL_SetFormat (xALP_StdList;1;"###0")
AL_SetMiscOpts (xALP_StdList;0;0;"\\";0;1)
AL_SetColOpts (xALP_StdList;0;0;0;1;0;0;0)
AL_SetWidths (xALP_StdList;1;2;20;220)
AL_SetHeaders (xALP_StdList;1;2;__ ("Nº");__ ("Nombre y apellidos"))
AL_SetRowOpts (xALP_StdList;1;1;1;0;0)
AL_SetSortOpts (xALP_StdList;1;1;0;"";1;1)
AL_SetDrgOpts (xALP_StdList;0;30;1)
$accCode:=String:C10(xALP_StdList)
AL_SetDrgSrc (xALP_StdList;1;$accCode)
AL_SetDrgDst (xALP_StdList;1;$accCode)
AL_SetSort (xALP_StdList;1)
AL_SetScroll (xALP_StdList;0;-3)
ALP_SetDefaultAppareance (xALP_StdList;9;1;4;1;4)
