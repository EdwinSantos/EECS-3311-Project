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
	make (command_name, msg: STRING; st_id :INTEGER)
	do
		item := command_name
		new_message := msg
		error_string := ""
		state_id := st_id-1
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

		end

	undo
		do
			state.state_msg_update(item)
			state.set_state_i(state_id)
		end

	redo
		do
			execute
			state.set_state_i(state_id)
		end

end
