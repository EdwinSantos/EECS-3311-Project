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

	does_tracker_exist : BOOLEAN
		do
			Result := FALSE
		end

	does_tracker_contain_phase: BOOLEAN
		do
			Result := FALSE
		end

	error_check
		do
			if does_tracker_exist then
				error_string :=	error.e1
			elseif does_tracker_contain_phase then
				error_string := error.e9
			else
				error_string := error.OK
			end
		end

	execute
		do
			state.state_msg_update(error.OK)
			state.remove_phase(pid)
		end

	undo
		do

		end

	redo
		do

		end

end
