C_BOOLEAN:C305(mailHeaderNextAction)
C_BOOLEAN:C305(driveHeaderNextAction)
C_BOOLEAN:C305(calHeaderNextAction)
C_BOOLEAN:C305(GAFESettingsModificados)
C_BOOLEAN:C305(SN_enable)
  //MONO ticket 144984
C_OBJECT:C1216($ob_request;$ob_response)
C_TEXT:C284($t_json)
C_LONGINT:C283($httpStatus_l)

Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(SN3_LoginTypeGAFE;0)
		ARRAY TEXT:C222(SN3_LoginTypeAluGAFE;0)
		ARRAY TEXT:C222(SN3_LoginTypeProfGAFE;0)
		
		APPEND TO ARRAY:C911(SN3_LoginTypeProfGAFE;__ ("No crear usuarios"))
		APPEND TO ARRAY:C911(SN3_LoginTypeProfGAFE;"-")
		APPEND TO ARRAY:C911(SN3_LoginTypeProfGAFE;__ ("Primer nombre (pedro)"))
		APPEND TO ARRAY:C911(SN3_LoginTypeProfGAFE;__ ("Primer nombre_Apellido paterno (pedro_malaga)"))
		APPEND TO ARRAY:C911(SN3_LoginTypeProfGAFE;__ ("Apellido Paterno (malaga)"))
		APPEND TO ARRAY:C911(SN3_LoginTypeProfGAFE;__ ("Nombres (pedro_alonso)"))
		APPEND TO ARRAY:C911(SN3_LoginTypeProfGAFE;__ ("Inicial primer nombre y apellido paterno (pmalaga)"))
		APPEND TO ARRAY:C911(SN3_LoginTypeProfGAFE;__ ("Identificador nacional principal (127214468)"))
		APPEND TO ARRAY:C911(SN3_LoginTypeProfGAFE;"-")
		APPEND TO ARRAY:C911(SN3_LoginTypeProfGAFE;__ ("La dirección de correo registrada en SchoolTrack"))
		
		
		COPY ARRAY:C226(SN3_LoginTypeProfGAFE;SN3_LoginTypeGAFE)
		
		SN_enable:=LICENCIA_esModuloAutorizado (1;SchoolNet)
		If (SN_enable)  //si el colegio tiene SN debe tener la opción de utilizar los ya generados en SN solo para alumnos y relaciones familiares
			APPEND TO ARRAY:C911(SN3_LoginTypeGAFE;__ ("Utilizar el usuario existente en Schoolnet"))
		End if 
		COPY ARRAY:C226(SN3_LoginTypeGAFE;SN3_LoginTypeAluGAFE)
		
		
		SN3_LoadGAFESettings 
		
		GET PICTURE FROM LIBRARY:C565("Config_Back_SchoolNet";vp_FondoConfig)
		
		OBJECT SET ENABLED:C1123(*;"appsRelFam@";(cb_GAFE_RelFam=1))
		OBJECT SET ENABLED:C1123(*;"appsProf@";(cb_GAFE_Prof=1))
		
		If (cb_GAFE_Alu=0)
			OBJECT SET ENTERABLE:C238(*;"ListNiveles";False:C215)
		Else 
			OBJECT SET ENTERABLE:C238(*;"ListNiveles";True:C214)
		End if 
		
		SN3_LoginTypeGAFE:=SN3_LoginTypeSelGAFE
		SN3_LoginTypeAluGAFE:=SN3_LoginTypeSelAluGAFE
		SN3_LoginTypeProfGAFE:=SN3_LoginTypeSelProfGAFE
		
		NIV_LoadArrays 
		ARRAY TEXT:C222(SN3_GAFE_Alu_Niveles;0)
		COPY ARRAY:C226(<>at_NombreNivelesSchoolNet;SN3_GAFE_Alu_Niveles)
		
		For ($i;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
			$el:=Find in array:C230(SN3_GAFE_Alu_IDNiveles;<>al_NumeroNivelesSchoolNet{$i})
			If ($el=-1)
				AT_Insert (Size of array:C274(SN3_GAFE_Alu_IDNiveles)+1;1;->SN3_GAFE_Alu_IDNiveles;->SN3_GAFE_Alu_Mail;->SN3_GAFE_Alu_Drive;->SN3_GAFE_Alu_Cal)
				SN3_GAFE_Alu_IDNiveles{Size of array:C274(SN3_GAFE_Alu_IDNiveles)}:=<>al_NumeroNivelesSchoolNet{$i}
			End if 
		End for 
		SORT ARRAY:C229(SN3_GAFE_Alu_IDNiveles;SN3_GAFE_Alu_Mail;SN3_GAFE_Alu_Drive;SN3_GAFE_Alu_Cal)
		  //LO SIGUIENTE HAY QUE HACERLO TAMBIEN ANTES DE ENVIAR A SN!!!
		For ($i;Size of array:C274(SN3_GAFE_Alu_IDNiveles);1;-1)
			$el:=Find in array:C230(<>al_NumeroNivelesSchoolNet;SN3_GAFE_Alu_IDNiveles{$i})
			If ($el=-1)
				AT_Delete ($i;1;->SN3_GAFE_Alu_IDNiveles;->SN3_GAFE_Alu_Mail;->SN3_GAFE_Alu_Drive;->SN3_GAFE_Alu_Cal)
			End if 
		End for 
		  //===============================================================
		mailHeaderNextAction:=True:C214
		driveHeaderNextAction:=True:C214
		calHeaderNextAction:=True:C214
		GAFESettingsModificados:=False:C215
		
		vt_GAFEDominio:=""
		
		  //MONO ticket 144984
		$ob_request:=OB_Create 
		OB_SET ($ob_request;-><>GROLBD;"rolbd")
		OB_SET ($ob_request;-><>GCOUNTRYCODE;"codpais")
		
		$t_jsonRequest:=OB_Object2Json ($ob_request;True:C214)
		$httpStatus_l:=Intranet3_LlamadoWS ("WS_GAFEGetDominioColegio";$t_jsonRequest;->$t_json)
		
		If ($httpStatus_l=200)
			$ob_response:=JSON Parse:C1218($t_json;Is object:K8:27)
			OB_GET ($ob_response;->vt_GAFEDominio;"resultado")
		End if 
		
		GAFEDisableModifications:=False:C215
		If (vt_GAFEDominio="")
			OBJECT SET ENABLED:C1123(*;"@";False:C215)
			OBJECT SET ENTERABLE:C238(*;"@";False:C215)
			GAFEDisableModifications:=True:C214
		End if 
		
	: (Form event:C388=On Close Box:K2:21)
		
		SN3_LoginTypeSelGAFE:=SN3_LoginTypeGAFE
		SN3_LoginTypeSelAluGAFE:=SN3_LoginTypeAluGAFE
		SN3_LoginTypeSelProfGAFE:=SN3_LoginTypeProfGAFE
		
		SN3_SaveGAFESettings 
		
		If (GAFESettingsModificados)
			SN3_SendGAFESettings (SN_enable)
		End if 
		
		CANCEL:C270
End case 



