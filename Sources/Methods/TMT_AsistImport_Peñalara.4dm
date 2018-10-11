//%attributes = {}
  //  //TMT_AsistImport_Peñalara
  //  //MONO:pasa a arreglos la info del xml con bloques del software peñalara
  //  //Esto es una demo, solicitada en el ticket 155060

  //C_TEXT($t_ruta;$1)
  //C_LONGINT($soa;$i)
  //C_POINTER($y_at_curso;$2;$y_al_id_asignatura;$3;$y_ai_numdia;$4;$y_ai_numhora;$5;$y_al_idprofesor;$6;$y_al_id_temp;$7;$y_al_nonivel;$8)

  //$t_ruta:=$1
  //$y_at_curso:=$2
  //$y_al_id_asignatura:=$3
  //$y_ai_numdia:=$4
  //$y_ai_numhora:=$5
  //$y_al_idprofesor:=$6
  //$y_al_id_temp:=$7
  //$y_al_nonivel:=$8

  //READ ONLY([Alumnos])
  //READ ONLY([Alumnos_Calificaciones])
  //READ ONLY([Asignaturas])

  //$proc:=IT_UThermometer (1;0;__ ("Cargando archivo Peñalara..."))
  //C_TEXT($xmlRef;$primer_XML_Ref;$siguiente_XML_Ref)
  //$cantidad_nodos:=0
  //$xmlRef:=DOM Parse XML source($t_ruta)

  //$ressubelem:=DOM Find XML element($xmlRef;"/datosGHC/marcosDeHorario")

  //If (OK=1)

  //$primer_marco:=DOM Get first child XML element($ressubelem;$childName;$childValue)
  //$siguiente_marco:=$primer_marco

  //If (OK=1)

  //Repeat   //marco

  //$siguiente_tramo:=DOM Get first child XML element($siguiente_marco;$childName;$childValue)

  //If (OK=1)

  //Repeat   //tramos

  //AT_Insert (0;1;$y_at_curso;$y_al_id_asignatura;$y_ai_numdia;$y_ai_numhora;$y_al_idprofesor;$y_al_id_temp;$y_al_nonivel)
  //$soa:=Size of array($y_at_curso->)
  //$countdt:=0
  //Repeat   //detalle del tramo

  //If ($countdt=0)
  //$next_node:=DOM Get first child XML element($siguiente_tramo;$childName;$childValue)
  //Else 
  //$next_node:=DOM Get next sibling XML element($next_node;$childName;$childValue)
  //End if 

  //If (OK=1)
  //SET BLOB SIZE($vx_text;0)
  //CONVERT FROM TEXT($childValue;"ISO-8859-1";$vx_text)
  //$childValue:=Convert to text($vx_text;"UTF-8")

  //Case of 
  //: ($childName="dia")
  //$y_ai_numdia->{$soa}:=Num($childValue)+1
  //: ($childName="indice")
  //$y_ai_numhora->{$soa}:=Num($childValue)+1
  //: ($childName="clavX")
  //$y_al_id_asignatura->{$soa}:=Num($childValue)

  //QUERY([Asignaturas];[Asignaturas]Numero=al_id_asignatura{$soa})
  //If (Records in selection([Asignaturas])=1)
  //$y_at_curso->{$soa}:=[Asignaturas]Curso
  //$y_al_idprofesor->{$soa}:=[Asignaturas]Profesor_Numero
  //$y_al_nonivel->{$soa}:=[Asignaturas]Numero_del_Nivel
  //End if 
  //End case 

  //End if 

  //$countdt:=$countdt+1
  //Until (OK=0)

  //al_id_temp{$soa}:=$soa
  //$siguiente_tramo:=DOM Get next sibling XML element($siguiente_tramo;$childName;$childValue)
  //Until (OK=0)

  //End if 

  //$siguiente_marco:=DOM Get next sibling XML element($siguiente_marco;$childName;$childValue)

  //Until (OK=0)

  //End if 

  //End if 
  //DOM CLOSE XML($xmlRef)
  //IT_UThermometer (-2;$proc)
