//%attributes = {}
  //ACTAS_plpPage2


  //If ((◊actas2000=False) | (◊gYear<2000))
  //ACTAS_plpPage2_old 
  //Else 
$err:=PL_SetArraysNam (pl_Firma;1;6;"aSignAsgCode";"aSignAsg";"aSignProf";"aSignRUNProfesor";"aSignAut";"aSign")
PL_SetWidths (pl_firma;1;6;40;190;230;60;120;80)
PL_SetHeaders (pl_Firma;1;6;"Código, N° o Abrev.";"Subsectores o Asignaturas";"Nombre Profesor";"R.U.N.";"Título/Habilitado";"Firma")
PL_SetHdrStyle (pl_Firma;0;vs_actaFont;6;1)
PL_SetFormat (pl_firma;1;"";0;2)
PL_SetFormat (pl_firma;2;"";0;2)
PL_SetFormat (pl_firma;3;"";0;2)
PL_SetFormat (pl_firma;4;"";0;2)
PL_SetFormat (pl_firma;5;"";0;2)
PL_SetFormat (pl_firma;6;"";0;2)
PL_SetStyle (pl_firma;0;vs_actaFont;8;0)
Case of 
	: (Size of array:C274(aSignAsg)<17)
		PL_SetHeight (pl_firma;2;2;0;6)
	: (Size of array:C274(aSignAsg)<27)
		PL_SetHeight (pl_firma;2;2;0;3)
	Else 
		PL_SetHeight (pl_firma;2;0;0;1)
		PL_SetStyle (pl_firma;0;vs_actaFont;7;0)
End case 

PL_SetDividers (pl_Firma;1;"Black";"Black";0;1;"Black";"Black";0)
PL_SetFrame (pl_firma;1;"Black";"Black";0;1;"Black";"Black";0)
PL_SetHdrOpts (pl_firma;1;0)
  //End if 

