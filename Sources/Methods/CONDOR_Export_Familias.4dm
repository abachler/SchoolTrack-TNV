//%attributes = {}
C_POINTER:C301($1;$2;$y_UUIDFamiliasXEnviar;$y_UUIDFamiliasEnviadas)

If (Count parameters:C259=2)
	$y_UUIDFamiliasXEnviar:=$2
	If (Not:C34(Is nil pointer:C315($y_UUIDFamiliasXEnviar)))
		QUERY WITH ARRAY:C644([Familia:78]Auto_UUID:23;$y_UUIDFamiliasXEnviar->)
	Else 
		ALL RECORDS:C47([Familia:78])
	End if 
Else 
	ALL RECORDS:C47([Familia:78])
End if 
$y_UUIDFamiliasEnviadas:=$1

If (Records in selection:C76([Familia:78])>0)
	$refXMLDoc:=CONDOR_ExportDataGenArchivo ("familias";->$vt_FileName)
	
	ARRAY LONGINT:C221($recNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Familia:78];$recNums)
	$size:=Size of array:C274($recNums)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de familias..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Familia:78];$recNums{$indice})
		If (Find in array:C230($y_UUIDFamiliasEnviadas->;[Familia:78]Auto_UUID:23)=-1)
			APPEND TO ARRAY:C911($y_UUIDFamiliasEnviadas->;[Familia:78]Auto_UUID:23)
		End if 
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"familia")
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Auto_UUID:23);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Nombre_de_la_familia:3);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"alumnos";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Numero_de_Alumnos:2);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"grupo";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Grupo_Familia:4);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_padre";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Padre_Número:5);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_madre";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Madre_Número:6);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"situacion";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Sit_Familiar:11);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"observaciones";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Observaciones:12);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Codigo_interno:14);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"year_ingreso";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Año__de_ingreso:17);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_creacion";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Fecha_de_creación:27);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_modificacion";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Fecha_de_Modificacion:28);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"foto";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Fotografia:35);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_matri_civil";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Fecha_Matrimonio_Civil:37);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_matri_religioso";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Fecha_Matrimonio_Religioso:39);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"activa";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Inactiva:31);False:C215;False:C215)
		
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"direcciones")
		If ([Familia:78]Dirección:7+[Familia:78]Comuna:8+[Familia:78]Codigo_postal:19+[Familia:78]Sector_Domicilio:44#"")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Dirección:7);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"comuna";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Comuna:8);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigopostal";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Codigo_postal:19);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"sector";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Sector_Domicilio:44);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"domicilio";False:C215)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End if 
		If ([Familia:78]Dirección:7#"")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Direccion_Postal:29);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"postal";False:C215)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End if 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefonos")
		If ([Familia:78]Telefono:10#"")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Telefono:10);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"personal";False:C215)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End if 
		If ([Familia:78]Celular:32#"")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]Celular:32);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"celular personal";False:C215)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End if 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"emails")
		If ([Familia:78]eMail:21#"")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"email")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;CONDOR_ExportDataTransformer (->[Familia:78]eMail:21);True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"personal";False:C215)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End if 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size;__ ("Exportando familia ")+[Familia:78]Nombre_de_la_familia:3+", "+String:C10($indice)+__ (" de ")+String:C10($size)+"...")
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
End if 

