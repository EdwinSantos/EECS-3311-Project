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
    	do
			-- perform some update on the model state
			model.default_update
			-- either undo or "there is nothing left to undo"
			etf_cmd_container.on_change.notify ([Current])

			-- from my lab 4 
			--if model.state.did_o_win or model.state.did_x_win then
			--	model.state.command_msg_update ("there is a winner")
			--elseif model.state.is_tie then
			--	model.state.command_msg_update ("game ended in a tie")
			--elseif model.history.is_empty and model.history.is_first then
			--	model.state.command_msg_update("ok")
			--elseif model.history.on_item then
			--	model.history.item.undo
			--	model.state.command_msg_update (model.history.item.item)
			--	model.history.back
			--end
    	end

end
