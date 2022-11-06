

getCRSfromDB <- function(con, tab) {
	
	x = dbGetQuery(con, str_glue("SHOW TABLES LIKE '{tab}'"))


	#table name without db
	x = stringr::str_split(tab, '\\.', simplify = TRUE)
	
	if(length(x) > 1) 
		tnam = stringr::str_trim(x[2]) 
	if(length(x) == 1) 
		tnam = stringr::str_trim(x[1]) 
	
	# if db name in tab then set db to active
	if(length(x) > 1) {
		db   = stringr::str_trim(x[1])

		dbExecute(con, paste('USE', db))
		
		} 


	SRID = dbq(con, paste('SELECT SRID FROM geometry_columns where F_TABLE_NAME = ', shQuote(tnam)   ) )$SRID

	SRTEXT = dbq(con, paste('SELECT SRTEXT FROM spatial_ref_sys where SRID = ', SRID))$SRTEXT

	sf::st_crs(wkt = SRTEXT)

	}




isNotSelect <- function(q) {
	o = str_trim(q) |> str_detect(regex('SELECT|SHOW', ignore_case = TRUE) )
	!o
	}


SQL2spatialSQL <- function(q, geometry) {


	# btw select ... from
	b = str_split(q, regex('FROM', ignore_case = TRUE), simplify = TRUE )[1]
	b = str_split(b, regex('SELECT', ignore_case = TRUE), simplify = TRUE )[2]
	b = str_split(b, ',', simplify = TRUE) |> str_trim()

	if(b[1] == '*') stop('Please avoid `SELECT * FROM` and specify the columns you want to select.')

	# add ST_AsText to geom
	gpos =which(str_detect(b, regex(geometry, ignore_case = TRUE)   )) 
	b[gpos] <-  str_glue('ST_AsText( {b[gpos]} ) as {geometry}') 
	b = paste(b, collapse = ',')

	# re-construct sql
	f = str_split(q, regex('FROM', ignore_case = TRUE), simplify = TRUE )[2]


	str_glue('SELECT {b} FROM {f}')

	}



SQL2tableName <- function(q) {

		b = str_split(q, regex('FROM', ignore_case = TRUE), simplify = TRUE )[2]
		b = str_split(b, regex('WHERE', ignore_case = TRUE), simplify = TRUE )[1]
		b = str_trim(b)

		complexQuery = str_detect(b, '=')

		if(complexQuery) {
			warning('More than one table identified. Give the table name explicitly?')
			b = NA
		
		}

		b



	}
