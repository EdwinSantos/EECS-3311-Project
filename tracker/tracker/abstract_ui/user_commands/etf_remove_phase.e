note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REMOVE_PHASE
inherit
	ETF_REMOVE_PHASE_INTERFACE
		redefine remove_phase end
create
	make
feature -- command
	remove_phase(pid: STRING)
		require else
			remove_phase_precond(pid)
		local
			remove_ph_oper : REMOVE_PHASE
			message_oper : MESSAGE
    	do
			-- perform some update on the model state
			model.default_update
			model.state.set_undo_redo(FALSE)
			create remove_ph_oper.make(pid , model.state.get_state_msg,model.get_i)
			if not remove_ph_oper.is_invalid then
				model.history.extend_history (remove_ph_oper)
				remove_ph_oper.execute
			else
				remove_ph_oper.error_check
				create message_oper.make (model.state.get_state_msg,remove_ph_oper.get_error, model.get_i)
				message_oper.execute
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
