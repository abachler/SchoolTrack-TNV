If (<>vt_IDNacional1_name="")
	<>vt_IDNacional1_name:="Identificador 1"
End if 
If (<>vt_IDNacional2_name="")
	<>vt_IDNacional2_name:="Identificador 2"
End if 
If (<>vt_IDNacional3_name="")
	<>vt_IDNacional3_name:="Identificador 3"
End if 

ARRAY INTEGER:C220(<>ai_IDNacional_LimiteEdad;3)
<>ai_IDNacional_LimiteEdad{1}:=<>vl_IDNacional1_edad
<>ai_IDNacional_LimiteEdad{2}:=<>vl_IDNacional2_edad
<>ai_IDNacional_LimiteEdad{3}:=<>vl_IDNacional3_edad
ARRAY TEXT:C222(<>at_IDNacional_Names;3)
<>at_IDNacional_Names{1}:=<>vt_IDNacional1_name
<>at_IDNacional_Names{2}:=<>vt_IDNacional2_name
<>at_IDNacional_Names{3}:=<>vt_IDNacional3_name

ARRAY LONGINT:C221(<>al_IDNational_Mandatory;3)
<>al_IDNational_Mandatory{1}:=0
<>al_IDNational_Mandatory{2}:=0
<>al_IDNational_Mandatory{3}:=0

If (vl_IDNac1_Obliga_Alumnos=1)
	<>al_IDNational_Mandatory{1}:=<>al_IDNational_Mandatory{1} ?+ 1
End if 

If (vl_IDNac2_Obliga_Alumnos=1)
	<>al_IDNational_Mandatory{1}:=<>al_IDNational_Mandatory{1} ?+ 2
End if 

If (vl_IDNac3_Obliga_Alumnos=1)
	<>al_IDNational_Mandatory{1}:=<>al_IDNational_Mandatory{1} ?+ 3
End if 


If (vl_IDNac1_Obliga_Profesores=1)
	<>al_IDNational_Mandatory{2}:=<>al_IDNational_Mandatory{2} ?+ 1
End if 

If (vl_IDNac2_Obliga_Profesores=1)
	<>al_IDNational_Mandatory{2}:=<>al_IDNational_Mandatory{2} ?+ 2
End if 

If (vl_IDNac3_Obliga_Profesores=1)
	<>al_IDNational_Mandatory{2}:=<>al_IDNational_Mandatory{2} ?+ 3
End if 


If (vl_IDNac1_Obliga_Personas=1)
	<>al_IDNational_Mandatory{3}:=<>al_IDNational_Mandatory{3} ?+ 1
End if 

If (vl_IDNac2_Obliga_Personas=1)
	<>al_IDNational_Mandatory{3}:=<>al_IDNational_Mandatory{3} ?+ 2
End if 

If (vl_IDNac3_Obliga_Personas=1)
	<>al_IDNational_Mandatory{3}:=<>al_IDNational_Mandatory{3} ?+ 3
End if 





BLOB_Variables2Blob (->$blob;0;-><>at_IDNacional_Names;-><>ai_IDNacional_LimiteEdad;-><>al_IDNational_Mandatory)
PREF_SetBlob (0;"IDsNacionales";$blob)

dhVS_SetSpecialTitles 