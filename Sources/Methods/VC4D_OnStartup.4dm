//%attributes = {"shared":true,"executedOnServer":true}
  // VC4D_OnStartup()
  //
  //
  // creado por: Alberto Bachler Klein: 28-01-16, 18:27:36
  // -----------------------------------------------------------
C_DATE:C307($d_fecha)
C_LONGINT:C283($l_elemento;$l_numeroTabla;$l_proceso;$l_processExecTime;$l_processStatus;$l_tipoObjeto)
C_TIME:C306($h_hora)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_code;$t_comentarios;$t_nombreObjeto;$t_nombreObjetoFormulario;$t_nombreTabla;$t_processName;$t_rutaMetodoVC4D;$t_rutaVC4D)

ARRAY BOOLEAN:C223($ab_obsoleto;0)
ARRAY LONGINT:C221($al_hora;0)
ARRAY LONGINT:C221($al_NumeroTabla;0)
ARRAY LONGINT:C221($al_tipoObjeto;0)
ARRAY TEXT:C222($at_code;0)
ARRAY TEXT:C222($at_comentarios;0)
ARRAY TEXT:C222($at_dtsModificacionVC4D;0)
ARRAY TEXT:C222($at_inclusion;0)
ARRAY TEXT:C222($at_modificacion;0)
ARRAY TEXT:C222($at_nombreObjeto;0)
ARRAY TEXT:C222($at_nombreObjetoFormulario;0)
ARRAY TEXT:C222($at_nombreTabla;0)
ARRAY TEXT:C222($at_Rutas;0)
ARRAY TEXT:C222($at_Rutas2;0)
ARRAY TEXT:C222($at_rutasInVC4D;0)
ARRAY TEXT:C222($at_usuario;0)



PROCESS PROPERTIES:C336(Current process:C322;$t_processName;$l_processStatus;$l_processExecTime)

  //TRACE
If ($t_processName#Current method name:C684)
	$l_proceso:=New process:C317(Current method name:C684;Pila_256K;Current method name:C684)
Else 
	
	If ((Not:C34(Is compiled mode:C492)) & (Application type:C494#4D Remote mode:K5:5))
		VC4D_CheckDB 
		$t_rutaVC4D:=VC4D_GetDBPath 
		
		Begin SQL
			USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
		End SQL
		
		Begin SQL
			Select ruta, dts_modificacion from VC4D_Metodos into :$at_rutasInVC4D, :$at_dtsModificacionVC4D;
		End SQL
		
		METHOD GET PATHS:C1163(Path all objects:K72:16;$at_Rutas;*)
		
		For ($i;1;Size of array:C274($at_Rutas))
			If (Find in array:C230($at_rutasInVC4D;$at_Rutas{$i})<0)
				METHOD RESOLVE PATH:C1165($at_Rutas{$i};$l_tipoObjeto;$y_tabla;$t_nombreObjeto;$t_nombreObjetoFormulario;*)
				METHOD GET CODE:C1190($at_Rutas{$i};$t_code;*)
				METHOD GET COMMENTS:C1189($at_Rutas{$i};$t_comentarios;*)
				METHOD GET MODIFICATION DATE:C1170($at_Rutas{$i};$d_fecha;$h_hora;*)
				If (Not:C34(Is nil pointer:C315($y_tabla)))
					$t_nombreTabla:=Table name:C256($y_tabla)
					$l_numeroTabla:=Table:C252($y_tabla)
				Else 
					$t_nombreTabla:=""
					$l_numeroTabla:=0
				End if 
				
				If (Position:C15("Alberto Bachler";$t_code)>0)
					APPEND TO ARRAY:C911($at_usuario;"Alberto Bachler")
				Else 
					APPEND TO ARRAY:C911($at_usuario;"")
				End if 
				APPEND TO ARRAY:C911($al_tipoObjeto;$l_tipoObjeto)
				APPEND TO ARRAY:C911($at_Rutas2;$at_Rutas{$i})
				APPEND TO ARRAY:C911($at_inclusion;String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178))
				APPEND TO ARRAY:C911($at_modificacion;String:C10($d_fecha;ISO date GMT:K1:10;$h_hora))
				APPEND TO ARRAY:C911($at_code;$t_code)
				APPEND TO ARRAY:C911($ab_obsoleto;False:C215)
				APPEND TO ARRAY:C911($al_NumeroTabla;$l_numeroTabla)
				APPEND TO ARRAY:C911($at_nombreTabla;$t_nombreTabla)
				APPEND TO ARRAY:C911($at_nombreObjeto;$t_nombreObjeto)
				APPEND TO ARRAY:C911($at_nombreObjetoFormulario;$t_nombreObjetoFormulario)
				APPEND TO ARRAY:C911($at_comentarios;$t_comentarios)
			End if 
		End for 
		
		
		Begin SQL
			INSERT INTO VC4D_Metodos
			(tipo_objeto, ruta, creador, dts_inclusion, dts_modificacion, codigo_actual, obsoleto, numero_tabla, nombre_tabla, nombre_objeto, nombre_objeto_formulario, comentarios)
			VALUES (:$al_tipoObjeto, :$at_Rutas2, :$at_usuario,  :$at_inclusion,  :$at_modificacion,  :$at_code,  :$ab_obsoleto, :$al_NumeroTabla, :$at_nombreTabla, :$at_nombreObjeto, :$at_nombreObjetoFormulario, :$at_comentarios);
		End SQL
		
		If (Size of array:C274($at_rutasInVC4D)>0)  // hay registros de métodos en la bd VC4D
			For ($i;1;Size of array:C274($at_rutasInVC4D))
				$t_rutaMetodoVC4D:=$at_rutasInVC4D{$i}
				$l_elemento:=Find in array:C230($at_Rutas;$t_rutaMetodoVC4D)
				If ($l_elemento<0)
					Begin SQL
						UPDATE VC4D_Metodos
						SET obsoleto = True
						Where ruta = :$t_rutaMetodoVC4D;
					End SQL
				End if 
			End for 
		End if 
		
		
		
		Begin SQL
			USE DATABASE SQL_INTERNAL;
		End SQL
	End if 
	
End if 


