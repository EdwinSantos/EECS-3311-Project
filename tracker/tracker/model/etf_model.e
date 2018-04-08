note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create s.make_empty
			create state.make
			create history.make
			i := 0
		end

feature -- model attributes
	s : STRING
	i : INTEGER
	state : STATE
	history : HISTORY
feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	get_i : INTEGER
		do
			-- for passing the value of i to the command used
			-- (for undo/redo, "state x (to y)")
			-- TODO: add this functionality to the operations
			Result := i
		end

	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("state " + i.out + " ")
			Result.append (state.out)
		end

end




