//%attributes = {}
  //AL_AsignaNoLista

QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)  // ASM 20150119 Ticket 140842 Para no mostrar a los alumnos ocultos de nominas
ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
ARRAY INTEGER:C220($no;0)
ARRAY INTEGER:C220($no;Records in selection:C76([Alumnos:2]))
For ($i;1;Size of array:C274($no))
	$no{$i}:=$i
End for 
ARRAY TO SELECTION:C261($no;[Alumnos:2]no_de_lista:53)
$0:=Size of array:C274($no)


ARRAY TEXT:C222(aText1;0)
ARRAY INTEGER:C220(aInt1;0)
ARRAY LONGINT:C221(aLong2;0)

QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)  // ASM 20150119 Ticket 140842 Para no mostrar a los alumnos ocultos de nominas
ORDER BY:C49([Alumnos:2];[Alumnos:2]numero:1;>)
SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]no_de_lista:53;aInt1;[Alumnos:2]numero:1;aLong2)
CUT NAMED SELECTION:C334([Alumnos:2];"notas")


If (Not:C34(SYS_isSpanishOrder ))
	For ($i;1;Size of array:C274(aText1))
		aText1{$i}:=ST_nTilde2Special (aText1{$i})
	End for 
End if 
  //End if 
SORT ARRAY:C229(aText1;aInt1;aLong2)
For ($i;1;Size of array:C274(aLong2))
	aInt1{$i}:=$i
End for 
SORT ARRAY:C229(aLong2;aText1;aInt1;>)
USE NAMED SELECTION:C332("notas")
ARRAY TO SELECTION:C261(aInt1;[Alumnos:2]no_de_lista:53)
$0:=Size of array:C274(aLong2)
UNLOAD RECORD:C212([Alumnos:2])

ARRAY TEXT:C222(aText1;0)
ARRAY INTEGER:C220(aInt1;0)
ARRAY LONGINT:C221(aLong2;0)