//%attributes = {"shared":true,"executedOnServer":true}
  // VC4D_GetData()
  //
  //
  // creado por: Alberto Bachler Klein: 09-02-16, 10:30:09
  // -----------------------------------------------------------
C_OBJECT:C1216($0)
C_TEXT:C284($1)

C_OBJECT:C1216($o_data;$o_parametros)
C_DATE:C307($d_fechaModif)
C_LONGINT:C283($l_desde;$l_metodos;$l_tipoObjeto)
C_TIME:C306($h_horaModif)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_dtsDesde;$t_dtsHasta;$t_nombreObjeto;$t_nombreObjetoFormulario;$t_rutaVC4D;$t_tabla;$t_uuid)

ARRAY BOOLEAN:C223($ab_obsoleto;0)
ARRAY LONGINT:C221($al_tipoObjeto;0)
ARRAY TEXT:C222($at_autor;0)
ARRAY TEXT:C222($at_codigo;0)
ARRAY TEXT:C222($at_creador;0)
ARRAY TEXT:C222($at_dtsInclusion;0)
ARRAY TEXT:C222($at_dtsModificacion;0)
ARRAY TEXT:C222($at_nombreObjeto;0)
ARRAY TEXT:C222($at_nombreObjetoFormulario;0)
ARRAY TEXT:C222($at_nombreTabla;0)
ARRAY TEXT:C222($at_ruta;0)
ARRAY TEXT:C222($at_uuidMetodo;0)
ARRAY TEXT:C222($at_rutaMetodos;0)



If (False:C215)
	C_OBJECT:C1216(VC4D_GetData ;$0)
	C_TEXT:C284(VC4D_GetData ;$1)
End if 

$t_tabla:=$1
If (Count parameters:C259=2)
	$o_parametros:=$2
End if 
$t_dtsDesde:=OB Get:C1224($o_parametros;"dtsDesde")
$t_dtsHasta:=OB Get:C1224($o_parametros;"dtsHasta")

If ($t_dtsHasta="")
	$t_dtsHasta:=String:C10(Current date:C33;ISO date:K1:8;Current time:C178)
End if 

$t_rutaVC4D:=VC4D_GetDBPath 

