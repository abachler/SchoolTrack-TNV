//%attributes = {}
  //HTML_DynamicTable

  // ----------------------------------------------------
  // Nombre usuario (OS): mauricio
  // Fecha y hora: 09/06/06, 13:12:15
  // ----------------------------------------------------
  // Método: HTML_DinamicTable
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_POINTER:C301($1;$vy_TittlesNames)
C_POINTER:C301($2;$vy_DataNames)
C_POINTER:C301($3;$vy_AlignMentTitles)
C_POINTER:C301($4;$vy_AlignMentValues)
C_POINTER:C301($5;$vy_OtherParamters)
C_TEXT:C284($0;$vt_Result)

  //C_BOOLEAN($3;$vb_EvaluateData)
  //C_TEXT($4;$vt_Recv_GeneralTableWidth)
  //C_TEXT($5;$vt_Recv_Border)
  //C_BOOLEAN($8;$vb_AutoAdjust)

$vy_TittlesNames:=$1
$vy_DataNames:=$2
$vy_AlignMentTitles:=$3
$vy_AlignMentValues:=$4
$vy_OtherParamters:=$5

  //Tittles Names
ARRAY TEXT:C222($at_RecTituleNames;0)
COPY ARRAY:C226($vy_TittlesNames->;$at_RecTituleNames)
  //Data Names
ARRAY TEXT:C222($at_RecDataNames;0)
COPY ARRAY:C226($vy_DataNames->;$at_RecDataNames)
  // //Special Properties
  //Alignments
$vy_AlignMentTitles:=$3
ARRAY TEXT:C222($at_AlignMentTitles;0)
COPY ARRAY:C226($vy_AlignMentTitles->;$at_AlignMentTitles)
$vy_AlignMentValues:=$4
ARRAY TEXT:C222($at_AlignMentValues;0)
COPY ARRAY:C226($vy_AlignMentValues->;$at_AlignMentValues)
  // //Other Properties
ARRAY TEXT:C222($at_OtherParamters;0)
COPY ARRAY:C226($vy_OtherParamters->;$at_OtherParamters)
  // //AutoAdjust
Case of 
	: ($at_OtherParamters{1}="True")
		$vb_EvaluateData:=True:C214
	: ($at_OtherParamters{1}="False")
		$vb_EvaluateData:=False:C215
End case 
  // //Width of Table
$vt_Recv_GeneralTableWidth:=$at_OtherParamters{2}
  // //Border of Table
$vt_Recv_Border:=$at_OtherParamters{3}


  //==============Evaluate with cases the Arrays Receiveds, if true condition is preset===============

If ($vb_EvaluateData=True:C214)
	C_LONGINT:C283($vl_sizeOFArrayTituleNames;$vl_sizeOFArrayDataNames;$vl_RestResult;$vl_Element;$i;$j)
	$vl_sizeOFArrayTituleNames:=Size of array:C274($at_RecTituleNames)
	$vl_sizeOFArrayDataNames:=Size of array:C274($at_RecDataNames)
	
	Case of 
			  //case 1: the Title Names Array its > Then Data Names Array
		: ($vl_sizeOFArrayTituleNames>$vl_sizeOFArrayDataNames)
			  //Delete the excess of $at_RecTituleNames
			$vl_RestResult:=$vl_sizeOFArrayTituleNames-$vl_sizeOFArrayDataNames
			$vl_Element:=$vl_sizeOFArrayDataNames
			For ($i;1;$vl_RestResult)
				$vl_Element:=$vl_Element+1
				DELETE FROM ARRAY:C228($at_RecTituleNames;$vl_Element)
			End for 
			  //Revisar y limpiar el Array de Datos las posiciones encontradas con datos nulos o cero sergan quitadas en ambos arrays.
			  //ArrayDataName
			For ($i;1;$vl_sizeOFArrayDataNames)
				$j:=$j+1
				If ($i<=$vl_sizeOFArrayDataNames)
					If (($at_RecDataNames{$j}="") | ($at_RecDataNames{$j}="0"))
						DELETE FROM ARRAY:C228($at_RecTituleNames;$j)
						DELETE FROM ARRAY:C228($at_RecDataNames;$j)
						DELETE FROM ARRAY:C228($at_AlignMentTitles;$j)
						DELETE FROM ARRAY:C228($at_AlignMentValues;$j)
						$j:=0
						$i:=0
					End if 
				End if 
				$vl_sizeOFArrayDataNames:=Size of array:C274($at_RecDataNames)
			End for 
			  //case 2:
		: ($vl_sizeOFArrayTituleNames<$vl_sizeOFArrayDataNames)
			  //Delete the excess of $vl_sizeOFArrayDataNames
			$vl_RestResult:=$vl_sizeOFArrayDataNames-$vl_sizeOFArrayTituleNames
			$vl_Element:=$vl_sizeOFArrayTituleNames
			For ($i;1;$vl_RestResult)
				$vl_Element:=$vl_Element+1
				DELETE FROM ARRAY:C228($at_RecDataNames;$vl_Element)
			End for 
			  //Revisar y limpiar el Array de Datos las posiciones encontradas con datos nulos o cero sergan quitadas en ambos arrays.
			  //ArrayDataName
			For ($i;1;$vl_sizeOFArrayDataNames)
				$j:=$j+1
				If ($i<=$vl_sizeOFArrayDataNames)
					If (($at_RecDataNames{$j}="") | ($at_RecDataNames{$j}="0"))
						DELETE FROM ARRAY:C228($at_RecTituleNames;$j)
						DELETE FROM ARRAY:C228($at_RecDataNames;$j)
						DELETE FROM ARRAY:C228($at_AlignMentTitles;$j)
						DELETE FROM ARRAY:C228($at_AlignMentValues;$j)
						$j:=0
						$i:=0
					End if 
				End if 
				$vl_sizeOFArrayDataNames:=Size of array:C274($at_RecDataNames)
			End for 
			  //case 3:
		: ($vl_sizeOFArrayTituleNames=$vl_sizeOFArrayDataNames)
			  //Revisar y limpiar el Array de Datos las posiciones encontradas con datos nulos o cero sergan quitadas en ambos arrays.
			  //ArrayDataName
			For ($i;1;$vl_sizeOFArrayDataNames)
				$j:=$j+1
				If ($i<=$vl_sizeOFArrayDataNames)
					If (($at_RecDataNames{$j}="") | ($at_RecDataNames{$j}="0"))
						DELETE FROM ARRAY:C228($at_RecTituleNames;$j)
						DELETE FROM ARRAY:C228($at_RecDataNames;$j)
						DELETE FROM ARRAY:C228($at_AlignMentTitles;$j)
						DELETE FROM ARRAY:C228($at_AlignMentValues;$j)
						$j:=0
						$i:=0
					End if 
				End if 
				$vl_sizeOFArrayDataNames:=Size of array:C274($at_RecDataNames)
			End for 
	End case 
