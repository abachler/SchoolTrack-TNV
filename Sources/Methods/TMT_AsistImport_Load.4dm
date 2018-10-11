//%attributes = {}
  //TMT_AsistImport_Load
  //MONO: Cargar el resultado de la precarga del archivo de importación del horario emn el Listbox del Asistente.

READ ONLY:C145([Asignaturas:18])
C_TEXT:C284($t_infoBloque)
C_OBJECT:C1216($1;$o_horarioCurso;$o_dias)
C_POINTER:C301($y_listBoxDia)
C_LONGINT:C283($i;$d;$h;$l_idTermometro)

ARRAY TEXT:C222($at_keyHora;0)
ARRAY OBJECT:C1221($ao_dias;0)
ARRAY TEXT:C222($at_dias;0)
ARRAY LONGINT:C221($al_horas;0)

$o_horarioCurso:=$1

  //arrays listbox
ARRAY LONGINT:C221(ai_num_hora;0)
ARRAY TEXT:C222(at_lbdia1;0)
ARRAY TEXT:C222(at_lbdia2;0)
ARRAY TEXT:C222(at_lbdia3;0)
ARRAY TEXT:C222(at_lbdia4;0)
ARRAY TEXT:C222(at_lbdia5;0)
ARRAY TEXT:C222(at_lbdia6;0)

ARRAY TEXT:C222($at_childName;0)
ARRAY OBJECT:C1221($ao_childObj;0)

$l_nodos:=OB_GetChildNodes ($o_horarioCurso;->$at_childName;->$ao_childObj)

$l_idTermometro:=IT_Progress (1;0;0;"Cargando Bloques ...")

For ($i;1;Size of array:C274($at_childName))  //{"idProfesor":255,"dias":{"1":{"horas":[1,2]}}}
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($at_childName))
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=Num:C11($at_childName{$i}))
	$t_infoBloque:=[Asignaturas:18]denominacion_interna:16+"("+String:C10([Asignaturas:18]Numero:1)+")"+"\n"+[Asignaturas:18]Curso:5+"\n"
	$l_id_profe:=OB Get:C1224($ao_childObj{$i};"idProfesor")
	If (($l_id_profe>0) & ($l_id_profe#[Asignaturas:18]profesor_numero:4))
		$t_infoBloque:=$t_infoBloque+"<SPAN STYLE='font-weight:bold'>"+KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$l_id_profe;->[Profesores:4]Apellidos_y_nombres:28)+"</SPAN>"
	Else 
		$t_infoBloque:=$t_infoBloque+[Asignaturas:18]profesor_nombre:13
	End if 
	  //$infoBloque:=$infoBloque+"\n"+$ptr_at_sala->{$DA_Return{$f}}//SALA, no considera en objecto actual
	
	$o_dias:=OB Get:C1224($ao_childObj{$i};"dias")
	$l_nodos:=OB_GetChildNodes ($o_dias;->$at_dias;->$ao_dias)
	
	For ($d;1;Size of array:C274($at_dias))
		
		$y_listBoxDia:=Get pointer:C304("at_lbdia"+$at_dias{$d})  //obtengo puntero al arreglo de días
		
		OB GET ARRAY:C1229($ao_dias{$d};"horas";$al_horas)
		
		For ($h;1;Size of array:C274($al_horas))
			
			Case of 
				: (Find in array:C230(ai_num_hora;$al_horas{$h})=-1)
					APPEND TO ARRAY:C911(ai_num_hora;$al_horas{$h})
					AT_Insert (0;1;->at_lbdia1;->at_lbdia2;->at_lbdia3;->at_lbdia4;->at_lbdia5;->at_lbdia6)
					$y_listBoxDia->{Size of array:C274($y_listBoxDia->)}:=$t_infoBloque
				: (Find in array:C230($at_keyHora;$at_dias{$d}+"."+String:C10($al_horas{$h}))>0)
					APPEND TO ARRAY:C911(ai_num_hora;$al_horas{$h})
					AT_Insert (0;1;->at_lbdia1;->at_lbdia2;->at_lbdia3;->at_lbdia4;->at_lbdia5;->at_lbdia6)
					$y_listBoxDia->{Size of array:C274($y_listBoxDia->)}:=$t_infoBloque
				Else 
					$fia:=Find in array:C230(ai_num_hora;$al_horas{$h})
					If ($y_listBoxDia->{$fia}#"")
						
					End if 
					$y_listBoxDia->{$fia}:=$t_infoBloque
			End case 
			APPEND TO ARRAY:C911($at_keyHora;$at_dias{$d}+"."+String:C10($al_horas{$h}))
			
		End for 
		
	End for 
	
End for 
SORT ARRAY:C229(ai_num_hora;at_lbdia1;at_lbdia2;at_lbdia3;at_lbdia4;at_lbdia5;at_lbdia6;>)
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)