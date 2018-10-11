//%attributes = {}
  // ACTac_Sort4Printing()
  // 
  //
  // modificado por: Alberto Bachler Klein: 25-12-16, 18:21:59
  // - normalización
  // - declaración de variables
  // - limpieza
  // -----------------------------------------------------------

ACTcfg_LoadConfigData (1)

  //JVP 20160614 agrego nuevo orden
Case of 
	: (OrdenCurNivNom=1)
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)
		
		
	: (bAvisoAlumno=1)
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		
		  // Modificado por: Saúl Ponce (14-08-2017) Ticket 184251
		  // GET FIELD RELATION producía error en compilado porque el campo [ACT_Avisos_de_Cobranza]ID_CuentaCorrriente no está relacionado a ningún otro.
		  // Se estaba guardando el id de la cuenta y la selección se creaba con registros incorrectos
		
		  // preservo las condiciones de activacion actuales de la relación
		  //GET FIELD RELATION([ACT_Avisos_de_Cobranza]ID_CuentaCorrriente;$l_AC_IdCC_N1;$l_AC_IdCC_1N)
		  //GET FIELD RELATION([ACT_CuentasCorrientes]ID_Alumno;$l_CC_IdAlumno_N1;$l_CC_IdAlumno_1N)
		
		  // activo las relaciones manuales N a 1 para llegar a la tabla alumnos
		  //SET FIELD RELATION([ACT_Avisos_de_Cobranza]ID_CuentaCorrriente;Automatic;Structure configuration)
		  //SET FIELD RELATION([ACT_CuentasCorrientes]ID_Alumno;Automatic;Structure configuration)
		
		  //SELECTION TO ARRAY([ACT_Avisos_de_Cobranza]ID_CuentaCorrriente;$al_recnums;[ACT_Avisos_de_Cobranza]Fecha_Emision;$ad_fecha;[Alumnos]Apellidos_y_Nombres;$at_nombreAlumnos)
		
		  //reestablezco las condiciones previas de las relaciones
		  //SET FIELD RELATION([ACT_Avisos_de_Cobranza]ID_CuentaCorrriente;$l_AC_IdCC_N1;$l_AC_IdCC_1N)
		  //SET FIELD RELATION([ACT_CuentasCorrientes]ID_Alumno;$l_CC_IdAlumno_N1;$l_CC_IdAlumno_1N)
		
		C_TEXT:C284($t_nombre)
		C_LONGINT:C283($l_idCta)
		
		ARRAY DATE:C224($ad_fecha;0)
		ARRAY LONGINT:C221($al_idCta;0)
		ARRAY LONGINT:C221($al_recnums;0)
		ARRAY TEXT:C222($at_nombreAlumnos;0)
		
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124];$al_recnums;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;$ad_fecha;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;$al_idCta)
		For ($z;1;Size of array:C274($al_recnums))
			$l_idCta:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$al_idCta{$z};->[ACT_CuentasCorrientes:175]ID_Alumno:3)
			$t_nombre:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idCta;->[Alumnos:2]apellidos_y_nombres:40)
			APPEND TO ARRAY:C911($at_nombreAlumnos;$t_nombre)
		End for 
		
		AT_MultiLevelSort (">>>";->$at_nombreAlumnos;->$ad_fecha;->$al_recnums)
		CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$al_recnums)
	Else 
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[Personas:7]Apellidos_y_nombres:30;>;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;>)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
End case 
