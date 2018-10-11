//%attributes = {}
  // SR_ValidaScripts()
  // Por: Alberto Bachler: 15/03/13, 12:17:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_informeValido;$b_hayElementos)
C_LONGINT:C283($i_Comandos;$l_areaSRP;$l_fin;$l_inicio)
C_TEXT:C284($t_scripts)

ARRAY LONGINT:C221($al_ObjectIds;0)
ARRAY TEXT:C222($at_comandosProhibidos;0)
ARRAY TEXT:C222($at_scripts;0)

If (False:C215)
	C_BOOLEAN:C305(SR_ValidaScripts ;$0)
	C_LONGINT:C283(SR_ValidaScripts ;$1)
End if 

$b_informeValido:=True:C214

Case of 
	: (Count parameters:C259=1)
		$l_areaSRP:=$1
End case 


If ([xShell_Reports:54]ReportType:2="gSR2")
	APPEND TO ARRAY:C911($at_comandosProhibidos;"SAVE RECORD")
	APPEND TO ARRAY:C911($at_comandosProhibidos;"DELETE RECORD")
	APPEND TO ARRAY:C911($at_comandosProhibidos;"DELETE SELECTION")
	APPEND TO ARRAY:C911($at_comandosProhibidos;"APPLY TO SELECTION")
	APPEND TO ARRAY:C911($at_comandosProhibidos;"ARRAY TO SELECTION")
	APPEND TO ARRAY:C911($at_comandosProhibidos;"KRL_DeleteRecord")
	APPEND TO ARRAY:C911($at_comandosProhibidos;"KRL_DeleteSelection")
	APPEND TO ARRAY:C911($at_comandosProhibidos;"KRL_Array2Selection")
	APPEND TO ARRAY:C911($at_comandosProhibidos;"KRL_DeleteDuplicates")
	APPEND TO ARRAY:C911($at_comandosProhibidos;"KRL_DeleteOrphans")
	
	
	$b_informeValido:=True:C214
	
	  // obtengo todos los scripts
	$t_scripts:=SR_GetAllScripts ($l_areaSRP;->$at_scripts;->$al_ObjectIds)
	
	If (True:C214)
		  // elimino los scripts a ejecutar antes y después de imprimir (definidos en el registro de informe)
		  // si queremos incluirlos en la verificación basta con poner en false
		SORT ARRAY:C229($al_ObjectIds;$at_scripts)
		$b_hayElementos:=Find in sorted array:C1333($al_ObjectIds;-32000;>;$l_inicio;$l_fin)
		DELETE FROM ARRAY:C228($al_ObjectIds;$l_inicio;$l_fin-$l_Inicio+1)
		DELETE FROM ARRAY:C228($at_scripts;$l_inicio;$l_fin-$l_Inicio+1)
		$t_scripts:=AT_array2text (->$at_scripts;"\r")
	End if 
	
	For ($i_Comandos;1;Size of array:C274($at_comandosProhibidos))
		If (Position:C15($at_comandosProhibidos{$i_Comandos};$t_scripts)>0)
			$b_informeValido:=False:C215
			$i_Comandos:=Size of array:C274($at_comandosProhibidos)
		End if 
	End for 
	
	
End if 

$0:=$b_informeValido