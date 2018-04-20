note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_CONTAINER
inherit
	ETF_NEW_CONTAINER_INTERFACE
		redefine new_container end
create
	make
feature -- command
	new_container(cid: STRING ; c: TUPLE[material: INTEGER_64; radioactivity: VALUE] ; pid: STRING)
		require else
			new_container_precond(cid, c, pid)
		local
			new_container_oper: NEW_CONTAINER
			message_oper :MESSAGE
    	do
			-- perform some update on the model state
			model.default_update
			create new_container_oper.make(cid, c.material, c.radioactivity, pid, model.state.get_state_msg, model.get_i)
			if not new_container_oper.is_invalid then
				model.history.extend_history (new_container_oper)
				new_container_oper.execute
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
