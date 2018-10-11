//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Patricio Aliaga
  // Fecha y hora: 13-09-18, 17:39:14
  // ----------------------------------------------------
  // Método: STR_ordenNominas
  // Descripción
  // Metodo encargado del CRUD de la prefencia str_ordenNomina
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($t_acción)
C_OBJECT:C1216($0;$o_in)
C_LONGINT:C283($l_nivel)

$t_acción:=$1
If (Count parameters:C259=2)
	$o_in:=$2
End if 

Case of 
	: ($t_acción="readPreference")
		
		$0:=PREF_fGetObject (0;"STR_ordenNominas")
		
	: ($t_acción="query")
		
		C_OBJECT:C1216($o_pref;$o_nivel)
		$o_pref:=STR_ordenNominas ("readPreference")
		If (OB Is defined:C1231($o_pref;String:C10(OB Get:C1224($o_in;"nivel";Is longint:K8:6))))
			$0:=OB Get:C1224($o_pref;String:C10(OB Get:C1224($o_in;"nivel";Is longint:K8:6));Is object:K8:27)
		Else 
			$0:=OB Get:C1224($o_pref;"0";Is object:K8:27)
		End if 
		
		
		
	: ($t_acción="loadInterfaz")
		
		C_POINTER:C301($y_niveles;$y_numeroOrden;$y_cursoNombres;$y_nombres;$y_genero;$y_uso)
		C_LONGINT:C283($i)
		$y_niveles:=OBJECT Get pointer:C1124(Object named:K67:5;"o_Niveles")
		$y_numeroOrden:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abNdeOrden")
		$y_cursoNombres:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abCursoNombres")
		$y_nombres:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abNombres")
		$y_uso:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abUso")
		$y_genero:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abGenero")
		C_OBJECT:C1216($o_conf;$o_in)
		OB SET:C1220($o_in;"nivel";0)
		$o_conf:=STR_ordenNominas ("query";$o_in)
		APPEND TO ARRAY:C911($y_niveles->;"configuración General")
		APPEND TO ARRAY:C911($y_numeroOrden->;OB Get:C1224($o_conf;"NdeOrden";Is boolean:K8:9))
		APPEND TO ARRAY:C911($y_cursoNombres->;OB Get:C1224($o_conf;"CursoNombres";Is boolean:K8:9))
		APPEND TO ARRAY:C911($y_nombres->;OB Get:C1224($o_conf;"Nombres";Is boolean:K8:9))
		APPEND TO ARRAY:C911($y_uso->;OB Get:C1224($o_conf;"UsaGenero";Is boolean:K8:9))
		APPEND TO ARRAY:C911($y_genero->;OB Get:C1224($o_conf;"Genero";Is boolean:K8:9))
		CLEAR VARIABLE:C89($o_conf)
		For ($i;1;Size of array:C274(<>at_NombreNivelesActivos))
			$o_conf:=STR_ordenNominas ("readPreference")
			APPEND TO ARRAY:C911($y_niveles->;<>at_NombreNivelesActivos{$i})
			If (OB Is defined:C1231($o_conf;String:C10(<>AL_NUMERONIVELESACTIVOS{$i})))
				CLEAR VARIABLE:C89($o_conf)
				CLEAR VARIABLE:C89($o_in)
				OB SET:C1220($o_in;"nivel";<>AL_NUMERONIVELESACTIVOS{$i})
				$o_conf:=STR_ordenNominas ("query";$o_in)
				APPEND TO ARRAY:C911($y_numeroOrden->;OB Get:C1224($o_conf;"NdeOrden";Is boolean:K8:9))
				APPEND TO ARRAY:C911($y_cursoNombres->;OB Get:C1224($o_conf;"CursoNombres";Is boolean:K8:9))
				APPEND TO ARRAY:C911($y_nombres->;OB Get:C1224($o_conf;"Nombres";Is boolean:K8:9))
				APPEND TO ARRAY:C911($y_uso->;OB Get:C1224($o_conf;"UsaGenero";Is boolean:K8:9))
				APPEND TO ARRAY:C911($y_genero->;OB Get:C1224($o_conf;"Genero";Is boolean:K8:9))
			Else 
				APPEND TO ARRAY:C911($y_numeroOrden->;False:C215)
				APPEND TO ARRAY:C911($y_cursoNombres->;False:C215)
				APPEND TO ARRAY:C911($y_nombres->;False:C215)
				APPEND TO ARRAY:C911($y_uso->;False:C215)
				APPEND TO ARRAY:C911($y_genero->;False:C215)
			End if 
			CLEAR VARIABLE:C89($o_conf)
		End for 
		OB SET:C1220($o_conf;"status";"ok")
		$0:=$o_conf
		
	: ($t_acción="saveInterfaz")
		
		C_OBJECT:C1216($o_pref;$o_configucciónGeneral;$o_conf)
		C_POINTER:C301($y_niveles;$y_numeroOrden;$y_cursoNombres;$y_nombres;$y_genero;$y_uso)
		C_LONGINT:C283($i)
		$y_niveles:=OBJECT Get pointer:C1124(Object named:K67:5;"o_Niveles")
		$y_numeroOrden:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abNdeOrden")
		$y_cursoNombres:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abCursoNombres")
		$y_nombres:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abNombres")
		$y_uso:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abUso")
		$y_genero:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abGenero")
		
		  // configuración General
		OB SET:C1220($o_configucciónGeneral;"NdeOrden";$y_numeroOrden->{1})
		OB SET:C1220($o_configucciónGeneral;"CursoNombres";$y_cursoNombres->{1})
		OB SET:C1220($o_configucciónGeneral;"Nombres";$y_nombres->{1})
		OB SET:C1220($o_configucciónGeneral;"UsaGenero";$y_uso->{1})
		OB SET:C1220($o_configucciónGeneral;"Genero";$y_genero->{1})
		OB SET:C1220($o_pref;"0";$o_configucciónGeneral)
		  //AT_Delete (1;1;$y_niveles;$y_numeroOrden;$y_cursoNombres;$y_nombres;$y_uso;$y_genero)
		
		  // configuración por Nivel
		For ($i;(Size of array:C274(<>AL_NUMERONIVELESACTIVOS)+1);2;-1)
			If ($y_numeroOrden->{$i} | $y_cursoNombres->{$i} | $y_nombres->{$i} | $y_uso->{$i})
				OB SET:C1220($o_conf;"NdeOrden";$y_numeroOrden->{$i})
				OB SET:C1220($o_conf;"CursoNombres";$y_cursoNombres->{$i})
				OB SET:C1220($o_conf;"Nombres";$y_nombres->{$i})
				OB SET:C1220($o_conf;"UsaGenero";$y_uso->{$i})
				OB SET:C1220($o_conf;"Genero";$y_genero->{$i})
				OB SET:C1220($o_pref;String:C10(<>AL_NUMERONIVELESACTIVOS{($i-1)});$o_conf)
			End if 
			CLEAR VARIABLE:C89($o_conf)
		End for 
		
		PREF_SetObject (0;"STR_ordenNominas";$o_pref)
		
		OB SET:C1220($o_conf;"status";"ok")
		$0:=$o_conf
		
	: ($t_acción="updateInterfaz")
		
		C_OBJECT:C1216($o_log;$o_resp)
		C_POINTER:C301($y_numeroOrden;$y_cursoNombres;$y_nombres;$y_uso;$y_niveles;$y_genero)
		C_TEXT:C284($t_genero)
		
		$y_numeroOrden:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abNdeOrden")
		$y_cursoNombres:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abCursoNombres")
		$y_nombres:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abNombres")
		$y_uso:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abUso")
		$y_niveles:=OBJECT Get pointer:C1124(Object named:K67:5;"o_Niveles")
		$y_genero:=OBJECT Get pointer:C1124(Object named:K67:5;"o_abGenero")
		$y_validar:=OBJECT Get pointer:C1124(Object named:K67:5;OB Get:C1224($o_in;"validar";Is text:K8:3))
		
		If ($y_genero->{Self:C308->})
			$t_genero:="Masculino"
		Else 
			$t_genero:="Femenino"
		End if 
		
		  // objeto para log
		OB SET:C1220($o_log;"nivel";$y_niveles->{Self:C308->})
		OB SET:C1220($o_log;"genero";$t_genero)
		OB SET:C1220($o_log;"registrar";False:C215)
		
		  // Carga de información sobre la interfaz
		If (Not:C34($y_nombres->{Self:C308->}) & Not:C34($y_numeroOrden->{Self:C308->}) & Not:C34($y_cursoNombres->{Self:C308->}))
			
			
			If ($y_validar->=1)
				$y_validar->{Self:C308->}:=True:C214
				CD_Dlog (0;__ ("Debe tener un tipo de orden configurado. Solo la opción de ^0 es opciónal";ST_Qte ("Utiliza Genero")))
			Else 
				
				If ((OB Get:C1224($o_in;"validar";Is text:K8:3)#"o_abUso") & (OB Get:C1224($o_in;"validar";Is text:K8:3)#"o_abGenero"))
					C_LONGINT:C283($l_resp)
					$l_resp:=CD_Dlog (1;__ ("Debe tener un tipo de orden configurado. Si quita esta opción el nivel ^0 utilizara la configuración general.\n\n¿Confirmar cambio?";$y_niveles->{Self:C308->});"";__ ("Si");__ ("No"))
					If ($l_resp=1)
						$y_nombres->{Self:C308->}:=False:C215
						$y_numeroOrden->{Self:C308->}:=False:C215
						$y_cursoNombres->{Self:C308->}:=False:C215
						$y_uso->{Self:C308->}:=False:C215
						$y_genero->{Self:C308->}:=False:C215
						OB SET:C1220($o_log;"tipolog";"general")
						OB SET:C1220($o_log;"registrar";True:C214)
					Else 
						$y_validar->{Self:C308->}:=True:C214
					End if 
				Else 
					$y_numeroOrden->{Self:C308->}:=True:C214
					OB SET:C1220($o_log;"tipolog";"opciónales")
					OB SET:C1220($o_log;"detalle";"uso")
					OB SET:C1220($o_log;"asignación";True:C214)
					$o_resp:=STR_ordenNominas ("log";$o_log)
					OB SET:C1220($o_log;"tipolog";"update")
					OB SET:C1220($o_log;"detalle";"N° de Orden")
					OB SET:C1220($o_log;"registrar";True:C214)
					
				End if 
				
			End if 
			
			
		Else 
			
			If ($y_validar->{Self:C308->})
				Case of 
					: (OB Get:C1224($o_in;"validar";Is text:K8:3)="o_abNdeOrden")
						$y_cursoNombres->{Self:C308->}:=False:C215
						$y_nombres->{Self:C308->}:=False:C215
						OB SET:C1220($o_log;"tipolog";"update")
						OB SET:C1220($o_log;"detalle";"N° de Orden")
						
					: (OB Get:C1224($o_in;"validar";Is text:K8:3)="o_abCursoNombres")
						$y_numeroOrden->{Self:C308->}:=False:C215
						$y_nombres->{Self:C308->}:=False:C215
						OB SET:C1220($o_log;"tipolog";"update")
						OB SET:C1220($o_log;"detalle";"Curso y Nombres")
						
					: (OB Get:C1224($o_in;"validar";Is text:K8:3)="o_abNombres")
						$y_numeroOrden->{Self:C308->}:=False:C215
						$y_cursoNombres->{Self:C308->}:=False:C215
						OB SET:C1220($o_log;"tipolog";"update")
						OB SET:C1220($o_log;"detalle";"Nombres")
						
					: (OB Get:C1224($o_in;"validar";Is text:K8:3)="o_abUso")
						OB SET:C1220($o_log;"tipolog";"opciónales")
						OB SET:C1220($o_log;"detalle";"uso")
						OB SET:C1220($o_log;"asignación";True:C214)
						
						
					: (OB Get:C1224($o_in;"validar";Is text:K8:3)="o_abGenero")
						OB SET:C1220($o_log;"tipolog";"opciónales")
						OB SET:C1220($o_log;"detalle";"genero")
						
				End case 
				
				OB SET:C1220($o_log;"registrar";True:C214)
				
				
			Else 
				
				Case of 
					: (OB Get:C1224($o_in;"validar";Is text:K8:3)="o_abUso")
						OB SET:C1220($o_log;"tipolog";"opciónales")
						OB SET:C1220($o_log;"detalle";"uso")
						OB SET:C1220($o_log;"asignación";False:C215)
						
					: (OB Get:C1224($o_in;"validar";Is text:K8:3)="o_abGenero")
						OB SET:C1220($o_log;"tipolog";"opciónales")
						OB SET:C1220($o_log;"detalle";"genero")
						
				End case 
				
				OB SET:C1220($o_log;"registrar";True:C214)
				
				
			End if 
		End if 
		
		
		
		If (OB Get:C1224($o_log;"registrar";Is boolean:K8:9))
			$o_resp:=STR_ordenNominas ("log";$o_log)
		End if 
		
	: ($t_acción="log")
		
		C_TEXT:C284($t_log)
		$t_log:=__ ("Orden de Nóminas:")+" "
		Case of 
			: (OB Get:C1224($o_in;"tipolog";Is text:K8:3)="general")
				$t_log:=$t_log+__ ("Se quita ordenamiento de nóminas para nivel ^0, esto provocara el uso de la configuración general para este nivel.";OB Get:C1224($o_in;"nivel";Is text:K8:3))
				
			: (OB Get:C1224($o_in;"tipolog";Is text:K8:3)="update")
				$t_log:=$t_log+__ ("Nivel ^0 fue asignado con el orden ^1.";OB Get:C1224($o_in;"nivel";Is text:K8:3);OB Get:C1224($o_in;"detalle";Is text:K8:3))
				
			: (OB Get:C1224($o_in;"tipolog";Is text:K8:3)="opciónales")
				If (OB Get:C1224($o_in;"detalle";Is text:K8:3)="uso")
					If (OB Get:C1224($o_in;"asignación";Is boolean:K8:9))
						$t_log:=$t_log+__ ("Nivel ^0 fue asignado con agrupación por genero, considerando primero el genero ^1.";OB Get:C1224($o_in;"nivel";Is text:K8:3);OB Get:C1224($o_in;"genero";Is text:K8:3))
					Else 
						$t_log:=$t_log+__ ("Nivel ^0 fue removida la agrupación por genero.";OB Get:C1224($o_in;"nivel";Is text:K8:3))
					End if 
				Else 
					$t_log:=$t_log+__ ("Nivel ^0 fue modificado el orden del genero considerando primero el genero ^1.";OB Get:C1224($o_in;"nivel";Is text:K8:3);OB Get:C1224($o_in;"genero";Is text:K8:3))
				End if 
				
		End case 
		
		LOG_RegisterEvt ($t_log)
		C_OBJECT:C1216($o_conf)
		OB SET:C1220($o_conf;"status";"ok")
		$0:=$o_conf
End case 
