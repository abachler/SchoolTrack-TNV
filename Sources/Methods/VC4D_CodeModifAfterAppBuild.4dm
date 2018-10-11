//%attributes = {}
  // Método: VC4D_CodeModifAfterAppBuild ({noActualizarMarcador ; {dts}})
  // Genera un documento excel con los metodos y formularios modificados desde la última ejecución de este método
  // o utilizando el marcador almacenado en los datos de la última generacion (lista xShell_AplicationVersion)
  // - si noActualizarMarcador es TRUE no se actualiza el marcador de modificación de código al finalizar la ejecución
  // - si se especifica dts y es valido se lo utiliza generando el documento con todos los objetos modificados después de ese momento
  //
  // por Alberto Bachler Klein
  // creación 12/06/17, 17:31:44
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($0)
C_BOOLEAN:C305($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_formularios;$b_formulariosProyecto;$b_formulariosTabla;$b_generarDocFormularios;$b_generarDocMetodos;$b_generarDocumento;$b_ignorarMarcador;$b_metodosDatabase;$b_metodosProyecto;$b_noActualizarMarcador)
C_BOOLEAN:C305($b_triggers)
C_DATE:C307($d_fechaModif)
C_LONGINT:C283($i_Metodo;$l_eliminarDesde;$l_error;$l_marcadorCodigo;$l_refHojaDBM;$l_refHojaPF;$l_refHojaPM;$l_refHojaTF;$l_refHojaTriggers;$l_refXLS)
C_LONGINT:C283($l_tipoObjeto;$l_versionBuild;$l_versionMayor;$l_versionRevision)
C_TIME:C306($h_horaModif)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_autor;$t_dtsDesde;$t_dtsModificacion;$t_nombreDocumento;$t_nombreObjeto;$t_nombreObjetoFormulario;$t_rutaDocumento;$t_rutaVC4D;$t_Tabla;$t_versionCompleta)
C_TEXT:C284($t_versionTipo)

ARRAY POINTER:C280($ay_Columnas;0)
ARRAY TEXT:C222($at_dtsModificacion;0)
ARRAY TEXT:C222($at_encabezados;0)
ARRAY TEXT:C222($at_formularios;0)
ARRAY TEXT:C222($at_formulariosPF;0)
ARRAY TEXT:C222($at_formulariosProyecto;0)
ARRAY TEXT:C222($at_formulariosTabla;0)
ARRAY TEXT:C222($at_formulariosTF;0)
ARRAY TEXT:C222($at_metodosDatabase;0)
ARRAY TEXT:C222($at_metodosDatabaseAutor;0)
ARRAY TEXT:C222($at_metodosDatabaseDts;0)
ARRAY TEXT:C222($at_metodosProyecto;0)
ARRAY TEXT:C222($at_metodosProyectoAutor;0)
ARRAY TEXT:C222($at_metodosProyectoDts;0)
ARRAY TEXT:C222($at_objetosPF;0)
ARRAY TEXT:C222($at_objetosPFAutor;0)
ARRAY TEXT:C222($at_objetosPFDts;0)
ARRAY TEXT:C222($at_objetosTF;0)
ARRAY TEXT:C222($at_objetosTFAutor;0)
ARRAY TEXT:C222($at_objetosTFDts;0)
ARRAY TEXT:C222($at_rutaMetodos;0)
ARRAY TEXT:C222($at_Tabla;0)
ARRAY TEXT:C222($at_triggerAutor;0)
ARRAY TEXT:C222($at_triggerDts;0)
ARRAY TEXT:C222($at_triggers;0)


If (False:C215)
	C_LONGINT:C283(VC4D_CodeModifAfterAppBuild ;$0)
	C_BOOLEAN:C305(VC4D_CodeModifAfterAppBuild ;$1)
	C_TEXT:C284(VC4D_CodeModifAfterAppBuild ;$2)
End if 

$t_versionCompleta:=SYS_LeeVersionEstructura ("principal";->$l_versionMayor)
$t_versionCompleta:=SYS_LeeVersionEstructura ("revision";->$l_versionRevision)
$t_versionCompleta:=SYS_LeeVersionEstructura ("build";->$l_versionBuild)
$t_versionCompleta:=SYS_LeeVersionEstructura ("tipo";->$t_versionTipo)
$t_versionCompleta:=SYS_LeeVersionEstructura ("marcadorCodigo";->$l_marcadorCodigo)
$t_nombreDocumento:=String:C10($l_versionMayor)+"."+String:C10($l_versionRevision)+"."+String:C10($l_versionBuild)+" "+$t_versionTipo+".xls"

Case of 
	: (Count parameters:C259=1)
		$b_noActualizarMarcador:=$1
		
	: (Count parameters:C259=2)
		$t_dtsDesde:=$2
		$b_ignorarMarcador:=True:C214
End case 



