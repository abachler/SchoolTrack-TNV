//%attributes = {}
  //TMT_AsistImportAddBlock2Obj
  //MONO

ARRAY TEXT:C222($at_nombrePropiedades;0)
ARRAY OBJECT:C1221($ao_objetos;0)
ARRAY LONGINT:C221($al_bloques;0)

C_POINTER:C301($1;$y_ojb)
C_OBJECT:C1216($2;$o_bloque;$o_ojb)
C_BOOLEAN:C305($b_asigfound)
C_TEXT:C284($t_nodoCurso;$t_nodoAsig;$t_prof)
C_LONGINT:C283($l_dia;$l_hora)

$y_ojb:=$1
$o_bloque:=$2

$b_asigfound:=OB Get:C1224($o_bloque;"asigFound")
$t_nodoCurso:=OB Get:C1224($o_bloque;"curso")
$t_nodoAsig:=OB Get:C1224($o_bloque;"asignatura")
$t_prof:=OB Get:C1224($o_bloque;"profesor")
$l_dia:=OB Get:C1224($o_bloque;"dia")
$l_hora:=OB Get:C1224($o_bloque;"hora")

If ($b_asigfound)
	  //estructura de asignatura encontrada
	
	If (Not:C34(OB Is defined:C1231($y_ojb->;$t_nodoCurso)))
		$o_obj:=OB_Create 
		OB SET:C1220($y_ojb->;$t_nodoCurso;$o_obj)
	End if 
	
	  //ASIGNATURA
	$o_curso:=OB_Create 
	  //$o_curso:=OB Get($o_horario;$t_curso;Is object)
	$l_nodos:=OB_GetChildNodes ($y_ojb->;->$at_nombrePropiedades;->$ao_objetos)
	$fia:=Find in array:C230($at_nombrePropiedades;$t_nodoCurso)
	  //$t_nodoAsig:=String([Asignaturas]Numero)
	If (Not:C34(OB Is defined:C1231($ao_objetos{$fia};$t_nodoAsig)))
		$o_obj:=OB_Create 
		$o_dias:=OB_Create 
		If ($t_prof#"")
			$l_IDprofe:=Num:C11($t_prof)
			If ($l_IDprofe=0)
				$l_IDprofe:=KRL_GetNumericFieldData (->[Profesores:4]Codigo_interno:30;->$t_prof;->[Profesores:4]Numero:1)
			End if 
		Else 
			$l_IDprofe:=0
		End if 
		If ($l_IDprofe=0)
			$l_IDprofe:=[Asignaturas:18]profesor_numero:4
		End if 
		
		OB SET:C1220($o_obj;"idProfesor";$l_IDprofe)
		OB SET:C1220($o_obj;"dias";$o_dias)
		OB SET:C1220($ao_objetos{$fia};$t_nodoAsig;$o_obj)
	End if 
	
	  //DIAS
	$o_dias:=OB_Create 
	OB_GET ($y_ojb->;->$o_dias;$t_nodoCurso+"."+$t_nodoAsig+".dias")
	If (Not:C34(OB Is defined:C1231($o_dias;String:C10($l_dia))))
		ARRAY LONGINT:C221($al_bloques;0)
		$o_diasn:=OB_Create 
		$o_dia:=OB_Create 
		OB_SET ($o_dia;->$al_bloques;"horas")
		OB_SET ($o_dias;->$o_dia;String:C10($l_dia))
	End if 
	
	  //HORAS
	$o_horas:=OB_Create 
	OB_GET ($y_ojb->;->$o_horas;$t_nodoCurso+"."+$t_nodoAsig+".dias")
	$l_nodos:=OB_GetChildNodes ($o_horas;->$at_nombrePropiedades;->$ao_objetos)
	$fia:=Find in array:C230($at_nombrePropiedades;String:C10($l_dia))
	OB_GET ($ao_objetos{$fia};->$al_bloques;"horas")
	
	If (Find in array:C230($al_bloques;$l_hora)=-1)
		APPEND TO ARRAY:C911($al_bloques;$l_hora)
		SORT ARRAY:C229($al_bloques;>)
		OB_SET ($ao_objetos{$fia};->$al_bloques;"horas")
	End if 
	
Else   //estructura de asignatura no encontrada
	
	$t_nivel:=OB Get:C1224($o_bloque;"nivel")
	
	If (Not:C34(OB Is defined:C1231($y_ojb->;$t_nivel)))
		$o_obj:=OB_Create 
		OB SET:C1220($y_ojb->;$t_nivel;$o_obj)
	End if 
	
	  //CURSO
	$o_nivel:=OB_Create 
	$o_nivel:=OB Get:C1224($y_ojb->;$t_nivel)
	If (Not:C34(OB Is defined:C1231($o_nivel;$t_nodoCurso)))
		$o_obj:=OB_Create 
		OB SET:C1220($o_nivel;$t_nodoCurso;$o_obj)
	End if 
	
	  //ASIGNATURA
	
	$o_curso:=OB_Create 
	$o_curso:=OB Get:C1224($o_nivel;$t_nodoCurso;Is object:K8:27)
	If (Not:C34(OB Is defined:C1231($o_curso;$t_nodoAsig)))
		$o_obj:=OB_Create 
		$o_dias:=OB_Create 
		If ($t_prof#"")
			$l_IDprofe:=KRL_GetNumericFieldData (->[Profesores:4]Codigo_interno:30;->$t_prof;->[Profesores:4]Numero:1)
		Else 
			$l_IDprofe:=0
		End if 
		OB SET:C1220($o_obj;"idProfesor";$l_IDprofe)
		OB SET:C1220($o_obj;"dias";$o_dias)
		OB SET:C1220($o_curso;$t_nodoAsig;$o_obj)
	End if 
	
	  //DIAS
	$o_diasAsig:=OB_Create 
	$o_diasAsig:=OB Get:C1224($o_curso;$t_nodoAsig)
	$o_dias:=OB Get:C1224($o_diasAsig;"dias")
	If (Not:C34(OB Is defined:C1231($o_dias;String:C10($l_dia))))
		ARRAY LONGINT:C221($al_bloques;0)
		$o_dia:=OB_Create 
		OB SET:C1220($o_dia;"horas";$al_bloques)
		OB SET:C1220($o_dias;String:C10($l_dia);$o_dia)
	End if 
	
	  //HORAS
	$l_nodos:=OB_GetChildNodes ($o_dias;->$at_nombrePropiedades;->$ao_objetos)
	$fia:=Find in array:C230($at_nombrePropiedades;String:C10($l_dia))
	OB GET ARRAY:C1229($ao_objetos{$fia};"horas";$al_bloques)
	If (Find in array:C230($al_bloques;$l_hora)=-1)
		APPEND TO ARRAY:C911($al_bloques;$l_hora)
		SORT ARRAY:C229($al_bloques;>)
		OB SET ARRAY:C1227($ao_objetos{$fia};"horas";$al_bloques)
	End if 
	
End if 