//%attributes = {}
  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)
C_BLOB:C604($blob)

$todos:=True:C214
$useArrays:=False:C215

Case of 
	: (Count parameters:C259=1)
		$todos:=$1
	: (Count parameters:C259=2)
		$todos:=$1
		$useArrays:=$2
End case 

$currentErrorHandler:=SN3_SetErrorHandler ("set")
C_BLOB:C604($blobFoto)
C_BLOB:C604($blobFirma)
C_BLOB:C604($blobLogo)
C_TEXT:C284($idNacional)
  //SN3_BuildSelections (SN3_DTi_RelacionesFamiliares;$todos;$useArrays)
READ ONLY:C145([Personas:7])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Profesores:4])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([xxSTR_Niveles:6])
READ ONLY:C145([Asignaturas:18])

ARRAY LONGINT:C221($aProfMandados;0)
ARRAY TEXT:C222($aUUIDFamiliaXMandar;0)

$condorfilespath:=SN3_GetFilesPath +"condorfiles"+Folder separator:K24:12
SYS_CreatePath ($condorfilespath)

If ((Records in table:C83([Personas:7])>0) | (Records in table:C83([Alumnos:2])>0) | (Records in table:C83([Profesores:4])>0))
	
	  //$vt_FileName:=SN3_CreateFile2Send ("crear";"";100;"sax";->$refXMLDoc)
	
	$vt_FileName:=SN3_GetFilesPath +"condorfiles"+Folder separator:K24:12+SN3_GenerateUniqueName +"."+<>vtXS_CountryCode+"."+<>gRolBD+"_100.snt"
	If (SYS_TestPathName ($vt_FileName)=Is a document:K24:1)
		DELETE DOCUMENT:C159($vt_FileName)
	End if 
	$refXMLDoc:=Create document:C266($vt_FileName)
	XML SET OPTIONS:C1090($refXMLDoc;XML String encoding:K45:21;XML raw data:K45:23)
	
	SAX_OpenRoot ($refXMLDoc;"colegium";"UTF-8";False:C215)
	
	$vt_RefVersion:=SYS_LeeVersionBaseDeDatos 
	$vt_RefContenido:="personas"
	
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_vers";True:C214;$vt_RefVersion)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_cont";True:C214;$vt_RefContenido)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"file_year";True:C214;String:C10(<>gYear;"0000"))
	
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"xml_data")
	SN3_InsertDTS ($refXMLDoc)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"personas")
	
	ALL RECORDS:C47([Personas:7])
	If (Records in selection:C76([Personas:7])>0)
		
		
		
		ARRAY LONGINT:C221($arrayLong;0)
		ARRAY LONGINT:C221($recNums;0)
		SELECTION TO ARRAY:C260([Personas:7];$recNums;[Personas:7]No:1;$arrayLong)
		
		$size:=Size of array:C274($recNums)
		
		  //SN3_BuildFileHeader ($refXMLDoc;SN3_RelacionesFamiliares;"relaciones";$todos;$useArrays;True)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de personas..."))
		For ($indice;1;$size)
			KRL_GotoRecord (->[Personas:7];$recNums{$indice};False:C215)
			$vt_Name:=ST_GetCleanString ([Personas:7]Nombres:2+[Personas:7]Apellido_paterno:3+[Personas:7]Apellido_materno:4)
			If ($vt_Name#"")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"persona")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"activo";True:C214;ST_Boolean2Str ([Personas:7]Inactivo:46;"0";"1");False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombres";True:C214;[Personas:7]Nombres:2;True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"appaterno";True:C214;[Personas:7]Apellido_paterno:3;True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"apmaterno";True:C214;[Personas:7]Apellido_materno:4;True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"pasaporte";True:C214;[Personas:7]Pasaporte:59;True:C214;False:C215)  //usuario
				$idNacional:=ST_Boolean2Text (([Personas:7]RUT:6#"");[Personas:7]RUT:6;ST_Boolean2Text (([Personas:7]IDNacional_2:37#"");[Personas:7]IDNacional_2:37;ST_Boolean2Text (([Personas:7]IDNacional_3:38#"");[Personas:7]IDNacional_3:38;"")))
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"idnacional";True:C214;$idNacional;True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"fechanacimiento";True:C214;SN3_MakeDateInmune2LocalFormat ([Personas:7]Fecha_de_nacimiento:5);False:C215;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"fechamuerte";True:C214;SN3_MakeDateInmune2LocalFormat ([Personas:7]Fecha_Deceso:89);False:C215;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nacionalidad";True:C214;[Personas:7]Nacionalidad:7;True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"estadocivil";True:C214;[Personas:7]Estado_civil:10;True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"sexo";True:C214;[Personas:7]Sexo:8;False:C215;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"religion";True:C214;[Personas:7]Religión:9;True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel_estudios";True:C214;[Personas:7]Nivel_de_estudios:11;True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"exalumno";True:C214;ST_Boolean2Str ([Personas:7]Es_ExAlumno:12;"1";"0");False:C215;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"profesion";True:C214;[Personas:7]Profesion:13;True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"empresa";True:C214;[Personas:7]Empresa:20;True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"cargo";True:C214;[Personas:7]Cargo:21;True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;[Personas:7]Codigo_interno:22;True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"prefijo";True:C214;[Personas:7]Prefijo:90;True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_persona";True:C214;[Personas:7]Auto_UUID:36;False:C215;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"observaciones";True:C214;[Personas:7]Observaciones:32;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_schooltrack";True:C214;String:C10([Personas:7]No:1);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipopersona";True:C214;"1";False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_st_formadepago";True:C214;String:C10([Personas:7]ACT_id_modo_de_pago:94);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"formapago";True:C214;[Personas:7]ACT_modo_de_pago_new:95;True:C214;False:C215)
				
				SET BLOB SIZE:C606($blobFoto;0)
				SET BLOB SIZE:C606($blobFirma;0)
				If ([Personas:7]ID_Profesor:78>0)
					If (KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->[Personas:7]ID_Profesor:78;False:C215)>-1)
						PICTURE TO BLOB:C692([Profesores:4]Fotografia:59;$blobFoto;".jpg")
						PICTURE TO BLOB:C692([Profesores:4]Firma:15;$blobFirma;".jpg")
						If (BLOB size:C605($blobFirma)>0)
							SAX OPEN XML ELEMENT:C853($refXMLDoc;"firma")  //global_persona
							SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blobFirma)
							SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						End if 
					End if 
				Else 
					PICTURE TO BLOB:C692([Personas:7]Fotografia:43;$blobFoto;".jpg")
				End if 
				If (BLOB size:C605($blobFoto)>0)
					SAX OPEN XML ELEMENT:C853($refXMLDoc;"foto")  //global_persona
					SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blobFoto)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefonos")
				If ([Personas:7]Telefono_domicilio:19#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Personas:7]Telefono_domicilio:19;True:C214)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"domicilio")
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				If ([Personas:7]Telefono_profesional:29#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Personas:7]Telefono_profesional:29;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"laboral";False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				If ([Personas:7]Celular:24#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Personas:7]Celular:24;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"celular personal";False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"emails")
				If ([Personas:7]eMail:34#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"email")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Personas:7]eMail:34;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"personal";False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"direcciones")
				If ([Personas:7]Direccion:14+[Personas:7]Comuna:16+[Personas:7]Codigo_postal:15+[Personas:7]Sector_Domicilio:92#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Personas:7]Direccion:14;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"comuna";True:C214;[Personas:7]Comuna:16;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigopostal";True:C214;[Personas:7]Codigo_postal:15;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"sector";True:C214;[Personas:7]Sector_Domicilio:92;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"region";True:C214;[Personas:7]Region_o_Estado:18;True:C214;False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"domicilio";False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				If ([Personas:7]Direccion_Profesional:23+[Personas:7]Sector_Dom_Profesional:93#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Personas:7]Direccion_Profesional:23;True:C214;False:C215)
					  //CONDOR_ExportSAXCreateNode ($refXMLDoc;"comuna";True;"")
					  //CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigopostal";True;"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"sector";True:C214;[Personas:7]Sector_Dom_Profesional:93;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"laboral";False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				If ([Personas:7]ACT_DireccionEC:67+[Personas:7]ACT_ComunaEC:68+[Personas:7]ACT_CodPostalEC:70#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Personas:7]ACT_DireccionEC:67;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"comuna";True:C214;[Personas:7]ACT_ComunaEC:68;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigopostal";True:C214;[Personas:7]ACT_CodPostalEC:70;True:C214;False:C215)
					  //CONDOR_ExportSAXCreateNode ($refXMLDoc;"sector";True;"";True)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"envio correspondencia";False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
				QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Familia:2#0)
				FIRST RECORD:C50([Familia_RelacionesFamiliares:77])
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"familias")
				While (Not:C34(End selection:C36([Familia_RelacionesFamiliares:77])))
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"familia")
					$uuidFamilia:=KRL_GetTextFieldData (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Auto_UUID:23)
					If (Find in array:C230($aUUIDFamiliaXMandar;$uuidFamilia)=-1)
						APPEND TO ARRAY:C911($aUUIDFamiliaXMandar;$uuidFamilia)
					End if 
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_familia";True:C214;$uuidFamilia;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tiporelacion";True:C214;String:C10([Familia_RelacionesFamiliares:77]Tipo_Relación:4);False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_relacion";True:C214;[Familia_RelacionesFamiliares:77]Auto_UUID:7;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"parentesco";True:C214;[Familia_RelacionesFamiliares:77]Parentesco:6;True:C214)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					NEXT RECORD:C51([Familia_RelacionesFamiliares:77])
				End while 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				
				If ([Personas:7]ID_Profesor:78>0)
					APPEND TO ARRAY:C911($aProfMandados;[Personas:7]ID_Profesor:78)
					If (KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->[Personas:7]ID_Profesor:78;False:C215)>-1)
						If (KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]NoEmployee:7;->[Profesores:4]Numero:1;False:C215)>-1)
							CONDOR_ExportSAXCreateNode ($refXMLDoc;"identificacion";True:C214;[xShell_Users:47]login:9;True:C214;False:C215)  //usuario
							$storedPassword:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
							CONDOR_ExportSAXCreateNode ($refXMLDoc;"clave";True:C214;$storedPassword;True:C214;False:C215)  //usuario
							CONDOR_ExportSAXCreateNode ($refXMLDoc;"email";True:C214;[xShell_Users:47]email:20;True:C214;False:C215)  //usuario
						End if 
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"profesor")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"activo";True:C214;ST_Boolean2Str ([Profesores:4]Inactivo:62;"0";"1");False:C215)  //20150126 RCH
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"departamento";True:C214;[Profesores:4]Departamento:14;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"cargofuncionario";True:C214;[Profesores:4]Cargo:19;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"oficina";True:C214;[Profesores:4]Oficina:22;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"anexo";True:C214;[Profesores:4]Anexo:23;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"habilitacion";True:C214;[Profesores:4]Habilitacion_MinEduc:26;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"iniciales";True:C214;[Profesores:4]Iniciales:29;True:C214;False:C215)  //usuario
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_tutor";True:C214;ST_Boolean2Str ([Profesores:4]Es_Tutor:34;"1";"0");False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_entrevistador";True:C214;ST_Boolean2Str ([Profesores:4]Es_Entrevistador_Admisiones:35;"1";"0");False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_examinador";True:C214;ST_Boolean2Str ([Profesores:4]Es_Examinador_Admisiones:63;"1";"0");False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_presentador";True:C214;ST_Boolean2Str ([Profesores:4]Es_Presentador_Admisiones:74;"1";"0");False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_clase";True:C214;String:C10([Profesores:4]Horas_de_Clase:50);True:C214;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_permanencia";True:C214;String:C10([Profesores:4]Horas_de_Permanencia:51);True:C214;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_jefatura";True:C214;String:C10([Profesores:4]Horas_de_Jefatura:52);True:C214;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_administrativas";True:C214;String:C10([Profesores:4]Horas_administrativas:53);True:C214;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_semanales";True:C214;String:C10([Profesores:4]Total_Horas_semanales:54);True:C214;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_docente";True:C214;ST_Boolean2Str ([Profesores:4]Es_docente:76;"1";"0");False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;[Profesores:4]Codigo_interno:30;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_schooltrack";True:C214;String:C10([Profesores:4]Numero:1);False:C215;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipopersona";True:C214;"3";False:C215;False:C215)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
						  //CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_schooltrack";True;String([Profesores]Numero);False;False)
						  //CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipopersona";True;"3";False;False)
					End if 
				End if 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre persona
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	
	ALL RECORDS:C47([Profesores:4])
	If (Records in selection:C76([Profesores:4])>0)
		ARRAY LONGINT:C221($arrayLong;0)
		ARRAY LONGINT:C221($recNums;0)
		SELECTION TO ARRAY:C260([Profesores:4];$recNums;[Profesores:4]Numero:1;$arrayLong)
		$size:=Size of array:C274($recNums)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de profesores..."))
		For ($indice;1;$size)
			If (Find in array:C230($aProfMandados;$arrayLong{$indice})=-1)
				APPEND TO ARRAY:C911($aProfMandados;$arrayLong{$indice})
				KRL_GotoRecord (->[Profesores:4];$recNums{$indice};False:C215)
				$vt_Name:=ST_GetCleanString ([Profesores:4]Nombres:2+[Profesores:4]Apellido_paterno:3+[Profesores:4]Apellido_materno:4)
				If ($vt_Name#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"persona")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"activo";True:C214;ST_Boolean2Str ([Profesores:4]Inactivo:62;"0";"1");False:C215)  //usuario
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombres";True:C214;[Profesores:4]Nombres:2;True:C214;False:C215)  //usuario
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"appaterno";True:C214;[Profesores:4]Apellido_paterno:3;True:C214;False:C215)  //usuario
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"apmaterno";True:C214;[Profesores:4]Apellido_materno:4;True:C214;False:C215)  //usuario
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"pasaporte";True:C214;[Profesores:4]Pasaporte:60;True:C214;False:C215)  //usuario
					$idNacional:=ST_Boolean2Text (([Profesores:4]RUT:27#"");[Profesores:4]RUT:27;ST_Boolean2Text (([Profesores:4]IDNacional_2:42#"");[Profesores:4]IDNacional_2:42;ST_Boolean2Text (([Profesores:4]IDNacional_3:43#"");[Profesores:4]IDNacional_3:43;"")))
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"idnacional";True:C214;$idNacional;True:C214;False:C215)  //usuario
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"fechanacimiento";True:C214;SN3_MakeDateInmune2LocalFormat ([Profesores:4]Fecha_de_nacimiento:6);False:C215;False:C215)  //usuario
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"fechamuerte";True:C214;SN3_MakeDateInmune2LocalFormat ([Profesores:4]Fecha_Deceso:71);False:C215;False:C215)  //usuario
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"nacionalidad";True:C214;[Profesores:4]Nacionalidad:7;True:C214;False:C215)  //usuario
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"estadocivil";True:C214;[Profesores:4]Estado_civil:18;True:C214;False:C215)  //usuario
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"sexo";True:C214;[Profesores:4]Sexo:5;False:C215;False:C215)  //global_persona
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"religion";True:C214;[Profesores:4]Religion:73;True:C214;False:C215)  //global_persona
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"observaciones";True:C214;[Profesores:4]Observaciones:32;True:C214;False:C215)  //AGREGADO JHB
					  //CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel_estudios";True;"";True)  //global_persona
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"exalumno";True:C214;ST_Boolean2Str ([Profesores:4]Es_ExAlumno:68;"1";"0");False:C215)  //global_persona
					  //CONDOR_ExportSAXCreateNode ($refXMLDoc;"profesion";True;"";True)  //global_persona
					  //CONDOR_ExportSAXCreateNode ($refXMLDoc;"empresa";True;"";True)  //global_persona
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"cargo";True:C214;[Profesores:4]Cargo:19;True:C214;False:C215)  //global_persona
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;[Profesores:4]Codigo_interno:30;True:C214;False:C215)  //global_persona
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"prefijo";True:C214;[Profesores:4]Prefijo:72;True:C214;False:C215)  //global_persona
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_persona";True:C214;[Profesores:4]Auto_UUID:41;False:C215)  //global_persona
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_schooltrack";True:C214;String:C10([Profesores:4]Numero:1);False:C215;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipopersona";True:C214;"3";False:C215;False:C215)
					
					SET BLOB SIZE:C606($blobFirma;0)
					PICTURE TO BLOB:C692([Profesores:4]Firma:15;$blobFirma;".jpg")
					If (BLOB size:C605($blobFirma)>0)
						SAX OPEN XML ELEMENT:C853($refXMLDoc;"firma")  //usuario
						SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blobFirma)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					End if 
					SET BLOB SIZE:C606($blobFoto;0)
					PICTURE TO BLOB:C692([Profesores:4]Fotografia:59;$blobFoto;".jpg")
					If (BLOB size:C605($blobFoto)>0)
						SAX OPEN XML ELEMENT:C853($refXMLDoc;"foto")  //global_persona
						SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blobFoto)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					End if 
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefonos")
					If ([Profesores:4]Telefono_domicilio:24#"")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Profesores:4]Telefono_domicilio:24;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"domicilio";False:C215)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					End if 
					If ([Profesores:4]Celular:44#"")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Profesores:4]Celular:44;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"celular personal";False:C215)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					End if 
					If ([Profesores:4]Fax:39#"")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Profesores:4]Fax:39;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"fax laboral";False:C215)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					End if 
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"emails")
					If ([Profesores:4]eMail_Personal:61#"")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"email")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Profesores:4]eMail_Personal:61;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"personal";False:C215)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					End if 
					If ([Profesores:4]eMail_profesional:38#"")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"email")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Profesores:4]eMail_profesional:38;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"laboral";False:C215)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					End if 
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direcciones")
					If ([Profesores:4]Dirección:8+[Profesores:4]Comuna:10+[Profesores:4]Codigo_postal:33+[Profesores:4]Sector_Domicilio:75#"")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Profesores:4]Dirección:8;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"comuna";True:C214;[Profesores:4]Comuna:10;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigopostal";True:C214;[Profesores:4]Codigo_postal:33;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"sector";True:C214;[Profesores:4]Sector_Domicilio:75;True:C214;False:C215)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"region";True:C214;[Profesores:4]Region_o_Estado:12;True:C214;False:C215)  //AGREGADO JHB
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"domicilio";False:C215)
						SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					End if 
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					
					If (KRL_FindAndLoadRecordByIndex (->[xShell_Users:47]NoEmployee:7;->[Profesores:4]Numero:1;False:C215)>-1)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"identificacion";True:C214;[xShell_Users:47]login:9;True:C214;False:C215)  //usuario
						$storedPassword:=USR_DecryptPassword ([xShell_Users:47]xPass:13)
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"clave";True:C214;$storedPassword;True:C214;False:C215)  //usuario
						CONDOR_ExportSAXCreateNode ($refXMLDoc;"email";True:C214;[xShell_Users:47]email:20;True:C214;False:C215)  //usuario
					End if 
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"profesor")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"activo";True:C214;ST_Boolean2Str ([Profesores:4]Inactivo:62;"0";"1");False:C215)  //usuario
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"departamento";True:C214;[Profesores:4]Departamento:14;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"cargofuncionario";True:C214;[Profesores:4]Cargo:19;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"oficina";True:C214;[Profesores:4]Oficina:22;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"anexo";True:C214;[Profesores:4]Anexo:23;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"habilitacion";True:C214;[Profesores:4]Habilitacion_MinEduc:26;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"iniciales";True:C214;[Profesores:4]Iniciales:29;True:C214;False:C215)  //usuario
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;[Profesores:4]Codigo_interno:30;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_tutor";True:C214;ST_Boolean2Str ([Profesores:4]Es_Tutor:34;"1";"0");False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_entrevistador";True:C214;ST_Boolean2Str ([Profesores:4]Es_Entrevistador_Admisiones:35;"1";"0");False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_examinador";True:C214;ST_Boolean2Str ([Profesores:4]Es_Examinador_Admisiones:63;"1";"0");False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_presentador";True:C214;ST_Boolean2Str ([Profesores:4]Es_Presentador_Admisiones:74;"1";"0");False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_clase";True:C214;String:C10([Profesores:4]Horas_de_Clase:50);True:C214;False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_permanencia";True:C214;String:C10([Profesores:4]Horas_de_Permanencia:51);True:C214;False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_jefatura";True:C214;String:C10([Profesores:4]Horas_de_Jefatura:52);True:C214;False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_administrativas";True:C214;String:C10([Profesores:4]Horas_administrativas:53);True:C214;False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_semanales";True:C214;String:C10([Profesores:4]Total_Horas_semanales:54);True:C214;False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"es_docente";True:C214;ST_Boolean2Str ([Profesores:4]Es_docente:76;"1";"0");False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_schooltrack";True:C214;String:C10([Profesores:4]Numero:1);False:C215;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipopersona";True:C214;"3";False:C215;False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					  //CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_schooltrack";True;String([Profesores]Numero);False;False)
					  //CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipopersona";True;"3";False;False)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre persona
				End if 
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	
	ALL RECORDS:C47([Alumnos:2])
	If (Records in selection:C76([Alumnos:2])>0)
		ARRAY LONGINT:C221($arrayLong;0)
		ARRAY LONGINT:C221($recNums;0)
		SELECTION TO ARRAY:C260([Alumnos:2];$recNums;[Alumnos:2]numero:1;$arrayLong)
		$size:=Size of array:C274($recNums)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de alumnos..."))
		For ($indice;1;$size)
			KRL_GotoRecord (->[Alumnos:2];$recNums{$indice};False:C215)
			$vt_Name:=ST_GetCleanString ([Alumnos:2]Nombres:2+[Alumnos:2]Apellido_paterno:3+[Alumnos:2]Apellido_materno:4)
			If ($vt_Name#"")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"persona")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"activo";True:C214;ST_Boolean2Str ([Alumnos:2]Status:50#"Activo";"0";"1");False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombres";True:C214;[Alumnos:2]Nombres:2;True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"appaterno";True:C214;[Alumnos:2]Apellido_paterno:3;True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"apmaterno";True:C214;[Alumnos:2]Apellido_materno:4;True:C214;False:C215)  //usuario
				$idNacional:=ST_Boolean2Text (([Alumnos:2]RUT:5#"");[Alumnos:2]RUT:5;ST_Boolean2Text (([Alumnos:2]IDNacional_2:71#"");[Alumnos:2]IDNacional_2:71;ST_Boolean2Text (([Alumnos:2]IDNacional_3:70#"");[Alumnos:2]IDNacional_3:70;"")))
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"idnacional";True:C214;$idNacional;True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"pasaporte";True:C214;[Alumnos:2]NoPasaporte:87;True:C214;False:C215)  //AGREGAR JHB
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"fechanacimiento";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos:2]Fecha_de_nacimiento:7);False:C215;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"fechamuerte";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos:2]Fecha_Deceso:98);False:C215;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nacionalidad";True:C214;[Alumnos:2]Nacionalidad:8;True:C214;False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"estadocivil";True:C214;"Soltero";False:C215)  //usuario
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"sexo";True:C214;[Alumnos:2]Sexo:49;False:C215;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"religion";True:C214;[Alumnos:2]Religion:9;True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;[Alumnos:2]Codigo_interno:6;True:C214;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_persona";True:C214;[Alumnos:2]auto_uuid:72;False:C215)  //global_persona
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_schooltrack";True:C214;String:C10([Alumnos:2]numero:1);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipopersona";True:C214;"2";False:C215;False:C215)
				
				SET BLOB SIZE:C606($blobFoto;0)
				PICTURE TO BLOB:C692([Alumnos:2]Fotografía:78;$blobFoto;".jpg")
				If (BLOB size:C605($blobFoto)>0)
					SAX OPEN XML ELEMENT:C853($refXMLDoc;"foto")  //global_persona
					SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blobFoto)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefonos")
				If ([Alumnos:2]Telefono:17#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Alumnos:2]Telefono:17;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"domicilio";False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				If ([Alumnos:2]Celular:95#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Alumnos:2]Celular:95;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"celular personal";False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"emails")
				If ([Alumnos:2]eMAIL:68#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"email")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Alumnos:2]eMAIL:68;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"personal";False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"direcciones")
				If ([Alumnos:2]Direccion:12+[Alumnos:2]Comuna:14+[Alumnos:2]Codigo_Postal:13+[Alumnos:2]Sector_Domicilio:80#"")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Alumnos:2]Direccion:12;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"comuna";True:C214;[Alumnos:2]Comuna:14;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigopostal";True:C214;[Alumnos:2]Codigo_Postal:13;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"sector";True:C214;[Alumnos:2]Sector_Domicilio:80;True:C214;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"region";True:C214;[Alumnos:2]Región_o_estado:16;True:C214;False:C215)  //AGREGADO JHB
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"domicilio";False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End if 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"alumno")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;[Alumnos:2]Codigo_interno:6;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"curso";True:C214;[Alumnos:2]curso:20;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_ingreso";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos:2]Fecha_de_Ingreso:41);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_retiro";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos:2]Fecha_de_retiro:42);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"motivo_retiro";True:C214;[Alumnos:2]Motivo_de_retiro:43;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"estatus";True:C214;[Alumnos:2]Status:50;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero_matricula";True:C214;[Alumnos:2]numero_de_matricula:51;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero_lista";True:C214;String:C10([Alumnos:2]no_de_lista:53);False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero_folio";True:C214;[Alumnos:2]NumeroDeFolio:103;True:C214;False:C215)  //AGREGADO JHB
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"hermanos_en_colegio";True:C214;ST_Boolean2Str ([Alumnos:2]Hermano_en_Colegio:64;"1";"0");False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"hermano_ex_alumno";True:C214;ST_Boolean2Str ([Alumnos:2]Hermano_ex_alumno:65;"1";"0");False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"hijo_ex_alumno";True:C214;ST_Boolean2Str ([Alumnos:2]Hijo_ex_Alumno:66;"1";"0");False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"hijo_funcionario";True:C214;ST_Boolean2Str ([Alumnos:2]Hijo_funcionario:67;"1";"0");False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"vive_con";True:C214;[Alumnos:2]Vive_con:81;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nacido_en";True:C214;[Alumnos:2]Nacido_en:10;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel_ingreso";True:C214;[Alumnos:2]Nivel_al_que_ingreso:35;True:C214;False:C215)  //AGREGADO JHB
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"observaciones";True:C214;[Alumnos:2]Observaciones_generales:39;True:C214;False:C215)  //AGREGADO JHB
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_primera_matricula";True:C214;SN3_MakeDateInmune2LocalFormat (Date:C102([Alumnos:2]Fecha_PrimeraMatricula:86));True:C214;False:C215)  //AGREGADO JHB
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_matricula_actual";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos:2]Fecha_Matricula:108);True:C214;False:C215)  //AGREGADO JHB
				$uuidApoAcademico:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Alumnos:2]Apoderado_académico_Número:27;->[Personas:7]Auto_UUID:36)
				$uuidApoCuentas:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Alumnos:2]Apoderado_Cuentas_Número:28;->[Personas:7]Auto_UUID:36)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_apoacademico";True:C214;$uuidApoAcademico;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_apocuentas";True:C214;$uuidApoCuentas;False:C215)
				$uuidFamilia:=KRL_GetTextFieldData (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;->[Familia:78]Auto_UUID:23)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_familia";True:C214;$uuidFamilia;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_schooltrack";True:C214;String:C10([Alumnos:2]numero:1);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipopersona";True:C214;"2";False:C215;False:C215)
				If (Find in array:C230($aUUIDFamiliaXMandar;$uuidFamilia)=-1)
					APPEND TO ARRAY:C911($aUUIDFamiliaXMandar;$uuidFamilia)
				End if 
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"grupo";True:C214;[Alumnos:2]Grupo:11;True:C214;False:C215)
				$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
				$prom:=""
				$asist:=0
				AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29;->$prom)
				AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33;->$asist)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"promedio";True:C214;$prom;False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"asistencia";True:C214;String:C10($asist;"###,##");False:C215;False:C215)
				
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre persona
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
End if 

