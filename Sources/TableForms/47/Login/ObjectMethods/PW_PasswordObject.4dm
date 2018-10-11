  // Password.password()
  // Por: Alberto Bachler Klein: 12-11-15, 11:05:13
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$y_bullets:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_clearPassword:=OBJECT Get pointer:C1124(Object named:K67:5;"clearPassword")


Case of 
	: (Form event:C388=On Load:K2:1)
		  //CALL SUBFORM CONTAINER(-On Load)
		
	: (Form event:C388=On Activate:K2:9)
		  //GOTO OBJECT(*;"PW_PasswordObject")
		  //OBJECT SET FOCUS RECTANGLE INVISIBLE(*;"PW_PasswordObject";False)
		  //OBJECT SET PLACEHOLDER(*;"PW_PasswordObject";"Contraseña")
		
	: (Form event:C388=On Before Keystroke:K2:6)
		GET HIGHLIGHT:C209($y_bullets->;$l_Inicio;$l_Fin)
		Case of 
			: (Character code:C91(Keystroke:C390)=Backspace:K15:36)
				If ($l_fin-$l_inicio=0)
					$l_Inicio:=$l_Inicio-1
				End if 
				$l_chars:=Choose:C955($l_fin-$l_inicio=0;1;$l_fin-$l_inicio)
				$y_clearPassword->:=Delete string:C232($y_clearPassword->;$l_inicio;$l_chars)
				HIGHLIGHT TEXT:C210($y_bullets->;$l_inicio;$l_inicio)
				
			: (Character code:C91(Keystroke:C390)=DEL ASCII code:K15:34)
				$l_chars:=Choose:C955($l_fin-$l_inicio=0;1;$l_fin-$l_inicio)
				$y_clearPassword->:=Delete string:C232($y_clearPassword->;$l_inicio;$l_chars)
				If ($l_chars>1)
					$y_bullets->:="•"*(Length:C16($y_clearPassword->))
				Else 
					$y_bullets->:="•"*(Length:C16($y_clearPassword->))
				End if 
				
		End case 
		
		
	: ((Form event:C388=On After Keystroke:K2:26) & (Character code:C91(Keystroke:C390)#Backspace:K15:36) & (Character code:C91(Keystroke:C390)#DEL ASCII code:K15:34))
		GET HIGHLIGHT:C209($y_bullets->;$l_Inicio;$l_Fin)
		$l_Inicio:=$l_Inicio-1
		$l_fin:=$l_fin-1
		
		Case of 
			: (Character code:C91(Keystroke:C390)=Tab:K15:37)
			: (Character code:C91(Keystroke:C390)=Carriage return:K15:38)
			: (Character code:C91(Keystroke:C390)=Left arrow key:K12:16)
			: (Character code:C91(Keystroke:C390)=Right arrow key:K12:17)
			: (Character code:C91(Keystroke:C390)=Up arrow key:K12:18)
			: (Character code:C91(Keystroke:C390)=Down arrow key:K12:19)
				
			Else 
				If ($l_Inicio#$l_Fin)
					$y_clearPassword->:=Substring:C12($y_clearPassword->;1;$l_Inicio-1)+Keystroke:C390+Substring:C12($y_clearPassword->;$l_Fin)
					
				Else 
					Case of 
						: ($l_Inicio<=1)
							$y_clearPassword->:=Keystroke:C390+$y_clearPassword->
							
						: ($l_Inicio>Length:C16($y_bullets->))
							$y_clearPassword->:=$y_clearPassword->+Keystroke:C390
							
						Else 
							$y_clearPassword->:=Substring:C12($y_clearPassword->;1;$l_Inicio-1)+Keystroke:C390+Substring:C12($y_clearPassword->;$l_Inicio)
					End case 
					
				End if 
		End case 
		$y_bullets->:="•"*(Length:C16($y_clearPassword->))
		
	: (Form event:C388=On After Edit:K2:43)
		$y_bullets->:="•"*(Length:C16($y_clearPassword->))
		
End case 

