//%attributes = {}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)

C_LONGINT:C283($i;$l_abajoO;$l_abajoRef;$l_arribaO;$l_arribaRef;$l_derechaO;$l_derechaRef;$l_desfase;$l_desplazamiento;$l_IzquierdaO)
C_LONGINT:C283($l_IzquierdaRef;$l_posicion)
C_TEXT:C284($t_objetoReferencia;$t_objetoSecundario)



If (False:C215)
	C_LONGINT:C283(IT_AlineaObjetos ;$1)
	C_LONGINT:C283(IT_AlineaObjetos ;$2)
	C_TEXT:C284(IT_AlineaObjetos ;$3)
End if 


$l_posicion:=$1
$l_desfase:=$2
$t_objetoReferencia:=$3

For ($i;4;Count parameters:C259)
	$t_objetoSecundario:=${$i}
	OBJECT GET COORDINATES:C663(*;$t_objetoReferencia;$l_IzquierdaRef;$l_arribaRef;$l_derechaRef;$l_abajoRef)
	OBJECT GET COORDINATES:C663(*;$t_objetoSecundario;$l_IzquierdaO;$l_arribaO;$l_derechaO;$l_abajoO)
	
	Case of 
		: ($l_posicion=Izquierda)  // alinea a la izquierda
			$l_desplazamiento:=$l_izquierdaRef-$l_IzquierdaO
			If ($l_desfase>0)
				$l_desplazamientoVertical:=$l_abajoRef+$l_desfase-$l_arribaO
			Else 
				$l_desplazamientoVertical:=$l_arribaRef-Abs:C99($l_desfase)-$l_arribaO
			End if 
			OBJECT MOVE:C664(*;$t_objetoSecundario;$l_desplazamiento;$l_desplazamientoVertical)
			
		: ($l_posicion=Arriba)  // alinea arriba
			$l_desplazamiento:=$l_arribaRef-$l_arribaO
			If ($l_desfase>0)
				$l_desplazamientoHorizontal:=$l_derechaRef+$l_desfase-$l_izquierdaO
			Else 
				$l_desplazamientoHorizontal:=$l_izquierdaRef-Abs:C99($l_desfase)-$l_derechaO
			End if 
			OBJECT MOVE:C664(*;$t_objetoSecundario;$l_desplazamientoHorizontal;$l_desplazamiento)
			
		: ($l_posicion=Derecha)  // alinea a  la derecha
			$l_desplazamiento:=$l_derechaRef-$l_derechaO
			If ($l_desfase>0)
				$l_desplazamientoVertical:=$l_arribaRef+$l_desfase-$l_abajoO
			Else 
				$l_desplazamientoVertical:=$l_arribaRef-Abs:C99($l_desfase)-$l_abajoO
			End if 
			OBJECT MOVE:C664(*;$t_objetoSecundario;$l_desplazamiento;$l_desplazamientoVertical)
			
		: ($l_posicion=Abajo)  // alinea abajo
			$l_desplazamiento:=$l_abajoRef-$l_abajoO
			If ($l_desfase>0)
				$l_desplazamientoHorizontal:=$l_derechaRef+$l_desfase-$l_izquierdaO
			Else 
				$l_desplazamientoHorizontal:=$l_izquierdaRef-Abs:C99($l_desfase)-$l_derechaO
			End if 
			OBJECT MOVE:C664(*;$t_objetoSecundario;$l_desplazamientoHorizontal;$l_desplazamiento)
			
	End case 
	
	OBJECT GET COORDINATES:C663(*;$t_objetoSecundario;$l_IzquierdaO;$l_arribaO;$l_derechaO;$l_abajoO)
End for 