//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 08-05-17, 17:43:43
  // ----------------------------------------------------
  // Método: STWA2_FiltraAsignPref
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_OBJECT:C1216($ob_prefencia)
C_LONGINT:C283($l_posEliminar)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$t_accion:=$4
$l_idUsuario:=STWA2_Session_GetUserSTID ($uuid)
$l_profID:=STWA2_Session_GetProfID ($uuid)

$ob_prefencia:=OB_Create 

Case of 
	: ($t_accion="guardaPreferencia")
		
		$t_preferencia:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"preferencia")
		$ob_preferencia:=OB_JsonToObject ($t_preferencia;"preferencia")
		PREF_SetObject ($l_idUsuario;"PreferenciaBusqueda";$ob_preferencia)
		
		STWA2_FiltraAsignPref ($uuid;$y_ParameterNames;$y_ParameterValues;"cargaPreferenciaBusqueda")
		STWA2_FiltraAsignPref ($uuid;$y_ParameterNames;$y_ParameterValues;"filtraAsignaturasPref")
		
	: ($t_accion="cargaPreferenciaBusqueda")
		C_TEXT:C284($t_id)
		C_BOOLEAN:C305($b_marcado)
		C_OBJECT:C1216($ob_preferencia)
		ARRAY OBJECT:C1221($ao_nombrePreferencias;0)
		
		$ob_preferencia:=PREF_fGetObject ($l_idUsuario;"PreferenciaBusqueda")
		If (Not:C34(OB Is defined:C1231($ob_preferencia)))
			$ob_preferencia:=OB_Create 
		End if 
		
		OB GET ARRAY:C1229($ob_preferencia;"preferencia";$ao_nombrePreferencias)
		For ($i;1;Size of array:C274($ao_nombrePreferencias))
			OB_GET ($ao_nombrePreferencias{$i};->$t_id;"id")
			OB_GET ($ao_nombrePreferencias{$i};->$b_marcado;"marcado")
			
			Case of 
				: ($t_id="profjefe")
					$l_recNum:=Find in field:C653([Cursos:3]Numero_del_profesor_jefe:2;$l_profID)
					
				: ($t_id="proffirm")
					$l_recNum:=Find in field:C653([Asignaturas:18]profesor_firmante_numero:33;$l_profID)
					
				: ($t_id="profasig")
					ARRAY LONGINT:C221($al_nivelNumero;0)
					ARRAY TEXT:C222($at_nivelNombre;0)
					$l_recNum:=Find in field:C653([Asignaturas:18]profesor_numero:4;$l_profID)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=$l_profID)
					KRL_RelateSelection (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;"")
					ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
					SELECTION TO ARRAY:C260([xxSTR_Niveles:6]NoNivel:5;$al_nivelNumero;[xxSTR_Niveles:6]Nivel:1;$at_nivelNombre)
					OB_SET ($ao_nombrePreferencias{$i};->$al_nivelNumero;"nivelnumero")
					OB_SET ($ao_nombrePreferencias{$i};->$at_nivelNombre;"nivelnombre")
				Else 
					$l_recNum:=0
			End case 
			
			$b_habilitar:=True:C214
			If ($l_recNum=-1)
				$b_habilitar:=False:C215
				$b_marcado:=False:C215
			End if 
			OB_SET ($ao_nombrePreferencias{$i};->$b_habilitar;"habilitar")
			OB_SET ($ao_nombrePreferencias{$i};->$b_marcado;"marcado")
			
		End for 
		OB_SET ($ob_preferencia;->$ao_nombrePreferencias;"preferencia")
		PREF_SetObject ($l_idUsuario;"PreferenciaBusqueda";$ob_preferencia)
		
	: ($t_accion="filtraAsignaturasPref")
		C_TEXT:C284($t_id)
		C_BOOLEAN:C305($b_marcado)
		ARRAY OBJECT:C1221($ao_nombrePreferencias;0)
		$continuar:=False:C215
		CREATE EMPTY SET:C140([Asignaturas:18];"temporal")
		
		$ob_preferencia:=PREF_fGetObject ($l_idUsuario;"PreferenciaBusqueda")
		OB GET ARRAY:C1229($ob_preferencia;"preferencia";$ao_nombrePreferencias)
		
		For ($i;1;Size of array:C274($ao_nombrePreferencias))
			OB_GET ($ao_nombrePreferencias{$i};->$t_id;"id")
			OB_GET ($ao_nombrePreferencias{$i};->$b_marcado;"marcado")
			Case of 
				: (($t_id="profjefe") & ($b_marcado))
					QUERY:C277([Cursos:3];[Cursos:3]Numero_del_profesor_jefe:2=$l_profID)
					KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
					KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
					KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
					CREATE SET:C116([Asignaturas:18];"profJefe")
					UNION:C120("profJefe";"temporal";"temporal")
					$continuar:=True:C214
					
				: (($t_id="profasig") & ($b_marcado))
					QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=$l_profID)
					CREATE SET:C116([Asignaturas:18];"profasign")
					UNION:C120("profasign";"temporal";"temporal")
					$continuar:=True:C214
					
				: (($t_id="proffirm") & ($b_marcado))
					QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33=$l_profID)
					CREATE SET:C116([Asignaturas:18];"proffirm")
					UNION:C120("proffirm";"temporal";"temporal")
					$continuar:=True:C214
					
				: (Num:C11($t_id)#0)
					If (Records in set:C195("temporal")>0)
						USE SET:C118("temporal")
						QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=Num:C11($t_id))
						CREATE SET:C116([Asignaturas:18];"temporal")
					End if 
					QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=$l_profID;*)
					QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6=Num:C11($t_id))
					CREATE SET:C116([Asignaturas:18];"nivel")
					UNION:C120("temporal";"nivel";"temporal")
					$continuar:=True:C214
					$l_posEliminar:=$i
			End case 
		End for 
		
		If ($l_posEliminar>0)
			CLEAR VARIABLE:C89($ob_preferencia)
			$ob_preferencia:=OB_Create 
			DELETE FROM ARRAY:C228($ao_nombrePreferencias;$l_posEliminar)
			OB_SET ($ob_preferencia;->$ao_nombrePreferencias;"preferencia")
			PREF_SetObject ($l_idUsuario;"PreferenciaBusqueda";$ob_preferencia)
		End if 
		
		If ($continuar)
			USE SET:C118("temporal")
		Else 
			If (Records in selection:C76([Asignaturas:18])=0)
				dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$l_profID)
			End if 
		End if 
		SET_ClearSets ("profJefe";"profasign";"temporal";"proffirm")
		
End case 

$0:=$ob_preferencia