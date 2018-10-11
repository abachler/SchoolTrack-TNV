  // [xxSTR_Niveles].Configuration.Campo81()
  // Por: Alberto Bachler K.: 23-07-14, 11:20:17
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



$percent:=1
Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		GET MOUSE:C468($vlMouseX;$vlMouseY;$vlButton)
		If ((Macintosh control down:C544) | ($vlButton=2))
			$size:=Pasteboard data size:C400(Picture data:K20:3)
			If ($size>0)
				$paste:="Pegar;"
			Else 
				$paste:="(Pegar;"
			End if 
			If (Picture size:C356(Self:C308->)>0)
				$copy_cut:="Cortar;Copiar;"
				$clear:="Borrar;"
				$format:="Truncado, centrado;Ajustado;Sobre fondo;Truncado, no centrado;Ajustado, "+"proporcional;Ajustado, centrado y proporcional"
				$resize:="200%;300%;400%;500%;600%;700%;800%;"
			Else 
				$copy_cut:="(Cortar;(Copiar;"
				$clear:="(Borrar;"
				$format:="(Truncado, centrado;(Ajustado;(Sobre fondo;(Truncado, no centrado;(Ajustado, "+"proporcional;(Ajustado, centrado y proporcional"
				$resize:="(200%;(300%;(400%;(500%;(600%;(700%;(800%;"
			End if 
			$menu:=$copy_cut+$paste+$clear+"(-;Insertar desde archivo…"
			$menu:=$menu+";(-;"+$format+";(-;"+$resize
			$userChoice:=Pop up menu:C542($menu)
			Case of 
				: ($userChoice=1)
					SET PICTURE TO PASTEBOARD:C521(Self:C308->)
					[xxSTR_Niveles:6]Logo:49:=[xxSTR_Niveles:6]Logo:49*0
				: ($userChoice=2)
					SET PICTURE TO PASTEBOARD:C521(Self:C308->)
				: ($userChoice=3)
					GET PICTURE FROM PASTEBOARD:C522($pict)
					PICTURE PROPERTIES:C457($pict;$width;$height)
					Case of 
						: (($height>128) & ($height>$width))
							$percent:=128/$height
						: (($width>128) & ($width>$height))
							$percent:=128/$width
					End case 
					$pict:=$pict*$percent
					[xxSTR_Niveles:6]Logo:49:=$pict
					PICT_Compress (->[xxSTR_Niveles:6]Logo:49;"jpeg";900)
					SAVE RECORD:C53([xxSTR_Niveles:6])
					
				: ($userChoice=4)
					[xxSTR_Niveles:6]Logo:49:=[xxSTR_Niveles:6]Logo:49*0
				: ($userChoice=5)
					  //          
				: ($userChoice=6)
					C_PICTURE:C286($pict)
					$doc:=xfGetFileName ("Seleccione el archivo con la imagen")
					
					If ($doc#"")  //
						$SIZE:=Get document size:C479($doc)
						[xxSTR_Niveles:6]Logo:49:=[xxSTR_Niveles:6]Logo:49*0
						READ PICTURE FILE:C678($doc;$pict)
						PICTURE PROPERTIES:C457($pict;$width;$height)
						Case of 
							: (($height>128) & ($height>$width))
								$percent:=128/$height
								$pict:=$pict*$percent
							: (($width>128) & ($width>$height))
								$percent:=128/$width
								$pict:=$pict*$percent
							: (($height<128) & ($height>$width))
								$percent:=128/$height
							: (($width<128) & ($width>$height))
								$percent:=128/$width
						End case 
						[xxSTR_Niveles:6]Logo:49:=$pict
						PICT_Compress (->[xxSTR_Niveles:6]Logo:49;"jpeg";500)
						SAVE RECORD:C53([xxSTR_Niveles:6])
					End if 
				: ($userChoice=7)
					  //          
				: ($userChoice=8)
					OBJECT SET FORMAT:C236([xxSTR_Niveles:6]Logo:49;Char:C90(Truncated centered:K6:1))
				: ($userChoice=9)
					OBJECT SET FORMAT:C236([xxSTR_Niveles:6]Logo:49;Char:C90(Scaled to fit:K6:2))
				: ($userChoice=10)
					OBJECT SET FORMAT:C236([xxSTR_Niveles:6]Logo:49;Char:C90(On background:K6:3))
				: ($userChoice=11)
					OBJECT SET FORMAT:C236([xxSTR_Niveles:6]Logo:49;Char:C90(Truncated non centered:K6:4))
				: ($userChoice=12)
					OBJECT SET FORMAT:C236([xxSTR_Niveles:6]Logo:49;Char:C90(Scaled to fit proportional:K6:5))
				: ($userChoice=13)
					OBJECT SET FORMAT:C236([xxSTR_Niveles:6]Logo:49;Char:C90(Scaled to fit prop centered:K6:6))
				: ($userChoice>=15)
					$resizeto:=$userChoice-13
					vp_Picture:=[xxSTR_Niveles:6]Logo:49*$resizeTo
					PICTURE PROPERTIES:C457(vp_Picture;$Width;$Height)
					WDW_Open ($Width;$Height;0;1)
					DIALOG:C40([xShell_Dialogs:114];"XS_ShowPicture")
					CLOSE WINDOW:C154
					vp_Picture:=vp_Picture*0
			End case 
			POST KEY:C465(9;0)
		End if 
	: (Form event:C388=On Double Clicked:K2:5)
		PICTURE PROPERTIES:C457([xxSTR_Niveles:6]Logo:49;$Width;$Height)
		WDW_Open ($Width;$Height;0;1)
		DIALOG:C40([xShell_Dialogs:114];"XS_ShowPicture")
		CLOSE WINDOW:C154
	: (Form event:C388=On Data Change:K2:15)
		PICT_Compress (->[xxSTR_Niveles:6]Logo:49;"jpeg";500)
		SAVE RECORD:C53([xxSTR_Niveles:6])
		POST KEY:C465(9;0)
End case 