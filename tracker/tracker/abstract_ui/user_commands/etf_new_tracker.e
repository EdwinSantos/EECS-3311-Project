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
    		-- message_oper: MESSAGE
    	do
			-- perform some update on the model state
			model.default_update
			create new_tracker_oper.make (max_phase_radiation, max_container_radiation)

			-- if new_tracker_oper.is_valid then
			model.history.clear
			new_tracker_oper.execute
			-- else
				-- new_tracker_oper.error_check
				-- create message_oper.make(model.state.get_command_msg, new_tracker_oper.get_error)
				-- message_oper.execute
			-- end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
