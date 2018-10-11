//%attributes = {}
  // MÉTODO: WIZ_STR_RECH
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 13/03/12, 15:26:04
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // WIZ_STR_RECH()
  // ----------------------------------------------------
C_BLOB:C604($x_blob1;$x_blob2)
C_BOOLEAN:C305($b_alumnoGrupoDiferencial;$b_alumnoIntegrado;$b_alumnoOrigenIndigena)
C_LONGINT:C283($i;$iAlumnos;$l_directorioExiste;$l_ListaCodigosEnseñanza;$l_refCodigoEnseñanza)
C_TEXT:C284($t_mensajeConfirmacion;$t_nombreDirectorio;$t_registroUnidadesEducativas;$t_tipoEnseñanza)

ARRAY LONGINT:C221($aRecNums;0)

  // CODIGO PRINCIPAL
EVS_LoadStyles 
vt_msg:=""
vt_folderName:=""
$t_mensajeConfirmacion:=""
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

$l_ListaCodigosEnseñanza:=Load list:C383("cl_CodigosEnseñanza")
ARRAY LONGINT:C221(al_DatosUnidadesEduc_Codes;0)
QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>=0)
ORDER BY:C49([Cursos:3];[Cursos:3]cl_RolBaseDatos:20;>;[Cursos:3]cl_CodigoTipoEnseñanza:21;>)
AT_DistinctsFieldValues (->[Cursos:3]cl_RolBaseDatos:20;->at_RolBD)
If (Size of array:C274(at_RolBD)>1)
	SELECTION TO ARRAY:C260([Cursos:3]cl_CodigoTipoEnseñanza:21;al_DatosUnidadesEduc_Codes;[Cursos:3]cl_RolBaseDatos:20;at_RolBD)
	For ($i;Size of array:C274(al_DatosUnidadesEduc_Codes);1;-1)
		If ((al_DatosUnidadesEduc_Codes{$i}=al_DatosUnidadesEduc_Codes{$i-1}) & (at_RolBD{$i}=at_RolBD{$i-1}))
			AT_Delete ($i;1;->al_DatosUnidadesEduc_Codes;->at_RolBD)
		End if 
	End for 
Else 
	AT_DistinctsFieldValues (->[Cursos:3]cl_CodigoTipoEnseñanza:21;->al_DatosUnidadesEduc_Codes)
End if 
ARRAY TEXT:C222(at_DatosUnidadesEduc_Tipos;Size of array:C274(al_DatosUnidadesEduc_Codes))
For ($i;1;Size of array:C274(at_DatosUnidadesEduc_Tipos))
	SELECT LIST ITEMS BY REFERENCE:C630($l_ListaCodigosEnseñanza;al_DatosUnidadesEduc_Codes{$i})
	GET LIST ITEM:C378($l_ListaCodigosEnseñanza;Selected list items:C379($l_ListaCodigosEnseñanza);$l_refCodigoEnseñanza;$t_tipoEnseñanza)
	If (Size of array:C274(at_RolBD)>1)
		at_DatosUnidadesEduc_Tipos{$i}:=$t_tipoEnseñanza+", Rol BD: "+at_RolBD{$i}
	Else 
		at_DatosUnidadesEduc_Tipos{$i}:=$t_tipoEnseñanza+", Rol BD: "+at_RolBD{1}
	End if 
	
	at_DatosUnidadesEduc_Values{20}:="0"
	at_DatosUnidadesEduc_Values{21}:="0"
	at_DatosUnidadesEduc_Values{22}:="0"
	at_DatosUnidadesEduc_Values{23}:="0"
	QUERY:C277([Cursos:3];[Cursos:3]cl_CodigoTipoEnseñanza:21=al_DatosUnidadesEduc_Codes{$i})
	KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
	CREATE SET:C116([Alumnos:2];"Alumnos")
	LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums)
	For ($iAlumnos;1;Size of array:C274($aRecNums))
		KRL_GotoRecord (->[Alumnos:2];$aRecNums{$iAlumnos})
		$b_alumnoOrigenIndigena:=MDATA_RetornaBooleano (->[Alumnos:2]numero:1;"Origen Indígena")
		$b_alumnoGrupoDiferencial:=MDATA_RetornaBooleano (->[Alumnos:2]numero:1;"En Grupo Diferencial")
		$b_alumnoIntegrado:=MDATA_RetornaBooleano (->[Alumnos:2]numero:1;"Es Alumno Integrado")
		Case of 
			: (($b_alumnoOrigenIndigena) & ($b_alumnoGrupoDiferencial) & ([Alumnos:2]Sexo:49="F"))
				at_DatosUnidadesEduc_Values{20}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{20})+1)  //"20. Als. hombres orígen indígena en Grupos Diferenciales"
			: (($b_alumnoOrigenIndigena) & ($b_alumnoGrupoDiferencial) & ([Alumnos:2]Sexo:49="M"))
				at_DatosUnidadesEduc_Values{21}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{21})+1)  //"21. Als. mujeres orígen indígena en Grupos Diferenciales"
		End case 
		Case of 
			: (($b_alumnoOrigenIndigena) & ($b_alumnoIntegrado) & ([Alumnos:2]Sexo:49="F"))
				at_DatosUnidadesEduc_Values{22}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{22})+1)  //"22. Als. hombres orígen indígena integrados"
			: (($b_alumnoOrigenIndigena) & ($b_alumnoIntegrado) & ([Alumnos:2]Sexo:49="M"))
				at_DatosUnidadesEduc_Values{23}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{23})+1)  //"23. Als. mujeres orígen indígena integradas"
		End case 
	End for 
	
