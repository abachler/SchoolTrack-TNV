//%attributes = {}
  //LOC_LoadIdenNacionales 

C_BLOB:C604($blob)
Case of 
	: (<>vtXS_CountryCode="cl")
		ARRAY INTEGER:C220(<>ai_IDNacional_LimiteEdad;3)
		<>ai_IDNacional_LimiteEdad{1}:=0
		<>ai_IDNacional_LimiteEdad{2}:=0
		<>ai_IDNacional_LimiteEdad{3}:=0
		ARRAY TEXT:C222(<>at_IDNacional_Names;3)
		<>at_IDNacional_Names{1}:="RUT"
		<>at_IDNacional_Names{2}:="Identificador Nacional 2"
		<>at_IDNacional_Names{3}:="Identificador Nacional 3"
		ARRAY LONGINT:C221(<>al_IDNational_Mandatory;3)
		<>al_IDNational_Mandatory{1}:=<>al_IDNational_Mandatory{1} ?+ 1
		<>al_IDNational_Mandatory{2}:=0
		<>al_IDNational_Mandatory{3}:=0
		
		
		BLOB_Variables2Blob (->$blob;0;-><>at_IDNacional_Names;-><>ai_IDNacional_LimiteEdad;-><>al_IDNational_Mandatory)
		
		
	: (<>vtXS_CountryCode="mx")
		ARRAY INTEGER:C220(<>ai_IDNacional_LimiteEdad;3)
		<>ai_IDNacional_LimiteEdad{1}:=0
		<>ai_IDNacional_LimiteEdad{2}:=0
		<>ai_IDNacional_LimiteEdad{3}:=0
		ARRAY TEXT:C222(<>at_IDNacional_Names;3)
		<>at_IDNacional_Names{1}:="CURP"
		<>at_IDNacional_Names{2}:="Identificador Nacional 2"
		<>at_IDNacional_Names{3}:="Identificador Nacional 3"
		ARRAY LONGINT:C221(<>al_IDNational_Mandatory;3)
		<>al_IDNational_Mandatory{1}:=0
		<>al_IDNational_Mandatory{2}:=0
		<>al_IDNational_Mandatory{3}:=0
		
		
		BLOB_Variables2Blob (->$blob;0;-><>at_IDNacional_Names;-><>ai_IDNacional_LimiteEdad;-><>al_IDNational_Mandatory)
		
		
	: (<>vtXS_CountryCode="co")
		ARRAY INTEGER:C220(<>ai_IDNacional_LimiteEdad;3)
		<>ai_IDNacional_LimiteEdad{1}:=5
		<>ai_IDNacional_LimiteEdad{2}:=18
		<>ai_IDNacional_LimiteEdad{3}:=0
		ARRAY TEXT:C222(<>at_IDNacional_Names;3)
		<>at_IDNacional_Names{1}:="Registro Civil"
		<>at_IDNacional_Names{2}:="T.I."
		<>at_IDNacional_Names{3}:="C.C."
		ARRAY LONGINT:C221(<>al_IDNational_Mandatory;3)
		<>al_IDNational_Mandatory{1}:=0
		<>al_IDNational_Mandatory{2}:=0
		<>al_IDNational_Mandatory{3}:=0
		BLOB_Variables2Blob (->$blob;0;-><>at_IDNacional_Names;-><>ai_IDNacional_LimiteEdad;-><>al_IDNational_Mandatory)
		
		
	Else 
		ARRAY INTEGER:C220(<>ai_IDNacional_LimiteEdad;3)
		<>ai_IDNacional_LimiteEdad{1}:=0
		<>ai_IDNacional_LimiteEdad{2}:=0
		<>ai_IDNacional_LimiteEdad{3}:=0
		ARRAY TEXT:C222(<>at_IDNacional_Names;3)
		<>at_IDNacional_Names{1}:="Identificador Nacional 1"
		<>at_IDNacional_Names{2}:="Identificador Nacional 2"
		<>at_IDNacional_Names{3}:="Identificador Nacional 3"
		ARRAY LONGINT:C221(<>al_IDNational_Mandatory;3)
		<>al_IDNational_Mandatory{1}:=0
		<>al_IDNational_Mandatory{2}:=0
		<>al_IDNational_Mandatory{3}:=0
		BLOB_Variables2Blob (->$blob;0;-><>at_IDNacional_Names;-><>ai_IDNacional_LimiteEdad;-><>al_IDNational_Mandatory)
		
End case 
$blob:=PREF_fGetBlob (0;"IDsNacionales";$blob)
BLOB_Blob2Vars (->$blob;0;-><>at_IDNacional_Names;-><>ai_IDNacional_LimiteEdad;-><>al_IDNational_Mandatory)
<>vt_IDNacional1_name:=<>at_IDNacional_Names{1}
<>vt_IDNacional2_name:=<>at_IDNacional_Names{2}
<>vt_IDNacional3_name:=<>at_IDNacional_Names{3}
<>vl_IDNacional1_edad:=<>ai_IDNacional_LimiteEdad{1}
<>vl_IDNacional2_edad:=<>ai_IDNacional_LimiteEdad{2}
<>vl_IDNacional3_edad:=<>ai_IDNacional_LimiteEdad{3}


vl_IDNac1_Obliga_Alumnos:=0
vl_IDNac2_Obliga_Alumnos:=0
vl_IDNac3_Obliga_Alumnos:=0
If (<>al_IDNational_Mandatory{1} ?? 1)
	vl_IDNac1_Obliga_Alumnos:=1
End if 
If (<>al_IDNational_Mandatory{1} ?? 2)
	vl_IDNac2_Obliga_Alumnos:=1
End if 
If (<>al_IDNational_Mandatory{1} ?? 3)
	vl_IDNac3_Obliga_Alumnos:=1
End if 

vl_IDNac1_Obliga_Profesores:=0
vl_IDNac2_Obliga_Profesores:=0
vl_IDNac3_Obliga_Profesores:=0
If (<>al_IDNational_Mandatory{2} ?? 1)
	vl_IDNac1_Obliga_Profesores:=1
End if 
If (<>al_IDNational_Mandatory{2} ?? 2)
	vl_IDNac2_Obliga_Profesores:=1
End if 
If (<>al_IDNational_Mandatory{2} ?? 3)
	vl_IDNac3_Obliga_Profesores:=1
End if 

vl_IDNac1_Obliga_Personas:=0
vl_IDNac2_Obliga_Personas:=0
vl_IDNac3_Obliga_Personas:=0
If (<>al_IDNational_Mandatory{3} ?? 1)
	vl_IDNac1_Obliga_Personas:=1
End if 
If (<>al_IDNational_Mandatory{3} ?? 2)
	vl_IDNac2_Obliga_Personas:=1
End if 
If (<>al_IDNational_Mandatory{3} ?? 3)
	vl_IDNac3_Obliga_Personas:=1
End if 


