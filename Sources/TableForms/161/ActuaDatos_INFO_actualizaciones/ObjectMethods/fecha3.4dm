$Fechafecha:=DT_PopCalendar 
$fecha:=String:C10($Fechafecha;7)
If ($fecha#dt_GetNullDateString )
	vt_Fecha3:=$fecha
	vd_Fecha3:=$Fechafecha
	
	ARRAY LONGINT:C221(al_id_per_actuadatos_temp;0)
	ARRAY TEXT:C222(at_per_ape_nom;0)
	ARRAY TEXT:C222(at_per_email;0)
	
	SN3_ActuaDatos_RF_Pendientes (vd_Fecha3;"RF_pendientes")
	USE SET:C118("RF_pendientes")
	ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
	SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;at_per_ape_nom;[Personas:7]No:1;al_id_per_actuadatos_temp;[Personas:7]eMail:34;at_per_email)
	OBJECT SET TITLE:C194(*;"Apo_cantidad_txt";__ ("Relaciones Familiares Listadas :")+" "+String:C10(Size of array:C274(al_id_per_actuadatos_temp)))
	CLEAR SET:C117("RF_pendientes")
Else 
	vt_Fecha3:=""
	vd_Fecha3:=!00-00-00!
End if 