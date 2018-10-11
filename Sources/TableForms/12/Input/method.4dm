Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		C_TEXT:C284(sName)
		STR_LeePreferenciasConducta2 
		sMotivo:=""
		atSTRal_MotivosSuspension:=0
		If (DateIsValid (Current date:C33;0))
			dFrom:=Current date:C33
			dTo:=Current date:C33
		Else 
			dFrom:=!00-00-00!
			dTo:=!00-00-00!
		End if 
		vt_observaciones:=""
		If (<>lUSR_RelatedTableUserID>0)
			sprof:=<>tUSR_CurrentUserName
			iProfID:=<>lUSR_RelatedTableUserID
		Else 
			sprof:=""
			iProfID:=0
		End if 
		  //MONO Ticket 179808
		viSTR_CrearInasistencias:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"SuspencionCreaInasistencia";"0"))
		viSTR_CrearInasistenciasFuturas:=Num:C11(PREF_fGet (<>lUSR_CurrentUserID;"SuspencionCreaInasistenciaFutura";"0"))
End case 


Case of 
	: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (vLocation#"Browser"))
		READ ONLY:C145([Alumnos:2])
		sName:=[Alumnos:2]apellidos_y_nombres:40
		$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
		  // determino si la opción de registro de inasistencias automático esta disponible, 
		  // solo con modo de registro de inasistencia diario (1) o por hora detallado (2)
		OBJECT SET ENABLED:C1123(viSTR_CrearInasistencias;($l_modoRegistroAsistencia=1) | ($l_modoRegistroAsistencia=2))
		OBJECT SET ENABLED:C1123(viSTR_CrearInasistenciasFuturas;(dTo>Current date:C33(*)) & ($l_modoRegistroAsistencia=1))
		OBJECT SET ENTERABLE:C238(sName;False:C215)
		
	: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (Size of array:C274(abrSelect)=0) & (vLocation="browser"))
		If (sName="")
			OBJECT SET ENABLED:C1123(viSTR_CrearInasistencias;False:C215)  // determino si la opción de registro de inasistencias automático esta disponible
			OBJECT SET ENABLED:C1123(viSTR_CrearInasistenciasFuturas;False:C215)
			
		Else 
			$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
			  // determino si la opción de registro de inasistencias automático esta disponible, 
			  // solo con modo de registro de inasistencia diario (1) o por hora detallado (2)
			OBJECT SET ENABLED:C1123(viSTR_CrearInasistencias;($l_modoRegistroAsistencia=1) | ($l_modoRegistroAsistencia=2))
			OBJECT SET ENABLED:C1123(viSTR_CrearInasistenciasFuturas;(dTo>Current date:C33(*)) & ($l_modoRegistroAsistencia=1))
		End if 
		
		
	: ((Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2])) & (Size of array:C274(abrSelect)>=1) & (vLocation="browser"))
		If (Size of array:C274(abrSelect)>1)
			sName:=String:C10(Size of array:C274(abrSelect))+" "+__ ("alumnos seleccionados")
			OBJECT SET ENTERABLE:C238(sName;False:C215)
		Else 
			GOTO RECORD:C242([Alumnos:2];alBWR_recordNumber{abrSelect{1}})
			sName:=[Alumnos:2]apellidos_y_nombres:40
			OBJECT SET ENTERABLE:C238(sName;False:C215)
		End if 
		
		  // determino si hay más de una modalidad de registro de inasistencia en la selección de alumnos
		ARRAY LONGINT:C221($al_recNums;0)
		For ($i;1;Size of array:C274(abrSelect))
			APPEND TO ARRAY:C911($al_recNums;alBWR_recordNumber{abrSelect{$i}})
		End for 
		READ ONLY:C145([Alumnos:2])
		CREATE SELECTION FROM ARRAY:C640([Alumnos:2];$al_recNums)
		READ ONLY:C145([xxSTR_Niveles:6])
		KRL_RelateSelection (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29)
		DISTINCT VALUES:C339([xxSTR_Niveles:6]AttendanceMode:3;$al_modosRegistroInasistencia)
		  // determino si la opción de registro de inasistencias automático esta disponible
		  // (si hay al menos un alumno con registro de inasistencia diaria o por hora detallado
		$b_opcionInasistencias:=(Find in array:C230($al_modosRegistroInasistencia;1)>0) | (Find in array:C230($al_modosRegistroInasistencia;2)>0)
		OBJECT SET ENABLED:C1123(viSTR_CrearInasistencias;$b_opcionInasistencias)
		OBJECT SET ENABLED:C1123(viSTR_CrearInasistenciasFuturas;(dTo>Current date:C33(*)) & (Find in array:C230($al_modosRegistroInasistencia;1)>0))
End case 
