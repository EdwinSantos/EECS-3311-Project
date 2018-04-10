note
	description: "Summary description for {MOVE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOVE_CONTAINER
inherit
	OPERATION
create
	make

feature {NONE}
	make (cid_given : STRING ; pid_old_given : STRING ; pid_new_given : STRING; msg : STRING)
	do
		cid := cid_given
		pid_old := pid_old_given
		pid_new := pid_new_given
		item := msg
		error_string := ""
		create error.make
	end

feature
	cid: STRING
	pid_old : STRING
	pid_new : STRING
	error_string: STRING
	error : ERRORS
	ph1: PHASE
	ph2: PHASE
	cn : MATERIAL_CONTAINER


	is_container_in_tracker : BOOLEAN
		do
			Result := FALSE
		end

	are_pids_same: BOOLEAN
		do
			Result := pid_old ~ pid_new
		end
	does_phase_exist: BOOLEAN
		do
			Result := FALSE
			-- Check both pid's
		end
	does_new_phase_exceeds_capacity: BOOLEAN
		do
			Result := ph2.containers_in_phase + 1 > ph2.container_capacity
		end
	does_radiation_exceed_capacity : BOOLEAN
		do
			Result := ph2.currentRad + cn.radioac > tracker.max_phase_radiation
		end

	error_check
		do

			if does_phase_exist then
				error_string := error.e9
			elseif are_pids_same then
				error_string := error.e15
			elseif is_container_in_tracker then
				error_string := error.e16
			else
				if
					attached state.phases.item (pid_old) as ph1 and
					attached state.phases.item (pid_new) as ph2 and
					attached state.containers.item (cid) as cn
				then
					if does_new_phase_exceeds_capacity then
						error_string := error.e11
					elseif does_radiation_exceed_capacity then
						error_string := error.e12
					elseif not ph2.accepts_material(cn.mat) then
						error_string := error.e13
					elseif not cn.pid.is_equal(pid_old) then
						error_string := error.e17
					end
				end
				error_string := error.OK
			end
		end

	execute
		do
			cn.moveToPhase(pid_new)
			ph1.remove_material(cn.radioac)
			ph2.add_material(cn.radoiac)
		end

	undo
		do
			cn.moveToPhase(pid_old)
			ph2.remove_material(cn.radioac)
			ph1.add_material(cn.radoiac)
		end

	redo
		do
			execute
		end
end
