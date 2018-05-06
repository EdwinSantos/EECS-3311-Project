note
	description: "Summary description for {MOVE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOVE_CONTAINER
inherit
	OPERATION
		redefine out end

create
	make

feature {NONE}
	make (cid_given : STRING ; pid_old_given : STRING ; pid_new_given : STRING; msg : STRING ; st_id : INTEGER; val_id : INTEGER)
	do
		cid := cid_given
		pid_old := pid_old_given
		pid_new := pid_new_given
		item := msg
		state_id := st_id
		last_valid_id := val_id
		error_string := ""
		fillernum := -1
		create filler2.make_from_int (-1)
		create errors.make
		if attached state.containers.at(cid_given) as cnatt then
			create cn.make(cnatt.cid, [cnatt.mat,cnatt.radioac], cnatt.pid)
		else
			create cn.make ("-1", [fillernum.to_integer_64, filler2], "-1")
			-- TODO fix this or create some kind of void comparison
		end
	end

feature
	cid: STRING
	pid_old : STRING
	pid_new : STRING
	errors : ERRORS
	-- "filler" objects with illegal values if the cid/pids given don't exist
	fillernum: INTEGER
	filler2 : VALUE
	cn : MATERIAL_CONTAINER

	is_invalid : BOOLEAN
		do
			Result := not is_container_in_tracker
			Result := Result or are_pids_same
			Result := Result or not does_phase_exist
			Result := Result or does_new_phase_exceeds_capacity
			Result := Result or does_radiation_exceed_capacity
			Result := Result or not new_phase_accepts_mat
			Result := Result or not is_container_in_source
		end

	does_phase_exist: BOOLEAN
		do
			Result := state.does_phase_exist(pid_old) AND state.does_phase_exist(pid_new)
		end

	is_container_in_tracker : BOOLEAN
		do
			Result := state.containers.has (cid)
		end

	are_pids_same: BOOLEAN
		do
			Result := pid_old ~ pid_new
		end

	does_new_phase_exceeds_capacity: BOOLEAN
		do
			Result := state.get_phase_with_pid (pid_new).is_full
		end

	does_radiation_exceed_capacity : BOOLEAN
		do
			Result := (state.get_phase_with_pid (pid_new).currentrad + cn.radioac) > state.tracker.max_phase_radiation
		end

	new_phase_accepts_mat : BOOLEAN
		do
			Result := state.get_phase_with_pid (pid_new).accepts_material(cn.mat)
		end

	is_container_in_source : BOOLEAN
		do
			Result := cn.pid.is_equal(pid_old)
		end

	error_check
		do
			if not is_container_in_tracker then
				error_string := errors.e15
			elseif are_pids_same then
				error_string := errors.e16
			elseif not does_phase_exist then
				error_string := errors.e9
			elseif not is_container_in_source then
				error_string := errors.e17
			elseif not new_phase_accepts_mat then
				error_string := errors.e13
			elseif does_new_phase_exceeds_capacity then
				error_string := errors.e11
			elseif  does_radiation_exceed_capacity then
				error_string := errors.e12
			else
				error_string := errors.OK
			end
		end

	execute
		do
			cn.moveToPhase(pid_new)
			state.remove_container (cid)
			state.state_msg_update(errors.OK)
			state.new_container (cid, cn.mat,cn.radioac, cn.pid)
			state.set_last_valid_i (state_id)
		end

	undo
		do
			cn.moveToPhase(pid_old)
			state.remove_container (cid)
			state.state_msg_update (item)
			state.new_container (cid, cn.mat,cn.radioac, cn.pid)
			state.set_state_i(last_valid_id)
		end

	redo
		do
			execute
		end

feature
	out: STRING
		do
			result := item
		end
end
