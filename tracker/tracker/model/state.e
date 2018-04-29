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
			undo_redo := FALSE
			state_i := 0
		end

feature
	tracker : TRACKER
	phases : HASH_TABLE[PHASE, STRING]
	containers : HASH_TABLE[MATERIAL_CONTAINER, STRING]
	errors : ERRORS
	state_message : STRING
	model_access : ETF_MODEL_ACCESS
	undo_redo : BOOLEAN
	state_i : INTEGER

feature -- queries
	get_state_i : INTEGER
		do
			Result := state_i
		end

	get_state_msg : STRING
		do
			Result := state_message
		end

	does_phase_exist(pid : STRING) : BOOLEAN
		do
			Result := across phases as target_phase some target_phase.item.pid ~ pid  end
		end

	--NOTE: We already know pid exists so we shouldnt need to check that again when returning the phase. Might be safer to check again inb4 code not through enough
	get_phase_with_pid (pid : STRING) : PHASE
		local
			target_phase : detachable PHASE
		do
			across phases as current_phase
			loop
				if current_phase.item.pid ~ pid then
					target_phase := current_phase.item
				end
			end
			check attached target_phase as target then
				Result := target_phase
			end
		end

feature -- commands
	state_msg_update(msg : STRING)
		do
			state_message := msg
		end

	set_undo_redo (setter : BOOLEAN)
		do
			undo_redo := setter
		end

	set_state_i(setter : INTEGER)
		do
			state_i := setter
		end

	new_tracker (max_p, max_c : VALUE)
		do
			-- doesnt wipe phases
			-- there should be no containers for this
			-- to be called
			tracker.new_maximums(max_p, max_c)
			model_access.m.history.clear
		end

	new_phase (ph_id: STRING ; name: STRING ; cap: INTEGER_64 ; expec: ARRAY[INTEGER_64])
		local
			n_phase : PHASE
		do
			create n_phase.make (ph_id,name,cap,expec)
			phases.put (n_phase, ph_id)
		end

	remove_phase (pid: STRING)
		do
			phases.remove (pid)
		end

	new_container (cid: STRING; material: INTEGER_64; rad: VALUE; pid: STRING)
		local
			n_container : MATERIAL_CONTAINER
		do
			create n_container.make (cid, material, rad, pid)
			containers.put (n_container, pid)
			if attached phases.at (pid) as phase_at then
				phase_at.add_container(n_container.radioac)
			end
		end

	remove_container (cid: STRING)
		do
			-- NEEDS MORE TESTING
			if attached containers.item (cid) as cont then
				if attached phases.item (cont.pid) as target_phase then
					target_phase.remove_container(cont.radioac)
					containers.remove (cid)
				end
			end
		end

feature -- output
	out : STRING
		do
			create Result.make_from_string("")
			-- this next append outputs the error or ok
			-- if no error output the rest of the state
			if undo_redo then
				Result.append("(to "+ state_i.out +") ")
			end
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
