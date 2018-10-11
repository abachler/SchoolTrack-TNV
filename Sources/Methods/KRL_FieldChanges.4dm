//%attributes = {}
  // Método: KRL_FieldChanges
  //
  //
  // por Alberto Bachler Klein
  // creación 28/06/17, 11:54:05
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($0)
C_POINTER:C301(${1})

C_BLOB:C604($x_new;$x_old)
C_LONGINT:C283($i;$l_parametros)
C_PICTURE:C286($p_1;$p_2;$p_diferencia;$p_old)
C_TEXT:C284($t_text1;$t_text2)


If (False:C215)
	C_BOOLEAN:C305(KRL_FieldChanges ;$0)
	C_POINTER:C301(KRL_FieldChanges ;${1})
End if 

$l_parametros:=Count parameters:C259

For ($i;1;$l_parametros)
	Case of 
		: (Type:C295(${$i}->)=Is alpha field:K8:1)
			  // generate digest es mas eficiente en textos cortos (toma en cuente tildes y otros caracteres)
			$0:=((Generate digest:C1147(Old:C35(${$i}->);SHA1 digest:K66:2))#(Generate digest:C1147(${$i}->;SHA1 digest:K66:2)))
			
			
		: (Type:C295(${$i}->)=Is text:K8:3)
			  // la comparacion por código de caracteres es mas eficiente en textos largos
			$0:=(ST_ExactlyEqual (Old:C35(${$i}->);${$i}->)=0)
			
			
		: (Type:C295(${$i}->)=Is BLOB:K8:12)
			$x_old:=Old:C35(${$i}->)
			$x_new:=${$i}->
			$0:=((Generate digest:C1147($x_old;SHA1 digest:K66:2))#(Generate digest:C1147($x_new;SHA1 digest:K66:2)))
			
			
		: (Type:C295(${$i}->)=Is picture:K8:10)
			$p_old:=Old:C35(${$i}->)
			$0:=Not:C34(Equal pictures:C1196($p_old;${$i}->;$p_diferencia)) & ((Picture size:C356($p_old)>0) | (Picture size:C356(${$i}->)>0))  //MONO TICKET 199898
			
		: (Type:C295(${$i}->)=Is object:K8:27)
			$0:=JSON Stringify:C1217(Old:C35(${$i}->))#JSON Stringify:C1217(${$i}->)
			
			
		: (Type:C295(${$i}->)=Is subtable:K8:11)
			$0:=False:C215
			
			
		Else 
			$0:=(${$i}->#Old:C35(${$i}->))
			
	End case 
	
	$i:=Choose:C955($0;$l_parametros;$i)
End for 




