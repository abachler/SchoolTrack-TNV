//%attributes = {}
  // dbu_CreaSesiones()
  // Por: Alberto Bachler: 21/08/13, 11:40:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($1)
C_DATE:C307($2)
C_DATE:C307($3)

C_BOOLEAN:C305($b_verificaPrefSesionesCreadas)
C_DATE:C307($d_fechaDeHoy;$d_fechaSesion;$d_SesionesDesde;$d_sesionesHasta;$d_terminoAñoEscolar)
_O_C_INTEGER:C282($i)
C_LONGINT:C283($l_idProcesoAvance;$l_numeroDias)
C_TEXT:C284($t_mensaje)

ARRAY LONGINT:C221($aIdsConfigPeriodos;0)
ARRAY LONGINT:C221($aNivelesConHorario;0)
ARRAY LONGINT:C221($aRecNums;0)
If (False:C215)
	C_BOOLEAN:C305(dbu_CreaSesiones ;$1)
	C_DATE:C307(dbu_CreaSesiones ;$2)
	C_DATE:C307(dbu_CreaSesiones ;$3)
End if 

$d_fechaDeHoy:=Current date:C33(*)

PERIODOS_Init 

$d_terminoAñoEscolar:=!00-00-00!
$d_SesionesDesde:=Current date:C33(*)

  //ABK 20111103 Cambio de la fecha de inicio de creación de sesiones
  //  hasta ahora se tomaban en cuenta todas las configuraciones de período
  // ahora uso sólo las utilizadas en los niveles en los que hay horarios

  // busco los niveles con horario
READ ONLY:C145([TMT_Horario:166])
ALL RECORDS:C47([TMT_Horario:166])
AT_DistinctsFieldValues (->[TMT_Horario:166]Nivel:10;->$aNivelesConHorario)

  // busco las configuraciones de períodos de los niveles con horario
READ ONLY:C145([xxSTR_Niveles:6])
QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;$aNivelesConHorario)
AT_DistinctsFieldValues (->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44;->$aIdsConfigPeriodos)

  // determino la fecha a partir de la cual deben existir sesiones
READ ONLY:C145([xxSTR_Periodos:100])
QUERY WITH ARRAY:C644([xxSTR_Periodos:100]ID:1;$aIdsConfigPeriodos)
SELECTION TO ARRAY:C260([xxSTR_Periodos:100];$aRecNums)
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([xxSTR_Periodos:100];$aRecNums{$i})
	PERIODOS_LoadData (0;[xxSTR_Periodos:100]ID:1)
	If (Size of array:C274(adSTR_Periodos_Desde)>0)
		If ((adSTR_Periodos_Desde{1}<$d_SesionesDesde) & (adSTR_Periodos_Desde{1}>!00-00-00!))
			$d_SesionesDesde:=adSTR_Periodos_Desde{1}
		End if 
		If (adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}>$d_terminoAñoEscolar)
			$d_terminoAñoEscolar:=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}
		End if 
	End if 
End for 
  //ABK 20111103

Case of 
	: (Count parameters:C259=3)
		$b_verificaPrefSesionesCreadas:=$1
		$d_SesionesDesde:=$2
		$d_sesionesHasta:=$3
	: (Count parameters:C259=2)
		$b_verificaPrefSesionesCreadas:=$1
		$d_SesionesDesde:=$2
		$d_sesionesHasta:=$d_fechaDeHoy
	: (Count parameters:C259=1)
		$b_verificaPrefSesionesCreadas:=$1
		$d_SesionesDesde:=adSTR_Periodos_Desde{1}
		$d_sesionesHasta:=$d_fechaDeHoy
	Else 
		$b_verificaPrefSesionesCreadas:=False:C215
		$d_sesionesHasta:=$d_fechaDeHoy
End case 

If ($d_sesionesHasta>$d_terminoAñoEscolar)
	$d_sesionesHasta:=$d_terminoAñoEscolar
End if 



If (($d_SesionesDesde>!00-00-00!) & ($d_SesionesDesde<=$d_fechaDeHoy))
	$d_fechaSesion:=$d_SesionesDesde
	$l_numeroDias:=$d_sesionesHasta-$d_fechaSesion
	$t_mensaje:=__ ("Verificando registros de sesiones de clases...")
	$l_idProcesoAvance:=IT_Progress (1;$l_idProcesoAvance;0;$t_mensaje)
	While (($d_fechaSesion<=$d_sesionesHasta) & ($d_fechaSesion<=$d_fechaDeHoy))
		AS_CreaSesiones ($d_fechaSesion;$b_verificaPrefSesionesCreadas;False:C215)
		$d_fechaSesion:=$d_fechaSesion+1
		$l_idProcesoAvance:=IT_Progress (0;$l_idProcesoAvance;($l_numeroDias-($d_sesionesHasta-$d_fechaSesion)/$l_numeroDias);$t_mensaje+"\r"+String:C10($d_fechaSesion;System date long:K1:3))
	End while 
	IT_Progress (-1;$l_idProcesoAvance)
End if 

  //PREF_Set (0;"CreacionDeSesiones";String(Current date))
PREF_Set (0;"CreacionDeSesiones";DTS_MakeFromDateTime (Current date:C33(*)))  //20180423 RCH

