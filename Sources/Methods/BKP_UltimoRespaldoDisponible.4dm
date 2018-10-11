//%attributes = {"executedOnServer":true}
  // Método: BKP_UltimoRespaldoDisponible () --> rutaRespaldo:T
  // Obtiene la ruta del último respaldo disponible.
  // Primero lee la ruta desde el documento backup.xml
  // Si no lo encuentra obteine la ruta del respaldo mas reciente existente en la carpeta respaldos
  //
  // creado por Alberto Bachler Klein
  // el 16/03/18, 09:14:26
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($i)
C_TEXT:C284($t_json;$t_nombreArchivo;$t_rutaCarpetaRespaldos;$t_rutaUltimoRespaldo;$t_rutaUltimoRespaldo7z;$t_XMLrefPrefsRespaldo)
C_OBJECT:C1216($o_objeto)

ARRAY TEXT:C222($at_fechamodificado;0)
ARRAY TEXT:C222($at_nombreArchivos;0)

$t_XMLrefPrefsRespaldo:=BKP_ParseXML 
$t_rutaUltimoRespaldo:=DOM_GetValue ($t_XMLrefPrefsRespaldo;"Preferences4D/Backup/DataBase/LastBackupPath/Item1")
DOM CLOSE XML:C722($t_XMLrefPrefsRespaldo)

$t_rutaUltimoRespaldo7z:=$t_rutaUltimoRespaldo+".7z"

Case of 
	: (Test path name:C476($t_rutaUltimoRespaldo7z)=Is a document:K24:1)
		$0:=$t_rutaUltimoRespaldo7z
	: (Test path name:C476($t_rutaUltimoRespaldo)=Is a document:K24:1)
		$0:=$t_rutaUltimoRespaldo
	Else 
		
		$t_json:=BKP_ListaRespaldos 
		$o_objeto:=JSON Parse:C1218($t_json)
		
		  //If (OB_ParseJson ($t_json;->$o_objeto)) actvivar en v17 y eliminar línea anterior
		OB GET ARRAY:C1229($o_objeto;"documentos";$at_nombreArchivos)
		OB GET ARRAY:C1229($o_objeto;"dts";$at_fechamodificado)
		
		If (Size of array:C274($at_nombreArchivos)>0)
			BKP_LeeItemPlanBackup ("BKP_rutaCarpetaRespaldos";->$t_rutaCarpetaRespaldos)
			
			SORT ARRAY:C229($at_fechamodificado;$at_nombreArchivos;<)
			For ($i;1;Size of array:C274($at_nombreArchivos))
				$t_rutaUltimoRespaldo:=$t_rutaCarpetaRespaldos+$at_nombreArchivos{$i}
				Case of 
					: (Test path name:C476($t_rutaUltimoRespaldo7z)=Is a document:K24:1)
						$0:=$t_rutaUltimoRespaldo7z
						$i:=Size of array:C274($at_nombreArchivos)
					: (Test path name:C476($t_rutaUltimoRespaldo)=Is a document:K24:1)
						$0:=$t_rutaUltimoRespaldo
						$i:=Size of array:C274($at_nombreArchivos)
					Else 
				End case 
			End for 
		End if 
		  //End if
End case 







