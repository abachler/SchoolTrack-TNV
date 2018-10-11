//%attributes = {}
  // Método: SYS_GetLocalVolumeList
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/09/10, 19:29:03
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BLOB:C604($blob;$0)
C_LONGINT:C283($hl_volumes)

  // Código principal
ARRAY TEXT:C222($aVolumes;0)
VOLUME LIST:C471($aVolumes)

$hl_volumes:=New list:C375
For ($i;1;Size of array:C274($aVolumes))
	If (SYS_IsMacintosh )
		$t_path:=$aVolumes{$i}+":"
		If (Test path name:C476($t_path)=Is a folder:K24:2)
			If (($aVolumes{$i}#"Net") & ($aVolumes{$i}#"Home"))
				APPEND TO LIST:C376($hl_volumes;$aVolumes{$i};-$i)
			End if 
		End if 
	Else 
		If (Test path name:C476($aVolumes{$i})=Is a folder:K24:2)
			APPEND TO LIST:C376($hl_volumes;$aVolumes{$i};-$i)
		End if 
	End if 
End for 



LIST TO BLOB:C556($hl_volumes;$blob)
$0:=$blob

CLEAR LIST:C377($hl_volumes)