End if 

  //=============Headers and Footers============
  //Footer for Mother Table
  // // General Header <table>
$vt_HeaderTable:="<table>"
  // // General Footer </table>
$vt_FooterTable:="</table>"

  //============Features===================
  //Features of Mother Table
  // //General Widht of Table  table widt="1"
$vt_GeneralTableWidth:="table width="+ST_Qte ($vt_Recv_GeneralTableWidth)
  // //General Border of Table border="1"
$vt_GeneralBorder:="border="+ST_Qte ($vt_Recv_Border)
  //Tags
  // //Tag Open <>
$vt_tag_Open:="<+>"
  // //Tag Close </>
$vt_tag_Close:="</+>"
  //Carriage Return
$vt_CarriageReturn:="\r"

  //============TRS======================
  //For Create a Files
  // //TR Open
$vt_tr_open:="<tr>"
  // //TR Close
$vt_tr_close:="</tr>"

  //============TDS======================
  //For Create a Titles
  // //TH Open
$vt_th_open:="<th>"
  // //TH Close
$vt_th_close:="</th>"

  //============TDS======================
  //For Create a Columns
  // //TD Open
$vt_td_open:="<td>"
  // //TD Close
$vt_td_close:="</td>"


  //============TITLES======================
  //This Create a TITLES
  // //Titulos
$vt_tr_titulos:=$vt_th_open+"+"+$vt_th_close


  //============COLUMNS======================
  //This Create a Column 
  // //Column
$vt_td_columnas:=$vt_td_open+"+"+$vt_td_close



  //============Element-Specific Atributtes=========

  //Create a Table
C_LONGINT:C283($i;$j)
$i:=0
$j:=0
C_TEXT:C284($vt_htmltable)
$vt_htmltable:=""
$vt_tr_filas_final:=""
$vt_td_columnas_final:=""


  //Header Table And Set General Features
$vt_GeneralTableWidth:=Replace string:C233($vt_tag_Open;"+";$vt_GeneralTableWidth+" "+$vt_GeneralBorder)
$vt_htmltable:=$vt_htmltable+$vt_GeneralTableWidth+$vt_CarriageReturn
  //Body Table

  //Generate Titles
  //Open for generate TR
$vt_htmltable:=$vt_htmltable+$vt_tr_open+$vt_CarriageReturn
For ($i;1;Size of array:C274($at_RecTituleNames))
	$vt_tr_titulos_final:=Replace string:C233($vt_tr_titulos;"+";HTML_Div_Align ($at_AlignMentTitles{$i};$at_RecTituleNames{$i}))
	$vt_htmltable:=$vt_htmltable+$vt_tr_titulos_final+$vt_CarriageReturn
End for 
  //Close For Terminate generate TR
$vt_htmltable:=$vt_htmltable+$vt_tr_close+$vt_CarriageReturn
  //Generate Titles End

C_LONGINT:C283($vl_TAM_ARRAY_Names;$vl_TAM_ARRAY_Values)
  //Declarare Arrays Data Sizes
$vl_TAM_ARRAY_Names:=Size of array:C274($at_RecTituleNames)
$vl_TAM_ARRAY_Values:=Size of array:C274($at_RecDataNames)

