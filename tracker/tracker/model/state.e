note
	description: "Summary description for {STATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STATE
inherit
	ANY
		redefine out end

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


feature
	out : STRING
		local
			l_show : STRING
		do
			create Result.make_from_string("  ")
			Result.append(tracker.out)
			Result.append ("  phases: pid->name:capacity,count,radiation" + "%N")
			phases.start
			across phases as phase loop
				Result.append ("    ")
			end
		end

end
