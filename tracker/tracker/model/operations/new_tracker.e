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
	make (max_ph, max_c : VALUE)
		do
			item := ""
			max_phase := max_ph
			max_cont := max_c
			error_string := ""
		end
feature -- attributes
	errors : ERRORS

feature -- queries
	max_phase : VALUE
	max_cont : VALUE

feature -- commands
	error_check
		do
			-- check here and change error_string
			-- to the relevant error msg

			if true then
			-- Condition TBD
			-- Tracker already in use
			-- Check if it has more than one container
				error_string := errors.E1
			elseif max_phase < 0.000 then
			-- Phase Radiation is negative E2
				error_string := errors.E2
			elseif max_cont < 0.000 then
			-- Radiation is a negative value	
				error_string := errors.E3
			elseif max_cont > max.phase then
			-- Container cant have a higher max than the phase
				error_string := errors.E4
			else
			-- there were no errors
				error_string := errors.OK
			end

		end

	execute
		do
			--state.command_msg_update(ERRORS.OK)
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