If (Size of array:C274($aUUIDFamiliaXMandar)>0)
	dbu_UpdateFamily 
	  //$vt_FileName:=SN3_CreateFile2Send ("crear";"";101;"sax";->$refXMLDoc)
	$vt_FileName:=SN3_GetFilesPath +"condorfiles"+Folder separator:K24:12+SN3_GenerateUniqueName +"."+<>vtXS_CountryCode+"."+<>gRolBD+"_101.snt"
	If (SYS_TestPathName ($vt_FileName)=Is a document:K24:1)
		DELETE DOCUMENT:C159($vt_FileName)
	End if 
	$refXMLDoc:=Create document:C266($vt_FileName)
	XML SET OPTIONS:C1090($refXMLDoc;XML String encoding:K45:21;XML raw data:K45:23)
	
	$size:=Size of array:C274($aUUIDFamiliaXMandar)
	
	  //SN3_BuildFileHeader ($refXMLDoc;SN3_RelacionesFamiliares;"relaciones";$todos;$useArrays;True)
	
	SAX_OpenRoot ($refXMLDoc;"colegium";"UTF-8";False:C215)
	
	$vt_RefVersion:=SYS_LeeVersionBaseDeDatos 
	$vt_RefContenido:="familias"
	
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_vers";True:C214;$vt_RefVersion)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_cont";True:C214;$vt_RefContenido)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"file_year";True:C214;String:C10(<>gYear;"0000"))
	
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"xml_data")
	SN3_InsertDTS ($refXMLDoc)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"familias")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de familias..."))
	For ($indice;1;$size)
		If (KRL_FindAndLoadRecordByIndex (->[Familia:78]Auto_UUID:23;->$aUUIDFamiliaXMandar{$indice};False:C215)>-1)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"familia")
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid";True:C214;[Familia:78]Auto_UUID:23;False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre";True:C214;[Familia:78]Nombre_de_la_familia:3;True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"grupo";True:C214;[Familia:78]Grupo_Familia:4;True:C214;False:C215)
			$uuidPadre:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Familia:78]Padre_Número:5;->[Personas:7]Auto_UUID:36)
			$uuidMadre:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Familia:78]Madre_Número:6;->[Personas:7]Auto_UUID:36)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_padre";True:C214;$uuidPadre;False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_madre";True:C214;$uuidMadre;False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"situacion";True:C214;[Familia:78]Sit_Familiar:11;True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"observaciones";True:C214;[Familia:78]Observaciones:12;True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;[Familia:78]Codigo_interno:14;True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"year_ingreso";True:C214;String:C10([Familia:78]Año__de_ingreso:17);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"activa";True:C214;ST_Boolean2Str (([Familia:78]Inactiva:31);"0";"1");False:C215;False:C215)
			SET BLOB SIZE:C606($blobFoto;0)
			PICTURE TO BLOB:C692([Familia:78]Fotografia:35;$blobFoto;".jpg")
			If (BLOB size:C605($blobFoto)>0)
				SAX OPEN XML ELEMENT:C853($refXMLDoc;"foto")  //global_persona
				SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blobFoto)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End if 
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_matrimonio_civil";True:C214;SN3_MakeDateInmune2LocalFormat ([Familia:78]Fecha_Matrimonio_Civil:37);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"fecha_matrimonio_religioso";True:C214;SN3_MakeDateInmune2LocalFormat ([Familia:78]Fecha_Matrimonio_Religioso:39);False:C215;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"intereses";True:C214;[Familia:78]Intereses:40;True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"hobbies";True:C214;[Familia:78]Hobbies:41;True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"preferencias";True:C214;[Familia:78]Preferencias:42;True:C214;False:C215)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"valores";True:C214;[Familia:78]Valores:43;True:C214;False:C215)
			
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"direcciones")
			If ([Familia:78]Dirección:7+[Familia:78]Comuna:8+[Familia:78]Codigo_postal:19+[Familia:78]Sector_Domicilio:44#"")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Familia:78]Dirección:7;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"comuna";True:C214;[Familia:78]Comuna:8;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigopostal";True:C214;[Familia:78]Codigo_postal:19;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"sector";True:C214;[Familia:78]Sector_Domicilio:44;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"domicilio";False:C215)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End if 
			If ([Familia:78]Dirección:7#"")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Familia:78]Direccion_Postal:29;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"postal";False:C215)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End if 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefonos")
			If ([Familia:78]Telefono:10#"")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Familia:78]Telefono:10;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"personal";False:C215)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End if 
			If ([Familia:78]Celular:32#"")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Familia:78]Celular:32;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"celular personal";False:C215)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End if 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"emails")
			If ([Familia:78]eMail:21#"")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"email")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Familia:78]eMail:21;True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"personal";False:C215)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End if 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre familia
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
End if 

QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
If (Records in selection:C76([Cursos:3])>0)
	  //$vt_FileName:=SN3_CreateFile2Send ("crear";"";102;"sax";->$refXMLDoc)
	$vt_FileName:=SN3_GetFilesPath +"condorfiles"+Folder separator:K24:12+SN3_GenerateUniqueName +"."+<>vtXS_CountryCode+"."+<>gRolBD+"_102.snt"
	If (SYS_TestPathName ($vt_FileName)=Is a document:K24:1)
		DELETE DOCUMENT:C159($vt_FileName)
	End if 
	$refXMLDoc:=Create document:C266($vt_FileName)
	XML SET OPTIONS:C1090($refXMLDoc;XML String encoding:K45:21;XML raw data:K45:23)
	
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Cursos:3];$recNums;[Cursos:3]Numero_del_curso:6;$arrayLong)
	$size:=Size of array:C274($recNums)
	
	SAX_OpenRoot ($refXMLDoc;"colegium";"UTF-8";False:C215)
	
	$vt_RefVersion:=SYS_LeeVersionBaseDeDatos 
	$vt_RefContenido:="cursos"
	
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_vers";True:C214;$vt_RefVersion)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_cont";True:C214;$vt_RefContenido)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"file_year";True:C214;String:C10(<>gYear;"0000"))
	
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"xml_data")
	SN3_InsertDTS ($refXMLDoc)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"cursos")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de cursos..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Cursos:3];$recNums{$indice};False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"curso")
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid";True:C214;[Cursos:3]Auto_UUID:47;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"curso";True:C214;[Cursos:3]Curso:1;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre_largo";True:C214;[Cursos:3]Nombre_Largo_curso:46;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre_oficial";True:C214;[Cursos:3]Nombre_Oficial_Curso:15;True:C214;False:C215)
		$uuidProfJefe:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Cursos:3]Numero_del_profesor_jefe:2;->[Profesores:4]Auto_UUID:41)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_profesor_jefe";True:C214;$uuidProfJefe;False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"sala";True:C214;[Cursos:3]Sala:3;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel";True:C214;String:C10([Cursos:3]Nivel_Numero:7);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"ciclo";True:C214;[Cursos:3]Ciclo:5;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cicloescolar";True:C214;String:C10([Cursos:3]CicloEscolar:16);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"letra";True:C214;[Cursos:3]Letra_Oficial_del_Curso:18;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"letraoficial";True:C214;[Cursos:3]Letra_del_curso:9;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"sede";True:C214;[Cursos:3]Sede:19;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"rol";True:C214;[Cursos:3]cl_RolBaseDatos:20;True:C214;False:C215)
		$uuidDirector:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Cursos:3]Director_IdFuncionario:42;->[Profesores:4]Auto_UUID:41)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_director";True:C214;$uuidDirector;False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoDecretoEvaluacion";True:C214;String:C10([Cursos:3]cl_CodigoDecretoEvaluacion:24);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoDecretoPlanEstudios";True:C214;String:C10([Cursos:3]cl_CodigoDecretoPlanEstudios:22);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoEspecialidadTP";True:C214;String:C10([Cursos:3]cl_CodigoEspecialidadTP:29);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoNivelEspecial";True:C214;[Cursos:3]cl_CodigoNivelEspecial:36;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoPlanEstudios";True:C214;String:C10([Cursos:3]cl_CodigoPlanEstudios:23);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoTipoEnseñanza";True:C214;String:C10([Cursos:3]cl_CodigoTipoEnseñanza:21);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_EspecialidadTP";True:C214;[Cursos:3]cl_EspecialidadTP:28;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_RamaTP";True:C214;[Cursos:3]cl_RamaTP:26;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_SectorEconomicoTP";True:C214;[Cursos:3]cl_SectorEconomicoTP:27;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_TipoEnseñanza";True:C214;[Cursos:3]cl_TipoEnseñanza:25;True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"jornada";True:C214;String:C10([Cursos:3]Jornada:32);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"capacidad";True:C214;String:C10([Cursos:3]Capacidad:30);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"matricula";True:C214;String:C10([Cursos:3]Numero_de_Alumnos:11);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"vacantes";True:C214;String:C10([Cursos:3]Vacantes:31);False:C215;False:C215)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre curso
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
End if 

