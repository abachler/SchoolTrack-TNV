  // [xShell_ExecutableCommands].Manager_v14()
  // Por: Alberto Bachler K.: 20-02-14, 15:14:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_pegarActivo)
C_LONGINT:C283($i;$l_numeroItem;$l_numeroMenu)
C_POINTER:C301($y_codigo;$y_ejecutarEnServidor;$y_nombreComandos_at;$y_recNumComandos_ar)
C_TEXT:C284($t_codigo;$t_nombreLocalizado)

ARRAY TEXT:C222($at_formatos;0)
ARRAY TEXT:C222($at_nombreComandos;0)
ARRAY TEXT:C222($at_tiposNativos;0)

$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"codigo")
$y_nombreComandos_at:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreComandos")
$y_recNumComandos_ar:=OBJECT Get pointer:C1124(Object named:K67:5;"recNumComandos")
$y_ejecutarEnServidor:=OBJECT Get pointer:C1124(Object named:K67:5;"ejecutarEnServidor")



Case of 
	: (Form event:C388=On Load:K2:1)
		vtEXC_Commands:=""
		SET MENU BAR:C67("XS_Edicion")
		
		READ ONLY:C145([xShell_ExecutableCommands:19])
		QUERY:C277([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]Module:3=<>vsXS_CurrentModule;*)
		QUERY:C277([xShell_ExecutableCommands:19]; | ;[xShell_ExecutableCommands:19]Module:3="Todos los modulos";*)
		QUERY:C277([xShell_ExecutableCommands:19]; | ;[xShell_ExecutableCommands:19]Module:3="All Modules")
		QUERY SELECTION:C341([xShell_ExecutableCommands:19];[xShell_ExecutableCommands:19]ExecutableByUsers:7=True:C214)
		
		SELECTION TO ARRAY:C260([xShell_ExecutableCommands:19];$y_recNumComandos_ar->;[xShell_ExecutableCommands:19]MethodName:2;$y_nombreComandos_at->)
		If (Size of array:C274($y_recNumComandos_ar->)>0)
			For ($i;Size of array:C274($y_recNumComandos_ar->);1;-1)
				If (USR_GetMethodAcces ($y_nombreComandos_at->{$i};0))
					$t_nombreLocalizado:=XS_GetCommandAliasDescription ($y_recNumComandos_ar->{$i};<>vtXS_CountryCode;<>vtXS_Langage)
					$y_nombreComandos_at->{$i}:=ST_GetWord ($t_nombreLocalizado;1;"\t")
				Else 
					AT_Delete ($i;1;$y_recNumComandos_ar;$y_nombreComandos_at)
				End if 
			End for 
		End if 
		LISTBOX SORT COLUMNS:C916(*;"lb_Comandos";1)
		LISTBOX SELECT ROW:C912(*;"lb_Comandos";0;lk remove from selection:K53:3)
		
		
		OBJECT SET VISIBLE:C603(*;"ejecutarEnServidor";(Application type:C494=4D Remote mode:K5:5))
		OBJECT SET ENABLED:C1123(*;"ejecutarComando";False:C215)
		OBJECT SET ENABLED:C1123(*;"ejecutarCodigo";False:C215)
		OBJECT SET VISIBLE:C603(*;"editarScript";USR_GetUserID <0)
		
		
	: ((Form event:C388=On Activate:K2:9) | (Form event:C388=On Clicked:K2:4))
		GET PASTEBOARD DATA TYPE:C958($at_tiposNativos;$at_formatos)
		$b_pegarActivo:=(Find in array:C230($at_tiposNativos;"com.4d.private.text@")>0)
		OBJECT SET ENABLED:C1123(*;"pegarScript";$b_pegarActivo)
		OBJECT SET ENABLED:C1123(*;"ejecutarCodigo";$y_codigo->#"")
		
	: (Form event:C388=On Menu Selected:K2:14)
		If (FORM Get current page:C276=2)
			$l_numeroMenu:=Menu selected:C152\65536
			$l_numeroItem:=Menu selected:C152%65536
			
			If (Get menu title:C430($l_numeroMenu)=__ ("Edición"))
				Case of 
					: (Get menu item:C422($l_numeroMenu;$l_numeroItem)=__ ("Pegar"))
						$y_codigo->:=Get text from pasteboard:C524
						$t_codigo:=CODE_Get_html ($y_codigo->)
						WA SET PAGE CONTENT:C1037(*;"codigoHTML";$t_codigo;"")
						EXE_StyleCodeText ($y_codigo)
						OBJECT SET ENABLED:C1123(*;"ejecutarCodigo";$y_codigo->#"")
						
					: (Get menu item:C422($l_numeroMenu;$l_numeroItem)=__ ("Cortar"))
						SET TEXT TO PASTEBOARD:C523($y_codigo->)
						$t_codigo:=CODE_Get_html ("")
						WA SET PAGE CONTENT:C1037(*;"codigoHTML";$t_codigo;"")
						
					: (Get menu item:C422($l_numeroMenu;$l_numeroItem)=__ ("Borrar"))
						$y_codigo->:=""
						$t_codigo:=CODE_Get_html ("")
						WA SET PAGE CONTENT:C1037(*;"codigoHTML";$t_codigo;"")
						
					Else 
						FILTER EVENT:C321
				End case 
			Else 
				FILTER EVENT:C321
			End if 
		End if 
		
End case 

