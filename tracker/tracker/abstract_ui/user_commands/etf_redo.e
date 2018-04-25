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
    	do
			-- perform some update on the model state
			model.default_update
			-- either redo or "there is nothing left to redo"
			etf_cmd_container.on_change.notify ([Current])

			-- from my lab 4
			--if model.state.did_o_win or model.state.did_x_win then
			--	model.state.command_msg_update ("there is a winner")
			--elseif model.state.is_tie then
			--	model.state.command_msg_update ("game ended in a tie")
			--elseif model.history.not_last then
			--	model.history.forth
			--	model.history.item.redo
			--end

    	end

end
