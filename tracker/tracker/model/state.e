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

create
	make

feature {NONE}
	make
		do
			create tracker.make
			create phases.make (1)
			create containers.make(1)
			create errors.make
			state_message := "ok"

		end

feature
	tracker : TRACKER
	phases : HASH_TABLE[PHASE, STRING]
	containers : HASH_TABLE[MATERIAL_CONTAINER, STRING]
	errors : ERRORS
	state_message : STRING

feature -- queries
	get_state_msg : STRING
		do
			Result := state_message
		end

feature -- commands
	state_msg_update(msg : STRING)
		do
			state_message := msg
		end

	new_tracker (max_p, max_c : VALUE)
		do
			phases.wipe_out
			containers.wipe_out
			tracker.new_maximums(max_p, max_c)
		end

	new_phase (ph_id: STRING ; name: STRING ; cap: INTEGER_64 ; expec: ARRAY[INTEGER_64])
		local
			n_phase : PHASE
		do
			create n_phase.make (ph_id,name,cap,expec)
			phases.put (n_phase, ph_id)
		end

	remove_phase (ph_id: STRING)
		do
			phases.remove (ph_id)
		end


feature -- output
	out : STRING
		do
			create Result.make_from_string("")

			-- need check for undo/redo state
			-- Result.append("(to "+ the model.i corresponding to the undo/redo command +") ")

			-- this next append outputs the error or ok
			-- if no error output the rest of the state
			Result.append(state_message + "%N")
			if state_message.is_equal (errors.OK) then
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

end
