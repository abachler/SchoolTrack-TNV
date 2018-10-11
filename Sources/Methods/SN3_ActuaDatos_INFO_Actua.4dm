//%attributes = {}
READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Personas:7])

C_LONGINT:C283($vl_tipo_de_consulta;$1)
C_DATE:C307($viniDate;$vendDate;$2;$3)

$vl_tipo_de_consulta:=$1
ARRAY TEXT:C222(at_tipo_id_usr;0)
ARRAY DATE:C224(ad_last_actuadatos;0)

If (Count parameters:C259=3)
	$viniDate:=$2
	$vendDate:=$3
End if 

$settingsBlob:=PREF_fGetBlob (0;"SN3_ActuaDatos_Actualizaciones";$settingsBlob)
$ot:=OT BLOBToObject ($settingsBlob)
OT GetArray ($ot;"tipo_id";at_tipo_id_usr)
OT GetArray ($ot;"fecha_actua";ad_last_actuadatos)
OT Clear ($ot)

ARRAY LONGINT:C221(al_id_alu_actuadatos;0)
ARRAY LONGINT:C221(al_id_alu_actuadatos_temp;0)

ARRAY TEXT:C222(at_alu_ape_nom;0)
ARRAY TEXT:C222(at_alu_curso;0)
ARRAY TEXT:C222(at_alu_email;0)
ARRAY DATE:C224(ad_actua_date_alu;0)
ARRAY DATE:C224(ad_actua_date_alu_temp;0)

ARRAY LONGINT:C221(al_id_per_actuadatos;0)
ARRAY LONGINT:C221(al_id_per_actuadatos_temp;0)

ARRAY TEXT:C222(at_per_ape_nom;0)
ARRAY TEXT:C222(at_per_email;0)
ARRAY DATE:C224(ad_actua_date_per;0)
ARRAY DATE:C224(ad_actua_date_per_temp;0)

ARRAY LONGINT:C221($DA_Return;0)

at_tipo_id_usr{0}:="2."
AT_SearchArray (->at_tipo_id_usr;">>";->$DA_Return)

For ($i;1;Size of array:C274($DA_Return))
	If (($viniDate#!00-00-00!) & ($vendDate#!00-00-00!))
		If ((ad_last_actuadatos{$DA_Return{$i}}>=$viniDate) & (ad_last_actuadatos{$DA_Return{$i}}<=$vendDate))
			APPEND TO ARRAY:C911(al_id_alu_actuadatos;Num:C11(Substring:C12(at_tipo_id_usr{$DA_Return{$i}};3)))
			APPEND TO ARRAY:C911(ad_actua_date_alu;ad_last_actuadatos{$DA_Return{$i}})
		End if 
	Else 
		APPEND TO ARRAY:C911(al_id_alu_actuadatos;Num:C11(Substring:C12(at_tipo_id_usr{$DA_Return{$i}};3)))
		APPEND TO ARRAY:C911(ad_actua_date_alu;ad_last_actuadatos{$DA_Return{$i}})
	End if 
End for 

ARRAY LONGINT:C221($DA_Return;0)
at_tipo_id_usr{0}:="7."
AT_SearchArray (->at_tipo_id_usr;">>";->$DA_Return)

For ($i;1;Size of array:C274($DA_Return))
	If (($viniDate#!00-00-00!) & ($vendDate#!00-00-00!))
		If ((ad_last_actuadatos{$DA_Return{$i}}>=$viniDate) & (ad_last_actuadatos{$DA_Return{$i}}<=$vendDate))
			APPEND TO ARRAY:C911(al_id_per_actuadatos;Num:C11(Substring:C12(at_tipo_id_usr{$DA_Return{$i}};3)))
			APPEND TO ARRAY:C911(ad_actua_date_per;ad_last_actuadatos{$DA_Return{$i}})
		End if 
	Else 
		APPEND TO ARRAY:C911(al_id_per_actuadatos;Num:C11(Substring:C12(at_tipo_id_usr{$DA_Return{$i}};3)))
		APPEND TO ARRAY:C911(ad_actua_date_per;ad_last_actuadatos{$DA_Return{$i}})
	End if 
End for 


If ($vl_tipo_de_consulta=1)  //los que han actualizado
	
	QUERY WITH ARRAY:C644([Alumnos:2]numero:1;al_id_alu_actuadatos)
	QUERY WITH ARRAY:C644([Personas:7]No:1;al_id_per_actuadatos)
	
Else 
	  //los que no han actualizado
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
	CREATE SET:C116([Alumnos:2];"alu_all")
	
	KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Alumnos:2]Familia_Número:24;"")
	QUERY SELECTION:C341([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3>0)
	KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
	QUERY SELECTION:C341([Personas:7];[Personas:7]Inactivo:46=False:C215)
	CREATE SET:C116([Personas:7];"per_all")
	
	QUERY WITH ARRAY:C644([Alumnos:2]numero:1;al_id_alu_actuadatos)
	CREATE SET:C116([Alumnos:2];"alu_actua")
	DIFFERENCE:C122("alu_all";"alu_actua";"alu_no_actua")
	USE SET:C118("alu_no_actua")
	
	QUERY WITH ARRAY:C644([Personas:7]No:1;al_id_per_actuadatos)
	CREATE SET:C116([Personas:7];"per_actua")
	DIFFERENCE:C122("per_all";"per_actua";"per_no_actua")
	USE SET:C118("per_no_actua")
	SET_ClearSets ("alu_all";"alu_actua";"alu_no_actua";"per_all";"per_actua";"per_no_actua")
End if 

ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)

SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;at_alu_ape_nom;[Alumnos:2]eMAIL:68;at_alu_email;[Alumnos:2]curso:20;at_alu_curso;[Alumnos:2]numero:1;al_id_alu_actuadatos_temp)
SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;at_per_ape_nom;[Personas:7]No:1;al_id_per_actuadatos_temp;[Personas:7]eMail:34;at_per_email)


