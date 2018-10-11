//%attributes = {}
  //MINEDUC_DocentesFirmantes

C_BLOB:C604($blob)
ARRAY TEXT:C222($aSignAsg;0)
ARRAY TEXT:C222($aSignProf;0)
ARRAY TEXT:C222($aSignAut;0)
ARRAY TEXT:C222($aStringPrfID;0)
ARRAY TEXT:C222($aAsgCode;0)
ARRAY TEXT:C222($aRUNProfesor;0)
$blob:=PREF_fGetBlob (0;"Firmantes en "+String:C10([Cursos:3]Numero_del_curso:6);$blob)
$objectRef:=OT BLOBToObject ($blob)
OT GetArray ($objectRef;"Asignatura";$aSignAsg)
OT GetArray ($objectRef;"Nombres profesores";$aSignProf)
OT GetArray ($objectRef;"Autorizaciones";$aSignAut)
OT GetArray ($objectRef;"ID Profesores";$aStringPrfID)
OT GetArray ($objectRef;"Codigos asignaturas";$aAsgCode)
OT GetArray ($objectRef;"RUN profesores";$aRUNProfesor)
OT Clear ($objectRef)



ARRAY TEXT:C222(aText1;0)
ARRAY TEXT:C222(aText2;0)
ARRAY TEXT:C222(aText3;0)
ARRAY TEXT:C222(aText4;0)
ARRAY TEXT:C222(aSignAsg;0)
ARRAY TEXT:C222(aSignProf;0)
ARRAY TEXT:C222(aSignAut;0)
ARRAY TEXT:C222(aSignRUNProfesor;0)
ARRAY TEXT:C222(aSignAsgCode;0)
ARRAY TEXT:C222(aStringPrfID;0)


For ($i;1;Size of array:C274($aSignAut))
	If (Position:C15("\r";$aSignProf{$i})>0)
		AT_Text2Array (->aText1;$aSignProf{$i};"\r")
		AT_Text2Array (->aText2;$aSignAut{$i};"\r")
		AT_Text2Array (->aText3;$aStringPrfID{$i};"\r")
		AT_Text2Array (->aText4;$aRUNProfesor{$i};"\r")
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
			$s:=Size of array:C274(aSignAsg)+1
			AT_Insert ($s;1;->aSignAsg;->aSignProf;->aSignAut;->aSignRUNProfesor;->aSignAsgCode;->aStringPrfID)
			aSignAsg{$s}:=$aSignAsg{$i}
			aSignAsgCode{$s}:=$aAsgCode{$i}
			QUERY:C277([Profesores:4];[Profesores:4]Numero:1=Num:C11(aText3{$j}))
			aStringPrfID{$s}:=aText3{$j}
			If ([Cursos:3]LastFirst_FirstLast:13)
				aSignProf{$s}:=[Profesores:4]Apellidos_y_nombres:28
			Else 
				aSignProf{$s}:=[Profesores:4]Nombres_apellidos:40
			End if 
			If (aText4{$j}#"")
				aSignRUNProfesor{$s}:=String:C10(Num:C11(Substring:C12(aText4{$j};1;Length:C16(aText4{$j})-1));"##.###.###-")+aText4{$j}[[Length:C16(aText4{$j})]]
			End if 
			If (Size of array:C274(aText2)>=$j)
				If (aText2{$j}#"")
					aSignAut{$s}:=aText2{$j}
				Else 
					aSignAut{$s}:="T"
				End if 
			Else 
				aSignAut{$s}:="T"
			End if 
		End for 
		ARRAY TEXT:C222(aText1;0)
		ARRAY TEXT:C222(aText2;0)
		ARRAY TEXT:C222(aText3;0)
		ARRAY TEXT:C222(aText4;0)
	Else 
		$s:=Size of array:C274(aSignAsg)+1
		AT_Insert ($s;1;->aSignAsg;->aSignProf;->aSignAut;->aSignRUNProfesor;->aSignAsgCode;->aStringPrfID)
		QUERY:C277([Profesores:4];[Profesores:4]Numero:1=Num:C11($aStringPrfID{$i}))
		aStringPrfID{$s}:=String:C10([Profesores:4]Numero:1)
		If ([Cursos:3]LastFirst_FirstLast:13)
			aSignProf{$s}:=[Profesores:4]Apellidos_y_nombres:28
		Else 
			aSignProf{$s}:=[Profesores:4]Nombres_apellidos:40
		End if 
		If ($aRUNProfesor{$i}#"")
			aSignRUNProfesor{$s}:=String:C10(Num:C11(Substring:C12($aRUNProfesor{$i};1;Length:C16($aRUNProfesor{$i})-1));"##.###.###-")+$aRUNProfesor{$i}[[Length:C16($aRUNProfesor{$i})]]
		End if 
		aSignAsg{$s}:=$aSignAsg{$i}
		aSignAut{$s}:=$aSignAut{$i}
		aSignAsgCode{$s}:=$aAsgCode{$i}
		If (aSignAsgCode{$s}="")
			$posSubsector:=Find in array:C230(<>aAsign;aSignAsg{$i})
			If ($posSubsector>0)
				aSignAsgCode{$i}:=<>aAsignCode{$posSubsector}
				If (aSignAsgCode{$s}="")
					$posSubsector:=Find in array:C230(<>aAsign;aSignAsg{$i})
					If ($posSubsector>0)
						aSignAsgCode{$i}:=<>aAsgAbrev{$posSubsector}
					End if 
				End if 
			End if 
		End if 
	End if 
End for 