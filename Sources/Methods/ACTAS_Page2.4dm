//%attributes = {}
  // Método: ACTAS_Page2
  // 
  // 
  // por Alberto Bachler Klein
  // creación 14/07/17, 16:37:29
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

C_LONGINT:C283($i;$j;$l_indexSubsector;$l_recNum;$l_elementos)
C_OBJECT:C1216($o_firmantes)

ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_autorizacion;0)
ARRAY TEXT:C222($at_codigoAsignatura;0)
ARRAY TEXT:C222($at_NombreProfesor;0)
ARRAY TEXT:C222($at_RunProfesor;0)
ARRAY TEXT:C222($at_uuidProfesor;0)


OB_BlobToObject (->[Cursos:3]xoFirmantesActas_cl:8;->$o_firmantes)
CU_Firmas_LeeFirmantes (->$at_asignaturas;->$at_codigoAsignatura;->$at_uuidProfesor;->$at_NombreProfesor;->$at_RunProfesor;->$at_autorizacion)




ARRAY TEXT:C222(aText1;0)
ARRAY TEXT:C222(aText2;0)
ARRAY TEXT:C222(aText3;0)
ARRAY TEXT:C222(aText4;0)
ARRAY TEXT:C222(aSignAsg;0)
ARRAY TEXT:C222(aSignProf;0)
ARRAY TEXT:C222(aSignAut;0)
ARRAY TEXT:C222(aSignRUNProfesor;0)
ARRAY TEXT:C222(aSignAsgCode;0)



For ($i;1;Size of array:C274($at_autorizacion))
	If (Position:C15("\r";$at_NombreProfesor{$i})>0)
		AT_Text2Array (->aText1;$at_NombreProfesor{$i};"\r")
		AT_Text2Array (->aText2;$at_autorizacion{$i};"\r")
		AT_Text2Array (->aText3;$at_uuidProfesor{$i};"\r")
		AT_Text2Array (->aText4;$at_RunProfesor{$i};"\r")
		If (Size of array:C274(aText3)<Size of array:C274(aText1))
			ARRAY TEXT:C222(aText4;Size of array:C274(aText1))
		End if 
		If (Size of array:C274(aText3)<Size of array:C274(aText1))
			ARRAY TEXT:C222(aText3;Size of array:C274(aText1))
		End if 
		If (Size of array:C274(aText2)<Size of array:C274(aText1))
			ARRAY TEXT:C222(aText2;Size of array:C274(aText1))
		End if 
		For ($j;1;Size of array:C274(aText1))
			$l_elementos:=Size of array:C274(aSignAsg)+1
			AT_Insert ($l_elementos;1;->aSignAsg;->aSignProf;->aSignAut;->aSignRUNProfesor;->aSignAsgCode)
			aSignAsg{$l_elementos}:=$at_asignaturas{$i}
			aSignAsgCode{$l_elementos}:=$at_codigoAsignatura{$i}
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=Num:C11(aText3{$j}))
			If ([Cursos:3]LastFirst_FirstLast:13)
				aSignProf{$l_elementos}:=[Profesores:4]Apellidos_y_nombres:28
			Else 
				aSignProf{$l_elementos}:=[Profesores:4]Nombres_apellidos:40
			End if 
			aSignRUNProfesor{$l_elementos}:=ST_FormatRUT_Chile ([Profesores:4]RUT:27)
			If (Size of array:C274(aText2)>=$j)
				If (aText2{$j}#"")
					aSignAut{$l_elementos}:=aText2{$j}
				Else 
					aSignAut{$l_elementos}:="T"
				End if 
			Else 
				aSignAut{$l_elementos}:="T"
			End if 
		End for 
		ARRAY TEXT:C222(aText1;0)
		ARRAY TEXT:C222(aText2;0)
		ARRAY TEXT:C222(aText3;0)
		ARRAY TEXT:C222(aText4;0)
	Else 
		$l_elementos:=Size of array:C274(aSignAsg)+1
		AT_Insert ($l_elementos;1;->aSignAsg;->aSignProf;->aSignAut;->aSignRUNProfesor;->aSignAsgCode)
		$l_recNum:=Find in field:C653([Profesores:4]Auto_UUID:41;$at_uuidProfesor{$i})
		If ($l_recNum>No current record:K29:2)
			GOTO RECORD:C242([Profesores:4];$l_recNum)
			If ([Cursos:3]LastFirst_FirstLast:13)
				aSignProf{$l_elementos}:=[Profesores:4]Apellidos_y_nombres:28
			Else 
				aSignProf{$l_elementos}:=[Profesores:4]Nombres_apellidos:40
			End if 
			aSignRUNProfesor{$l_elementos}:=ST_FormatRUT_Chile ([Profesores:4]RUT:27)
		Else 
			aSignProf{$l_elementos}:=""
			aSignRUNProfesor{$l_elementos}:=""
		End if 
		
		aSignAsg{$l_elementos}:=$at_asignaturas{$i}
		aSignAut{$l_elementos}:=$at_autorizacion{$i}
		aSignAsgCode{$l_elementos}:=$at_codigoAsignatura{$i}
		If (aSignAsgCode{$l_elementos}="")
			$l_indexSubsector:=Find in array:C230(<>aAsign;aSignAsg{$i})
			If ($l_indexSubsector>0)
				aSignAsgCode{$i}:=<>aAsignCode{$l_indexSubsector}
			End if 
		End if 
	End if 
End for 

For ($i;1;Size of array:C274(aSignAsg))
	$l_indexSubsector:=Find in array:C230(<>aAsign;aSignAsg{$i})
	If ($l_indexSubsector>0)
		If (<>aAsgLongName{$l_indexSubsector}#"")
			aSignAsg{$i}:=<>aAsgLongName{$l_indexSubsector}
		End if 
	End if 
	If (bPrintCodes=1)
		If ($l_indexSubsector>0)
			aSignAsgCode{$i}:=<>aAsgAbrev{$l_indexSubsector}
		End if 
	Else 
		If ($l_indexSubsector>0)
			aSignAsgCode{$i}:=<>aAsignCode{$l_indexSubsector}
		End if 
	End if 
	If (aSignProf{$i}="")
		aSignAut{$i}:=""
	Else 
		If (aSignAut{$i}="")
			aSignAut{$i}:="T"
		End if 
	End if 
End for 
ARRAY TEXT:C222(aSign;Size of array:C274(aSignAsg))
ARRAY TEXT:C222(aSignCom;Size of array:C274(aSignAsg))


sDate:=ST_Uppercase (<>gComuna+", "+DT_SpecialDate2String (Current date:C33))
QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)
If (vi_UppercaseNames=1)
	vTeacher:=Replace string:C233([Profesores:4]Nombres:2+" "+ST_Uppercase ([Profesores:4]Apellido_paterno:3)+" "+ST_Uppercase ([Profesores:4]Apellido_materno:4);"  ";" ")
Else 
	vTeacher:=Replace string:C233([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
End if 
If (vRespName="")
	vRespName1:=vTeacher
Else 
	vRespName1:=vRespName
End if 
