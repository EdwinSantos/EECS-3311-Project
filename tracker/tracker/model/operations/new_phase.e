note
	description: "Summary description for {NEW_PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_PHASE
inherit
	OPERATION
		redefine
			out
		end
create
	make

feature {NONE}
	make (ph_id: STRING ; name: STRING ; cap: INTEGER_64 ; expec: ARRAY[INTEGER_64] ; msg: STRING; st_id : INTEGER)
		do
			pid := ph_id
			phase_name := name
			capacity := cap
			create expected_materials.make_from_array(expec)
			item := msg
			state_id := st_id
			error_string := ""
			create error.make
		end

feature -- queries
	pid:STRING
	phase_name:STRING
	capacity:INTEGER_64
	expected_materials : ARRAY[INTEGER_64]
	error : ERRORS

	is_invalid : BOOLEAN
		do
			Result := is_already_in_use or is_not_alphanumeric_start or does_phase_exist
			Result := Result or is_capacity_neg or is_expected_mat_neg
		end

	is_already_in_use : BOOLEAN
		do
			-- E1 check TODO
			Result := FALSE
		end

	is_not_alphanumeric_start : BOOLEAN
		do
			-- checking both in one
			Result := not pid.at (1).is_alpha_numeric or not phase_name.at (1).is_alpha_numeric
		end

	does_phase_exist : BOOLEAN
		do
			-- TODO E6
			Result := FALSE
		end

	is_capacity_neg : BOOLEAN
		do
			Result := capacity < 1
		end

	is_expected_mat_neg : BOOLEAN
		do
			Result := expected_materials.count < 1
		end

feature -- commands
	error_check
		do
			-- state. get tracker info
			-- state. get current phases
			-- run the error checking queries  (to be added)
			-- modify error_string if the queries find errors

			if is_already_in_use then
				-- Condition TODO
				-- Tracker already in use
				-- Check if it has more than one container
				error_string := error.E1
			elseif is_not_alphanumeric_start then
				-- pid or name starts with an odd character
				error_string := error.E5
			elseif does_phase_exist then
				-- phase id already exists
				-- condition TBD
				error_string := error.E6
			elseif is_capacity_neg then
				-- phase capacity must be positive	
				error_string := error.E7
			elseif is_expected_mat_neg then
				-- needs atleast one expected material
				error_string := error.E8
			else
				-- CREATE PHASE
				-- no errors found
				error_string := error.OK
			end
		end

	execute
		do
			state.state_msg_update(error.OK)
			state.new_phase(pid,phase_name,capacity,expected_materials)
		end

	undo
		do
			state.remove_phase(pid)
			state.state_msg_update(item)
		end

	redo
		do
			execute
		end

feature
	out: STRING
		do
			Result := item
		end
end
