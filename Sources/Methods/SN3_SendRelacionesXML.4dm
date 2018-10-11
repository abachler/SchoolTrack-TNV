//%attributes = {}
  //SN3_SendRelacionesXML

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)

C_LONGINT:C283($academico;$cuentas;$apoderado)

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

SN3_BuildSelections (SN3_DTi_RelacionesFamiliares;$todos;$useArrays)
If (Records in selection:C76([Personas:7])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Personas:7];$recNums;[Personas:7]No:1;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_RelacionesFamiliares;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_RelacionesFamiliares;"relaciones";$todos;$useArrays;True:C214)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de relaciones familiares..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Personas:7];$recNums{$indice};False:C215)
		$vt_Name:=ST_GetCleanString ([Personas:7]Nombres:2+[Personas:7]Apellido_paterno:3+[Personas:7]Apellido_materno:4)
		If ($vt_Name#"")
			SAX_CreateNode ($refXMLDoc;"relacion")
			SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Personas:7]No:1))
			SAX_CreateNode ($refXMLDoc;"prefijo";True:C214;[Personas:7]Prefijo:90;True:C214)  //mono sn3 cambio
			SAX_CreateNode ($refXMLDoc;"nombres";True:C214;[Personas:7]Nombres:2;True:C214)
			SAX_CreateNode ($refXMLDoc;"appaterno";True:C214;[Personas:7]Apellido_paterno:3;True:C214)
			SAX_CreateNode ($refXMLDoc;"apmaterno";True:C214;[Personas:7]Apellido_materno:4;True:C214)
			SAX_CreateNode ($refXMLDoc;"nombrecompleto";True:C214;[Personas:7]Apellidos_y_nombres:30;True:C214)
			SAX_CreateNode ($refXMLDoc;"sexo";True:C214;[Personas:7]Sexo:8;True:C214)  //mono sn3 cambio
			If ([Personas:7]RUT:6#"")
				SAX_CreateNode ($refXMLDoc;"idnacional";True:C214;[Personas:7]RUT:6;True:C214)
			Else 
				SAX_CreateNode ($refXMLDoc;"idnacional";True:C214;[Personas:7]Pasaporte:59;True:C214)
			End if 
			  /// 16102015 JVP  ticket 134973 se envia identificador nacional 3, por solicitud de Rodrigo Lerzundi en el ticket mencionado
			SAX_CreateNode ($refXMLDoc;"idnacional3";True:C214;[Personas:7]IDNacional_3:38;True:C214)
			  ///
			SAX_CreateNode ($refXMLDoc;"inactivo";True:C214;String:C10(Num:C11([Personas:7]Inactivo:46)))
			PICTURE TO BLOB:C692([Personas:7]Fotografia:43;$blob;".jpg")
			  //BASE64 ENCODE($blob)
			SAX OPEN XML ELEMENT:C853($refXMLDoc;"foto")
			SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blob)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			If ([Personas:7]ES_Apoderado_de_Cuentas:42)
				SAX_CreateNode ($refXMLDoc;"deuda";True:C214;String:C10([Personas:7]Saldo_Ejercicio:85))
				SAX_CreateNode ($refXMLDoc;"fechadeuda";True:C214;SN3_MakeDateInmune2LocalFormat (Current date:C33(*)))
			End if 
			
			  //Para ficha por internet...
			SAX_CreateNode ($refXMLDoc;"fechanacimiento";True:C214;SN3_MakeDateInmune2LocalFormat ([Personas:7]Fecha_de_nacimiento:5))
			SAX_CreateNode ($refXMLDoc;"nacionalidad";True:C214;[Personas:7]Nacionalidad:7;True:C214)
			SAX_CreateNode ($refXMLDoc;"estadocivil";True:C214;[Personas:7]Estado_civil:10;True:C214)
			SAX_CreateNode ($refXMLDoc;"religion";True:C214;[Personas:7]Religión:9;True:C214)
			SAX_CreateNode ($refXMLDoc;"profesion";True:C214;[Personas:7]Profesion:13;True:C214)
			SAX_CreateNode ($refXMLDoc;"nivelestudios";True:C214;[Personas:7]Nivel_de_estudios:11;True:C214)
			SAX_CreateNode ($refXMLDoc;"empresa";True:C214;[Personas:7]Empresa:20;True:C214)
			SAX_CreateNode ($refXMLDoc;"cargo";True:C214;[Personas:7]Cargo:21;True:C214)
			SAX_CreateNode ($refXMLDoc;"telefonoprofesional";True:C214;[Personas:7]Telefono_profesional:29;True:C214)
			SAX_CreateNode ($refXMLDoc;"faxprofesional";True:C214;[Personas:7]Fax_empresa:25;True:C214)
			SAX_CreateNode ($refXMLDoc;"direccionprofesional";True:C214;[Personas:7]Direccion_Profesional:23;True:C214)
			
			SAX_CreateNode ($refXMLDoc;"direccion";True:C214;[Personas:7]Direccion:14;True:C214)
			SAX_CreateNode ($refXMLDoc;"comuna";True:C214;[Personas:7]Comuna:16;True:C214)
			SAX_CreateNode ($refXMLDoc;"codpostal";True:C214;[Personas:7]Codigo_postal:15;True:C214)
			SAX_CreateNode ($refXMLDoc;"ciudad";True:C214;[Personas:7]Ciudad:17;True:C214)
			SAX_CreateNode ($refXMLDoc;"telefono";True:C214;[Personas:7]Telefono_domicilio:19;True:C214)
			SAX_CreateNode ($refXMLDoc;"celular";True:C214;[Personas:7]Celular:24;True:C214)
			SAX_CreateNode ($refXMLDoc;"fax";True:C214;[Personas:7]Fax:35;True:C214)
			SAX_CreateNode ($refXMLDoc;"email";True:C214;[Personas:7]eMail:34;True:C214)
			
			SAX_CreateNode ($refXMLDoc;"direccionec";True:C214;[Personas:7]ACT_DireccionEC:67;True:C214)
			SAX_CreateNode ($refXMLDoc;"comunaec";True:C214;[Personas:7]ACT_ComunaEC:68;True:C214)
			SAX_CreateNode ($refXMLDoc;"codpostalec";True:C214;[Personas:7]ACT_CodPostalEC:70;True:C214)
			SAX_CreateNode ($refXMLDoc;"ciudadec";True:C214;[Personas:7]ACT_CiudadEC:69;True:C214)
			  //fin para ficha por internet
			
			QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
			QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Familia:2#0)
			FIRST RECORD:C50([Familia_RelacionesFamiliares:77])
			SAX_CreateNode ($refXMLDoc;"familias")
			While (Not:C34(End selection:C36([Familia_RelacionesFamiliares:77])))
				SAX_CreateNode ($refXMLDoc;"familia")
				SAX_CreateNode ($refXMLDoc;"idfamilia";True:C214;String:C10([Familia_RelacionesFamiliares:77]ID_Familia:2))
				SET QUERY DESTINATION:C396(Into variable:K19:4;$academico)
				QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Familia_RelacionesFamiliares:77]ID_Persona:3;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24=[Familia_RelacionesFamiliares:77]ID_Familia:2)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$cuentas)
				QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[Familia_RelacionesFamiliares:77]ID_Persona:3;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24=[Familia_RelacionesFamiliares:77]ID_Familia:2)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				$apoderado:=0
				If ($academico>0)
					$apoderado:=$apoderado+1
				End if 
				If ($cuentas>0)
					$apoderado:=$apoderado+2
				End if 
				SAX_CreateNode ($refXMLDoc;"tipoapoderado";True:C214;String:C10($apoderado))
				SAX_CreateNode ($refXMLDoc;"tiporelacion";True:C214;String:C10([Familia_RelacionesFamiliares:77]Tipo_Relación:4))
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				NEXT RECORD:C51([Familia_RelacionesFamiliares:77])
			End while 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_RelacionesFamiliares;0;SNT_Accion_Actualizar;->$arrayLong)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de relaciones familiares.")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de relaciones familiares no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)

