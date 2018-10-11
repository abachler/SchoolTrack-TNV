//%attributes = {}
  // MÉTODO: USR_checkRights
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 12/03/12, 19:19:22
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // USR_checkRights()
  // ----------------------------------------------------

C_BOOLEAN:C305($0;$b_Autorizado)
C_TEXT:C284($1)
C_POINTER:C301($y_tabla)
C_LONGINT:C283($l_userID;$3)



  // CODIGO PRINCIPAL
$t_modoAcceso:=$1
$y_tabla:=$2
$b_Autorizado:=True:C214

If (Count parameters:C259=3)
	$l_userID:=$3
Else 
	$l_userID:=<>lUSR_CurrentUserID
End if 

$y_tabla:=USR_AccesoTablasAgrupadas ($y_tabla)


  // si el ID de usuario es negativo o igual a 0 (posible llamado desde trigger o procedimiento almacenado)
If ($l_userID<=0)
	$b_Autorizado:=True:C214
Else 
	
	
	If (Count parameters:C259=3)
		  // si se pasó un ID de usuario específico se leen los grupos a los que pertenece
		ARRAY LONGINT:C221(alUSR_Membership;0)
		ARRAY INTEGER:C220($ai_numeroTabla;0)
		ARRAY INTEGER:C220($ai_nivelAcceso;0)
		ARRAY REAL:C219(aUserPriv;0)
		USR_GetUserProperties ($l_userID;->vsUSR_UserName;->vsUSR_StartUpMethod;->vsUSR_Password;->vlUSR_NbLogin;->vdUSR_LastLogin;->alUSR_Membership)
		
		  // lectura de los niveles de acceso de cada uno de los grupos a los que pertenece el usuario activo
		For ($i_groups;1;Size of array:C274(alUSR_Membership))
			READ ONLY:C145([xShell_UserGroups:17])
			QUERY:C277([xShell_UserGroups:17];[xShell_UserGroups:17]IDGroup:1=alUSR_Membership{$i_groups})
			If (Records in selection:C76([xShell_UserGroups:17])=1)
				If (BLOB size:C605([xShell_UserGroups:17]xTableAcces:4)>0)
					BLOB_Blob2Vars (->[xShell_UserGroups:17]xTableAcces:4;0;->aUserPriv)
					For ($i;1;Size of array:C274(aUserPriv))
						$l_numeroTabla:=Int:C8(aUserPriv{$i})
						$l_nivelAcceso:=Dec:C9(aUserPriv{$i})*10
						$l_elemento:=Find in array:C230($ai_numeroTabla;$l_numeroTabla)
						If ($l_elemento<0)
							APPEND TO ARRAY:C911($ai_numeroTabla;$l_numeroTabla)
							APPEND TO ARRAY:C911($ai_nivelAcceso;$l_nivelAcceso)
						Else 
							If ($l_nivelAcceso>$ai_nivelAcceso{$l_elemento})
								$ai_nivelAcceso{$l_elemento}:=$l_nivelAcceso
							End if 
						End if 
					End for 
				End if 
			End if 
		End for 
		UNLOAD RECORD:C212([xShell_UserGroups:17])
		ARRAY REAL:C219(aUserPriv;0)
		ARRAY LONGINT:C221(alUSR_Membership;0)
		
		  // se determina si el usuario dispone de privilegios para el nivel de acceso requerido
		$r:=Find in array:C230($ai_numeroTabla;Table:C252($y_tabla))
		Case of 
			: ($r=-1)
				$b_Autorizado:=True:C214
			: ($1="A")
				$b_Autorizado:=($ai_nivelAcceso{$r}>=3)
			: ($1="M")
				$b_Autorizado:=($ai_nivelAcceso{$r}>=2)
			: ($1="D")
				$b_Autorizado:=($ai_nivelAcceso{$r}>=4)
			: ($1="L")
				$b_Autorizado:=($ai_nivelAcceso{$r}>=1)
		End case 
		
		
		
	Else 
		  // si no se pasó un ID especifico el usuario es el usuario actual
		  // se leen los privilegios en el arreglo interproceso cargado en USR_GetUserRights
		  // y se determina si el usuario dispone de privilegios para el nivel de acceso requerido
		If (Not:C34(Undefined:C82(<>aAccesFile)))
			$r:=Find in array:C230(<>aAccesFile;Table:C252($y_tabla))
			Case of 
				: ($r=-1)
					$b_Autorizado:=True:C214
				: ($1="A")
					$b_Autorizado:=(<>aAccesPriv{$r}>=3)
				: ($1="M")
					$b_Autorizado:=(<>aAccesPriv{$r}>=2)
				: ($1="D")
					$b_Autorizado:=(<>aAccesPriv{$r}>=4)
				: ($1="L")
					$b_Autorizado:=(<>aAccesPriv{$r}>=1)
			End case 
		End if 
	End if 
End if 


$0:=$b_Autorizado
