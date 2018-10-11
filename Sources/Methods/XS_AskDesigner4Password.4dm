//%attributes = {}
  //XS_AskDesigner4Password

GET LIST ITEM:C378(hl_Designers;Selected list items:C379(hl_Designers);$ref;$text)
vtXS_Did:=ST_GetWord ($text;1;":")
vtXS_Dnombre:=ST_GetWord ($text;2;":")
vtXS_Dlogin:=ST_GetWord ($text;3;":")
vtXS_Dpass:=ST_GetWord ($text;4;":")
vtXS_Demail:=ST_GetWord ($text;5;":")

$userName:="appSchoolTrack@colegium.com"
$password:="quasimodo"
$body:="NO RESPONDA A ESTE CORREO"+"\r\r"+"Estimado "+vtXS_Dnombre+":"+"\r\r"+"Por motivos de seguridad es necesario modificar su clave de acceso a SchoolTrack."+" Por favor envíe su nueva clave (máximo 15 caracteres) a nuevaclave@colegi"+"um.com "+"a la brevedad."
$body:=$body+"\r"+"Su nueva clave estará operativa a partir de la próxima versión de SchoolTrack."+"\r\r"+"Atentamente,"+"\r"+"Departamento de Desarrollo"+"\r"+"Colegium S.A."
$err:=SMTP_Send_Text ("mail.colegium.com";"Colegium";vtXS_Demail;"Solicitud de Nueva Clave";$body;$userName;$password;1)
$0:=$err