ALL RECORDS:C47([xxSTR_Niveles:6])
  //$vt_FileName:=SN3_CreateFile2Send ("crear";"";103;"sax";->$refXMLDoc)
$vt_FileName:=SN3_GetFilesPath +"condorfiles"+Folder separator:K24:12+SN3_GenerateUniqueName +"."+<>vtXS_CountryCode+"."+<>gRolBD+"_103.snt"
If (SYS_TestPathName ($vt_FileName)=Is a document:K24:1)
	DELETE DOCUMENT:C159($vt_FileName)
End if 
$refXMLDoc:=Create document:C266($vt_FileName)
XML SET OPTIONS:C1090($refXMLDoc;XML String encoding:K45:21;XML raw data:K45:23)

ARRAY LONGINT:C221($arrayLong;0)
ARRAY LONGINT:C221($recNums;0)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6];$recNums)
$size:=Size of array:C274($recNums)

SAX_OpenRoot ($refXMLDoc;"colegium";"UTF-8";False:C215)

$vt_RefVersion:=SYS_LeeVersionBaseDeDatos 
$vt_RefContenido:="niveles"

CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_vers";True:C214;$vt_RefVersion)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_cont";True:C214;$vt_RefContenido)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"file_year";True:C214;String:C10(<>gYear;"0000"))

