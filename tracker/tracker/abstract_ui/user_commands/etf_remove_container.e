note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REMOVE_CONTAINER
inherit
	ETF_REMOVE_CONTAINER_INTERFACE
		redefine remove_container end
create
	make
feature -- command
	remove_container(cid: STRING)
		require else
			remove_container_precond(cid)
    	local
    		remove_cn_oper:  REMOVE_CONTAINER
    		message_oper : MESSAGE
    	do
			-- perform some update on the model state
			model.default_update
			model.state.set_undo_redo(FALSE)
			create remove_cn_oper.make(cid , model.state.get_state_msg,model.get_i, model.state.get_last_valid_i)
			if not remove_cn_oper.is_invalid then
				model.history.extend_history (remove_cn_oper)
				remove_cn_oper.execute
			else
				remove_cn_oper.error_check
				create message_oper.make (model.state.get_state_msg,remove_cn_oper.get_error, model.get_i, model.state.get_last_valid_i)
				model.history.extend_history (message_oper)
				message_oper.execute
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
