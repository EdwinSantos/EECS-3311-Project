note
	description: "Summary description for {REMOVE_PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REMOVE_PHASE
inherit
	OPERATION
		redefine out end

create
	make

feature {NONE}
	make (pid_given: STRING; msg: STRING; st_id : INTEGER)
	do
		pid := pid_given
		item := msg
		state_id := st_id
		fillernum := -1
	 	create fillerarr.make_empty
		create error.make
		error_string := ""
		if attached state.phases.at(pid_given) as phat then
			create ph.make(phat.pid,phat.phase_name,phat.container_capacity,phat.expected_materials)
		else
			create ph.make("-1","-1",fillernum.to_integer_64,fillerarr)
		end
	end

feature
	error : ERRORS
	pid : STRING
	fillernum :INTEGER
	fillerarr : ARRAY[INTEGER_64]
	ph : PHASE

	is_invalid : BOOLEAN
		do
			Result := does_tracker_exist or does_tracker_contain_phase
		end

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

feature
	out: STRING
		do
			Result := item
		end

end
