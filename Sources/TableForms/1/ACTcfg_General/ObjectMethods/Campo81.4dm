$percent:=1
$vl_maxSize:=200
Case of 
	: ((Form event:C388=On Getting Focus:K2:7) | (Form event:C388=On Clicked:K2:4))
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
					[ACT_RazonesSociales:279]logo:17:=[ACT_RazonesSociales:279]logo:17*0
				: ($userChoice=2)
					SET PICTURE TO PASTEBOARD:C521(Self:C308->)
				: ($userChoice=3)
					If (($size/1024)<$vl_maxSize)
						GET PICTURE FROM PASTEBOARD:C522($pict)
						PICTURE PROPERTIES:C457($pict;$width;$height)
						Case of 
							: (($height>128) & ($height>$width))
								$percent:=128/$height
							: (($width>128) & ($width>$height))
								$percent:=128/$width
						End case 
						$pict:=$pict*$percent
						[ACT_RazonesSociales:279]logo:17:=$pict
						PICT_Compress (->[ACT_RazonesSociales:279]logo:17;"jpeg";900)
						SAVE RECORD:C53([ACT_RazonesSociales:279])
					Else 
						CD_Dlog (0;__ ("Para no afectar el rendimiento de la aplicación, el tamaño de la imagen a agregar"+" no puede ser superior a ")+String:C10($vl_maxSize)+" "+__ ("Kilobytes")+"."+__ ("La imagen que intenta utilizar tiene un tamaño de ")+String:C10(Round:C94(($size/1024);0))+" "+__ ("Kilobytes")+"."+"\r\r"+__ ("Utilice alguna aplicación para disminuir el tamaño de la imagen (por ejemplo Pain"+"t) o envíe un mail a soporte (soporte@colegium.com), con la imagen adjunta, solic"+"itando asistencia.")+"\r\r"+__ ("El logo no pudo ser agregado."))
					End if 
				: ($userChoice=4)
					[ACT_RazonesSociales:279]logo:17:=[ACT_RazonesSociales:279]logo:17*0
				: ($userChoice=5)
					  //          
				: ($userChoice=6)
					C_PICTURE:C286($pict)
					$doc:=xfGetFileName ("Seleccione el archivo con la imagen")
					
					If ($doc#"")  //
						$SIZE:=Get document size:C479($doc)
						If (($size/1024)<$vl_maxSize)
							[ACT_RazonesSociales:279]logo:17:=[ACT_RazonesSociales:279]logo:17*0
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
							[ACT_RazonesSociales:279]logo:17:=$pict
							PICT_Compress (->[ACT_RazonesSociales:279]logo:17;"jpeg";500)
							SAVE RECORD:C53([ACT_RazonesSociales:279])
						Else 
							CD_Dlog (0;__ ("Para no afectar el rendimiento de la aplicación, el tamaño de la imagen a agregar"+" no puede ser superior a ")+String:C10($vl_maxSize)+" "+__ ("Kilobytes")+"."+__ ("La imagen que intenta utilizar tiene un tamaño de ")+String:C10(Round:C94(($size/1024);0))+" "+__ ("Kilobytes")+"."+"\r\r"+__ ("Utilice alguna aplicación para disminuir el tamaño de la imagen (por ejemplo Pain"+"t) o envíe un mail a soporte (soporte@colegium.com), con la imagen adjunta, solic"+"itando asistencia.")+"\r\r"+__ ("El logo no pudo ser agregado."))
						End if 
					End if 
				: ($userChoice=7)
					  //          
				: ($userChoice=8)
					OBJECT SET FORMAT:C236([ACT_RazonesSociales:279]logo:17;Char:C90(Truncated centered:K6:1))
				: ($userChoice=9)
					OBJECT SET FORMAT:C236([ACT_RazonesSociales:279]logo:17;Char:C90(Scaled to fit:K6:2))
				: ($userChoice=10)
					OBJECT SET FORMAT:C236([ACT_RazonesSociales:279]logo:17;Char:C90(On background:K6:3))
				: ($userChoice=11)
					OBJECT SET FORMAT:C236([ACT_RazonesSociales:279]logo:17;Char:C90(Truncated non centered:K6:4))
				: ($userChoice=12)
					OBJECT SET FORMAT:C236([ACT_RazonesSociales:279]logo:17;Char:C90(Scaled to fit proportional:K6:5))
				: ($userChoice=13)
					OBJECT SET FORMAT:C236([ACT_RazonesSociales:279]logo:17;Char:C90(Scaled to fit prop centered:K6:6))
				: ($userChoice>=15)
					$resizeto:=$userChoice-13
					vp_Picture:=[ACT_RazonesSociales:279]logo:17*$resizeTo
					PICTURE PROPERTIES:C457(vp_Picture;$Width;$Height)
					WDW_Open ($Width;$Height;0;1)
					DIALOG:C40([xShell_Dialogs:114];"XS_ShowPicture")
					CLOSE WINDOW:C154
					vp_Picture:=vp_Picture*0
			End case 
			POST KEY:C465(9;0)
		End if 
	: (Form event:C388=On Double Clicked:K2:5)
		PICTURE PROPERTIES:C457([ACT_RazonesSociales:279]logo:17;$Width;$Height)
		WDW_Open ($Width;$Height;0;1)
		vp_Picture:=[ACT_RazonesSociales:279]logo:17
		DIALOG:C40([xShell_Dialogs:114];"XS_ShowPicture")
		CLOSE WINDOW:C154
	: (Form event:C388=On Data Change:K2:15)
		$size:=Pasteboard data size:C400(Picture data:K20:3)
		If (($size/1024)<$vl_maxSize)
			PICT_Compress (->[ACT_RazonesSociales:279]logo:17;"jpeg";500)
			SAVE RECORD:C53([ACT_RazonesSociales:279])
			POST KEY:C465(9;0)
		Else 
			[ACT_RazonesSociales:279]logo:17:=[ACT_RazonesSociales:279]logo:17*0
			CD_Dlog (0;__ ("Para no afectar el rendimiento de la aplicación, el tamaño de la imagen a agregar"+" no puede ser superior a ")+String:C10($vl_maxSize)+" "+__ ("Kilobytes")+"."+__ ("La imagen que intenta utilizar tiene un tamaño de ")+String:C10(Round:C94(($size/1024);0))+" "+__ ("Kilobytes")+"."+"\r\r"+__ ("Utilice alguna aplicación para disminuir el tamaño de la imagen (por ejemplo Pain"+"t) o envíe un mail a soporte (soporte@colegium.com), con la imagen adjunta, solic"+"itando asistencia.")+"\r\r"+__ ("El logo no pudo ser agregado."))
		End if 
End case 