CONDOR_ExportSAXCreateNode ($refXMLDoc;"xml_data")
SN3_InsertDTS ($refXMLDoc)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"niveles")

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de niveles..."))
For ($indice;1;$size)
	KRL_GotoRecord (->[xxSTR_Niveles:6];$recNums{$indice};False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivelnumero";True:C214;String:C10([xxSTR_Niveles:6]NoNivel:5);False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre";True:C214;[xxSTR_Niveles:6]Nivel:1;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombreoficial";True:C214;[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"abreviatura";True:C214;[xxSTR_Niveles:6]Abreviatura:19;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"abreviatura_oficial";True:C214;[xxSTR_Niveles:6]Abreviatura_Oficial:35;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoDecretoEvaluacion";True:C214;String:C10([xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38);False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoDecretoPlanEstudios";True:C214;String:C10([xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39);False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoTipoEnseñanza";True:C214;String:C10([xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41);False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoPlanEstudios";True:C214;String:C10([xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40);False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelSubAnual";True:C214;String:C10(Num:C11([xxSTR_Niveles:6]Es_Nivel_SubAnual:50));False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelActivo";True:C214;String:C10(Num:C11([xxSTR_Niveles:6]EsNIvelActivo:30));False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelOficial";True:C214;String:C10(Num:C11([xxSTR_Niveles:6]EsNivelOficial:15));False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelRegular";True:C214;String:C10(Num:C11([xxSTR_Niveles:6]EsNivelRegular:4));False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelSistema";True:C214;String:C10(Num:C11([xxSTR_Niveles:6]EsNivelSistema:10));False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"EsNivelPostulable";True:C214;String:C10(Num:C11([xxSTR_Niveles:6]EsPostulable:45));False:C215;False:C215)
	$uuidDirector:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[xxSTR_Niveles:6]ID_DirectorNivel:52;->[Profesores:4]Auto_UUID:41)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_director";True:C214;$uuidDirector;False:C215;False:C215)
	SET BLOB SIZE:C606($blobLogo;0)
	PICTURE TO BLOB:C692([xxSTR_Niveles:6]Logo:49;$blobLogo;".jpg")
	If (BLOB size:C605($blobLogo)>0)
		SAX OPEN XML ELEMENT:C853($refXMLDoc;"logo")  //global_persona
		SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blobLogo)
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	End if 
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"ciclo";True:C214;[xxSTR_Niveles:6]Sección:9;True:C214;False:C215)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre nivel
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)

