note
	description: "Summary description for {REMOVE_PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REMOVE_PHASE
inherit
	OPERATION
create
	make

feature {NONE}
	make (pid_given)
	do
		pid := pid
		create errors.make
		error_string := ""
	end

feature
	error : ERRORS
	pid : STRING
	error_string : STRING
	--new_message: STRING

	error_check
		do

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