If ($vl_tipo_de_consulta=1)
	For ($i;1;Size of array:C274(al_id_alu_actuadatos_temp))
		$fia:=Find in array:C230(al_id_alu_actuadatos;al_id_alu_actuadatos_temp{$i})
		APPEND TO ARRAY:C911(ad_actua_date_alu_temp;ad_actua_date_alu{$fia})
	End for 
	
	For ($i;1;Size of array:C274(al_id_per_actuadatos_temp))
		$fia:=Find in array:C230(al_id_per_actuadatos;al_id_per_actuadatos_temp{$i})  //falta declarar uno de estos arreglos arriba....
		APPEND TO ARRAY:C911(ad_actua_date_per_temp;ad_actua_date_per{$fia})
	End for 
	
	$vb_show:=True:C214
Else 
	
	$vb_show:=False:C215
	ARRAY DATE:C224(ad_actua_date_alu_temp;Size of array:C274(at_alu_email))
	ARRAY DATE:C224(ad_actua_date_per_temp;Size of array:C274(at_per_email))
End if 

OBJECT SET VISIBLE:C603(*;"ad_actua_date_alu_temp";$vb_show)
OBJECT SET VISIBLE:C603(*;"ad_actua_date_per_temp";$vb_show)

OBJECT SET VISIBLE:C603(*;"vb_Hoy";$vb_show)
OBJECT SET VISIBLE:C603(*;"vb_Mes";$vb_show)
OBJECT SET VISIBLE:C603(*;"vb_Año";$vb_show)
OBJECT SET VISIBLE:C603(*;"vb_Rango";$vb_show)
OBJECT SET VISIBLE:C603(*;"vt_Fecha1";$vb_show)
OBJECT SET VISIBLE:C603(*;"vt_Fecha2";$vb_show)
OBJECT SET VISIBLE:C603(*;"Texto1";$vb_show)
OBJECT SET VISIBLE:C603(*;"fecha2";$vb_show)
OBJECT SET VISIBLE:C603(*;"fecha1";$vb_show)
OBJECT SET VISIBLE:C603(*;"vl_Año";$vb_show)
OBJECT SET VISIBLE:C603(*;"vl_Año2";$vb_show)
OBJECT SET VISIBLE:C603(*;"vt_Mes";$vb_show)
OBJECT SET VISIBLE:C603(*;"bMes";$vb_show)
OBJECT SET VISIBLE:C603(*;"triangulo";$vb_show)
OBJECT SET VISIBLE:C603(*;"buscar";$vb_show)