ALL RECORDS:C47([Asignaturas:18])
  //$vt_FileName:=SN3_CreateFile2Send ("crear";"";104;"sax";->$refXMLDoc)

$vt_FileName:=SN3_GetFilesPath +"condorfiles"+Folder separator:K24:12+SN3_GenerateUniqueName +"."+<>vtXS_CountryCode+"."+<>gRolBD+"_104.snt"
If (SYS_TestPathName ($vt_FileName)=Is a document:K24:1)
	DELETE DOCUMENT:C159($vt_FileName)
End if 
$refXMLDoc:=Create document:C266($vt_FileName)
XML SET OPTIONS:C1090($refXMLDoc;XML String encoding:K45:21;XML raw data:K45:23)

ARRAY LONGINT:C221($arrayLong;0)
ARRAY LONGINT:C221($recNums;0)
SELECTION TO ARRAY:C260([Asignaturas:18];$recNums)
$size:=Size of array:C274($recNums)

SAX_OpenRoot ($refXMLDoc;"colegium";"UTF-8";False:C215)

$vt_RefVersion:=SYS_LeeVersionBaseDeDatos 
$vt_RefContenido:="asignaturas"

CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_vers";True:C214;$vt_RefVersion)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_cont";True:C214;$vt_RefContenido)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"file_year";True:C214;String:C10(<>gYear;"0000"))

