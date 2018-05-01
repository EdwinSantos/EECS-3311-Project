note
	description: "Summary description for {NEW_TRACKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_TRACKER
inherit
	OPERATION
		redefine out end

create
	make

feature {NONE}
	make (max_ph, max_c : VALUE; st_id: INTEGER)
		do
			item := ""
			max_phase := max_ph
			max_cont := max_c
			error_string := ""
			state_id := st_id-1
			create errors.make
		end
feature -- attributes
	errors : ERRORS

feature -- queries
	max_phase : VALUE
	max_cont : VALUE

	is_invalid : BOOLEAN
	 do
	 	Result := is_already_in_use or is_max_phase_neg or is_container_neg or is_container_greater_phase
	 end

	is_already_in_use : BOOLEAN
		do
			if state.containers.count >= 1 then
				Result := TRUE
			else
				Result := FALSE
			end
		end

	is_max_phase_neg : BOOLEAN
		do
			Result := max_phase < 0.000
		end

	is_container_neg : BOOLEAN
		do
			Result := max_cont < 0.000
		end

	is_container_greater_phase : BOOLEAN
		do
			Result := max_cont > max_phase
		end

feature -- commands
	error_check
		do
			-- check here and change error_string
			-- to the relevant error msg

			if is_already_in_use then
			-- Condition TODO
			-- Tracker already in use
			-- Check if it has more than one container
				error_string := errors.E1
			elseif is_max_phase_neg then
			-- Phase Radiation is negative E2
				error_string := errors.E2
			elseif is_container_neg then
			-- Radiation is a negative value	
				error_string := errors.E3
			elseif is_container_greater_phase then
			-- Container cant have a higher max than the phase
				error_string := errors.E4
			else
			-- there were no errors
				error_string := errors.OK
			end

		end

	execute
		do
			state.state_msg_update(ERRORS.OK)
			state.new_tracker(max_phase, max_cont)
		end

	undo
		do
			-- nothing
		end

	redo
		do
			-- message op is in queue for this
		end

feature
	out: STRING
		do
			Result := item
		end
end
