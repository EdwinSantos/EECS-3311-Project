note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REDO
inherit
	ETF_REDO_INTERFACE
		redefine redo end
create
	make
feature -- command
	redo
		local
			errors :ERRORS
    	do
    		create errors.make
			-- perform some update on the model state
			model.default_update
			model.state.set_undo_redo(FALSE)
			if model.history.is_empty or model.history.is_last then
				model.state.set_undo_redo(FALSE)
				model.state.set_invalid_redo(TRUE)
				--model.state.set_state_i (model.state.get_last_valid_i)
			elseif model.history.not_last then
				model.state.set_undo_redo(TRUE)
				model.history.forth
				model.history.item.redo
				model.state.set_state_i(model.history.item.state_id)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
