//%attributes = {}
C_TEXT:C284($t_accion;$1;$t_retorno;$0)

$t_accion:=$1

Case of 
	: ($t_accion="Eliminar")
		READ WRITE:C146([ACT_CFG_DctosIndividuales:229])
		QUERY:C277([ACT_CFG_DctosIndividuales:229];[ACT_CFG_DctosIndividuales:229]ID:1=$2->)
		
		C_LONGINT:C283($l_recs)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recs)
		SET QUERY LIMIT:C395(1)
		READ ONLY:C145([ACT_DctosIndividuales_Cuentas:228])
		QUERY:C277([ACT_DctosIndividuales_Cuentas:228];[ACT_DctosIndividuales_Cuentas:228]ID_Descuento:5=[ACT_CFG_DctosIndividuales:229]ID:1)
		SET QUERY LIMIT:C395(0)
		If ($l_recs=0)
			If (Not:C34(Locked:C147([ACT_CFG_DctosIndividuales:229])))
				DELETE RECORD:C58([ACT_CFG_DctosIndividuales:229])
				$t_retorno:="1"
			Else 
				$t_retorno:="0"
			End if 
		Else 
			$t_retorno:="-1"
		End if 
		KRL_UnloadReadOnly (->[ACT_CFG_DctosIndividuales:229])
		
	: ($t_accion="Insertar")
		C_LONGINT:C283($l_id)
		C_TEXT:C284($t_nombreOrg;$t_nombre)
		C_LONGINT:C283($l_contador)
		
		CREATE RECORD:C68([ACT_CFG_DctosIndividuales:229])
		
		$l_id:=SQ_SeqNumber (->[ACT_CFG_DctosIndividuales:229]ID:1)
		While (Find in field:C653([ACT_CFG_DctosIndividuales:229]ID:1;$l_id)#-1)
			$l_id:=SQ_SeqNumber (->[ACT_CFG_DctosIndividuales:229]ID:1)
		End while 
		
		$t_nombreOrg:="Nuevo Descuento"
		$l_contador:=1
		$t_nombre:=$t_nombreOrg
		While (Find in field:C653([ACT_CFG_DctosIndividuales:229]Nombre:5;$t_nombre)#-1)
			$t_nombre:=$t_nombreOrg+" "+String:C10($l_contador)
			$l_contador:=$l_contador+1
		End while 
		
		[ACT_CFG_DctosIndividuales:229]ID:1:=$l_id
		[ACT_CFG_DctosIndividuales:229]Nombre:5:=$t_nombre
		[ACT_CFG_DctosIndividuales:229]Orden:8:=$2->
		
		SAVE RECORD:C53([ACT_CFG_DctosIndividuales:229])
		KRL_UnloadReadOnly (->[ACT_CFG_DctosIndividuales:229])
		
		$t_retorno:=String:C10($l_id)
End case 

$0:=$t_retorno