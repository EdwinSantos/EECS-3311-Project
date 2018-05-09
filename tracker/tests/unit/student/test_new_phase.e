note
	description: "Summary description for {TEST_NEW_PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_NEW_PHASE
inherit
	ES_TEST
create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case(agent error5)
			add_boolean_case(agent error6)
			add_boolean_case(agent error7)
			add_boolean_case(agent error8)
			add_boolean_case(agent noError)
		end
feature
	error5: BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
			first_error : STRING
		do
			create errors.make
			comment("e5: identifiers/names must start with A-Z, a-z or 0..9")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("~e5_phase1", "someName", 1, << 1 >>, "", 1, 0)
			operation.error_check
			first_error := operation.error_string
			operation := create {NEW_PHASE}.make ("123e5_phase2", "$$$", 1, << 1 >>, "", 1, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e5) and first_error.is_equal (errors.e5)
		end
	error6 : BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
		do
			create errors.make
			comment("e6: phase identifier already exists")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("4"), create {VALUE}.make_from_string ("2"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e6_phase1", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e6_phase1", "otherName", 1, << 1 >>, "", 1, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e6)
		end
	error7 : BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
		do
			create errors.make
			comment("e7: phase capacity must be a positive integer")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("4"), create {VALUE}.make_from_string ("2"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e7_phase", "SomeString", -1, << 1 >>, "", 1, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e7)
		end
	error8: BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
		do
			create errors.make
			comment("e8: there must be at least one expected material for this phase")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("4"), create {VALUE}.make_from_string ("2"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e8_phase", "SomeString", 1, << >>, "", 1, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e8)
		end
	noError : BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
		do
			create errors.make
			comment("ok: sucessfully created a new container")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("NP_noError_phase", "someName", 1, << 1 >>, "", 1, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.ok)
		end


end
