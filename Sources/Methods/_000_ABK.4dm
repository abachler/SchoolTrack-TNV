//%attributes = {}
ARRAY POINTER:C280($ay_data;0)

QUERY:C277([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40="a@")
APPEND TO ARRAY:C911($ay_data;->[Alumnos:2]Nombres:2)
APPEND TO ARRAY:C911($ay_data;->[Alumnos:2]Apellido_paterno:3)
Json_Seleccion_a_jSon (->[Alumnos:2];->$ay_data)