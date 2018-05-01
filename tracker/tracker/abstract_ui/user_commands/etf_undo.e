note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
		redefine undo end
create
	make
feature -- command
	undo
		local
			errors : ERRORS
    	do
    		create errors.make
			-- perform some update on the model state
			model.default_update
			-- either undo or "there is nothing left to undo"


			if model.history.is_empty or model.history.is_first then
				model.state.set_undo_redo(FALSE)
				model.state.state_msg_update (errors.e19)
			elseif model.history.on_item then
				model.state.set_undo_redo(TRUE)
				model.history.item.undo
				model.state.state_msg_update (model.history.item.item)
				model.history.back
			end
		--	model.state.state_msg_update (model.history.on_item.out)
			etf_cmd_container.on_change.notify ([Current])
    	end

end
