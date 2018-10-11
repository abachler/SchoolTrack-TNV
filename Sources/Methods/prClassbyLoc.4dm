//%attributes = {}
  //prClassbyLoc

C_LONGINT:C283($males;$females)
$males:=0
$females:=0
QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
  //MONO TICKET 155405
If (Not:C34(Shift down:C543))
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89#True:C214)
End if 
SELECTION TO ARRAY:C260([Alumnos:2]Comuna:14;<>aText1;[Alumnos:2]apellidos_y_nombres:40;<>aText2;[Alumnos:2]Sexo:49;<>aText4)
ARRAY TEXT:C222(<>aText3;Size of array:C274(<>aText1))
$err:=PL_SetArraysNam ($1->;1;3;"◊aText1";"◊aText2";"◊aText3")
For ($i;1;Size of array:C274(<>aText1))
	$males:=$males+Num:C11(<>aText4{$i}="M")
	$females:=$females+Num:C11(<>aText4{$i}="F")
End for 
iTotal:=$males+$females
If ($males#0) & ($females#0)
	sCounts:="Mujeres: "+String:C10($females)+"\r"+"Hombres: "+String:C10($males)
End if 
AT_MultiLevelSort (">>";-><>aText1;-><>aText2)
PL_SetWidths ($1->;1;3;150;300;100)
PL_SetHdrOpts ($1->;2)
PL_SetHeight ($1->;1;1;0;0)
PL_SetHdrStyle ($1->;0;"Tahoma";10;1)
PL_SetStyle ($1->;0;"Tahoma";10;0)
PL_SetHeaders ($1->;1;3;"Comuna";"Alumno";"")
  //PL_SetDividers ($1>>;0,5;"Black";"Black";0;0,5;"Black";"Black";0)
PL_SetFrame ($1->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
PL_SetRepeatVal ($1->;1;1)
PL_SetBrkRowDiv ($1->;0.25;"Black";"Black";0)
PL_SetBrkHeight ($1->;1;1;2)
PL_SetBrkText ($1->;1;1;" \\BreakValue: \\Count";3)
PL_SetBrkColOpt ($1->;1;0;0;1;"Black";"Black";0)
PL_SetBrkStyle ($1->;1;0;"Tahoma";10;1)