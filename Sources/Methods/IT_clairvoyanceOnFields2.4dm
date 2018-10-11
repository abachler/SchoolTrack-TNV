//%attributes = {}
  // IT_clairvoyanceOnFields2()
  // Por: Alberto Bachler: 30/03/13, 13:25:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_POINTER:C301($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($b_permancerEnCampo)
C_LONGINT:C283($Ascii;$l_finSeleccion;$l_largoCadena;$l_recNum;$l_inicioSeleccion)
C_POINTER:C301($y_campo;$y_objeto;$y_tabla;$y_tablaPointer)
C_TEXT:C284($t_valorPreservado;$t_valor_a_buscar)

ARRAY LONGINT:C221($al_RecordNumbers;0)
ARRAY TEXT:C222($at_TextValues;0)

If (False:C215)
	C_POINTER:C301(IT_clairvoyanceOnFields2 ;$1)
	C_POINTER:C301(IT_clairvoyanceOnFields2 ;$2)
	C_BOOLEAN:C305(IT_clairvoyanceOnFields2 ;$3)
End if 

C_TEXT:C284(vt_BeforeEntryValue;vtKeystroke_Filter;vt_EditedText)

$y_objeto:=$1
$y_campo:=$2
$b_permancerEnCampo:=True:C214
$b_filtrarRetirados:=False:C215
Case of 
	: (Count parameters:C259=3)
		$b_permancerEnCampo:=$3
	: (Count parameters:C259=4)
		$b_permancerEnCampo:=$3
		$b_filtrarRetirados:=$4  //20160523 ASM Ticket 161927
End case 

$y_tabla:=Table:C252(Table:C252($y_campo))

Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		vt_BeforeEntryValue:=$y_objeto->
		
	: (Form event:C388=On Before Keystroke:K2:6)
		
	: (Form event:C388=On After Keystroke:K2:26)
		
		$y_objeto->:=Get edited text:C655
		vt_EditedText:=$y_objeto->
		$Ascii:=Character code:C91(Keystroke:C390)
		
		If (($ascii#Backspace key:K12:29) & ($ascii#DEL ASCII code:K15:34))
			$l_largoCadena:=Length:C16($y_objeto->)
			If ($l_largoCadena>0)
				$t_valor_a_buscar:=$y_objeto->+"@"
				$l_recNum:=Find in field:C653($y_campo->;$t_valor_a_buscar)
				If ($b_filtrarRetirados)
					QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)  //MONO 206455
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@")  //MONO 206455
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Egresado@")  //MONO 206455
					QUERY SELECTION:C341($y_tabla->;$y_campo->=($y_objeto->+"@"))
					REDUCE SELECTION:C351([Alumnos:2];1)
					$l_recNum:=Record number:C243([Alumnos:2])
				End if 
				If ($l_recNum#-1)
					GOTO RECORD:C242($y_tabla->;$l_recNum)
					$y_objeto->:=$y_campo->
					$l_inicioSeleccion:=$l_largoCadena+1
					$l_finSeleccion:=Length:C16($y_objeto->)+1
					HIGHLIGHT TEXT:C210($y_objeto->;$l_inicioSeleccion;$l_finSeleccion)
				Else 
					HIGHLIGHT TEXT:C210($y_objeto->;$l_largoCadena+1;$l_largoCadena+1)
				End if 
			End if 
		Else 
			vt_BeforeEntryValue:=$y_objeto->
		End if 
		
	: ((Form event:C388=On Losing Focus:K2:8) | (Form event:C388=On Data Change:K2:15))
		$l_codigoCaracter:=Character code:C91(Keystroke:C390)
		If ($l_codigoCaracter>13)
			GET HIGHLIGHT:C209($y_objeto->;$l_inicioSeleccion;$l_finSeleccion)
			If (($l_inicioSeleccion>1) & ($l_finSeleccion>$l_inicioSeleccion) & ($l_inicioSeleccion<Length:C16($y_objeto->)))
				$t_valorPreservado:=$y_objeto->
				$y_objeto->:=Substring:C12($y_objeto->;0;$l_inicioSeleccion-1)
			End if 
			If (($y_objeto->#vt_BeforeEntryValue) & ($y_objeto->#""))
				QUERY:C277($y_tabla->;$y_campo->=($y_objeto->+"@"))
				If ($b_filtrarRetirados)
					QUERY SELECTION WITH ARRAY:C1050([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)  //MONO 206455
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@")  //MONO 206455
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Egresado@")  //MONO 206455
				End if 
				Case of 
					: (Records in selection:C76($y_tabla->)=0)
						$y_objeto->:=""
						GOTO OBJECT:C206($y_objeto->)
					: (Records in selection:C76($y_tabla->)=1)
						$y_objeto->:=$y_campo->
					: (Records in selection:C76($y_tabla->)>1)
						$y_tablaPointer:=Table:C252(Table:C252($y_campo))
						SELECTION TO ARRAY:C260($y_campo->;$at_TextValues;$y_tablaPointer->;$al_RecordNumbers)
						$y_objeto->:=IT_ShowChoices (->$at_TextValues;$y_objeto;"";->$al_RecordNumbers;$y_tablaPointer)
						If (OK=0)
							$y_objeto->:=""
						End if 
						FILTER KEYSTROKE:C389("")
				End case 
			End if 
			If ($y_objeto->="")
				If ($b_permancerEnCampo)
					GOTO OBJECT:C206($y_objeto->)
				End if 
			End if 
		End if 
End case 