C_LONGINT:C283($vl_Divide1;$vl_Mod1;$vl_ResultDiv1)
  //Declare Results for settings Table Creation
$vl_Divide1:=Round:C94($vl_TAM_ARRAY_Values\$vl_TAM_ARRAY_Names;0)
$vl_Mod1:=Mod:C98($vl_TAM_ARRAY_Values;$vl_TAM_ARRAY_Names)
$vl_ResultDiv1:=$vl_Divide1+$vl_Mod1

C_LONGINT:C283($vl_Divide2;$vl_Mod2;$vl_ResultDiv2)
$vl_Divide2:=Round:C94($vl_TAM_ARRAY_Names\$vl_TAM_ARRAY_Values;0)
$vl_Mod2:=Mod:C98($vl_TAM_ARRAY_Names;$vl_TAM_ARRAY_Values)
$vl_ResultDiv2:=$vl_Divide2+$vl_Mod2

  //Generate Data

  // //Set Scape Routine
C_LONGINT:C283($k;$vl_SetScape)
$vl_SetScape:=0
Case of 
	: ($vl_TAM_ARRAY_Names=$vl_TAM_ARRAY_Values)
		  //Open for generate TR
		$vt_htmltable:=$vt_htmltable+$vt_tr_open+$vt_CarriageReturn
		  //Generate Filas y Columnas
		For ($j;1;$vl_TAM_ARRAY_Values)
			$vt_td_columnas_final:=Replace string:C233($vt_td_columnas;"+";HTML_Div_Align ($at_AlignMentValues{$j};$at_RecDataNames{$j}))
			$vt_htmltable:=$vt_htmltable+$vt_td_columnas_final+$vt_CarriageReturn
		End for 
		  //Close For Terminate generate TR
		$vt_htmltable:=$vt_htmltable+$vt_tr_close+$vt_CarriageReturn
		  //Generate Data End
	: ($vl_TAM_ARRAY_Names<$vl_TAM_ARRAY_Values)
		$k:=0  //Reset counter K
		For ($i;1;$vl_ResultDiv1)
			  //Open for generate TR
			$vt_htmltable:=$vt_htmltable+$vt_tr_open+$vt_CarriageReturn
			  //Generate Filas y Columnas
			For ($j;1;$vl_TAM_ARRAY_Names)
				  // //Scape of Fors
				If ($k=$vl_TAM_ARRAY_Values)
					$j:=$vl_TAM_ARRAY_Names+1
					$i:=$vl_Divide1+1
					$vl_SetScape:=1
				Else 
					$k:=$k+1
					$vt_td_columnas_final:=Replace string:C233($vt_td_columnas;"+";HTML_Div_Align ($at_AlignMentValues{$k};$at_RecDataNames{$k}))
					$vt_htmltable:=$vt_htmltable+$vt_td_columnas_final+$vt_CarriageReturn
				End if 
			End for 
			  //Close For Terminate generate TR
			If (($k<=$vl_TAM_ARRAY_Values) & ($vl_SetScape=0))
				$vt_htmltable:=$vt_htmltable+$vt_tr_close+$vt_CarriageReturn
			End if 
			  //Generate Data End
		End for 
	: ($vl_TAM_ARRAY_Names>$vl_TAM_ARRAY_Values)
		$k:=0  //Reset counter K
		For ($i;1;$vl_ResultDiv2)
			  //Open for generate TR
			$vt_htmltable:=$vt_htmltable+$vt_tr_open+$vt_CarriageReturn
			  //Generate Filas y Columnas
			For ($j;1;$vl_TAM_ARRAY_Values)
				  // //Scape of Fors
				If ($k=$vl_TAM_ARRAY_Values)
					$j:=$vl_TAM_ARRAY_Values+1
					$i:=$vl_Divide2+1
					$vl_SetScape:=1
				Else 
					$k:=$k+1
					$vt_td_columnas_final:=Replace string:C233($vt_td_columnas;"+";HTML_Div_Align ($at_AlignMentValues{$k};$at_RecDataNames{$k}))
					$vt_htmltable:=$vt_htmltable+$vt_td_columnas_final+$vt_CarriageReturn
				End if 
			End for 
			  //Close For Terminate generate TR
			If (($k<=$vl_TAM_ARRAY_Values) & ($vl_SetScape=0))
				$vt_htmltable:=$vt_htmltable+$vt_tr_close+$vt_CarriageReturn
				  //Generate Data End
			End if 
		End for 
End case 
  //Footer Table
$vt_htmltable:=$vt_htmltable+$vt_FooterTable
  //html table end

  //Send Return
$vt_Result:=$vt_htmltable

$0:=$vt_Result


  //  `// Just for evaluate the method
  //$vt_HTML:="encabezado2"+".txt"
  //vsEntry:=$vt_Result
  //C_TIME(vhDoc)
  //vhDoc:=Create document($vt_HTML)  ` Create new document "
  //SEND PACKET(vhDoc;vsEntry)  ` Write one word in the document 
  //CLOSE DOCUMENT(vhDoc)  ` Close the document



