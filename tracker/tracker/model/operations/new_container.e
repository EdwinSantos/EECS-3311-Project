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

	make (cid_given: STRING; cont_given: TUPLE[material_given: INTEGER_64; rad_given: VALUE]; pid_given: STRING ; st_id : INTEGER)
	do
		cid.make_from_string(cid_given)
		container.material = cont_given.material_given
		container.rad = cont_given.rad_given
		pid:= pid_given
		state_id := st_id
		error_string := ""

		create error.make
	end


feature
	cid : STRING
	pid : STRING
	container : TUPLE[material :INTEGER_64; rad :VALUE]
	error : ERRORS
	new_message : STRING

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
			Result := container.rad < 0.000
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
			state.new_container(cid, container, pid)
		end

	undo
		do

		end

	redo
		do

		end
end
