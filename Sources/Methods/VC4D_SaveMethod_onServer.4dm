//%attributes = {"shared":true,"executedOnServer":true}
  // VC4D_SaveMethod_onServer()
  //
  //
  // creado por: Alberto Bachler Klein: 29-02-16, 12:13:19
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_BOOLEAN:C305($b_obsoleto)
C_LONGINT:C283($i;$l_numeroTabla;$l_tipoObjeto)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_autouuid;$t_code;$t_codigo;$t_comentarios;$t_dts;$t_dts2;$t_nombreObjeto;$t_nombreObjetoFormulario;$t_nombreTabla;$t_onErrMethod)
C_TEXT:C284($t_ruta;$t_rutaVC4D;$t_text;$t_usuario)
C_OBJECT:C1216($ob_atributos)

ARRAY LONGINT:C221($al_errCodes;0)
ARRAY TEXT:C222($at_errorText;0)
ARRAY TEXT:C222($at_internalComponent;0)


If (False:C215)
	C_TEXT:C284(VC4D_SaveMethod_onServer ;$0)
	C_TEXT:C284(VC4D_SaveMethod_onServer ;$1)
	C_TEXT:C284(VC4D_SaveMethod_onServer ;$2)
	C_TEXT:C284(VC4D_SaveMethod_onServer ;$3)
End if 

$t_ruta:=$1
$t_codigo:=$2
$t_usuario:=$3

  //TRACE
If (Count parameters:C259=4)
	$t_dts:=$4
Else 
	$t_dts:=String:C10(Current date:C33(*);ISO date:K1:8;Current time:C178(*))
End if 
$t_dts2:=$t_dts

$t_onErrMethod:=Method called on error:C704
error:=0
ERR_CodeSQL:=0
ON ERR CALL:C155("VC4D_OnError")

  //TRACE
METHOD RESOLVE PATH:C1165($t_ruta;$l_tipoObjeto;$y_tabla;$t_nombreObjeto;$t_nombreObjetoFormulario;*)
If ($l_tipoObjeto=Path project method:K72:1)
	METHOD GET ATTRIBUTES:C1334($t_ruta;$ob_atributos;*)
End if 
If ($l_tipoObjeto=Path project method:K72:1)  //| ($l_tipoObjeto=Path database method) | ($l_tipoObjeto=Path trigger))
	METHOD GET COMMENTS:C1189($t_ruta;$t_comentarios;*)
End if 

If (Not:C34(Is nil pointer:C315($y_tabla)))
	$t_nombreTabla:=Table name:C256($y_tabla)
	$l_numeroTabla:=Table:C252($y_tabla)
Else 
	$t_nombreTabla:=""
	$l_numeroTabla:=0
End if 
$b_obsoleto:=False:C215

  //TRACE
$t_rutaVC4D:=VC4D_GetDBPath 

If (error=0)
	Begin SQL
		USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE;
		Select auto_uuid from VC4D_metodos where ruta = :$t_ruta into :$t_autouuid for update;
	End SQL
	
	
	If ((ERR_CodeSQL=0) & (error=0))
		If ($t_autouuid="")
			$t_autouuid:=Generate UUID:C1066
			Begin SQL
				INSERT INTO VC4D_Metodos
				(auto_uuid, tipo_objeto, ruta, creador, dts_inclusion, dts_modificacion, codigo_actual, obsoleto, numero_tabla, nombre_tabla, nombre_objeto, nombre_objeto_formulario, comentarios)
				VALUES
				(:$t_autouuid, :$l_tipoObjeto, :$t_ruta, :$t_usuario, :$t_dts, :$t_dts2, :$t_codigo, :$b_obsoleto, :$l_numeroTabla, :$t_nombreTabla, :$t_nombreObjeto, :$t_nombreObjetoFormulario, :$t_comentarios);
				
				insert into VC4D_HistorialCambios
				(uuid_metodo, autor, codigo, dts_modificacion, comentarios)
				VALUES (:$t_autouuid, :$t_usuario, :$t_codigo, :$t_dts, :$t_comentarios);
			End SQL
			
			
		Else 
			
			Begin SQL
				insert into VC4D_HistorialCambios
				(uuid_metodo, autor, codigo, dts_modificacion, comentarios)
				VALUES (:$t_autouuid, :$t_usuario, :$t_codigo, :$t_dts, :$t_comentarios);
				
				UPDATE VC4D_Metodos
				SET dts_modificacion = :$t_dts, codigo_actual = :$t_codigo, comentarios = :$t_comentarios
				where ruta= :$t_ruta;
			End SQL
		End if 
	End if 
	
	Begin SQL
		USE DATABASE SQL_INTERNAL;
	End SQL
End if 



If (error#0)
	GET LAST ERROR STACK:C1015($al_errCodes;$at_internalComponent;$at_errorText)
	$t_text:=""
	For ($i;1;Size of array:C274($al_errCodes))
		$t_text:=$t_text+"#"+String:C10($al_errCodes{$i};"######")+": "+$at_errorText{$i}+" ("+$at_internalComponent{$i}+")\r"
	End for 
	If (error=-1)
		$t_text:="El método \""+$t_ruta+"\" no pudo ser guardado en el historial a causa de un error SQL en "+Current method name:C684+":\r\r"+$t_text
	Else 
		$t_text:="El método \""+$t_ruta+"\" no pudo ser guardado en el historial a causa de un error en el método "+Current method name:C684+":\r\""+error formula+"\"\r\r"+$t_text
	End if 
End if 

$0:=$t_Text
ON ERR CALL:C155($t_onErrMethod)


