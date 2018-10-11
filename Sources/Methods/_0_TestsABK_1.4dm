//%attributes = {}
$o_options:=New object:C1471
$o_options.withLog:="always"
$o_options.filter:=New object:C1471("projectMethods";True:C214;"databaseMethods";True:C214;"triggerMethods";True:C214;"forms";True:C214;"menus";True:C214;"tips";True:C214;"lists";True:C214;"filters";True:C214;"trash")
$o_resultado:=Export structure file:C1565("Big Data"+Folder separator:K24:12+"GitHub"+Folder separator:K24:12+"SchoolTrack-TNV";$o_options)

