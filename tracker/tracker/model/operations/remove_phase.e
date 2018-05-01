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
		state_id := st_id-1
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
			Result := does_tracker_exist or not does_phase_exist
		end

	does_tracker_exist : BOOLEAN
		do
			-- any containers even if the phase being removed
			-- doesnt have containers
			if state.containers.count >= 1 then
				Result := TRUE
			else
				Result := FALSE
			end
		end

	does_phase_exist: BOOLEAN
		do
			if attached state.phases.at (pid) as ph_exists then
				Result := TRUE
			else
				Result := FALSE
			end
		end

	error_check
		do
			if does_tracker_exist then
				error_string :=	error.e1
			elseif not does_phase_exist then
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
			state.new_phase (ph.pid, ph.phase_name,ph.container_capacity, ph.expected_materials)
			state.state_msg_update (item)
			state.set_state_i(state_id)
		end

	redo
		do
			execute
			state.set_state_i(state_id + 1)
		end

feature
	out: STRING
		do
			Result := item
		end

end
