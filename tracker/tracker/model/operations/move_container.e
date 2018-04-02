note
	description: "Summary description for {MOVE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOVE_CONTAINER
inherit
	OPERATION
create
	make

feature {NONE}
	make (cid_given : STRING ; pid_old_given : STRING ; pid_new_given : STRING; msg : STRING)
	do
		cid := cid_given
		pid_old := pid_old_given
		pid_new := pid_new_given
		item := msg
		error_string := ""
		create error.make
	end

feature
	cid: STRING
	pid_old : STRING
	pid_new : STRING
	error_string: STRING
	error : ERRORS

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
