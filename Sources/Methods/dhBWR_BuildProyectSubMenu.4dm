//%attributes = {}
  // dhBWR_BuildProyectSubMenu()
  // Por: Alberto Bachler K.: 31-08-15, 10:35:25
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($t_itemsMenu)

ARRAY TEXT:C222($at_itemsMenu;0)

C_TEXT:C284(vmref_proyectSubMenuRef)

Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Familias"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Relaciones Familiares"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Apoderados académicos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Apoderados de cuentas"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Padres y Madres"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Padres"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Madres"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Cursos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Asignaturas"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Cursos:3]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Asignaturas"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Profesores"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Alumnos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Familias"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Relaciones Familiares"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Familia:78]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Alumnos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Relaciones Familiares [todas]"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Padres y Madres"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Padres"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Madres"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Cursos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Asignaturas"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Alumnos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Familias"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Asignaturas"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Alumnos"))
				
		End case 
	: (vsBWR_CurrentModule="AccountTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Apoderados"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Terceros"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Avisos de Cobranza"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagarés"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Tributarios"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos en Cartera"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Depositados"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Cuentas Corrientes"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Terceros"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Avisos de Cobranza"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagarés"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Tributarios"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos en Cartera"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Depositados"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Terceros:138]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Cuentas Corrientes"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Apoderados"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Avisos de Cobranza"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagarés"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Tributarios"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos en Cartera"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Depositados"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Familia:78]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Cuentas Corrientes"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Apoderados"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagares:184]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Cuentas Corrientes"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Apoderados"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Terceros"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Avisos de Cobranza"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Tributarios"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos en Cartera"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Depositados"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Cuentas Corrientes"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Apoderados"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Terceros"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagarés"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Tributarios"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos en Cartera"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Depositados"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Cuentas Corrientes"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Apoderados"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Terceros"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Avisos de Cobranza"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagarés"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Tributarios"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos en Cartera"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Depositados"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Cuentas Corrientes"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Apoderados"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Terceros"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Avisos de Cobranza"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagarés"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos en Cartera"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Depositados"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Cuentas Corrientes"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Apoderados"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Terceros"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Avisos de Cobranza"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagarés"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Tributarios"))
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Cuentas Corrientes"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Apoderados"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Terceros"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Avisos de Cobranza"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagarés"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Pagos"))
				APPEND TO ARRAY:C911($at_itemsMenu;__ ("Documentos Tributarios"))
				
			Else 
				vl_ProyectMenuID:=0
				$t_itemsMenu:=""
		End case 
End case 

If (Size of array:C274($at_itemsMenu)>0)
	$t_itemsMenu:=AT_array2text (->$at_itemsMenu)
	APPEND MENU ITEM:C411(3;"(-")
	
	If (vmref_proyectSubMenuRef#"")
		RELEASE MENU:C978(vmref_proyectSubMenuRef)
	End if 
	vmref_proyectSubMenuRef:=Create menu:C408
	
	APPEND MENU ITEM:C411(vmref_proyectSubMenuRef;$t_itemsMenu;Current process:C322)
	APPEND MENU ITEM:C411(3;__ ("Proyectar selección a");vmref_proyectSubMenuRef;Current process:C322)
	MNU_SetMenuItemState ((Size of array:C274(alBWR_recordNumber)>0);3;11)
End if 
