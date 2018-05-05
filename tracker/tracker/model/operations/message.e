note
	description: "Summary description for {MESSAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE
inherit
	OPERATION
create
	make

feature {NONE}
	make (command_name, msg: STRING; st_id :INTEGER; val_id : INTEGER)
	do
		item := command_name
		new_message := msg
		error_string := ""
		state_id := st_id
		last_valid_id := val_id
	end

feature
	new_message: STRING

	error_check
		do
			-- nothing in message
		end

	execute
		do
			state.state_msg_update(new_message)
			state.set_last_valid_i (state_id)

		end

	undo
		do
			state.state_msg_update(item)
			state.set_state_i(last_valid_id)
		end

	redo
		do
			execute
		end

end
