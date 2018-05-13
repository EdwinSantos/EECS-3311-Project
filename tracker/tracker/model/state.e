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
			create phaselist.make_empty
			create containerlist.make_empty
			create errors.make
			state_message := "ok"
			undo_redo := FALSE
			invalid_undo := FALSE
			invalid_redo := FALSE
			state_i := 0
			last_valid_i := 0
			first_i := 0
			create zero_value.make_from_int (0)
		end

feature
	tracker : TRACKER
	phases : HASH_TABLE[PHASE, STRING]
	containers : HASH_TABLE[MATERIAL_CONTAINER, STRING]
	phaselist : ARRAY[STRING]
	containerlist : ARRAY[STRING]
	errors : ERRORS
	state_message : STRING
	model_access : ETF_MODEL_ACCESS
	undo_redo : BOOLEAN
	invalid_undo :BOOLEAN
	invalid_redo: BOOLEAN
	state_i : INTEGER
	last_valid_i : INTEGER
	first_i : INTEGER
	zero_value : VALUE


feature -- queries
	get_state_i : INTEGER
		do
			Result := state_i
		end

	get_last_valid_i : INTEGER
		do
			Result := last_valid_i
		end

	get_first_i : INTEGER -- 0 until newtracker is called
		do
			Result := first_i
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

	set_invalid_undo (setter :BOOLEAN)
		do
			invalid_undo := setter
		end

	set_invalid_redo (setter :BOOLEAN)
		do
			invalid_redo := setter
		end

	set_state_i(setter : INTEGER)
		do
			state_i := setter
		end

	set_last_valid_i(setter:INTEGER)
		do
			last_valid_i := setter
		end

	set_first_i (setter :INTEGER)
		do
			first_i := setter
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
			sort_phases
		end

	remove_phase (pid: STRING)
		do
			phases.remove (pid)
			sort_phases
		end

	new_container (cid: STRING; material: INTEGER_64; rad: VALUE; pid: STRING)
		local
			n_container : MATERIAL_CONTAINER
		do
			create n_container.make (cid, material, rad, pid)
			containers.put (n_container, cid)
			if attached phases.at (pid) as phase_at then
				phase_at.add_container(n_container.radioac)
			end
			sort_containers
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
			sort_containers
		end

	sort_phases
		local
			increment : INTEGER
			key : STRING
			key2 : STRING
			j_inc : INTEGER
		do
			phaselist.make_empty
			increment := 0
			across phases as sorting_phase loop
				phaselist.force (sorting_phase.item.pid, increment)
				increment := increment + 1
			end

			if increment = 2 then
				key := phaselist.at (0)
				key2 := phaselist.at (1)
				if key.is_greater (key2) then
					phaselist.make_empty
					phaselist.force(key2, 0)
					phaselist.force (key, 1)
				end
			elseif increment > 2 then

				across 1 |..| (phaselist.count-1) as sorting_i loop
					from
						j_inc := sorting_i.item - 1
						key := phaselist.at (sorting_i.item)
					until
						j_inc < 0 or not phaselist.at (j_inc).is_greater(key)
					loop
						phaselist.force( phaselist.at (j_inc),j_inc +1)
						j_inc := j_inc - 1
					end
					phaselist.force (key, j_inc + 1)
				end
			end
		end

	sort_containers
		local
			incrementc : INTEGER
			keyc : STRING
			keyc2 : STRING
			jc_inc : INTEGER
		do
			containerlist.make_empty
			incrementc := 0
			across containers as sorting_cn loop
				containerlist.force (sorting_cn.item.cid, incrementc)
				incrementc := incrementc + 1
			end
			if incrementc = 2 then
				keyc := containerlist.at (0)
				keyc2 := containerlist.at (1)
				if keyc.is_greater (keyc2) then
					containerlist.make_empty
					containerlist.force(keyc2, 0)
					containerlist.force (keyc, 1)
				end
			elseif incrementc > 2 then
				across 1 |..| (containerlist.count-1) as sorting_ic loop
					from
						jc_inc := sorting_ic.item - 1
						keyc := containerlist.at (sorting_ic.item)
					until
						jc_inc < 0 or not containerlist.at (jc_inc).is_greater(keyc)
					loop
						containerlist.force(containerlist.at (jc_inc),jc_inc +1)
						jc_inc := jc_inc - 1
					end
					containerlist.force (keyc, jc_inc + 1)
				end
			end
		end

feature -- output
	out : STRING
		do
			create Result.make_from_string("")
			-- this next append outputs the error or ok
			-- if no error output the rest of the state

			if invalid_undo then
				Result.append(errors.e19)
				set_state_i (last_valid_i)
				set_invalid_undo(FALSE)
			elseif invalid_redo then
				Result.append(errors.e20)
				set_invalid_redo(FALSE)
			else
				if undo_redo then
					--Result.append (last_valid_i.out + "  |  ")
					Result.append("(to "+ state_i.out +") ")
				end
				--Result.append (last_valid_i.out + "  |  ")
				Result.append(state_message)
				if state_message.is_equal (errors.OK) then
					Result.append("%N" + tracker.out)
					Result.append ("  phases: pid->name:capacity,count,radiation" + "%N")
					across phaselist as ph_string loop
						if attached phases.at (ph_string.item) as ph_output then
							Result.append ("    ")
							Result.append (ph_output.out)
						end
					end
					Result.append ("  containers: cid->pid->material,radioactivity")
					if containerlist.count >= 1 then
						Result.append("%N")
					end
					across containerlist as cn_string loop
						if attached containers.at (cn_string.item) as cn_output then
							if cn_string.is_last then
								Result.append("    ")
								Result.append(cn_output.out)
							else
								Result.append("    ")
								Result.append(cn_output.out + "%N")
							end

						end
					end
				end
			end


		end

invariant
	valid_phases: across phaselist as ph_string all attached phases.at (ph_string.item) as ph_out end
	valid_containers : across containerlist as cn_string all attached containers.at(cn_string.item) as cn_out end
	valid_tracker_ph_max: tracker.max_phase_radiation.is_greater_equal (zero_value)
	valid_tracker_cn_max: tracker.max_container_radiation.is_greater_equal (zero_value)
end
