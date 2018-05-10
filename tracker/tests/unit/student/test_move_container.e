note
	description: "Summary description for {TEST_MOVE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_MOVE_CONTAINER
inherit
	ES_TEST
create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent MC_error11)
			add_boolean_case (agent MC_error12)
			add_boolean_case (agent MC_error13)
			add_boolean_case (agent MC_error15)
			add_boolean_case (agent MC_error16)
			add_boolean_case (agent MC_error17)
			add_boolean_case (agent MC_NoError)
		end

feature

	MC_error11 : BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e11: this container will exceed phase capacity")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_E11_P1", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_E11_P2", "someOtherName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("MC_E11_C1", 1, create {VALUE}.make_from_int (1), "MC_E11_P1", "", 2, 1)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("MC_E11_C2", 1, create {VALUE}.make_from_int (1), "MC_E11_P2", "", 2, 1)
			operation.execute
			operation := create {MOVE_CONTAINER}.make ("MC_E11_C1", "MC_E11_P1", "MC_E11_P2", "", 3, 2)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e11)
		end
	MC_error12 : BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e12: this container will exceed phase safe radiation")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("1"), create {VALUE}.make_from_string ("2"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_E12_P1", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_E12_P2", "someOtherName", 2, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("MC_E12_C1", 1, create {VALUE}.make_from_int (1), "MC_E12_P1", "", 2, 1)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("MC_E12_C2", 1, create {VALUE}.make_from_int (1), "MC_E12_P2", "", 2, 1)
			operation.execute
			operation := create {MOVE_CONTAINER}.make ("MC_E12_C1", "MC_E12_P1", "MC_E12_P2", "", 3, 2)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e12)
		end
	MC_error13 : BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e13: phase does not expect this container material")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("1"), create {VALUE}.make_from_string ("2"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_E13_P1", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_E13_P2", "someOtherName", 2, << 2 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("MC_E13_C1", 1, create {VALUE}.make_from_int (1), "MC_E13_P1", "", 2, 1)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("MC_E13_C2", 1, create {VALUE}.make_from_int (1), "MC_E13_P2", "", 2, 1)
			operation.execute
			operation := create {MOVE_CONTAINER}.make ("MC_E13_C1", "MC_E13_P1", "MC_E13_P2", "", 3, 2)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e13)
		end
	MC_error15 : BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e15: this container identifier not in tracker")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("1"), create {VALUE}.make_from_string ("2"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_E15_P1", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_E15_P2", "someOtherName", 2, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("MC_E15_C1", 1, create {VALUE}.make_from_int (1), "MC_E15_P1", "", 2, 1)
			operation.execute
			operation := create {MOVE_CONTAINER}.make ("NOT_MC_E15_C1", "MC_E15_P1", "MC_E15_P2", "", 3, 2)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e15)
		end
	MC_error16 : BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e16: source and target phase identifier must be different")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("1"), create {VALUE}.make_from_string ("2"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_E16_P1", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("MC_E16_C1", 1, create {VALUE}.make_from_int (1), "MC_E16_P1", "", 2, 1)
			operation.execute
			operation := create {MOVE_CONTAINER}.make ("MC_E16_C1", "MC_E16_P1", "MC_E16_P1", "", 3, 2)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e16)
		end
	MC_error17 : BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e17: this container identifier is not in the source phase")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("1"), create {VALUE}.make_from_string ("2"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_E17_P1", "someName", 2, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_E17_P2", "someOtherName", 2, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("MC_E17_C1", 1, create {VALUE}.make_from_int (1), "MC_E17_P1", "", 2, 1)
			operation.execute
			operation := create {MOVE_CONTAINER}.make ("MC_E17_C1", "MC_E17_P2", "MC_E17_P1", "", 3, 2)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e17)
		end
	MC_NoError : BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("ok: sucessfully moved container to another phase")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("2"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_NoError_P1", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("MC_NoError_P2", "someOtherName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("MC_Container1", 1, create {VALUE}.make_from_int (1), "MC_NoError_P1", "", 2, 1)
			operation.execute
			operation := create {MOVE_CONTAINER}.make ("MC_Container1", "MC_NoError_P1", "MC_NoError_P2", "", 3, 2)
			operation.error_check
			Result := operation.error_string.is_equal (errors.ok)
		end
end
