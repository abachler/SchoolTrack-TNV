  // Actualizacion11_1.Botón15()
  // Por: Alberto Bachler: 11/01/13, 18:31:24
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($t_asunto;$t_copiaA;$t_Cuerpo;$t_email;$t_versionBaseDeDatos;$t_versionEstructura)

Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		
	: (Form event:C388=On Clicked:K2:4)
		
		$t_versionEstructura:=OBJECT Get title:C1068(*;"versionAplicacion")
		$t_versionBaseDeDatos:=OBJECT Get title:C1068(*;"versionBD")
		$t_asunto:="Informe de verificación de Base de datos "+<>gCustom
		
		Case of 
			: (FORM Get current page:C276=3)
				$t_Cuerpo:="\r\r"+__ ("En la verificación de la base de datos previa a la actualización desde ^0 a ^1 se detectaron daños en la base de datos de la institución ")+<>gCustom+": \r\r"
				$t_Cuerpo:=$t_Cuerpo+AT_array2text (->at_DataFileError;"\r")
				$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("La base de datos dañada se encuentra en el servidor SchoolTrack de la institución en la ruta siguiente:\r")+Data file:C490+"\r\r"
				
			: (FORM Get current page:C276=4)
				$t_Cuerpo:=__ ("Se detectó pérdida de registros en algunas tablas después de compactar la base de datos.")+<>gCustom+": \r\r"
				$t_Cuerpo:=$t_Cuerpo+"\r\r"+__ ("La base de datos se encuentra en el servidor SchoolTrack de la institución en la ruta siguiente:\r")+Data file:C490+"\r\r"
				
		End case 
		
		
		
		
		$t_cuerpo:=Replace string:C233($t_Cuerpo;"^0";$t_versionBaseDeDatos)
		$t_cuerpo:=Replace string:C233($t_Cuerpo;"^1";$t_versionEstructura)
		
		$t_email:="soporte@colegium.com"
		$t_copiaA:="qa@colegium.com"
		OPEN URL:C673("mailto:"+$t_email+"?cc="+$t_copiaA+"&subject="+$t_asunto+"&body="+$t_Cuerpo)
		
End case 