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

feature -- queries
	max_phase : VALUE
	max_cont : VALUE

feature -- commands
	error_check
		do
			-- check here and change error_string
			-- to the relevant error msg
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
