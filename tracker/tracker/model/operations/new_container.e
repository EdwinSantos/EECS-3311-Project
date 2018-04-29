note
	description: "Summary description for {NEW_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_CONTAINER
inherit
	OPERATION
		redefine out end
create
	make

feature {NONE}

	make (cid_given: STRING; material_given: INTEGER_64; rad_given: VALUE; pid_given: STRING ; msg : STRING; st_id : INTEGER;)
	do
		cid := cid_given
		material := material_given
		rad := rad_given
		pid := pid_given
		state_id := st_id
		error_string := ""
		item := msg
		create errors.make
	end


feature
	cid : STRING
	pid : STRING
	material :INTEGER_64
	rad :VALUE

	errors : ERRORS

	is_invalid : BOOLEAN
		do
			Result := is_not_alphanumeric_start
			Result := Result or not does_pid_exist
			Result := Result or does_cid_exist
			Result := Result or is_container_rad_neg
			Result := Result or is_phase_capacity_exceeded
			Result := Result or is_max_phase_rad_exceeded
			Result := Result or not does_phase_expect_material
			Result := Result or is_container_rad_over_limit
		end

	is_not_alphanumeric_start : BOOLEAN
		do
			Result := not pid.at (1).is_alpha_numeric or not cid.at (1).is_alpha_numeric
		end

	does_pid_exist : BOOLEAN
		do
			Result := state.does_phase_exist(pid)
		end

	does_cid_exist : BOOLEAN
		do
			Result := across state.containers as current_container some current_container.item.cid ~ cid end
		end

	is_phase_capacity_exceeded : BOOLEAN
		do
			Result := state.get_phase_with_pid(pid).is_full
		end

	is_max_phase_rad_exceeded : BOOLEAN
		do
			Result := rad + state.get_phase_with_pid(pid).currentrad >= state.tracker.max_phase_radiation
		end

	does_phase_expect_material: BOOLEAN
		do
			if attached state.phases.at (pid) as ph_mat then
				if ph_mat.accepts_material (material) then
					Result := TRUE
				else
					Result := FALSE
				end
			else
				Result := FALSE
			end
		end

	is_container_rad_over_limit :BOOLEAN
		do
			Result := rad > state.tracker.max_container_radiation
		end

	is_container_rad_neg : BOOLEAN
		do
			Result := rad < 0.000
		end

	error_check
		do
			if is_not_alphanumeric_start then
				error_string := errors.E5
			elseif not does_pid_exist then
				error_string := errors.E9
			elseif does_cid_exist then
				error_string := errors.E10
			elseif is_phase_capacity_exceeded then
				error_string := errors.E11
			elseif is_max_phase_rad_exceeded then
				error_string := errors.E12
			elseif not does_phase_expect_material then
				error_string := errors.E13
			elseif is_container_rad_over_limit then
				error_string := errors.E14
			elseif is_container_rad_neg then
				error_string := errors.E18
			else
				error_string := errors.OK
			end
		end

	execute
		do
			state.state_msg_update(errors.OK)
			state.new_container(cid, material, rad, pid)
		end

	undo
		do
			state.remove_container (cid)
			state.state_msg_update (item)
			state.set_state_i(state_id)
		end

	redo
		do
			execute
			state.set_state_i(state_id)
		end

feature
	out: STRING
		do
			Result := item
		end
end
