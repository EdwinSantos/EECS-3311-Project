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
	make (ph_id: STRING ; name: STRING ; cap: INTEGER_64 ; expec: ARRAY[INTEGER_64]; msg : STRING)
		do
			pid := ph_id
			phase_name := name
			capacity := cap
			create expected_materials.make_from_array(expec)
			item := msg
			error_string := ""
		end

feature
	pid:STRING
	phase_name:STRING
	capacity:INTEGER_64
	expected_materials :ARRAY[INTEGER_64]
	errors : ERRORS

	error_check
		do
			-- state. get tracker info
			-- state. get current phases
			-- run the error checking queries  (to be added)
			-- modify error_string if the queries find errors

			if FALSE then
			-- Condition TBD
			-- Tracker already in use
			-- Check if it has more than one container
				error_string := errors.E1
			elseif pid.at (1).is_alpha_numeric then
			-- name starts with an odd character
				error_string := errors.E5
			elseif phase_name.at (1).is_alpha_numeric then
			-- name starts with an odd character
				error_strign := errors.E5
			elseif FALSE then
			-- phase id already exists
			-- condition TBD
				error_string := errors.E6
			elseif capacity < 1 then
			-- phase capacity must be positive	
				error_sting := errors.E7
			elseif expected_materials.count < 1 then
			-- needs atleast one expected material
				error_string := errors.E8
			else
			-- CREATE PHASE
			-- no errors found
				error_string := errors.OK
			end
		end

	execute
		do
			state.state_msg_update("ok")
			state.new_phase(pid,phase_name,capacity,expected_materials)
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
