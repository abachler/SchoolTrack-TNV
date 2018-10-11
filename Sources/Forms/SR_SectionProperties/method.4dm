  // Método: Método de Formulario: SR_SectionProperties
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 25/12/10, 09:41:18
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283(HL_sectionProperties;hlSRop_BreakObjects;vlSR_useSection;vlSR_print;vlSR_position;vlSR_options;vlSR_throwPage;vlSR_minSpace;vlSR_breakType;vlSR_breakTable;vlSR_breakField)
C_TEXT:C284(vtSR_breakVariable)

  // Código principal
Case of 
	: (Form event:C388=On Load:K2:1)
		HL_ClearList (HL_sectionProperties)
		HL_sectionProperties:=New list:C375
		APPEND TO LIST:C376(HL_sectionProperties;__ ("Propiedades de impresión");1)
		APPEND TO LIST:C376(HL_sectionProperties;__ ("Script");2)
		APPEND TO LIST:C376(HL_sectionProperties;__ ("Html tags");3)
		
		
		HL_ClearList (hlSRop_BreakObjects)
		hlSRop_BreakObjects:=New list:C375
		APPEND TO LIST:C376(hlSRop_BreakObjects;__ ("Campo");SR Section Break On Field)
		APPEND TO LIST:C376(hlSRop_BreakObjects;__ ("Variable");SR Section Break On Variable)
		APPEND TO LIST:C376(hlSRop_BreakObjects;__ ("Arreglo");SR Section Break On Array)
		
		
		If (vlSR_SectionRef=0)
			_O_ENABLE BUTTON:C192(r3_SRP_UseSection)
			_O_ENABLE BUTTON:C192(r4_SRP_UseSection)
		Else 
			_O_DISABLE BUTTON:C193(r3_SRP_UseSection)
			_O_DISABLE BUTTON:C193(r4_SRP_UseSection)
		End if 
		
		$error:=SR Get Section Scripts (xReportData;vlSR_SectionRef;vtSR_SectionScript;vtSR_Html_Before;vtSR_Html_After)
		$error:=SR Get Section Properties (xReportData;vlSR_SectionRef;vlSR_useSection;vlSR_PrintSection;vlSR_position;vlSR_options;vlSR_throwPage;vlSR_minSpace;vlSR_breakType;vlSR_breakTable;vlSR_breakField;vtSR_breakVariable)
		$useSectionPointer:=Get pointer:C304("r"+String:C10(vlSR_useSection)+"_SRP_UseSection")
		$useSectionPointer->:=1
		
		SELECT LIST ITEMS BY REFERENCE:C630(hlSRop_BreakObjects;vlSR_breakType)
		If (r2_SRP_UseSection=1)
			_O_ENABLE BUTTON:C192(hlSRop_BreakObjects)
			OBJECT SET ENTERABLE:C238(vtSRP_BreakObjectName;False:C215)
		Else 
			_O_DISABLE BUTTON:C193(hlSRop_BreakObjects)
			OBJECT SET ENTERABLE:C238(vtSRP_BreakObjectName;False:C215)
		End if 
		
		Case of 
			: ((vlSR_breakType=SR Section Break On Field) & (vlSR_useSection=SR Use Section On Break))
				vtSRP_BreakObjectName:="["+API Get Virtual Table Name (vlSR_breakTable)+"]"+API Get Virtual Field Name (vlSR_breakTable;vlSR_breakField)
				vtSR_breakVariable:=""
				
				
			: ((vlSR_breakType=SR Section Break On Array) & (vlSR_useSection=SR Use Section On Break))
				vtSRP_BreakObjectName:=vtSR_breakVariable
				
				
			: ((vlSR_breakType=SR Section Break On Variable) & (vlSR_useSection=SR Use Section On Break))
				vtSRP_BreakObjectName:=vtSR_breakVariable
				
		End case 
		
		If (vlSR_options=1)
			vlSRP_KeepSectionOnPage:=1
		Else 
			vlSRP_KeepSectionOnPage:=0
		End if 
		$throwPagePointer:=Get pointer:C304("t"+String:C10(vlSR_throwPage)+"_ThrowPage")
		$throwPagePointer->:=1
		OBJECT SET ENTERABLE:C238(vlSR_minSpace;(vlSR_throwPage=SR Section Throw Page Min Space))
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		If (r2_SRP_UseSection=1)
			_O_ENABLE BUTTON:C192(hlSRop_BreakObjects)
			OBJECT SET ENTERABLE:C238(vtSRP_BreakObjectName;False:C215)
		Else 
			_O_DISABLE BUTTON:C193(hlSRop_BreakObjects)
			OBJECT SET ENTERABLE:C238(vtSRP_BreakObjectName;False:C215)
		End if 
		
		Case of 
			: ((vlSR_breakType=SR Section Break On Field) & (vlSR_useSection=SR Use Section On Break))
				vtSRP_BreakObjectName:="["+API Get Virtual Table Name (vlSR_breakTable)+"]"+API Get Virtual Field Name (vlSR_breakTable;vlSR_breakField)
				
			: ((vlSR_breakType=SR Section Break On Array) & (vlSR_useSection=SR Use Section On Break))
				vtSRP_BreakObjectName:=vtSR_breakVariable
				
			: ((vlSR_breakType=SR Section Break On Variable) & (vlSR_useSection=SR Use Section On Break))
				vtSRP_BreakObjectName:=vtSR_breakVariable
				
		End case 
		
		
		OBJECT SET ENTERABLE:C238(vlSR_minSpace;(vlSR_throwPage=SR Section Throw Page Min Space))
		
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 




