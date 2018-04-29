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
			etf_cmd_container.on_change.notify ([Current])

			if model.history.is_empty or not model.history.is_last then
				model.state.set_undo_redo(FALSE)
				model.state.state_msg_update (errors.e19)
			elseif model.history.on_item then
				model.state.set_undo_redo(TRUE)
				model.history.forth
				model.history.item.redo
				model.state.state_msg_update ("to " + model.get_i.out + ") " + model.history.item.item)
			end
    	end

end
