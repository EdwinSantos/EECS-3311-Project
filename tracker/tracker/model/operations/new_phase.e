note
	description: "Summary description for {NEW_PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_PHASE
inherit
	OPERATION
		redefine
			out
		end
create
	make

feature {NONE}
	make (ph_id: STRING ; name: STRING ; cap: INTEGER_64 ; expec: ARRAY[INTEGER_64]; msg : STRING)
		do
			pid := ph_id
			phase_name := name
			capacity := cap
			create expected_materials.make_from_array(expec)
			item := msg
			error_string := ""
		end

feature
	pid:STRING
	phase_name:STRING
	capacity:INTEGER_64
	expected_materials :ARRAY[INTEGER_64]

	error_check
		do
			-- state. get tracker info
			-- state. get current phases
			-- run the error checking queries  (to be added)
			-- modify error_string if the queries find errors
		end

	execute
		do
			state.state_msg_update("ok")
			state.new_phase(pid,phase_name,capacity,expected_materials)
		end

	undo
		do

		end

	redo
		do

		end

feature
	out: STRING
		do
			Result := item
		end
end
