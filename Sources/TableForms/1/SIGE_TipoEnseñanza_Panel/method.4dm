Case of 
	: (Form event:C388=On Load:K2:1)
		
		C_LONGINT:C283($RECORDS;$proc)
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([Alumnos:2])
		
		EVS_LoadStyles 
		vt_msg:=""
		vt_folderName:=""
		$msg:=""
		
		$proc:=IT_UThermometer (1;0;__ ("Cargando configuración ..."))
		
		ARRAY TEXT:C222(at_DatosUnidadesEduc_Ejemplo;29)
		ARRAY TEXT:C222(at_DatosUnidadesEduc_Names;29)
		ARRAY TEXT:C222(at_DatosUnidadesEduc_Values;0)
		ARRAY TEXT:C222(at_DatosUnidadesEduc_Values;29)
		at_DatosUnidadesEduc_Names{1}:="1. RBD"
		at_DatosUnidadesEduc_Names{2}:="2. Dígito verificador RBD"
		at_DatosUnidadesEduc_Names{3}:="3. Código del tipo de enseñanza"
		at_DatosUnidadesEduc_Names{4}:="4. Indicador de existencia Centro de padres"
		at_DatosUnidadesEduc_Names{5}:="5. Indicador de Personalidad jurídica del Centro de padres"
		at_DatosUnidadesEduc_Names{6}:="6. Número de Res. de autorización del tipo de enseñanza"
		at_DatosUnidadesEduc_Names{7}:="7. Fecha de Res. de autorización del tipo de enseñanza"
		at_DatosUnidadesEduc_Names{8}:="8. Número de Res. de cierre del tipo de enseñanza"
		at_DatosUnidadesEduc_Names{9}:="9. Fecha de Res. de cierre del tipo de enseñanza"
		at_DatosUnidadesEduc_Names{10}:="10. Número de Grupos Diferenciales (Sólo E Básica Niños)"
		at_DatosUnidadesEduc_Names{11}:="11. Horario inicio actividades jornada mañana"
		at_DatosUnidadesEduc_Names{12}:="12. Horario término actividades jornada mañana"
		at_DatosUnidadesEduc_Names{13}:="13. Horario inicio actividades jornada tarde"
		at_DatosUnidadesEduc_Names{14}:="14. Horario término actividades jornada tarde"
		at_DatosUnidadesEduc_Names{15}:="15. Horario inicio actividades jornada mañana y tarde"
		at_DatosUnidadesEduc_Names{16}:="16. Horario término actividades jornada mañana y tarde"
		at_DatosUnidadesEduc_Names{17}:="17. Horario inicio actividades jornada vespertino/nocturna"
		at_DatosUnidadesEduc_Names{18}:="18. Horario término actividades jornada vespertino/nocturna"
		at_DatosUnidadesEduc_Names{19}:="19. Estado del tipo de enseñanza (funcionamiento)"
		at_DatosUnidadesEduc_Names{20}:="20. Als. hombres orígen indígena en Grupos Diferenciales"
		at_DatosUnidadesEduc_Names{21}:="21. Als. mujeres orígen indígena en Grupos Diferenciales"
		at_DatosUnidadesEduc_Names{22}:="22. Als. hombres orígen indígena integrados"
		at_DatosUnidadesEduc_Names{23}:="23. Als. mujeres orígen indígena integradas"
		at_DatosUnidadesEduc_Names{24}:="24. Als. hombres orígen indígena en Práctica (sólo E Media TP)"
		at_DatosUnidadesEduc_Names{25}:="25. Als. mujeres orígen indígena en Práctica (sólo E Media TP)"
		at_DatosUnidadesEduc_Names{26}:="26. Als. hombres orígen indígena Egresados (sólo E Media TP)"
		at_DatosUnidadesEduc_Names{27}:="27. Als. mujeres orígen indígena Egresadas (sólo E Media TP)"
		at_DatosUnidadesEduc_Names{28}:="28. Als. hombres orígen indígena Titulados (sólo E Media TP)"
		at_DatosUnidadesEduc_Names{29}:="29. Als. mujeres orígen indígena Tituladas (sólo E Media TP)"
		
		AT_Inc (0)
		at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Numérico"
		at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Númérico"
		at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Númerico"
		at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Caracter (Si/No)"
		at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Caracter (Si/No)"
		at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Numérico"
		at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Fecha (dd/mm/aaaa)"
		at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Numérico"
		at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Fecha (dd/mm/aaaa)"
		at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Numérico"
		For ($i;11;18)
			at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Hora (hh:mm)"
		End for 
		at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Numérico"
		For ($i;20;29)
			at_DatosUnidadesEduc_Ejemplo{AT_Inc }:="Numérico"
		End for 
		
		$list:=Load list:C383("cl_CodigosEnseñanza")
		ARRAY LONGINT:C221(al_DatosUnidadesEduc_Codes;0)
		ARRAY TEXT:C222(at_RolBD_TE;0)
		  //ALL RECORDS([Cursos])
		QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>=0)
		ORDER BY:C49([Cursos:3];[Cursos:3]cl_RolBaseDatos:20;>;[Cursos:3]cl_CodigoTipoEnseñanza:21;>)
		AT_DistinctsFieldValues (->[Cursos:3]cl_RolBaseDatos:20;->at_RolBD_TE)
		If (Size of array:C274(at_RolBD_TE)>1)
			SELECTION TO ARRAY:C260([Cursos:3]cl_CodigoTipoEnseñanza:21;al_DatosUnidadesEduc_Codes;[Cursos:3]cl_RolBaseDatos:20;at_RolBD_TE)
			For ($i;Size of array:C274(al_DatosUnidadesEduc_Codes);1;-1)
				If ((al_DatosUnidadesEduc_Codes{$i}=al_DatosUnidadesEduc_Codes{$i-1}) & (at_RolBD_TE{$i}=at_RolBD_TE{$i-1}))
					AT_Delete ($i;1;->al_DatosUnidadesEduc_Codes;->at_RolBD_TE)
				End if 
			End for 
		Else 
			AT_DistinctsFieldValues (->[Cursos:3]cl_CodigoTipoEnseñanza:21;->al_DatosUnidadesEduc_Codes)
		End if 
		ARRAY TEXT:C222(at_DatosUnidadesEduc_Tipos;Size of array:C274(al_DatosUnidadesEduc_Codes))
		For ($i;1;Size of array:C274(at_DatosUnidadesEduc_Tipos))
			SELECT LIST ITEMS BY REFERENCE:C630($list;al_DatosUnidadesEduc_Codes{$i})
			GET LIST ITEM:C378($list;Selected list items:C379($list);$ref;$text)
			If (Size of array:C274(at_RolBD_TE)>1)
				at_DatosUnidadesEduc_Tipos{$i}:=$text+", Rol BD: "+at_RolBD_TE{$i}
			Else 
				at_DatosUnidadesEduc_Tipos{$i}:=$text+", Rol BD: "+at_RolBD_TE{1}
			End if 
			
			
			at_DatosUnidadesEduc_Values{20}:="0"
			at_DatosUnidadesEduc_Values{21}:="0"
			at_DatosUnidadesEduc_Values{22}:="0"
			at_DatosUnidadesEduc_Values{23}:="0"
			QUERY:C277([Cursos:3];[Cursos:3]cl_CodigoTipoEnseñanza:21=al_DatosUnidadesEduc_Codes{$i})
			KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
			CREATE SET:C116([Alumnos:2];"Alumnos")
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums)
			For ($iAlumnos;1;Size of array:C274($aRecNums))
				KRL_GotoRecord (->[Alumnos:2];$aRecNums{$iAlumnos})
				$origenIndigena:=MDATA_RetornaBooleano (->[Alumnos:2]numero:1;"Origen Indígena")
				$diferencial:=MDATA_RetornaBooleano (->[Alumnos:2]numero:1;"En Grupo Diferencial")
				$integrado:=MDATA_RetornaBooleano (->[Alumnos:2]numero:1;"Es Alumno Integrado")
				Case of 
					: (($origenIndigena) & ($diferencial) & ([Alumnos:2]Sexo:49="F"))
						at_DatosUnidadesEduc_Values{20}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{20})+1)  //"20. Als. hombres orígen indígena en Grupos Diferenciales"
					: (($origenIndigena) & ($diferencial) & ([Alumnos:2]Sexo:49="M"))
						at_DatosUnidadesEduc_Values{21}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{21})+1)  //"21. Als. mujeres orígen indígena en Grupos Diferenciales"
				End case 
				Case of 
					: (($origenIndigena) & ($integrado) & ([Alumnos:2]Sexo:49="F"))
						at_DatosUnidadesEduc_Values{22}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{22})+1)  //"22. Als. hombres orígen indígena integrados"
					: (($origenIndigena) & ($integrado) & ([Alumnos:2]Sexo:49="M"))
						at_DatosUnidadesEduc_Values{23}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{23})+1)  //"23. Als. mujeres orígen indígena integradas"
				End case 
			End for 
			
		End for 
		at_DatosUnidadesEduc_Tipos:=1
		al_DatosUnidadesEduc_Codes:=1
		$prefRecord:="MatriculaInicial_"+String:C10(al_DatosUnidadesEduc_Codes{1})
		C_BLOB:C604($blob;$blob2)
		BLOB_Variables2Blob (->$blob2;0;->at_DatosUnidadesEduc_Values)
		$blob:=PREF_fGetBlob (0;$prefRecord;$blob2)
		$blob2:=$blob
		BLOB_Blob2Vars (->$blob2;0;->at_DatosUnidadesEduc_Values)
		
		If (at_DatosUnidadesEduc_Values{1}="")
			QUERY:C277([Cursos:3];[Cursos:3]cl_CodigoTipoEnseñanza:21=al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
			at_DatosUnidadesEduc_Values{1}:=Substring:C12([Cursos:3]cl_RolBaseDatos:20;1;Length:C16([Cursos:3]cl_RolBaseDatos:20)-1)
			at_DatosUnidadesEduc_Values{2}:=Substring:C12([Cursos:3]cl_RolBaseDatos:20;Length:C16([Cursos:3]cl_RolBaseDatos:20))
		End if 
		
		If (at_DatosUnidadesEduc_Values{3}="")
			at_DatosUnidadesEduc_Values{3}:=String:C10(al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
		End if 
		
		$err:=ALP_DefaultColSettings (xALP_UNidades;1;"at_DatosUnidadesEduc_Names";__ ("Campo");250)
		$err:=ALP_DefaultColSettings (xALP_UNidades;2;"at_DatosUnidadesEduc_Ejemplo";__ ("Formato");100)
		$err:=ALP_DefaultColSettings (xALP_UNidades;3;"at_DatosUnidadesEduc_Values";__ ("Valores");60)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_UNidades;9;1;4;1;1)
		AL_SetColOpts (xALP_UNidades;1;1;1;0;0)
		AL_SetRowOpts (xALP_UNidades;0;1;0;0;1;1)
		AL_SetCellOpts (xALP_UNidades;0;1;1)
		AL_SetMiscOpts (xALP_UNidades;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_UNidades;"";"")
		AL_SetScroll (xALP_UNidades;0;-3)
		AL_SetEntryOpts (xALP_UNidades;2;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_UNidades;0;30;0)
		AL_SetEnterable (xALP_UNidades;3;1)
		  //dragging options
		
		AL_SetDrgSrc (xALP_UNidades;1;"";"";"")
		AL_SetDrgSrc (xALP_UNidades;2;"";"";"")
		AL_SetDrgSrc (xALP_UNidades;3;"";"";"")
		AL_SetDrgDst (xALP_UNidades;1;"";"";"")
		AL_SetDrgDst (xALP_UNidades;1;"";"";"")
		AL_SetDrgDst (xALP_UNidades;1;"";"";"")
		
		IT_UThermometer (-2;$proc)
		
	: (Form event:C388=On Close Box:K2:21)
		$prefRecord:="MatriculaInicial_"+String:C10(al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
		BLOB_Variables2Blob (->$blob;0;->at_DatosUnidadesEduc_Values)
		PREF_SetBlob (0;$prefRecord;$blob)
		CANCEL:C270
End case 