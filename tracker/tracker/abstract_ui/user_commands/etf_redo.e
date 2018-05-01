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
			-- either redo or "there is nothing left to redo"
			if model.history.is_empty or model.history.is_last then
				model.state.set_undo_redo(FALSE)
				model.state.state_msg_update (errors.e20)
			elseif model.history.not_last then
				model.state.set_undo_redo(TRUE)
				model.history.forth
				model.history.item.redo
				--model.state.state_msg_update (model.history.item.item)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
