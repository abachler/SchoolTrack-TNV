//%attributes = {}
  // QR_IsReportAllowed()
  //
  //
  // creado por: Alberto Bachler Klein: 05-04-16, 16:37:45
  // -----------------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_informeAutorizado)
C_LONGINT:C283($i;$l_idGrupo;$l_IdInforme;$l_listaGruposUsuarios;$l_listaUsuarios)
C_TEXT:C284($t_nombreGrupo;$t_nombreUsuario)


If (False:C215)
	C_BOOLEAN:C305(QR_IsReportAllowed ;$0)
	C_LONGINT:C283(QR_IsReportAllowed ;$1)
End if 

If (Count parameters:C259=1)
	$l_IdInforme:=$1
	READ ONLY:C145([xShell_Reports:54])
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ID:7=$l_IdInforme)
End if 

If (Record number:C243([xShell_Reports:54])>=0)
	Case of 
		: ([xShell_Reports:54]Propietary:9=<>lUSR_CurrentUserID)
			$b_informeAutorizado:=True:C214
		: ([xShell_Reports:54]Public:8)
			If (([xShell_Reports:54]RelatedTable:14=0) | ([xShell_Reports:54]RelatedTable:14=[xShell_Reports:54]MainTable:3))
				If (USR_checkRights ("L";Table:C252([xShell_Reports:54]MainTable:3)))
					$b_informeAutorizado:=True:C214
				Else 
					$b_informeAutorizado:=False:C215
				End if 
			Else 
				If (USR_checkRights ("L";Table:C252([xShell_Reports:54]RelatedTable:14)))
					$b_informeAutorizado:=True:C214
				Else 
					$b_informeAutorizado:=False:C215
				End if 
			End if 
		: (USR_IsGroupMember_by_GrpID (-15001))
			$b_informeAutorizado:=True:C214
		: (<>lUSR_CurrentUserID<0)
			$b_informeAutorizado:=True:C214
		Else 
			If (BLOB size:C605([xShell_Reports:54]xAuthorizedUsers:28)>0)
				$l_listaUsuarios:=BLOB to list:C557([xShell_Reports:54]xAuthorizedUsers:28)
				$t_nombreUsuario:=HL_FindInListByReference ($l_listaUsuarios;<>lUSR_CurrentUserID)
				If ($t_nombreUsuario="")
					If (BLOB size:C605([xShell_Reports:54]xAuthorizedGroups:27)>0)
						$l_listaGruposUsuarios:=BLOB to list:C557([xShell_Reports:54]xAuthorizedGroups:27)
						For ($i;1;Count list items:C380($l_listaGruposUsuarios))
							GET LIST ITEM:C378($l_listaGruposUsuarios;$i;$l_idGrupo;$t_nombreGrupo)
							If (USR_IsGroupMember_by_GrpID ($l_idGrupo))
								$b_informeAutorizado:=True:C214
								$i:=Count list items:C380($l_listaGruposUsuarios)+1
							End if 
						End for 
					End if 
				Else 
					$b_informeAutorizado:=True:C214
				End if 
			Else 
				If (([xShell_Reports:54]RelatedTable:14=0) | ([xShell_Reports:54]RelatedTable:14=[xShell_Reports:54]MainTable:3))
					If (USR_checkRights ("L";Table:C252([xShell_Reports:54]MainTable:3)))
						$b_informeAutorizado:=True:C214
					Else 
						$b_informeAutorizado:=False:C215
					End if 
				Else 
					If (USR_checkRights ("L";Table:C252([xShell_Reports:54]RelatedTable:14)))
						$b_informeAutorizado:=True:C214
					Else 
						$b_informeAutorizado:=False:C215
					End if 
				End if 
			End if 
	End case 
	
	$0:=$b_informeAutorizado
Else 
	$0:=False:C215
End if 

