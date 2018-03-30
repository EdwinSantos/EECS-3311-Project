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
			create containers.make(1)
		end

feature
	tracker : TRACKER
	phases : HASH_TABLE[PHASE, STRING]
	containers : HASH_TABLE[MATERIAL_CONTAINER, STRING]

feature -- commands
	new_tracker (max_p, max_c : VALUE)
		do
			phases.wipe_out
			containers.wipe_out
			tracker.new_maximums(max_p, max_c)
		end

feature -- output
	out : STRING
		do
			create Result.make_from_string("")
			-- if error this next append outputs the error
			-- else output ok
			Result.append("ok" + "%N")
			-- if no error then output the following
			Result.append("  " +tracker.out)
			Result.append ("  phases: pid->name:capacity,count,radiation" + "%N")
			phases.start
			across phases as phase loop
				Result.append ("    ")
				Result.append (phase.item.out)
			end
			Result.append ("  containers: cid->pid->material,radioactivity"+"%N")
			containers.start
			across containers as container loop
				Result.append("    ")
				Result.append(container.item.out)
			end
		end

end
