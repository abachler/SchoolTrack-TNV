//%attributes = {}
  // VC4D_CheckDB()
  //
  //
  // creado por: Alberto Bachler Klein: 28-02-16, 11:38:33
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_createDB;$b_esObsoleto;$b_metodoEnVC4D)
C_DATE:C307($d_fecha)
C_LONGINT:C283($l_metodos;$l_numeroTabla;$l_resultado;$l_tipoObjeto)
C_TIME:C306($h_hora)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_code;$t_nombreObjeto;$t_nombreObjetoFormulario;$t_nombreTabla;$t_rutaCarpeta;$t_rutaVC4D;$t_valores)

ARRAY BOOLEAN:C223($ab_obsoleto;0)
ARRAY DATE:C224($ad_fecha;0)
ARRAY LONGINT:C221($al_hora;0)
ARRAY LONGINT:C221($al_numeroTabla;0)
ARRAY LONGINT:C221($al_tipoObjeto;0)
ARRAY TEXT:C222($at_code;0)
ARRAY TEXT:C222($at_comentarios;0)
ARRAY TEXT:C222($at_inclusion;0)
ARRAY TEXT:C222($at_modificacion;0)
ARRAY TEXT:C222($at_NombreFormulario;0)
ARRAY TEXT:C222($at_nombreObjeto;0)
ARRAY TEXT:C222($at_nombreObjetoFormulario;0)
ARRAY TEXT:C222($at_nombreTabla;0)
ARRAY TEXT:C222($at_Rutas;0)
ARRAY TEXT:C222($at_rutasInVC4D;0)
ARRAY TEXT:C222($at_usuario;0)


If ((Not:C34(Is compiled mode:C492)) & (Application type:C494#4D Remote mode:K5:5))
	$t_rutaVC4D:=VC4D_GetDBPath 
	
	  // si la BD no existe la creo
	If (Test path name:C476($t_rutaVC4D+".4db")#Is a document:K24:1)
		$b_createDB:=True:C214
		Begin SQL
			CREATE DATABASE IF NOT EXISTS DATAFILE :$t_rutaVC4D;
		End SQL
	End if 
	
	
	If ($b_createDB)
		  // abro la BD y me aseguro que las tablas existan en la BD
		Begin SQL
			USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
		End SQL
		
		
		Begin SQL
			CREATE TABLE IF NOT EXISTS VC4D_Metodos
			(auto_uuid UUID PRIMARY KEY AUTO_GENERATE, ruta VARCHAR, creador VARCHAR, dts_inclusion VARCHAR, dts_modificacion VARCHAR, codigo_actual TEXT, obsoleto BOOLEAN, tipo_objeto INT32, numero_tabla INT32, nombre_tabla varchar, nombre_objeto VARCHAR, nombre_objeto_formulario VARCHAR, comentarios TEXT);
			
			CREATE TABLE IF NOT EXISTS VC4D_HistorialCambios
			(auto_uuid UUID PRIMARY KEY AUTO_GENERATE, uuid_metodo UUID, autor VARCHAR, codigo TEXT, dts_modificacion VARCHAR, comentarios TEXT, commited Boolean);
			
			CREATE TABLE IF NOT EXISTS VC4D_Commits
			(auto_uuid UUID PRIMARY KEY AUTO_GENERATE, dts VARCHAR, usuario VARCHAR, comentarios TEXT, commited_to_url VARCHAR);
			
			CREATE TABLE IF NOT EXISTS VC4D_CommitedCode
			(auto_uuid UUID PRIMARY KEY AUTO_GENERATE, uuid_commit UUID, uuid_metodo UUID, ruta VARCHAR, codigo TEXT);
		End SQL
		
		METHOD GET PATHS:C1163(Path all objects:K72:16;$at_Rutas;*)
		METHOD GET CODE:C1190($at_Rutas;$at_code;*)
		METHOD GET COMMENTS:C1189($at_Rutas;$at_comentarios;*)
		METHOD GET MODIFICATION DATE:C1170($at_Rutas;$ad_fecha;$al_hora;*)
		
		For ($i;1;Size of array:C274($at_Rutas))
			METHOD RESOLVE PATH:C1165($at_Rutas{$i};$l_tipoObjeto;$y_tabla;$t_nombreObjeto;$t_nombreObjetoFormulario;*)
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
			
			$h_hora:=$al_hora{$i}
			APPEND TO ARRAY:C911($al_tipoObjeto;$l_tipoObjeto)
			APPEND TO ARRAY:C911($at_inclusion;String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178))
			APPEND TO ARRAY:C911($at_modificacion;String:C10($ad_fecha{$i};ISO date GMT:K1:10;$h_hora))
			APPEND TO ARRAY:C911($ab_obsoleto;False:C215)
			APPEND TO ARRAY:C911($at_nombreTabla;$t_nombreTabla)
			APPEND TO ARRAY:C911($al_numeroTabla;$l_numeroTabla)
			APPEND TO ARRAY:C911($at_NombreObjeto;$t_nombreObjeto)
			APPEND TO ARRAY:C911($at_nombreObjetoFormulario;$t_nombreObjetoFormulario)
		End for 
		
		Begin SQL
			TRUNCATE TABLE VC4D_Metodos;
			INSERT INTO VC4D_Metodos
			(tipo_objeto, ruta, creador, dts_inclusion, dts_modificacion, codigo_actual, obsoleto, numero_tabla, nombre_tabla, nombre_objeto, nombre_objeto_formulario, comentarios)
			VALUES (:$al_tipoObjeto, :$at_Rutas, :$at_usuario,  :$at_inclusion,  :$at_modificacion,  :$at_code,  :$ab_obsoleto, :$al_NumeroTabla, :$at_nombreTabla, :$at_nombreObjeto, :$at_nombreObjetoFormulario, :$at_comentarios);
		End SQL
		
		Begin SQL
			USE DATABASE SQL_INTERNAL;
		End SQL
	End if 
End if 