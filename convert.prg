#include "Dbstruct.ch"
param source, destination, struct

private fieldname
set century on
set date format "dd-mm-yyyy"

if (empty(source) .or. lower(source)== '/h' .or. lower(source) = '--h' .or. source == '/?')
    ? 'convert source [destination [struct] ]'
    return
endif 

if (empty(destination))
   destination = 'dane_fik'
endif

if (empty(struct))
	struct = 'dane_fik.str'
endif

use (struct) alias struct new
a_struct = dbstruct()	
use
dbcreate(destination,a_struct)
use (destination) new alias destination
use (source) new alias source
s_struct = dbstruct()
while (!eof())
    select destination
    append blank	
	for i:=1 to len(a_struct)
	    fieldname = a_struct[i][DBS_NAME]
	    if (ascan(s_struct, {|value| value[DBS_NAME]==fieldname})<=0)
	        loop
	    endif
	    fieldvalue = source->(&fieldname)
        destination->&fieldname := fieldvalue
	next
	select source
	skip
enddo