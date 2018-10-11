//%attributes = {"executedOnServer":true}
  // CIM_ReconstruyeIndex()
  // Por: Alberto Bachler K.: 05-12-14, 08:42:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($i_campos;$i_indexes;$l_idProgreso;$l_tipo)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_json;$t_nombreCampo;$t_nombreIndex;$t_rutaDefinicionIndexes;$t_uuid;$t_variante)
C_OBJECT:C1216($ob_raiz)

ARRAY LONGINT:C221($al_Campos;0)
ARRAY LONGINT:C221($al_tablas;0)
ARRAY POINTER:C280($ay_Campos;0)
ARRAY TEXT:C222($at_nombrePropiedades;0)
ARRAY TEXT:C222($at_refNodos;0)
ARRAY OBJECT:C1221($ao_Objetos;0)



If (False:C215)
	C_TEXT:C284(CIM_ReconstruyeIndex ;$1)
End if 

$t_rutaDefinicionIndexes:=Get 4D folder:C485(Database folder:K5:14)+"indexacionSchooltrack.json"

If (Test path name:C476($t_rutaDefinicionIndexes)=Is a document:K24:1)
	
	KRL_DropIndexes 
	
	TRACE:C157
	MESSAGES ON:C181
	  //DOCUMENT TO BLOB($t_rutaDefinicionIndexes;$x_blob)
	  //$t_textoJson:=BLOB to text($x_blob;UTF8 text without length)
	$t_json:=Document to text:C1236($t_rutaDefinicionIndexes;"UTF-8")
	$ob_raiz:=OB_JsonToObject ($t_json)
	OB_GetChildNodes ($ob_raiz;->$at_nombrePropiedades;->$ao_Objetos)
	
	
	$l_idProgreso:=Progress New 
	For ($i_indexes;1;Size of array:C274($ao_Objetos))
		OB_GET ($ao_Objetos{$i_indexes};->$t_uuid;"uuid")
		OB_GET ($ao_Objetos{$i_indexes};->$t_nombreIndex;"nombreIndex")
		OB_GET ($ao_Objetos{$i_indexes};->$t_nombreCampo;"nombreCampo")
		OB_GET ($ao_Objetos{$i_indexes};->$l_tipo;"tipo")
		OB_GET ($ao_Objetos{$i_indexes};->$t_variante;"varianteTipo")
		OB_GET ($ao_Objetos{$i_indexes};->$al_tablas;"tabla")
		OB_GET ($ao_Objetos{$i_indexes};->$al_Campos;"campo")
		
		For ($i_campos;Size of array:C274($al_tablas);1;-1)
			Case of 
				: (Not:C34(Is table number valid:C999($al_tablas{$i_campos})))
					AT_Delete ($i_Campos;1;->$al_Tablas;->$al_Campos)
				: (Not:C34(Is field number valid:C1000($al_tablas{$i_campos};$al_Campos{$i_campos})))
					AT_Delete ($i_Campos;1;->$al_Tablas;->$al_Campos)
			End case 
		End for 
		
		AT_Initialize (->$ay_Campos)
		For ($i_campos;1;Size of array:C274($al_tablas))
			APPEND TO ARRAY:C911($ay_campos;Field:C253($al_tablas{$i_campos};$al_Campos{$i_campos}))
		End for 
		
		
		If (($t_nombreIndex#"") & (Size of array:C274($al_Campos)>0))
			$y_tabla:=Table:C252($al_tablas{1})
			CREATE INDEX:C966($y_tabla->;$ay_campos;$l_tipo;$t_nombreIndex)
		End if 
		
		Progress SET TITLE ($l_idProgreso;"Reconstruyendo indexes";$i_indexes/Size of array:C274($at_refNodos);$t_nombreIndex;True:C214)
	End for 
	
	Progress QUIT ($l_idProgreso)
	MESSAGES OFF:C175
	
End if 