CONDOR_ExportSAXCreateNode ($refXMLDoc;"xml_data")
SN3_InsertDTS ($refXMLDoc)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"asignaturas")

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de asignaturas..."))
For ($indice;1;$size)
	KRL_GotoRecord (->[Asignaturas:18];$recNums{$indice};False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"asignatura")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid";True:C214;[Asignaturas:18]auto_uuid:12;False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre";True:C214;[Asignaturas:18]Asignatura:3;True:C214;False:C215)
	$uuidProfesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_numero:4;->[Profesores:4]Auto_UUID:41)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_profesor";True:C214;$uuidProfesor;False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel";True:C214;String:C10([Asignaturas:18]Numero_del_Nivel:6);False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"sector";True:C214;[Asignaturas:18]Sector:9;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"denominacion_interna";True:C214;[Asignaturas:18]denominacion_interna:16;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"seleccion_por_sexo";True:C214;String:C10([Asignaturas:18]Seleccion_por_sexo:24);False:C215;False:C215)
	$uuidCurso:=KRL_GetTextFieldData (->[Cursos:3]Numero_del_curso:6;->[Asignaturas:18]Numero_del_Curso:25;->[Cursos:3]Auto_UUID:47)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_curso";True:C214;$uuidCurso;False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"abreviatura";True:C214;[Asignaturas:18]Abreviación:26;True:C214;False:C215)
	$uuidFirmante:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_firmante_numero:33;->[Profesores:4]Auto_UUID:41)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_firmante";True:C214;$uuidFirmante;False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_codigo_mineduc";True:C214;[Asignaturas:18]CHILE_CodigoMineduc:41;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigo_interno";True:C214;[Asignaturas:18]Codigo_interno:48;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_semanales";True:C214;String:C10([Asignaturas:18]Horas_Semanales:51);False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_anuales";True:C214;String:C10([Asignaturas:18]Horas_Anuales:68);False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"horas_efectivas";True:C214;String:C10([Asignaturas:18]Horas_de_clases_efectivas:52);False:C215;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"orden_general";True:C214;[Asignaturas:18]ordenGeneral:105;True:C214;False:C215)
	
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre asignatura
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)

