//%attributes = {}
  //BKPaws_LoadConfig

C_BOOLEAN:C305(<>b_AWSDebug)
If (Not:C34(Is compiled mode:C492))
	<>b_AWSDebug:=True:C214
End if 
AWS_notificationsShowSet (<>b_AWSDebug)
AWS_debugSet (<>b_AWSDebug)

  //Por motivos de seguridad, el archivo se crea y se elimina
$t_ruta:=Get 4D folder:C485(Current resources folder:K5:16)
$vt_dir:=System folder:C487(User preferences_user:K41:4)
$vt_dir:=$vt_dir+"AwsComponent"+Folder separator:K24:12

CREATE FOLDER:C475($vt_dir;*)

$t_xmlCredFile:=$vt_dir+"awsCredentials.xml"
$t_xmlConfFile:=$vt_dir+"awsConfig.xml"

If (Test path name:C476($t_xmlCredFile)=Is a document:K24:1)
	DELETE DOCUMENT:C159($t_xmlCredFile)
End if 
If (Test path name:C476($t_xmlConfFile)=Is a document:K24:1)
	DELETE DOCUMENT:C159($t_xmlConfFile)
End if 

C_TEXT:C284($t_xmlCredenciales;$t_xmlConfiguracion)
$t_xmlCredenciales:=BKPs3_ObtieneXMLCredenciales 
$t_xmlConfiguracion:=BKPs3_ObtieneXMLConfiguracion 

TEXT TO DOCUMENT:C1237($t_xmlCredFile;$t_xmlCredenciales;"UTF-8")
TEXT TO DOCUMENT:C1237($t_xmlConfFile;$t_xmlConfiguracion;"UTF-8")

AWS_paramAuto 

DELETE FOLDER:C693($vt_dir;Delete with contents:K24:24)