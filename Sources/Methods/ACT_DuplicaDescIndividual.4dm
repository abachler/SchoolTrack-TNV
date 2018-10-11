//%attributes = {}


  // Creado por: Alexis Bustamante (09-07-2017)


C_LONGINT:C283($l_progres;$i;$year)
C_TEXT:C284($t_year)
C_LONGINT:C283($l_progres;$i;$l_RecNumNew)
ARRAY LONGINT:C221($al_RecNumDesc;0)
ARRAY TEXT:C222($at_Cuentas;0)
  //mensaje des

$t_year:=CD_Request (__ ("El siguiente Script dejará inactivo los descuentos individuales del periodo actual luego los duplicará y se les  asignará el Periodo que se ingresa a continuación: ");__ ("Aceptar");__ ("Cancelar");__ ("");__ (String:C10(<>gyear+1)))
If (ok=1)
	
	READ WRITE:C146([ACT_DctosIndividuales_Cuentas:228])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	
	QUERY:C277([ACT_DctosIndividuales_Cuentas:228];[ACT_DctosIndividuales_Cuentas:228]Inactivo:10=False:C215)
	SELECTION TO ARRAY:C260([ACT_DctosIndividuales_Cuentas:228];$al_RecNumDesc)
	
	$l_progres:=IT_Progress (1;0;$l_progres;__ ("Creando Descuentos Individuales"))
	
	For ($i;1;Size of array:C274($al_RecNumDesc))
		GOTO RECORD:C242([ACT_DctosIndividuales_Cuentas:228];$al_RecNumDesc{$i})
		If ([ACT_DctosIndividuales_Cuentas:228]Periodo:9#$t_year)
			
			[ACT_DctosIndividuales_Cuentas:228]Inactivo:10:=True:C214
			SAVE RECORD:C53([ACT_DctosIndividuales_Cuentas:228])
			
			DUPLICATE RECORD:C225([ACT_DctosIndividuales_Cuentas:228])
			[ACT_DctosIndividuales_Cuentas:228]ID:1:=SQ_SeqNumber (->[ACT_DctosIndividuales_Cuentas:228]ID:1)
			[ACT_DctosIndividuales_Cuentas:228]Inactivo:10:=False:C215
			[ACT_DctosIndividuales_Cuentas:228]Periodo:9:=$t_year
			SAVE RECORD:C53([ACT_DctosIndividuales_Cuentas:228])
			
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_DctosIndividuales_Cuentas:228]ID_CuentaCorriente:6)
			
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
			APPEND TO ARRAY:C911($at_Cuentas;[Alumnos:2]apellidos_y_nombres:40)
			
			  //agregar log
		End if 
		$l_progres:=IT_Progress (0;$l_progres;$i/Size of array:C274($al_RecNumDesc))
	End for 
	$l_progres:=IT_Progress (-1;$l_progres)
	KRL_UnloadReadOnly (->[ACT_DctosIndividuales_Cuentas:228])
	
	LOG_RegisterEvt ("Creación de descuentos individuales, periodo "+$t_year+", para las cuentas :"+AT_array2text (->$at_Cuentas;"-"))
End if 