ALL RECORDS:C47([Colegio:31])
  //$vt_FileName:=SN3_CreateFile2Send ("crear";"";99;"sax";->$refXMLDoc)

$vt_FileName:=SN3_GetFilesPath +"condorfiles"+Folder separator:K24:12+SN3_GenerateUniqueName +"."+<>vtXS_CountryCode+"."+<>gRolBD+"_99.snt"
If (SYS_TestPathName ($vt_FileName)=Is a document:K24:1)
	DELETE DOCUMENT:C159($vt_FileName)
End if 
$refXMLDoc:=Create document:C266($vt_FileName)
XML SET OPTIONS:C1090($refXMLDoc;XML String encoding:K45:21;XML raw data:K45:23)

SAX_OpenRoot ($refXMLDoc;"colegium";"UTF-8";False:C215)

$vt_RefVersion:=SYS_LeeVersionBaseDeDatos 
$vt_RefContenido:="colegio"

CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_vers";True:C214;$vt_RefVersion)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"ref_cont";True:C214;$vt_RefContenido)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"file_year";True:C214;String:C10(<>gYear;"0000"))

CONDOR_ExportSAXCreateNode ($refXMLDoc;"xml_data")
SN3_InsertDTS ($refXMLDoc)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"colegio")

CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid";True:C214;[Colegio:31]UUID:58;False:C215;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"rol";True:C214;[Colegio:31]Rol Base Datos:9;True:C214;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"pais";True:C214;[Colegio:31]Codigo_Pais:31;True:C214;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefonos")
If ([Colegio:31]Celular:17#"")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Colegio:31]Celular:17;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"celular";False:C215)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
End if 
If ([Colegio:31]Telefono1:7#"")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Colegio:31]Telefono1:7;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"laboral";False:C215)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
End if 
If ([Colegio:31]Telefono2:22#"")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Colegio:31]Telefono2:22;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"laboral";False:C215)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
End if 
If ([Colegio:31]Telefono3:23#"")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Colegio:31]Telefono3:23;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"laboral";False:C215)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
End if 
If ([Colegio:31]Administracion_Telefono:45#"")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"telefono")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"numero";True:C214;[Colegio:31]Administracion_Telefono:45;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"administracion";False:C215)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
End if 
SAX CLOSE XML ELEMENT:C854($refXMLDoc)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"emails")
If ([Colegio:31]eMail:25#"")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"email")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Colegio:31]eMail:25;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"laboral";False:C215)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
End if 
If ([Colegio:31]Administracion_EMail:47#"")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"email")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Colegio:31]Administracion_EMail:47;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"administracion";False:C215)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
End if 
SAX CLOSE XML ELEMENT:C854($refXMLDoc)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"direcciones")
If ([Colegio:31]Dirección:3+[Colegio:31]Comuna:4+[Colegio:31]CodigoPostal:24#"")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Colegio:31]Dirección:3;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"comuna";True:C214;[Colegio:31]Comuna:4;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigopostal";True:C214;[Colegio:31]CodigoPostal:24;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"laboral";False:C215)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
End if 
If ([Colegio:31]Administracion_Direccion:41+[Colegio:31]Administracion_Comuna:42+[Colegio:31]Administracion_CPostal:44#"")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion")
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"direccion";True:C214;[Colegio:31]Administracion_Direccion:41;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"comuna";True:C214;[Colegio:31]Administracion_Comuna:42;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"codigopostal";True:C214;[Colegio:31]Administracion_CPostal:44;True:C214;False:C215)
	CONDOR_ExportSAXCreateNode ($refXMLDoc;"tipo";True:C214;"administracion";False:C215)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
End if 
SAX CLOSE XML ELEMENT:C854($refXMLDoc)

CONDOR_ExportSAXCreateNode ($refXMLDoc;"idcorporacion";True:C214;[Colegio:31]Corporacion_ID:34;True:C214;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"corporacionnombre";True:C214;[Colegio:31]Corporacion_Nombre:35;True:C214;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre";True:C214;[Colegio:31]Nombre_Colegio:1;True:C214;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"razonsocial";True:C214;[Colegio:31]RazonSocial:38;True:C214;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"id_nacional";True:C214;[Colegio:31]RUT:2;True:C214;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"representante_nombre";True:C214;[Colegio:31]RepresentanteLegal_Nombre:39;True:C214;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"representante_RUN";True:C214;[Colegio:31]RepresentanteLegal_RUN:40;True:C214;False:C215)
$uuidDirector:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Colegio:31]Director_IdFuncionario:61;->[Profesores:4]Auto_UUID:41)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_director";True:C214;$uuidDirector;False:C215;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"MINEDUC_codigodirprovincial";True:C214;String:C10([Colegio:31]MINEDUC_CodigoDirProvincial:29);True:C214;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"MINEDUC_codigoensenanza";True:C214;[Colegio:31]MINEDUC_CodigoEnsenanza:32;True:C214;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"MINEDUC_codigoestablecimiento";True:C214;[Colegio:31]MINEDUC_CodigoEstablecimiento:33;True:C214;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"MINEDUC_derechosescolares";True:C214;String:C10([Colegio:31]MINEDUC_DerechosEscolares:30);False:C215;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"MINEDUC_fechareconocimiento";True:C214;SN3_MakeDateInmune2LocalFormat ([Colegio:31]MINEDUC_FechaReconocimiento:15);False:C215;False:C215)
CONDOR_ExportSAXCreateNode ($refXMLDoc;"MINEDUC_noresolreconocimiento";True:C214;[Colegio:31]MINEDUC_NoResolReconocimiento:12;True:C214;False:C215)

SET BLOB SIZE:C606($blobLogo;0)
PICTURE TO BLOB:C692([Colegio:31]Logo:37;$blobLogo;".jpg")
If (BLOB size:C605($blobLogo)>0)
	SAX OPEN XML ELEMENT:C853($refXMLDoc;"logo")
	SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blob)
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
End if 

SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)

ARRAY TEXT:C222($aDocs;0)
DOCUMENT LIST:C474($condorfilespath;$aDocs)
If (Size of array:C274($aDocs)>0)
	SN3_LoadGeneralSettings 
	
	$err:=IT_GetPort (1;$port)
	$err:=IT_SetPort (1;SN3_FTP_Port)
	
	$err:=FTP_Login (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpConnectionID)
	If ($err=0)
		  //$err:=FTP_SetPassive ($ftpConnectionID;<>ftp_UsePassive)
		$err:=FTP_SetPassive ($ftpConnectionID;1)  //20170520 RCH. Se cambia a pedido de JHB
		$ftpDirectory:="/CondorFiles"
		$err:=FTP_CreatePath ($ftpConnectionID;$ftpDirectory)
		If ($err=0)
			$err:=FTP_ChangeDir ($ftpConnectionID;$ftpDirectory)
			If ($err=0)
				$folder:=$condorfilespath
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Enviando archivos a condor..."))
				For ($x;1;Size of array:C274($aDocs))
					$hostPath:=$ftpDirectory+"/"+$aDocs{$x}
					$newPath:=$folder+$aDocs{$x}
					$errorString:=SN3_FTP_SendFile (SN3_FTP_Server;SN3_FTP_User;SN3_FTP_Password;$ftpDirectory;$newPath;$hostPath;True:C214;->$ftpConnectionID;False:C215)
					If ($errorString="")
						LOG_RegisterEvt ("CONDOR_ExportTest: Archivo "+$aDocs{$x}+" transferido con exito.")
					Else 
						LOG_RegisterEvt ("CONDOR_ExportTest: Archivo "+$aDocs{$x}+" no transferido. "+$errorString)
					End if 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$x/Size of array:C274($aDocs))
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			End if 
		End if 
		$err:=FTP_Logout ($ftpConnectionID)
		$err:=IT_SetPort (1;$port)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)