Case of 
		  //: (Macintosh option down | Windows Alt down)
	: ($t_tabla="VC4D_HistorialCambios")
		METHOD GET PATHS:C1163(Path all objects:K72:16;$at_rutaMetodos)
		$l_metodos:=Size of array:C274($at_rutaMetodos)
		AT_Initialize (->$at_ruta;->$al_tipoObjeto;->$at_nombreTabla;->$at_nombreObjeto;->$at_nombreObjetoFormulario;->$at_autor;->$at_dtsInclusion;->$at_dtsModificacion;->$ab_obsoleto;->$at_ruta;->$at_uuidMetodo)
		For ($i;1;$l_metodos)
			METHOD GET MODIFICATION DATE:C1170($at_rutaMetodos{$i};$d_fechaModif;$h_horaModif;*)
			$t_dts:=String:C10($d_fechaModif;ISO date:K1:8;$h_horaModif)
			If (($t_dts>=$t_dtsDesde) & ($t_dts<=$t_dtsHasta))
				METHOD RESOLVE PATH:C1165($at_rutaMetodos{$i};$l_tipoObjeto;$y_tabla;$t_nombreObjeto;$t_nombreObjetoFormulario;*)
				APPEND TO ARRAY:C911($at_ruta;$at_rutaMetodos{$i})
				APPEND TO ARRAY:C911($al_tipoObjeto;$l_tipoObjeto)
				If (Not:C34(Is nil pointer:C315($y_tabla)))
					APPEND TO ARRAY:C911($at_nombreTabla;Table name:C256($y_tabla))
				Else 
					APPEND TO ARRAY:C911($at_nombreTabla;"")
				End if 
				APPEND TO ARRAY:C911($at_nombreObjeto;$t_nombreObjeto)
				APPEND TO ARRAY:C911($at_nombreObjetoFormulario;$t_nombreObjetoFormulario)
				APPEND TO ARRAY:C911($at_autor;"")
				APPEND TO ARRAY:C911($at_dtsModificacion;$t_dts)
				APPEND TO ARRAY:C911($at_dtsInclusion;$t_dts)
				APPEND TO ARRAY:C911($ab_obsoleto;False:C215)
				APPEND TO ARRAY:C911($at_uuidMetodo;"")
			End if 
		End for 
		
		
		OB SET ARRAY:C1227($o_data;"tipo_objeto";$al_tipoObjeto)
		OB SET ARRAY:C1227($o_data;"nombre_tabla";$at_nombreTabla)
		OB SET ARRAY:C1227($o_data;"nombre_objeto";$at_nombreObjeto)
		OB SET ARRAY:C1227($o_data;"nombre_objeto_formulario";$at_nombreObjetoFormulario)
		OB SET ARRAY:C1227($o_data;"autor";$at_autor)
		OB SET ARRAY:C1227($o_data;"dts_inclusion";$at_dtsInclusion)
		OB SET ARRAY:C1227($o_data;"dts_modificacion";$at_dtsModificacion)
		OB SET ARRAY:C1227($o_data;"obsoleto";$ab_obsoleto)
		OB SET ARRAY:C1227($o_data;"ruta";$at_ruta)
		OB SET ARRAY:C1227($o_data;"uuid_metodo";$at_uuidMetodo)
		
		
		  // tabla métodos en BD VC4D
	: ($t_tabla="VC4d_Metodos")
		  //$t_dts:=OB Get($o_parametros;"dts")
		Begin SQL
			USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
			SELECT tipo_objeto, nombre_tabla, nombre_objeto, nombre_objeto_formulario, creador, dts_inclusion, dts_modificacion, obsoleto, ruta, auto_uuid  FROM VC4D_Metodos
			Where dts_modificacion >= :$t_dtsDesde AND dts_modificacion <= :$t_dtsHasta
			INTO :$al_tipoObjeto, :$at_nombreTabla, :$at_nombreObjeto, :$at_nombreObjetoFormulario, :$at_creador, :$at_dtsInclusion, :$at_dtsModificacion, :$ab_obsoleto, :$at_ruta, :$at_uuidMetodo;
		End SQL
		
		OB SET ARRAY:C1227($o_data;"tipo_objeto";$al_tipoObjeto)
		OB SET ARRAY:C1227($o_data;"nombre_tabla";$at_nombreTabla)
		OB SET ARRAY:C1227($o_data;"nombre_objeto";$at_nombreObjeto)
		OB SET ARRAY:C1227($o_data;"nombre_objeto_formulario";$at_nombreObjetoFormulario)
		OB SET ARRAY:C1227($o_data;"creador";$at_creador)
		OB SET ARRAY:C1227($o_data;"dts_inclusion";$at_dtsInclusion)
		OB SET ARRAY:C1227($o_data;"dts_modificacion";$at_dtsModificacion)
		OB SET ARRAY:C1227($o_data;"obsoleto";$ab_obsoleto)
		OB SET ARRAY:C1227($o_data;"ruta";$at_ruta)
		OB SET ARRAY:C1227($o_data;"uuid";$at_uuidMetodo)
		
		  // tabla cambios en VC4D
	: ($t_tabla="VC4d_HistorialCambios")
		If ($t_dtsDesde="")
			$t_dtsDesde:="1900-01-01T00:00:00"
		End if 
		
		If ($t_dtsDesde#"")
			Begin SQL
				USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
				SELECT metodos.tipo_objeto, metodos.ruta, metodos.nombre_tabla, metodos.nombre_objeto, metodos.nombre_objeto_formulario, cambios.autor, metodos.dts_modificacion, metodos.auto_uuid FROM VC4D_HistorialCambios as 'cambios', VC4D_Metodos AS 'metodos'
				WHERE cambios.dts_modificacion >= :$t_dtsDesde AND cambios.dts_modificacion <= :$t_dtsHasta AND cambios.uuid_metodo=metodos.auto_uuid
				ORDER BY 1 ASC, 2 ASC, 7 DESC
				INTO :$al_tipoObjeto, :$at_ruta, :$at_nombreTabla, :$at_nombreObjeto, :$at_nombreObjetoFormulario, :$at_autor, :$at_dtsModificacion, :$at_uuidMetodo;
			End SQL
		Else 
			Begin SQL
				USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
				SELECT metodos.tipo_objeto, metodos.ruta, metodos.nombre_tabla, metodos.nombre_objeto, metodos.nombre_objeto_formulario, cambios.autor, metodos.dts_modificacion, metodos.auto_uuid FROM VC4D_HistorialCambios as 'cambios', VC4D_Metodos AS 'metodos'
				WHERE cambios.commited=False AND cambios.uuid_metodo=metodos.auto_uuid
				ORDER BY 1 ASC, 2 ASC, 7 DESC
				INTO :$al_tipoObjeto, :$at_ruta, :$at_nombreTabla, :$at_nombreObjeto, :$at_nombreObjetoFormulario, :$at_autor, :$at_dtsModificacion, :$at_uuidMetodo;
			End SQL
		End if 
		
		
		For ($i;Size of array:C274($at_ruta);2;-1)
			Case of 
				: ($at_ruta{$i}=$at_ruta{$i-1})
					DELETE FROM ARRAY:C228($al_tipoObjeto;$i)
					DELETE FROM ARRAY:C228($at_ruta;$i)
					DELETE FROM ARRAY:C228($at_autor;$i)
					DELETE FROM ARRAY:C228($at_dtsModificacion;$i)
					DELETE FROM ARRAY:C228($at_nombreTabla;$i)
					DELETE FROM ARRAY:C228($at_nombreObjeto;$i)
					DELETE FROM ARRAY:C228($at_nombreObjetoFormulario;$i)
					DELETE FROM ARRAY:C228($at_uuidMetodo;$i)
			End case 
		End for 
		
		OB SET ARRAY:C1227($o_data;"tipo_objeto";$al_tipoObjeto)
		OB SET ARRAY:C1227($o_data;"ruta";$at_ruta)
		OB SET ARRAY:C1227($o_data;"autor";$at_autor)
		OB SET ARRAY:C1227($o_data;"dts_modificacion";$at_dtsModificacion)
		OB SET ARRAY:C1227($o_data;"nombre_tabla";$at_nombreTabla)
		OB SET ARRAY:C1227($o_data;"nombre_objeto";$at_nombreObjeto)
		OB SET ARRAY:C1227($o_data;"nombre_objeto_formulario";$at_nombreObjetoFormulario)
		OB SET ARRAY:C1227($o_data;"uuid_metodo";$at_uuidMetodo)
		
		
		
	: ($t_tabla="versiones")
		$t_uuid:=OB Get:C1224($o_parametros;"uuid")
		If (Util_isValidUUID ($t_uuid))
			Begin SQL
				USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
				SELECT autor, dts_modificacion, codigo FROM VC4D_HistorialCambios
				WHERE uuid_metodo=:$t_uuid
				INTO :$at_autor, :$at_dtsModificacion, :$at_codigo;
			End SQL
			
			If (Size of array:C274($at_autor)=0)
				Begin SQL
					USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
					SELECT creador, dts_modificacion, codigo_actual FROM VC4D_Metodos
					WHERE auto_uuid=:$t_uuid
					INTO :$at_autor, :$at_dtsModificacion, :$at_codigo;
				End SQL
			End if 
			
			
			OB SET ARRAY:C1227($o_data;"autor";$at_autor)
			OB SET ARRAY:C1227($o_data;"dts_modificacion";$at_dtsModificacion)
			OB SET ARRAY:C1227($o_data;"codigo";$at_codigo)
		End if 
End case 

Begin SQL
	USE DATABASE SQL_INTERNAL;
End SQL


$0:=$o_data








