//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma  // Fecha y hora: 05-02-18, 15:48:13
  // ----------------------------------------------------
  // Método: UD_v20180301_BlobHorario2Object
  // Descripción: Paso del blob del horario a al objeto en la misma tabla.
  // //MONO Ticket 144924
  //
  // Parámetros
  // ----------------------------------------------------

ARRAY LONGINT:C221($al_recnum;0)

C_LONGINT:C283($i;$OTref_Horario;$vlSTR_Horario_TipoCiclos;$vlSTR_Horario_NoCiclos;$vlSTR_Horario_DiaInicioCiclo;$vlSTR_Horario_SabadoLabor)
READ ONLY:C145([xxSTR_Periodos:100])

$l_idTermometro:=IT_Progress (1;0;0;__ ("Periodos Horario traspaso a objeto ..."))
ALL RECORDS:C47([xxSTR_Periodos:100])
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Periodos:100];$al_recnum;"")

For ($i;1;Size of array:C274($al_recnum))
	READ WRITE:C146([xxSTR_Periodos:100])
	GOTO RECORD:C242([xxSTR_Periodos:100];$al_recnum{$i})
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_recnum))
	
	
	If (Not:C34(OB Is defined:C1231([xxSTR_Periodos:100]Horario:14)))
		
		ARRAY INTEGER:C220($aiSTR_Horario_HoraNo;0)
		ARRAY LONGINT:C221($alSTR_Horario_Desde;0)
		ARRAY LONGINT:C221($alSTR_Horario_Hasta;0)
		ARRAY LONGINT:C221($alSTR_Horario_Duracion;0)
		ARRAY DATE:C224($adSTR_Periodos_InicioCiclos;0)
		ARRAY LONGINT:C221($alSTR_Horario_RefTipoHora;0)
		ARRAY TEXT:C222($at_HoraAlias;0)  //Nuevo para Hora 0 
		
		$vlSTR_Horario_TipoCiclos:=1
		$vlSTR_Horario_NoCiclos:=1
		$vlSTR_Horario_DiasCiclo:=5
		$vlSTR_Horario_DiaInicioCiclo:=2
		$vlSTR_Horario_SabadoLabor:=0
		
		If (BLOB size:C605([xxSTR_Periodos:100]Horarios:8)>0)
			$OTref_Horario:=OT BLOBToObject ([xxSTR_Periodos:100]Horarios:8)
			OT GetArray ($OTref_Horario;"aiSTR_Horario_HoraNo";$aiSTR_Horario_HoraNo)
			OT GetArray ($OTref_Horario;"alSTR_Horario_Desde";$alSTR_Horario_Desde)
			OT GetArray ($OTref_Horario;"alSTR_Horario_Hasta";$alSTR_Horario_Hasta)
			OT GetArray ($OTref_Horario;"alSTR_Horario_Duracion";$alSTR_Horario_Duracion)
			$vlSTR_Horario_TipoCiclos:=OT GetLong ($OTref_Horario;"vlSTR_Horario_TipoCiclos")
			$vlSTR_Horario_NoCiclos:=OT GetLong ($OTref_Horario;"vlSTR_Horario_NoCiclos")
			$vlSTR_Horario_DiasCiclo:=OT GetLong ($OTref_Horario;"vlSTR_Horario_DiasCiclo")
			$vlSTR_Horario_DiaInicioCiclo:=OT GetLong ($OTref_Horario;"vlSTR_Horario_DiaInicioCiclo")
			$vlSTR_Horario_SabadoLabor:=OT GetLong ($OTref_Horario;"vlSTR_Horario_SabadoLabor")
			$vlSTR_Horario_ResetCiclos:=OT GetLong ($OTref_Horario;"vlSTR_Horario_ResetCiclos")
			OT GetArray ($OTref_Horario;"adSTR_Periodos_InicioCiclos";$adSTR_Periodos_InicioCiclos)
			OT GetArray ($OTref_Horario;"alSTR_Horario_RefTipoHora";$alSTR_Horario_RefTipoHora)
			OT Clear ($OTref_Horario)
		End if 
		
		If ($vlSTR_Horario_TipoCiclos=0)
			$vlSTR_Horario_TipoCiclos:=1
			$vlSTR_Horario_NoCiclos:=1
			$vlSTR_Horario_DiasCiclo:=5
			$vlSTR_Horario_DiaInicioCiclo:=2
			$vlSTR_Horario_SabadoLabor:=0
			$vlSTR_Horario_ResetCiclos:=0
		End if 
		
		For ($h;1;Size of array:C274($aiSTR_Horario_HoraNo))
			APPEND TO ARRAY:C911($at_HoraAlias;String:C10($aiSTR_Horario_HoraNo{$h}))
		End for 
		
		[xxSTR_Periodos:100]Horario:14:=OB_Create 
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"ai_HoraNo";$aiSTR_Horario_HoraNo)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"at_HoraAlias";$at_HoraAlias)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_Desde";$alSTR_Horario_Desde)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_Hasta";$alSTR_Horario_Hasta)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_Duracion";$alSTR_Horario_Duracion)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_TipoCiclos";$vlSTR_Horario_TipoCiclos)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_NoCiclos";$vlSTR_Horario_NoCiclos)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_DiasCiclo";$vlSTR_Horario_DiasCiclo)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_DiaInicioCiclo";$vlSTR_Horario_DiaInicioCiclo)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_SabadoLabor";$vlSTR_Horario_SabadoLabor)
		OB SET:C1220([xxSTR_Periodos:100]Horario:14;"l_ResetCiclos";$vlSTR_Horario_ResetCiclos)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"ad_InicioCiclos";$adSTR_Periodos_InicioCiclos)
		OB SET ARRAY:C1227([xxSTR_Periodos:100]Horario:14;"al_RefTipoHora";$alSTR_Horario_RefTipoHora)
		SAVE RECORD:C53([xxSTR_Periodos:100])
	End if 
	KRL_UnloadReadOnly (->[xxSTR_Periodos:100])
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)