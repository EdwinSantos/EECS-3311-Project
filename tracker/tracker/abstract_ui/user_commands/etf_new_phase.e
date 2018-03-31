note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_PHASE
inherit
	ETF_NEW_PHASE_INTERFACE
		redefine new_phase end
create
	make
feature -- command
	new_phase(pid: STRING ; phase_name: STRING ; capacity: INTEGER_64 ; expected_materials: ARRAY[INTEGER_64])
		require else
			new_phase_precond(pid, phase_name, capacity, expected_materials)
    	local
    		new_phase_oper: NEW_PHASE
    		-- message_oper : MESSAGE
    	do
			-- perform some update on the model state
			model.default_update
			create new_phase_oper.make(pid,phase_name,capacity, expected_materials, model.state.get_state_msg)
			-- if valid
			model.history.extend_history(new_phase_oper)
			new_phase_oper.execute
			-- else
			-- new_phase_oper.error_check
			-- create message_oper.make(model.state.get_state_msg, new_phase_oper.get_error)
			-- model.history.extend_history(message_oper)
			-- message_oper.execute
			etf_cmd_container.on_change.notify ([Current])
    	end

end
