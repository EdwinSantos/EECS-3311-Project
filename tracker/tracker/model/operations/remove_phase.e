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
	make (command_name, msg : STRING)
	do
		item := command_name
		new_message := msg
		error_string := ""
	end

feature
	new_message: STRING

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
