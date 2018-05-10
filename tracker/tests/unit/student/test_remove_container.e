note
	description: "Summary description for {TEST_REMOVE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_REMOVE_CONTAINER

inherit
	ES_TEST
create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case(agent error15)
			add_boolean_case(agent noError)
		end
feature
	error15 : BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
		do
			create errors.make
			comment("e15: this container identifier not in tracker")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("1"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("RC_error15_P1", "someName", 1, << 1 >>, "", 0, 0)
			operation.execute
			operation := create {REMOVE_CONTAINER}.make ("NOT_RC_error15_C1", "", 0, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e15)
		end

	noError : BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
		do
			create errors.make
			comment("ok: sucessfully removed a container from a phase")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("1"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("RC_noError_P1", "someName", 1, << 1 >>, "", 0, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("RC_noError_C1", 1, create {VALUE}.make_from_int (1), "RC_noError_P1", "", 2, 1)
			operation.execute
			operation := create {REMOVE_CONTAINER}.make ("RC_noError_C1", "", 0, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.ok)
		end
end
