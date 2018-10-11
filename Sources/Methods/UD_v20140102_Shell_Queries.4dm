//%attributes = {}
  // UD_v20140102_Shell_Queries()
  // Por: Alberto Bachler K.: 02-01-14, 18:43:35
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_tabla)
C_LONGINT:C283($i;$l_numeroRegistros;$l_ObjectSize;$l_refObjeto)
C_TEXT:C284($t_nombreRegistro;$t_SQL)

ARRAY LONGINT:C221($al_RecNums;0)

  // en la tabla xShell_Queries hay una falla estructural que hace que el campo Auto_UUID creado el 20131229 arroje un error al utilizarlo como llave primaria.
  // Después de intentar reasignar los UUID y aún cuando no hay duplicados el problema persiste.
  // la unica solución que pude encontrar consiste en los pasos siguientes:
  // - desactivar el atributo llave primaria
  // - eliminar el index
  // - exportar los registros de consultas usuario a un objeto OT (podría haberse utilizado otro método)
  // - eliminar todos los registros de consultas
  // - recuperar las consultas usuario desde el objeto OT
  // - recuperar las consultas estándar
  // - indexar el campo [xShell_Queries]Auto_UUID
  // - activar el atributo llave primaria

  // [INFORMACION ADICIONAL]
  // cuando cree el campo AutoUUID, 4D le asignó primero el numero 11 en la tabla (al momento de la creación)
  // pero se guardó con el numero 4
  // compactar la estructura y la base de datos no solucionó el problema
  //

  // desactivo la llave primaria
ON ERR CALL:C155("ERR_GenericOnError")
$t_SQL:="ALTER TABLE xShell_Queries DROP PRIMARY KEY;"
Begin SQL
	EXECUTE IMMEDIATE :$t_SQL
End SQL
ON ERR CALL:C155("")

  // elimino el index
SET INDEX:C344([xShell_Queries:53]AUTO_UUID:4;False:C215)

  // busco y guardo las consultas usuario y los pongo en un objeto OT
QUERY:C277([xShell_Queries:53];[xShell_Queries:53]No:1>0)
$l_numeroRegistros:=Records in selection:C76([xShell_Queries:53])
If ($l_numeroRegistros>0)
	$l_refObjeto:=OT New 
	LONGINT ARRAY FROM SELECTION:C647([xShell_Queries:53];$al_RecNums;"")
	For ($i;1;Size of array:C274($al_RecNums))
		GOTO RECORD:C242([xShell_Queries:53];$al_RecNums{$i})
		$t_nombreRegistro:="Registro"+String:C10($al_RecNums{$i})
		OT PutRecord ($l_refObjeto;$t_nombreRegistro;->[xShell_Queries:53])
	End for 
	KRL_UnloadReadOnly (->[xShell_Queries:53])
	$l_ObjectSize:=OT ObjectSize ($l_refObjeto)
	
	  // elimino todos los registros
	ALL RECORDS:C47([xShell_Queries:53])
	KRL_DeleteSelection (->[xShell_Queries:53])
	
	  // recupero las consultas usuario
	UNLOAD RECORD:C212([xShell_Queries:53])
	$l_numeroRegistros:=OT ItemCount ($l_refObjeto)
	For ($i;1;$l_numeroRegistros)
		CREATE RECORD:C68([xShell_Queries:53])
		OT GetItemProperties ($l_refObjeto;$i;$t_nombreRegistro)
		OT GetRecord ($l_refObjeto;$t_nombreRegistro)
		[xShell_Queries:53]AUTO_UUID:4:=Generate UUID:C1066
		SAVE RECORD:C53([xShell_Queries:53])
	End for 
	OT Clear ($l_refObjeto)
	
Else 
	ALL RECORDS:C47([xShell_Queries:53])
	KRL_DeleteSelection (->[xShell_Queries:53])
End if 

  // recupero las consultas estándar
QRY_LoadLibrary 

  // indexo el campo
SET INDEX:C344([xShell_Queries:53]AUTO_UUID:4;True:C214)

  // activo el atributo Llave primaria
$i_tabla:=Table:C252(->[xShell_Queries:53])
$t_SQL:="ALTER TABLE xShell_Queries ADD CONSTRAINT "+" pk"+String:C10($i_tabla)+" PRIMARY KEY (Auto_UUID);"
Begin SQL
	EXECUTE IMMEDIATE :$t_SQL
End SQL