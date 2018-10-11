


If (Form event:C388=On Printing Detail:K2:18)
	PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
	Case of 
		: (vs_ConfigToUse="Periodo")
			$width1:=15
			  //$width2:=90
			  // 20170929 Mod TIcket N° 188661. Patricio aliaga
			$width2:=91
			If (cbAsistencia=1)
				$widthAsistencia:=25
			Else 
				$widthAsistencia:=0
			End if 
			If (cb_HideAverage=0)
				  //Se modifica   el ancho de las columnas de PF y PP
				  //AB ( 30/07/2015)- ticket 146411 
				$widthAvgF:=20
				$widthAvgP:=20
				  //$widthAvgF:=30
				  //$widthAvgP:=30
			Else 
				$widthAvgF:=0
				$widthAvgP:=0
			End if 
			$remainingWidth:=725-$width1-$width2-$widthAvgF-$widthAvgP-$widthAsistencia
			$widthNota:=Int:C8($remainingWidth/vi_Columns)
			
			
			Case of 
				: ($widthNota<=12)
					$fontsize:=4
				: ($widthNota<=14)
					$fontsize:=5
				: ($widthNota<=16)
					  //Se modifica  tamaño de letra ya que al imprimir las asignaturas hijas las notas no se visualizan de forma correcta
					  //AB y JV ( 30/07/2015)- ticket 146411 
					$fontsize:=5
					  //$fontsize:=6
				Else 
					  //Se modifica  tamaño de letra ya que al imprimir las notas no se visualizan de forma correcta
					  //AB (20-10-2015)-ticket 150144
					$fontsize:=6
					  //$fontsize:=5
			End case 
			$fontName:="Arial"
			
			
			$err:=PL_SetArraysNam (pl_acta;1;2;"aOrder";"aC0")
			PL_SetWidths (pl_acta;1;2;$width1;$width2)
			PL_SetFormat (pl_acta;1;"##";2;2;0)
			PL_SetFormat (pl_acta;2;"";0;2;0)
			PL_SetStyle (pl_acta;1;$fontName;$fontsize;0)
			PL_SetStyle (pl_acta;2;$fontName;$fontsize;0)
			PL_SetHeaders (pl_acta;1;2;"No";"Alumno")
			  //PL_SetHdrStyle (pl_Acta;1;$fontName;$fontsize;0)
			PL_SetHdrStyle (pl_Acta;1;$fontName;$fontsize;0)
			
			For ($i;1;vi_Columns)
				
				$arrName:="aC"+String:C10($i)
				$err:=PL_SetArraysNam (pl_acta;$i+2;1;$arrName)
				
				PL_SetFormat (pl_acta;$i+2;"";2;2;0)
				PL_SetWidths (pl_acta;$i+2;1;$widthNota)
				  //PL_SetStyle (pl_acta;$i+2;$fontName;$fontsize;0)
				PL_SetStyle (pl_acta;$i+2;$fontName;$fontsize;0)
				
				PL_SetHeaders (pl_acta;$i+2;1;aAsgAbrev{$i})
				PL_SetHdrStyle (pl_Acta;$i+2;$fontName;$fontsize;0)
				
			End for 
			
			
			If (cb_HideAverage=0)
				If (vPeriodo>0)
					$err:=PL_SetArraysNam (pl_acta;vi_Columns+3;1;"aCAvgP")
					PL_SetFormat (pl_acta;vi_Columns+3;"";2;2;0)
					PL_SetWidths (pl_acta;vi_Columns+3;1;$widthAvgP)
					PL_SetStyle (pl_acta;vi_Columns+3;$fontName;$fontSize;1)
					PL_SetHeaders (pl_acta;vi_Columns+3;1;"PP")
					
					
					$err:=PL_SetArraysNam (pl_acta;vi_Columns+4;1;"aCAvg")
					PL_SetFormat (pl_acta;vi_Columns+4;"";2;2;0)
					PL_SetWidths (pl_acta;vi_Columns+4;1;$widthAvgF)
					PL_SetStyle (pl_acta;vi_Columns+4;$fontName;$fontSize;1)
					PL_SetHeaders (pl_acta;vi_Columns+4;1;"PF")
					$lastColumn:=vi_Columns+4
				Else 
					$err:=PL_SetArraysNam (pl_acta;vi_Columns+3;1;"aCAvg")
					PL_SetFormat (pl_acta;vi_Columns+3;"";2;2;0)
					PL_SetWidths (pl_acta;vi_Columns+3;1;$widthAvgF)
					PL_SetStyle (pl_acta;vi_Columns+3;$fontName;$fontSize;1)
					PL_SetHeaders (pl_acta;vi_Columns+3;1;"PF")
					$lastColumn:=vi_Columns+3
				End if 
			Else 
				$lastColumn:=vi_Columns+2
			End if 
			
			If (cbAsistencia=1)
				  //$err:=PL_SetArraysNam (pl_acta;$lastColumn+1;1;"aPctAsistencia")
				  //PL_SetFormat (pl_acta;$lastColumn+1;"###"+<>txs_rs_decimalseparator+"#";2;2;0)
				$err:=PL_SetArraysNam (pl_acta;$lastColumn+1;1;"atPctAsistencia")
				PL_SetFormat (pl_acta;$lastColumn+1;"";2;2;0)
				PL_SetWidths (pl_acta;$lastColumn+1;1;$widthAsistencia)
				PL_SetStyle (pl_acta;$lastColumn+1;$fontName;$fontSize;0)
				PL_SetHeaders (pl_acta;$lastColumn+1;1;"% asist.")
				$lastColumn:=$lastColumn+1
			End if 
			
			PL_SetHdrStyle (pl_acta;0;$fontName;$fontSize;1)
			PL_SetHdrOpts (pl_acta;1;0)
			PL_SetColOpts (pl_acta;0;0)
			PL_SetDividers (pl_acta;0.5;"Black";"Black";0;0.5;"Gray";"Black";0)
			PL_SetFrame (pl_acta;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			
			
			ARRAY INTEGER:C220(aInt2D;2;0)
			If (aPeriodos<Size of array:C274(aPeriodos))
				PL_SetRowColor (pl_acta;Size of array:C274(aC0)-2;"";16;"";16*15+2)
				PL_SetRowColor (pl_acta;Size of array:C274(aC0)-1;"";16;"";16*15+2)
				PL_SetRowColor (pl_acta;Size of array:C274(aC0);"";16;"";16*15+2)
				PL_SetRowStyle (pl_acta;Size of array:C274(aC0)-2;1)
				PL_SetRowStyle (pl_acta;Size of array:C274(aC0)-1;1)
				PL_SetRowStyle (pl_acta;Size of array:C274(aC0);1)
			Else 
				PL_SetRowColor (pl_acta;Size of array:C274(aC0)-1;"";16;"";16*15+2)
				PL_SetRowColor (pl_acta;Size of array:C274(aC0);"";16;"";16*15+2)
				PL_SetRowStyle (pl_acta;Size of array:C274(aC0)-1;1)
				PL_SetRowStyle (pl_acta;Size of array:C274(aC0);1)
			End if 
			
			If (cb_HideAverage=0)
				If (cbAsistencia=0)
					If (vPeriodo>0)
						PL_SetRowColor (pl_acta;Size of array:C274(aC0)-2;"";16;"";16*15+2)
						PL_SetRowColor (pl_acta;Size of array:C274(aC0)-1;"";16;"";16*15+2)
						PL_SetRowColor (pl_acta;Size of array:C274(aC0);"";16;"";16*15+2)
						PL_SetRowStyle (pl_acta;Size of array:C274(aC0)-2;1)
						PL_SetRowStyle (pl_acta;Size of array:C274(aC0)-1;1)
						PL_SetRowStyle (pl_acta;Size of array:C274(aC0);1)
					Else 
						PL_SetRowColor (pl_acta;Size of array:C274(aC0)-1;"";16;"";16*15+2)
						PL_SetRowColor (pl_acta;Size of array:C274(aC0);"";16;"";16*15+2)
						PL_SetRowStyle (pl_acta;Size of array:C274(aC0)-1;1)
						PL_SetRowStyle (pl_acta;Size of array:C274(aC0);1)
					End if 
				Else 
					If (vPeriodo>0)
						PL_SetRowColor (pl_acta;Size of array:C274(aC0)-2;"";16;"";16*15+2)
						PL_SetRowColor (pl_acta;Size of array:C274(aC0)-1;"";16;"";16*15+2)
						PL_SetRowColor (pl_acta;Size of array:C274(aC0);"";16;"";16*15+2)
						PL_SetRowStyle (pl_acta;Size of array:C274(aC0)-2;1)
						PL_SetRowStyle (pl_acta;Size of array:C274(aC0)-1;1)
						PL_SetRowStyle (pl_acta;Size of array:C274(aC0);1)
					Else 
						PL_SetRowColor (pl_acta;Size of array:C274(aC0)-1;"";16;"";16*15+2)
						PL_SetRowColor (pl_acta;Size of array:C274(aC0);"";16;"";16*15+2)
						PL_SetRowStyle (pl_acta;Size of array:C274(aC0)-1;1)
						PL_SetRowStyle (pl_acta;Size of array:C274(aC0);1)
					End if 
				End if 
			End if 
			PL_SetHeight (pl_acta;2;3;0;2)
			
			
			sDate:=String:C10(Current date:C33;3)+" a las "+String:C10(Current time:C178;2)
			RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
			
			
			
		: (vs_ConfigToUse="OnePage")
			
			Case of 
				: (vi_Columns<=10)
					$fontSize:=5
					$fontSizeNames:=5
					$width1:=9
					$widthNta:=60
					$widthAsistencia:=16
					$widthAvgF:=15
				: (vi_Columns<=12)
					$fontSize:=4
					$fontSizeNames:=4
					$width1:=10
					$widthNta:=51
					$widthAsistencia:=10
					$widthAvgF:=12
				Else 
					  //JV mono cambio los font size debido a que con 3 que estaba anteriormente no tomaba esta configuración : ticket 137833
					$fontSize:=4
					$fontSizeNames:=4
					$width1:=10
					$widthNta:=40
					$widthAsistencia:=14
					$widthAvgF:=12
			End case 
			$usedWidth:=($widthNta*vi_Columns)+$width1
			If (cbasistencia=1)
				$usedWidth:=$usedWidth+$widthAsistencia
			End if 
			If (cb_HideAverage=0)
				$usedWidth:=$usedWidth+$widthAvgF
			End if 
			$width2:=710-$usedWidth
			Case of 
				: ($fontsize=3) & ($width2>50)
					$width2Distribute:=$width2-50
					$width2:=50
					$widthNta:=$widthNta+($width2Distribute/vi_Columns)
				: ($fontsize=4) & ($width2>70)
					$width2Distribute:=$width2-70
					$width2:=70
					$widthNta:=$widthNta+($width2Distribute/vi_Columns)
				: ($fontsize=5) & ($width2>90)
					$width2Distribute:=$width2-90
					$width2:=90
					$widthNta:=$widthNta+($width2Distribute/vi_Columns)
			End case 
			
			$err:=PL_SetArraysNam (pl_acta;1;2;"aOrder";"aC0")
			PL_SetWidths (pl_acta;1;2;$width1;$width2)
			PL_SetFormat (pl_acta;1;"##";2;2;0)
			PL_SetFormat (pl_acta;2;"";0;2;0)
			PL_SetStyle (pl_acta;1;"Arial";$fontSize;0)
			PL_SetStyle (pl_acta;2;"Arial";$fontSize;0)
			PL_SetHeaders (pl_acta;1;2;"No";"Alumno")
			
			For ($i;1;vi_Columns)
				$arrName:="aC"+String:C10($i)
				$err:=PL_SetArraysNam (pl_acta;$i+2;1;$arrName)
				PL_SetFormat (pl_acta;$i+2;"";2;2;0)
				PL_SetWidths (pl_acta;$i+2;1;$widthNta)
				PL_SetStyle (pl_acta;$i+2;"Arial";$fontSize;0)
				PL_SetHeaders (pl_acta;$i+2;1;aAsgAbrev{$i})
			End for 
			
			If (cb_HideAverage=0)
				$err:=PL_SetArraysNam (pl_acta;vi_Columns+3;1;"aCAvg")
				PL_SetFormat (pl_acta;vi_Columns+3;"";2;2;0)
				PL_SetWidths (pl_acta;vi_Columns+3;1;$widthAvgF)
				PL_SetStyle (pl_acta;vi_Columns+3;"Arial";$fontSize;1)
				PL_SetHeaders (pl_acta;vi_Columns+3;1;"PF")
				$lastColumn:=vi_Columns+3
			Else 
				$lastColumn:=vi_Columns
			End if 
			
			If (cbAsistencia=1)
				  //$err:=PL_SetArraysNam (pl_acta;$lastColumn+1;1;"aPctAsistencia")
				  //PL_SetFormat (pl_acta;$lastColumn+1;"###"+<>txs_rs_decimalseparator+"#";2;2;0)
				$err:=PL_SetArraysNam (pl_acta;$lastColumn+1;1;"atPctAsistencia")
				PL_SetFormat (pl_acta;$lastColumn+1;"";2;2;0)
				PL_SetWidths (pl_acta;$lastColumn+1;1;$widthAsistencia)
				PL_SetStyle (pl_acta;$lastColumn+1;"Arial";$fontSize;0)
				PL_SetHeaders (pl_acta;$lastColumn+1;1;"% asist.")
				$lastColumn:=$lastColumn+1
			End if 
			
			PL_SetHdrStyle (pl_acta;0;$fontName;$fontSize;1)
			PL_SetHdrOpts (pl_acta;1;0)
			PL_SetColOpts (pl_acta;0;0)
			PL_SetDividers (pl_acta;0.5;"Black";"Black";0;0.5;"Gray";"Black";0)
			PL_SetFrame (pl_acta;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			
			
			  // lineas de promedios y aprobados  (pie)
			PL_SetRowStyle (pl_acta;Size of array:C274(aC0)-1;1)
			PL_SetRowColor (pl_acta;Size of array:C274(aC0)-1;"";16;"";16*15+2)
			PL_SetRowStyle (pl_acta;Size of array:C274(aC0);1)
			PL_SetRowColor (pl_acta;Size of array:C274(aC0);"";16;"";16*15+2)
			
			
			PL_SetHdrStyle (pl_acta;0;"Tahoma";$fontSizenames;1)
			PL_SetHdrOpts (pl_acta;1;0)
			PL_SetColOpts (pl_acta;0;0)
			PL_SetDividers (pl_acta;0.5;"Black";"Black";0;0.5;"Gray";"Black";0)
			PL_SetFrame (pl_acta;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			
			PL_SetHeight (pl_acta;1;4;1;1)
			
			  // PL_SetSort (pl_acta;1)
			sDate:=String:C10(Current date:C33;3)+" a las "+String:C10(Current time:C178;2)
			RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
			
		: (vs_ConfigToUse="MultiPage")
			  // 
			
			vi_Columns:=vi_LastCol+6
			
			If (vPageNumber>1)
				$printedColumns:=(vPageNumber-1)*6
				$nextColumn:=$printedColumns+1
			Else 
				$printedColumns:=6
				$nextColumn:=1
			End if 
			
			$width1:=20
			$width2:=80
			If (cbAsistencia=1)
				$widthAsistencia:=25
			Else 
				$widthAsistencia:=0
			End if 
			If (cb_HideAverage=0)
				$widthAvgF:=20
			Else 
				$widthAvgF:=0
			End if 
			
			$remainingWidth:=725-$width1-$width2-$widthAvgF-$widthAsistencia
			$widthNota:=Int:C8($remainingWidth/6)
			$width2:=725-(($widthNota*6)+$width1+$widthAvgF+$widthAsistencia)
			$fontSize:=6
			$fontName:="Arial"
			
			
			$err:=PL_SetArraysNam (pl_acta;1;2;"aOrder";"aC0")
			PL_SetWidths (pl_acta;1;2;$width1;$width2)
			PL_SetFormat (pl_acta;1;"##";2;2;0)
			PL_SetFormat (pl_acta;2;"";0;2;0)
			PL_SetStyle (pl_acta;1;"Arial";6;0)
			PL_SetStyle (pl_acta;2;"Arial";6;0)
			PL_SetHeaders (pl_acta;1;2;"No";"Alumno")
			
			
			For ($i;$nextColumn;$nextColumn+6-1)
				$arrName:="aC"+String:C10($i)
				$arrPointer:=Get pointer:C304($arrName)
				If ($i<=Size of array:C274(aAsgAbrev))
					$err:=PL_SetArraysNam (pl_acta;$i+2;1;$arrName)
					PL_SetFormat (pl_acta;$i+2;"";2;2;0)
					PL_SetWidths (pl_acta;$i+2;1;$widthNota)
					PL_SetStyle (pl_acta;$i+2;"Arial";5;0)
					PL_SetHeaders (pl_acta;$i+2;1;aAsgAbrev{$i})
				Else 
					INSERT IN ARRAY:C227($arrPointer->;Size of array:C274($arrPointer->)+1;Size of array:C274(aC0)-Size of array:C274($arrPointer->))
					$err:=PL_SetArraysNam (pl_acta;$i+2;1;$arrName)
					PL_SetHeaders (pl_acta;$i+2;1;"")
					PL_SetFormat (pl_acta;$i+2;"";2;2;0)
					PL_SetWidths (pl_acta;$i+2;1;$widthNota)
					PL_SetStyle (pl_acta;$i+2;"Arial";5;0)
					If (Size of array:C274(aAsgAbrev)>=$i)
						PL_SetHeaders (pl_acta;$i+2;1;aAsgAbrev{$i})
					Else 
						PL_SetHeaders (pl_acta;$i+2;1;"")
					End if 
				End if 
			End for 
			
			If (cb_HideAverage=0)
				$err:=PL_SetArraysNam (pl_acta;vi_Columns+3;1;"aCAvg")
				PL_SetFormat (pl_acta;vi_Columns+3;"";2;2;0)
				PL_SetWidths (pl_acta;vi_Columns+3;1;$widthAvgF)
				PL_SetStyle (pl_acta;vi_Columns+3;"Arial";5;1)
				PL_SetHeaders (pl_acta;vi_Columns+3;1;"PF")
				$lastColumn:=9
			Else 
				$lastColumn:=8
			End if 
			
			
			If (cbAsistencia=1)
				  //$err:=PL_SetArraysNam (pl_acta;$lastColumn+1;1;"aPctAsistencia")
				  //PL_SetFormat (pl_acta;$lastColumn+1;"##0"+<>txs_rs_decimalseparator+"0%";2;2;0)
				$err:=PL_SetArraysNam (pl_acta;$lastColumn+1;1;"atPctAsistencia")
				PL_SetFormat (pl_acta;$lastColumn+1;"";2;2;0)
				PL_SetWidths (pl_acta;$lastColumn+1;1;$widthAsistencia)
				PL_SetStyle (pl_acta;$lastColumn+1;"Arial";5;0)
				PL_SetHeaders (pl_acta;$lastColumn+1;1;"% asist.")
				$lastColumn:=$lastColumn+1
			End if 
			
			PL_SetHdrStyle (pl_acta;0;$fontName;$fontSize;1)
			PL_SetHdrOpts (pl_acta;1;0)
			PL_SetColOpts (pl_acta;0;0)
			PL_SetDividers (pl_acta;0.5;"Black";"Black";0;0.5;"Gray";"Black";0)
			PL_SetFrame (pl_acta;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
			
			  // lineas de promedios y aprobados  (pie)
			PL_SetRowStyle (pl_acta;Size of array:C274(aC0)-1;1)
			PL_SetRowColor (pl_acta;Size of array:C274(aC0)-1;"";16;"";16*15+2)
			PL_SetRowStyle (pl_acta;Size of array:C274(aC0);1)
			PL_SetRowColor (pl_acta;Size of array:C274(aC0);"";16;"";16*15+2)
			
			PL_SetHeight (pl_acta;2;3;0;2)
			
			sDate:=String:C10(Current date:C33;3)+" a las "+String:C10(Current time:C178;2)
			RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
	End case 
End if 