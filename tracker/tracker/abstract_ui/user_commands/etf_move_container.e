note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE_CONTAINER
inherit
	ETF_MOVE_CONTAINER_INTERFACE
		redefine move_container end
create
	make
feature -- command
	move_container(cid: STRING ; pid1: STRING ; pid2: STRING)
		require else
			move_container_precond(cid, pid1, pid2)
		local
			move_container_oper: MOVE_CONTAINER
			message_oper: MESSAGE
    	do
			-- perform some update on the model state
			model.default_update
			model.state.set_undo_redo(FALSE)
			create move_container_oper.make(cid, pid1, pid2, model.state.get_state_msg, model.get_i)
			if not move_container_oper.is_invalid then
				model.history.extend_history (move_container_oper)
				move_container_oper.execute
			else
				move_container_oper.error_check
				create message_oper.make (model.state.get_state_msg, move_container_oper.get_error, model.get_i)
				model.history.extend_history (message_oper)
				message_oper.execute
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
