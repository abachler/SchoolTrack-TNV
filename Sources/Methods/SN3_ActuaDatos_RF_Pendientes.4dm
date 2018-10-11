//%attributes = {}
  //SN3_ActuaDatos_RF_Pendientes
C_DATE:C307($1;$vd_fecha)
C_TEXT:C284($2;$vt_nombre_set)

$vd_fecha:=$1
$vt_nombre_set:=$2

ARRAY TEXT:C222($at_tipo_id_usr;0)
ARRAY DATE:C224($ad_last_actuadatos;0)
ARRAY LONGINT:C221($al_id_per_actuadatos;0)
C_TEXT:C284($vt_ids)

If ($vd_fecha#!00-00-00!)
	$settingsBlob:=PREF_fGetBlob (0;"SN3_ActuaDatos_Actualizaciones";$settingsBlob)
	$ot:=OT BLOBToObject ($settingsBlob)
	OT GetArray ($ot;"tipo_id";$at_tipo_id_usr)
	OT GetArray ($ot;"fecha_actua";$ad_last_actuadatos)
	OT Clear ($ot)
	
	ARRAY LONGINT:C221($DA_Return;0)
	$at_tipo_id_usr{0}:="7."
	AT_SearchArray (->$at_tipo_id_usr;">>";->$DA_Return)
	
	For ($i;1;Size of array:C274($DA_Return))
		If ($ad_last_actuadatos{$DA_Return{$i}}>=$vd_fecha)
			APPEND TO ARRAY:C911($al_id_per_actuadatos;Num:C11(Substring:C12($at_tipo_id_usr{$DA_Return{$i}};3)))
		End if 
	End for 
End if 

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Personas:7])
ARRAY LONGINT:C221($al_niv_publica;0)

$proc:=IT_UThermometer (1;0;__ ("Cargando..."))
For ($i;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
	SN3_LoadDataReceptionSettings (<>al_NumeroNivelesSchoolNet{$i})
	If (SN3_ActuaDatosPublica=1)
		APPEND TO ARRAY:C911($al_niv_publica;<>al_NumeroNivelesSchoolNet{$i})
	End if 
End for 
IT_UThermometer (-2;$proc)

QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;$al_niv_publica)
KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Alumnos:2]Familia_Número:24;"")
QUERY SELECTION:C341([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3>0)
KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
QUERY SELECTION:C341([Personas:7];[Personas:7]Inactivo:46=False:C215)
CREATE SET:C116([Personas:7];$vt_nombre_set)

QUERY WITH ARRAY:C644([Personas:7]No:1;$al_id_per_actuadatos)
CREATE SET:C116([Personas:7];"fuera")
DIFFERENCE:C122($vt_nombre_set;"fuera";$vt_nombre_set)
CLEAR SET:C117("fuera")
