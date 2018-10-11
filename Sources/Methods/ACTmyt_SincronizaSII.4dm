//%attributes = {}
$content:=$1
$yearStr:=$2

C_LONGINT:C283($cuantosTd;$haytd;$pEnSgteLinea)
ARRAY REAL:C219(aReal1;12)
ARRAY TEXT:C222(aText1;0)
AT_Text2Array (->aText1;$content;"\r"+Char:C90(10))
$foundAt:=1
For ($i;1;12)
	  //20171018 RCH
	If ((Num:C11($yearStr))>=2013)
		ARRAY TEXT:C222($at_lineas;0)
		AT_Text2Array (->$at_lineas;$content;"\n")
		$mes:="@"+<>atXS_MonthNames{$i}+"@"
		$l_pos:=Find in array:C230($at_lineas;$mes)
		If ($l_pos>0)
			$t_ipc:=$at_lineas{$l_pos+4}
			$t_ipc:=Replace string:C233($t_ipc;"<td align='center'>";"")
			$t_ipc:=Replace string:C233($t_ipc;"</td>";"")
			$t_ipc:=Replace string:C233($t_ipc;".";<>tXS_RS_DecimalSeparator)
			$t_ipc:=Replace string:C233($t_ipc;",";<>tXS_RS_DecimalSeparator)
			aReal1{$i}:=Num:C11($t_ipc)
		End if 
	Else 
		$mes:=<>atXS_MonthNames{$i}
		For ($j;$foundAt;Size of array:C274(aText1))
			$text:=aText1{$j}
			$foundAt:=Position:C15($mes;$text)
			If ($foundAt>0)
				Case of 
					: (Num:C11($yearStr)>=2010)
						C_LONGINT:C283($vl_td;$vl_contador;$vl_indice;$vl_pos)
						$vl_td:=4
						$vl_contador:=0
						$vl_indice:=$j
						$vl_pos:=Position:C15("</td>";aText1{$vl_indice})
						  //While ($vl_contador#$vl_td)
						  //While ($vl_pos#0)
						  //$vl_contador:=$vl_contador+1
						  //$vl_pos:=Position("</td>";aText1{$vl_indice};$vl_pos+1)// este comando tiene un problema en 4d 2004
						  //End while 
						  //If ($vl_contador#$vl_td)
						  //$vl_indice:=$vl_indice+1
						  //$vl_pos:=Position("</td>";aText1{$vl_indice})
						  //End if 
						  //End while 
						While ($vl_contador#$vl_td)
							While (($vl_pos#0) & ($vl_contador#$vl_td))
								$vl_contador:=$vl_contador+1
								If ($vl_contador#$vl_td)
									aText1{$vl_indice}:=Replace string:C233(aText1{$vl_indice};"</td>";"";1)
									$vl_pos:=Position:C15("</td>";aText1{$vl_indice})
								End if 
							End while 
							If ($vl_contador#$vl_td)
								$vl_indice:=$vl_indice+1
								$vl_pos:=Position:C15("</td>";aText1{$vl_indice})
							End if 
						End while 
						
						  //20120831 ASM. se producía un problema en 
						  //$ipc:=Substring(aText1{$vl_indice};$vl_pos-3;3)
						
						  //20121205 RCH Habia problema en MAC. Se obtenia un valor que no correspondia...
						  //$ipc:=aText1{$vl_indice}
						  //$ipc:=Replace string($ipc;"</td>";"")
						  //$ipc:=Replace string($ipc;"<td>";"")
						$ipc:=Substring:C12(aText1{$vl_indice};$vl_pos-5;5)
						$ipc:=Replace string:C233($ipc;"<";"")
						$ipc:=Replace string:C233($ipc;">";"")
						$ipc:=Replace string:C233($ipc;"t";"")
						$ipc:=Replace string:C233($ipc;"d";"")
						$ipc:=Replace string:C233($ipc;"/";"")
						
						If (Position:C15(".";$ipc)>0)
							$ipc:=Replace string:C233($ipc;".";<>tXS_RS_DecimalSeparator)
						Else 
							$ipc:=Replace string:C233($ipc;",";<>tXS_RS_DecimalSeparator)
						End if 
						$foundAt:=$vl_indice
						$j:=Size of array:C274(aText1)+1
						aReal1{$i}:=Num:C11($ipc)
						
						  //20110504 RCH Se elimina linea del mes procesado
						$vl_tr:=Position:C15("</tr>";aText1{$vl_indice})+5
						aText1{$vl_indice}:=Substring:C12(aText1{$vl_indice};$vl_tr)
						
					: (Num:C11($yearStr)<2007)
						$index:=$j+3
						$first:=Position:C15("2";aText1{$index})+3
						$last:=Position:C15("</font>";aText1{$index})-1
						$ipc:=Substring:C12(aText1{$index};$first;$last-$first+1)
						If (Position:C15(".";$ipc)>0)
							$ipc:=Replace string:C233($ipc;".";<>tXS_RS_DecimalSeparator)
						Else 
							$ipc:=Replace string:C233($ipc;",";<>tXS_RS_DecimalSeparator)
						End if 
						$foundAt:=$index+1
						$j:=Size of array:C274(aText1)+1
						aReal1{$i}:=Num:C11($ipc)
					: (Num:C11($yearStr)>=2007)
						$cuantosTd:=0
						For ($j;$j+1;Size of array:C274(aText1))
							$text:=aText1{$j}
							$haytd:=Position:C15("<td";$text)
							If ($haytd>0)
								$cuantosTd:=$cuantosTd+1
								If ($cuantosTd=4)
									$process:=True:C214
									$continuar:=True:C214
									While ($continuar)
										$cierre:=Position:C15("</font>";aText1{$j})
										If ($cierre#0)
											$continuar:=False:C215
											$process:=True:C214
											$j:=$j-1
										Else 
											$cierre:=Position:C15("</td>";aText1{$j})
											If ($cierre#0)
												$continuar:=False:C215
												$process:=False:C215
												$foundAt:=$j-1
												$j:=Size of array:C274(aText1)+1
												aReal1{$i}:=0
											End if 
										End if 
										$j:=$j+1
									End while 
									If ($process)
										$last:=Position:C15("</font>";aText1{$j})
										$textTemp:=Substring:C12(aText1{$j};$last-5;Length:C16(aText1{$j}))
										$first:=Position:C15(">";$textTemp)
										$last:=Position:C15("</font>";$textTemp)-1
										$ipc:=Substring:C12($textTemp;$first+1;$last-$first)
										If (Position:C15(".";$ipc)>0)
											$ipc:=Replace string:C233($ipc;".";<>tXS_RS_DecimalSeparator)
										Else 
											$ipc:=Replace string:C233($ipc;",";<>tXS_RS_DecimalSeparator)
										End if 
										$foundAt:=$j-1
										$j:=Size of array:C274(aText1)+1
										aReal1{$i}:=Num:C11($ipc)
									End if 
								End if 
							End if 
						End for 
				End case 
			End if 
		End for 
	End if 
End for 
  //IT_UThermometer (0;$proc;__ ("Recalculando valores UF..."))
COPY ARRAY:C226(aReal1;arACT_VariacionIPC)
ACTcfg_RecalcUF 
AT_Initialize (->aReal1;->aText1)
LOG_RegisterEvt ("Sincronización de valores de UF e IPC con servidor de SII exitosa.")