If ($l_marcadorCodigo=0)
	If ($t_dtsDesde="")
		$t_versionCompleta:=SYS_LeeVersionEstructura ("dts";->$t_dtsDesde)
	End if 
	METHOD GET PATHS:C1163(Path all objects:K72:16;$at_rutaMetodos;$l_marcadorCodigo;*)
	For ($i_Metodo;1;Size of array:C274($at_rutaMetodos))
		METHOD GET MODIFICATION DATE:C1170($at_rutaMetodos{$i_Metodo};$d_fechaModif;$h_horaModif;*)
		$t_dtsModificacion:=String:C10($d_fechaModif;ISO date:K1:8;$h_horaModif)
		APPEND TO ARRAY:C911($at_dtsModificacion;String:C10($d_fechaModif;ISO date:K1:8;$h_horaModif))
	End for 
	SORT ARRAY:C229($at_dtsModificacion;$at_rutaMetodos;<)
	For ($i_Metodo;1;Size of array:C274($at_rutaMetodos))
		If ($at_dtsModificacion{$i_Metodo}<$t_dtsDesde)
			$l_eliminarDesde:=$i_Metodo
			$i_metodo:=Size of array:C274($at_rutaMetodos)+1
		End if 
	End for 
	If ($l_eliminarDesde>0)
		DELETE FROM ARRAY:C228($at_dtsModificacion;$l_eliminarDesde;MAXLONG:K35:2)
		DELETE FROM ARRAY:C228($at_rutaMetodos;$l_eliminarDesde;MAXLONG:K35:2)
	End if 
Else 
	METHOD GET PATHS:C1163(Path all objects:K72:16;$at_rutaMetodos;$l_marcadorCodigo;*)
End if 
SORT ARRAY:C229($at_rutaMetodos;>)

$t_rutaVC4D:=VC4D_GetDBPath 
Begin SQL
	USE DATABASE DATAFILE :$t_rutaVC4D AUTO_CLOSE
End SQL

