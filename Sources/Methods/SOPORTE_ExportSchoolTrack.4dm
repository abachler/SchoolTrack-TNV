//%attributes = {}
  //SOPORTE_ExportSchoolTrack

  //REGISTRO DE CAMBIOS
  //20080305 RCH. Se agrega un parametro opcional para poder exportar MT.

C_LONGINT:C283($moduleRef;$table;$1;$2)

$moduleRef:=1
If (Count parameters:C259>=1)
	$moduleRef:=$1
End if 
If (Count parameters:C259=2)
	$table:=$2
End if 
LIST TO ARRAY:C288("XS_Modules";$atXS_ModuleNames;$alXS_ModuleRef)
$moduleName:=$atXS_ModuleNames{Find in array:C230($alXS_ModuleRef;$moduleRef)}
$path:=SYS_SelectFolder ("Seleccione la carpeta donde desea guardar los archivos")
$pathDatos:=$path+"Exportación"+$moduleName

If (Test path name:C476($pathDatos)<0)
	CREATE FOLDER:C475($pathDatos)
End if 
ARRAY TEXT:C222($adocuments;0)
DOCUMENT LIST:C474($pathDatos;$adocuments)
For ($i;1;Size of array:C274($adocuments))
	If (Test path name:C476($pathDatos+Folder separator:K24:12+$adocuments{$i})=Is a document:K24:1)
		DELETE DOCUMENT:C159($pathDatos+Folder separator:K24:12+$adocuments{$i})
	End if 
End for 

TRACE:C157
ARRAY INTEGER:C220($aTableNumbers;0)
If ($table=0)
	QUERY:C277([xShell_Tables:51];[xShell_Tables:51]ReferenciaModulo:36=$moduleRef)
	SELECTION TO ARRAY:C260([xShell_Tables:51]NumeroDeTabla:5;$aTableNumbers)
	ARRAY TEXT:C222($aTableNames;Size of array:C274($aTableNumbers))
Else 
	APPEND TO ARRAY:C911($aTableNumbers;$table)
	ARRAY TEXT:C222($aTableNames;Size of array:C274($aTableNumbers))
End if 

For ($i;1;Size of array:C274($aTableNumbers))
	If (Is table number valid:C999($aTableNumbers{$i}))
		$aTableNames{$i}:=XSvs_nombreTablaLocal_Numero ($aTableNumbers{$i};<>vtXS_CountryCode;<>vtXS_Langage)
		  //envio de la estructura  (primera linea del archivo)
		$fileName:=$pathDatos+Folder separator:K24:12+String:C10($aTableNumbers{$i};"000")+ST_ReplaceAccentedChars (Substring:C12(Table name:C256($aTableNumbers{$i});1;23))+".txt"
		$ref:=Create document:C266($fileName)
		$record:=""
		For ($j;1;Get last field number:C255($aTableNumbers{$i}))
			  //20130321 RCH
			If (Is field number valid:C1000($aTableNumbers{$i};$j))
				$record:=$record+String:C10($aTableNumbers{$i};"000")+String:C10($j;"000")+"\t"
			End if 
		End for 
		$record:=Substring:C12($record;1;Length:C16($record)-1)+"\r"
		SEND PACKET:C103($ref;$record)
		
		  //envio de los datos
		$tablePointer:=Table:C252($aTableNumbers{$i})
		ALL RECORDS:C47($tablePointer->)
		FIRST RECORD:C50($tablePointer->)
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Exportando datos de la tabla: ")+$aTableNames{$i})
		While (Not:C34(End selection:C36($tablePointer->)))
			$record:=""
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246($tablePointer->)/Records in selection:C76($tablePointer->);__ ("Exportando datos de la tabla: ")+$aTableNames{$i})
			For ($j;1;Get last field number:C255($aTableNumbers{$i}))
				  //20130321 RCH
				If (Is field number valid:C1000(Table:C252($tablePointer);$j))
					$textValue:=Replace string:C233(ST_GetCleanString (ST_Coerce_to_Text (Field:C253($aTableNumbers{$i};$j);False:C215));"\r";"¶")
				End if 
				$record:=$record+$textValue+"\t"
			End for 
			$record:=Substring:C12($record;1;Length:C16($record)-1)+"\r"
			SEND PACKET:C103($ref;$record)
			
			NEXT RECORD:C51($tablePointer->)
		End while 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		CLOSE DOCUMENT:C267($ref)
	End if 
End for 