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
	make (cid_given: STRING)
	do
		cid := cid_given
		error_string := ""
		create error.make
	end

feature
	cid: STRING
	error_string: STRING
	error : ERRORS

	does_container_exist : BOOLEAN
		do
			Result := FALSE
		end

	error_check
		do
			if does_container_exist then
				error_string := error.E15
			else
				error_string := error.OK
			end

		end

	execute
		do
			state.state_msg_update(error.OK)
			state.remove_container(cid)
		end

	undo
		do

		end

	redo
		do

		end
end
