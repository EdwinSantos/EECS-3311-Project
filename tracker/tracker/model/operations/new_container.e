note
	description: "Summary description for {NEW_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_CONTAINER
inherit
	OPERATION
create
	make

feature {NONE}

	make (cid_given: STRING; material_given: INTEGER_64; rad_given: VALUE; pid_given: STRING ; msg : STRING; st_id : INTEGER;)
	do
		cid := cid_given

		material := material_given
		rad := rad_given
		pid := pid_given
		state_id := st_id
		error_string := ""
		item := msg
		create error.make
	end


feature
	cid : STRING
	pid : STRING
	material :INTEGER_64
	rad :VALUE

	error : ERRORS
	--new_message : STRING

	is_invalid : BOOLEAN
		do
			Result := is_not_alphanumeric_start or does_pid_exist or does_cid_exist or is_container_rad_positive
		end

	is_not_alphanumeric_start : BOOLEAN
		do
			Result := pid.at (1).is_alpha_numeric or cid.at (1).is_alpha_numeric
		end

	does_pid_exist : BOOLEAN
		do
			Result := FALSE
		end
	does_cid_exist : BOOLEAN
		do
			Result := FALSE
		end
	is_container_rad_positive : BOOLEAN
		do
			Result := rad < 0.000
		end
	error_check
		do
			if not is_not_alphanumeric_start then
				error_string := error.E5
			elseif does_pid_exist then
				error_string := error.E9
			elseif does_cid_exist then
				error_string := error.E10
			elseif is_container_rad_positive then
				error_string := error.E18
			else
				error_string := error.OK
			end
		end

	execute
		do
			state.state_msg_update(error.OK)
			state.new_container(cid, material, rad, pid)
		end

	undo
		do

		end

	redo
		do

		end
end
