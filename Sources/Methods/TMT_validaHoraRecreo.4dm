//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 02-08-16, 16:30:17
  // ----------------------------------------------------
  // Método: TMT_validaHoraRecreo
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

$l_numeroNivel:=$1
$l_numeroDia_ISO_Destino:=$2
$l_numeroHora_Destino:=$3
$b_conflicto:=False:C215


PERIODOS_LoadData ($l_numeroNivel)
$l_pos:=Find in array:C230(aiSTR_Horario_HoraNo;$l_numeroHora_Destino)
If ($l_pos#-1)
	If (alSTR_Horario_RefTipoHora{$l_pos}=0)  // es Recreo
		$b_conflicto:=True:C214
	End if 
End if 
$0:=$b_conflicto