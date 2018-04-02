note
	description: "Summary description for {REMOVE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REMOVE_CONTAINER
inherit
	OPERATION
create
	make

feature {NONE}
	make (cid_given: STRING , msg : STRING)
	do
		cid := cid_given
		error_string := ""
		create error.make
	end

feature
	cid: STRING
	error_string: STRING
	error : ERRORS
	
	error_check
		do
			if FALSE then
				-- Check if the container exists
				error_string := error.E15
			else
				error_string := error.OK
			end

		end

	execute
		do

		end

	undo
		do

		end

	redo
		do

		end
end
