param table
if empty(table)
	? 'db filename'
else
	use &table new
	browse()
endif

