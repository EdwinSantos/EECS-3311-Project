note
	description: "Summary description for {STATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STATE

-- Hold tracker for reference
-- Should the tracker hold a phase hashtable
-- ''  phase hashtable hold the container hashtable?
create
	make

feature {NONE}
	make
		do
			create tracker.make

			create phases.make (1)
		end

feature
	tracker : TRACKER
	phases : HASH_TABLE[PHASE, STRING]

end
