note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_TRACKER
inherit
	ETF_NEW_TRACKER_INTERFACE
		redefine new_tracker end
create
	make
feature -- command
	new_tracker(max_phase_radiation: VALUE ; max_container_radiation: VALUE)
    	local
    		new_tracker_oper : NEW_TRACKER
    		message_oper: MESSAGE
    	do
			-- perform some update on the model state
			model.default_update
			model.state.set_undo_redo(FALSE)
			create new_tracker_oper.make (max_phase_radiation, max_container_radiation, model.get_i, model.state.get_last_valid_i)

			if not new_tracker_oper.is_invalid then
				model.history.clear
				model.history.extend_history(new_tracker_oper)
				new_tracker_oper.execute
			else
				new_tracker_oper.error_check
				create message_oper.make(model.state.get_state_msg, new_tracker_oper.get_error,model.get_i, model.state.get_last_valid_i)
				model.history.extend_history (message_oper)
				message_oper.execute
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