End for 
at_DatosUnidadesEduc_Tipos:=1
al_DatosUnidadesEduc_Codes:=1
$t_registroUnidadesEducativas:="MatriculaInicial_"+String:C10(al_DatosUnidadesEduc_Codes{1})
BLOB_Variables2Blob (->$x_blob2;0;->at_DatosUnidadesEduc_Values)
$x_blob1:=PREF_fGetBlob (0;$t_registroUnidadesEducativas;$x_blob2)
$x_blob2:=$x_blob1
BLOB_Blob2Vars (->$x_blob2;0;->at_DatosUnidadesEduc_Values)

If (at_DatosUnidadesEduc_Values{1}="")
	QUERY:C277([Cursos:3];[Cursos:3]cl_CodigoTipoEnseñanza:21=al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
	at_DatosUnidadesEduc_Values{1}:=Substring:C12([Cursos:3]cl_RolBaseDatos:20;1;Length:C16([Cursos:3]cl_RolBaseDatos:20)-1)
	at_DatosUnidadesEduc_Values{2}:=Substring:C12([Cursos:3]cl_RolBaseDatos:20;Length:C16([Cursos:3]cl_RolBaseDatos:20))
End if 

If (at_DatosUnidadesEduc_Values{3}="")
	at_DatosUnidadesEduc_Values{3}:=String:C10(al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
End if 

WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_CL_Asistente_RECH";-1;8;__ ("Asistentes"))
DIALOG:C40([xxSTR_Constants:1];"STR_CL_Asistente_RECH")
CLOSE WINDOW:C154

If (ok=1)
	  //$t_nombreDirectorio:=vt_Foldername+Folder separator+"Actas"+Folder separator
	$t_nombreDirectorio:=vt_Foldername
	$l_directorioExiste:=Test path name:C476($t_nombreDirectorio)
	If ($l_directorioExiste<0)
		CREATE FOLDER:C475(vt_Foldername)
	End if 
	READ WRITE:C146([Cursos:3])
	QUERY:C277([Cursos:3];[Cursos:3]cl_RolBaseDatos:20="")
	APPLY TO SELECTION:C70([Cursos:3];[Cursos:3]cl_RolBaseDatos:20:=<>gRolBD)
	UNLOAD RECORD:C212([Cursos:3])
	READ ONLY:C145([Cursos:3])
	QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesOficiales)
	
	ARRAY TEXT:C222(aRolesBD;0)
	AT_DistinctsFieldValues (->[Cursos:3]cl_RolBaseDatos:20;->aRolesBD)
	Case of 
		: (r1_Actas=1)
			
			For ($i;1;Size of array:C274(aRolesBD))
				<>gRolBD:=aRolesBD{$i}
				If (b1=1)
					MINEDUC_File1 ($t_nombreDirectorio)
				End if 
				If (b2=1)
					MINEDUC_File2 ($t_nombreDirectorio)
				End if 
				If (b3=1)
					MINEDUC_File3 ($t_nombreDirectorio)
				End if 
				If (b4=1)
					MINEDUC_File4 ($t_nombreDirectorio)
				End if 
				If (b5=1)
					MINEDUC_File5 ($t_nombreDirectorio)
				End if 
				If (b6=1)
					MINEDUC_File6 ($t_nombreDirectorio)
				End if 
				If (b7=1)
					MINEDUC_File7 ($t_nombreDirectorio)
				End if 
				If (b8=1)
					MINEDUC_File8 ($t_nombreDirectorio)
				End if 
			End for 
			$t_mensajeConfirmacion:="La generación de archivos de actas de calificaciones concluyó exitosamente"+"\r\r"
			$t_mensajeConfirmacion:=$t_mensajeConfirmacion+" Los archivos se encuentran en: "+$t_nombreDirectorio
			
		: (r2_Matricula=1)
			$t_nombreDirectorio:=vt_Foldername+Folder separator:K24:12+"Matrícula Inicial"+Folder separator:K24:12
			$l_directorioExiste:=Test path name:C476($t_nombreDirectorio)
			If ($l_directorioExiste<0)
				CREATE FOLDER:C475(vt_Foldername+Folder separator:K24:12+"Matrícula Inicial")
			End if 
			For ($i;1;Size of array:C274(aRolesBD))
				<>gRolBD:=aRolesBD{$i}
				If (b21=1)
					MINEDUC_MatriculaInicial ("21";$t_nombreDirectorio)
				End if 
				If (b22=1)
					MINEDUC_MatriculaInicial ("22";$t_nombreDirectorio)
				End if 
				If (b23=1)
					MINEDUC_MatriculaInicial ("23";$t_nombreDirectorio)
				End if 
				If (b24=1)
					MINEDUC_MatriculaInicial ("24";$t_nombreDirectorio)
				End if 
				If (b25=1)
					MINEDUC_MatriculaInicial ("25";$t_nombreDirectorio)
				End if 
				If (b26=1)
					MINEDUC_MatriculaInicial ("26";$t_nombreDirectorio)
				End if 
			End for 
			$t_mensajeConfirmacion:="La generación de archivos de matrícula inicial concluyó exitosamente"+"\r\r"
			$t_mensajeConfirmacion:=$t_mensajeConfirmacion+" Los archivos se encuentran en: "+$t_nombreDirectorio
			
	End case 
	If ($t_mensajeConfirmacion#"")
		CD_Dlog (0;$t_mensajeConfirmacion)
	End if 
	
	STR_ReadGlobals 
End if 