For ($i_Metodo;1;Size of array:C274($at_rutaMetodos))
	METHOD RESOLVE PATH:C1165($at_rutaMetodos{$i_Metodo};$l_tipoObjeto;$y_tabla;$t_nombreObjeto;$t_nombreObjetoFormulario;*)
	$t_autor:=VC4D_GetLastModifData ($at_rutaMetodos{$i_Metodo};->$t_dtsModificacion)
	Case of 
		: ($l_tipoObjeto=Path project form:K72:3)
			$t_Tabla:="[]"
			APPEND TO ARRAY:C911($at_formulariosPF;$t_nombreObjeto)
			APPEND TO ARRAY:C911($at_objetosPF;Choose:C955($t_nombreObjetoFormulario#"";$t_nombreObjetoFormulario;"{metodo formulario}"))
			APPEND TO ARRAY:C911($at_objetosPFDts;$t_dtsModificacion)
			APPEND TO ARRAY:C911($at_objetosPFAutor;$t_autor)
			
		: ($l_tipoObjeto=Path table form:K72:5)
			$t_Tabla:="["+Table name:C256($y_tabla)+"]"
			APPEND TO ARRAY:C911($at_Tabla;$t_Tabla)
			APPEND TO ARRAY:C911($at_formulariosTF;$t_nombreObjeto)
			APPEND TO ARRAY:C911($at_objetosTF;Choose:C955($t_nombreObjetoFormulario#"";$t_nombreObjetoFormulario;"{metodo formulario}"))
			APPEND TO ARRAY:C911($at_objetosTFDts;$t_dtsModificacion)
			APPEND TO ARRAY:C911($at_objetosTFAutor;$t_autor)
			
		: ($l_tipoObjeto=Path trigger:K72:4)
			$t_Tabla:=Table name:C256($y_tabla)
			APPEND TO ARRAY:C911($at_Tabla;$t_Tabla)
			APPEND TO ARRAY:C911($at_triggers;$t_nombreObjeto)
			APPEND TO ARRAY:C911($at_triggerDts;$t_dtsModificacion)
			APPEND TO ARRAY:C911($at_triggerAutor;$t_autor)
			
		: ($l_tipoObjeto=Path database method:K72:2)
			APPEND TO ARRAY:C911($at_metodosDatabase;$t_nombreObjeto)
			APPEND TO ARRAY:C911($at_metodosDatabaseDts;$t_dtsModificacion)
			APPEND TO ARRAY:C911($at_metodosDatabaseAutor;$t_autor)
			
		: ($l_tipoObjeto=Path project method:K72:1)
			APPEND TO ARRAY:C911($at_metodosProyecto;$t_nombreObjeto)
			APPEND TO ARRAY:C911($at_metodosProyectoDts;$t_autor)
			APPEND TO ARRAY:C911($at_metodosProyectoAutor;$t_dtsModificacion)
	End case 
End for 

Begin SQL
	USE DATABASE SQL_INTERNAL;
End SQL



$b_formulariosProyecto:=(Size of array:C274($at_formulariosPF)>0)
$b_formulariosTabla:=(Size of array:C274($at_formulariosTF)>0)
$b_metodosProyecto:=(Size of array:C274($at_metodosProyecto)>0)
$b_metodosDatabase:=(Size of array:C274($at_metodosDatabase)>0)
$b_triggers:=(Size of array:C274($at_triggers)>0)

$b_generarDocumento:=($b_formularios | $b_metodosProyecto | $b_metodosDatabase | $b_triggers)

$b_generarDocMetodos:=(Size of array:C274($at_metodosDatabase)>0) | (Size of array:C274($at_triggers)>0) | (Size of array:C274($at_metodosProyecto)>0)
$b_generarDocFormularios:=(Size of array:C274($at_formularios)>0)

If ($b_generarDocumento)
	$l_refXLS:=XLS_CreateBook 
	If ($b_metodosProyecto)
		$l_refHojaPM:=XLS_CreateSheet ($l_refXLS;"Métodos Proyecto")
		AT_Initialize (->$at_encabezados;->$ay_Columnas)
		AT_AppendItems2TextArray (->$at_encabezados;"Método";"Autor";"Fecha de modificacion")
		AT_AppendToPointerArray (->$ay_Columnas;->$at_metodosProyecto;->$at_metodosProyectoAutor;->$at_metodosProyectoDts)
		XLS_SetColumns ($l_refHojaPM;->$ay_columnas;->$at_encabezados)
	End if 
	
	If ($b_metodosDatabase)
		$l_refHojaDBM:=XLS_CreateSheet ($l_refXLS;"Métodos de base datos")
		AT_Initialize (->$at_encabezados;->$ay_Columnas)
		AT_AppendItems2TextArray (->$at_encabezados;"Método";"Autor";"Fecha de modificacion")
		AT_AppendToPointerArray (->$ay_Columnas;->$at_metodosDatabase;->$at_metodosDatabaseAutor;->$at_metodosDatabaseDts)
		XLS_SetColumns ($l_refHojaDBM;->$ay_columnas;->$at_encabezados)
	End if 
	
	If ($b_triggers)
		$l_refHojaTriggers:=XLS_CreateSheet ($l_refXLS;"Triggers")
		AT_Initialize (->$at_encabezados;->$ay_Columnas)
		AT_AppendItems2TextArray (->$at_encabezados;"Tabla";"Autor";"Fecha de modificacion")
		AT_AppendToPointerArray (->$ay_Columnas;->$at_triggers;->$at_triggerAutor;->$at_triggerDts)
		XLS_SetColumns ($l_refHojaTriggers;->$ay_columnas;->$at_encabezados)
	End if 
	
	If ($b_formulariosProyecto)
		$l_refHojaPF:=XLS_CreateSheet ($l_refXLS;"Formularios Proyecto")
		AT_Initialize (->$at_encabezados;->$ay_Columnas)
		AT_AppendItems2TextArray (->$at_encabezados;"Formulario";"Objeto";"Autor";"Fecha de modificacion")
		AT_AppendToPointerArray (->$ay_Columnas;->$at_formulariosPF;->$at_objetosPF;->$at_objetosPFAutor;->$at_objetosPFDts)
		XLS_SetColumns ($l_refHojaPF;->$ay_columnas;->$at_encabezados)
	End if 
	
	If ($b_formulariosTabla)
		$l_refHojaTF:=XLS_CreateSheet ($l_refXLS;"Formularios Tabla")
		AT_Initialize (->$at_encabezados;->$ay_Columnas)
		AT_AppendItems2TextArray (->$at_encabezados;"Formulario";"Objeto";"Autor";"Fecha de modificacion")
		AT_AppendToPointerArray (->$ay_Columnas;->$at_Tabla;->$at_formulariosTF;->$at_objetosTF;->$at_objetosTFAutor;->$at_objetosTFDts)
		XLS_SetColumns ($l_refHojaTF;->$ay_columnas;->$at_encabezados)
	End if 
	
	$t_rutaDocumento:=Get 4D folder:C485(Database folder:K5:14)+"OEM Distribution"+Folder separator:K24:12+"Historial de cambios"+Folder separator:K24:12+$t_nombreDocumento
	SYS_DeleteFile ($t_rutaDocumento)
	CREATE FOLDER:C475($t_rutaDocumento;*)
	$l_error:=XLS_SaveDocument ($l_refXLS;$t_rutaDocumento)
	If ($b_metodosProyecto)
		XLS_ClearSheet ($l_refHojaPM)
	End if 
	If ($b_metodosDatabase)
		XLS_ClearSheet ($l_refHojaDBM)
	End if 
	If ($b_triggers)
		XLS_ClearSheet ($l_refHojaTriggers)
	End if 
	If ($b_formulariosProyecto)
		XLS_ClearSheet ($l_refHojaPF)
	End if 
	If ($b_formulariosTabla)
		XLS_ClearSheet ($l_refHojaTF)
	End if 
	XLS_ClearBook ($l_refxls)
End if 

If ($b_noActualizarMarcador)
	$0:=0
Else 
	$0:=$l_marcadorCodigo
End if 













