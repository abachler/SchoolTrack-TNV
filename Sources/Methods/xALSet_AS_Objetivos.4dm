//%attributes = {}
  //xALSet_AS_Observaciones

bc_MostrarFotografías:=Num:C11(PREF_fGet (USR_GetUserID ;"FotosEnObservaciones";"1"))

AL_RemoveArrays (xALP_ObjxAlu;1;9)
$Error:=AL_SetArraysNam (xALP_ObjxAlu;1;1;"aNtaOrden")
$error:=$error+AL_SetArraysNam (xALP_ObjxAlu;2;1;"aNtaStdNme")
$error:=$error+AL_SetArraysNam (xALP_ObjxAlu;3;1;"aFotografías")
$error:=$error+AL_SetArraysNam (xALP_ObjxAlu;4;1;"aNtaF")
$error:=$error+AL_SetArraysNam (xALP_ObjxAlu;5;1;"aNtaObj")
$error:=$error+AL_SetArraysNam (xALP_ObjxAlu;6;1;"aNtaIDAlumno")
$error:=$error+AL_SetArraysNam (xALP_ObjxAlu;7;1;"aRealNtaF")
$error:=$error+AL_SetArraysNam (xALP_ObjxAlu;8;1;"aNtaStatus")
$error:=$error+AL_SetArraysNam (xALP_ObjxAlu;9;1;"aNtaRegEximicion")

  //column 1 settings
AL_SetHeaders (xALP_ObjxAlu;1;1;__ ("Nº"))
AL_SetWidths (xALP_ObjxAlu;1;1;40)
AL_SetFormat (xALP_ObjxAlu;1;"##";2;0;0;0)
AL_SetHdrStyle (xALP_ObjxAlu;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ObjxAlu;1;"Tahoma";9;0)
AL_SetStyle (xALP_ObjxAlu;1;"Tahoma";9;0)
AL_SetForeColor (xALP_ObjxAlu;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ObjxAlu;1;"White";0;"";(16*15)+2;"";(16*15)+2)  //(16*13)+1
AL_SetEnterable (xALP_ObjxAlu;1;0)

  //column 2 settings
AL_SetHeaders (xALP_ObjxAlu;2;1;__ ("Alumno"))
AL_SetWidths (xALP_ObjxAlu;2;1;180)
AL_SetFormat (xALP_ObjxAlu;2;"";1;0;0;0)
AL_SetHdrStyle (xALP_ObjxAlu;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ObjxAlu;2;"Tahoma";9;0)
AL_SetStyle (xALP_ObjxAlu;2;"Tahoma";9;0)
AL_SetForeColor (xALP_ObjxAlu;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ObjxAlu;2;"White";0;"";(16*15)+2;"";(16*15)+2)  //fondo gris claro
AL_SetEnterable (xALP_ObjxAlu;2;0)

  //column 3 settings
AL_SetHeaders (xALP_ObjxAlu;3;1;__ ("Fotografía"))
AL_SetWidths (xALP_ObjxAlu;3;1;64)
AL_SetFormat (xALP_ObjxAlu;3;"3";1;0;0;0)
AL_SetHdrStyle (xALP_ObjxAlu;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ObjxAlu;3;"Tahoma";9;0)
AL_SetStyle (xALP_ObjxAlu;3;"Tahoma";9;0)
AL_SetForeColor (xALP_ObjxAlu;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ObjxAlu;3;"White";0;"";(16*15)+2;"";(16*15)+2)  //fondo gris claro
AL_SetEnterable (xALP_ObjxAlu;3;0)

  //column 4 settings
AL_SetHeaders (xALP_ObjxAlu;4;1;__ ("Prom."))
AL_SetWidths (xALP_ObjxAlu;4;1;40)
AL_SetFormat (xALP_ObjxAlu;4;"";2;0;0;0)
AL_SetHdrStyle (xALP_ObjxAlu;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ObjxAlu;4;"Tahoma";9;0)
AL_SetStyle (xALP_ObjxAlu;4;"Tahoma";9;0)
AL_SetForeColor (xALP_ObjxAlu;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ObjxAlu;4;"White";0;"";(16*15)+2;"";(16*15)+2)  //fondo gris claro
AL_SetEnterable (xALP_ObjxAlu;4;0)

  //column 5 settings
AL_SetWidths (xALP_ObjxAlu;5;1;496)
AL_SetHeaders (xALP_ObjxAlu;5;1;__ ("Objetivos del período"))
AL_SetFormat (xALP_ObjxAlu;5;"";1;0;0;0)
AL_SetHdrStyle (xALP_ObjxAlu;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_ObjxAlu;5;"Tahoma";9;0)
AL_SetStyle (xALP_ObjxAlu;5;"Tahoma";9;0)
AL_SetForeColor (xALP_ObjxAlu;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_ObjxAlu;5;"White";0;"";1;"";15)
AL_SetEnterable (xALP_ObjxAlu;5;$enterableGrades)


ALP_SetDefaultAppareance (xALP_ObjxAlu;9;5;4;2;8)
AL_SetRowOpts (xALP_ObjxAlu;0;0;0;0;1;0)
AL_SetCellOpts (xALP_ObjxAlu;0;0;0)
AL_SetMiscOpts (xALP_ObjxAlu;0;0;"\\";0;1)
AL_SetColLock (xALP_ObjxAlu;0)
AL_SetDrgOpts (xALP_ObjxAlu;0;30;0)
AL_SetColOpts (xALP_ObjxAlu;1;1;1;4;0)
AL_SetScroll (xALP_ObjxAlu;0;-3)
