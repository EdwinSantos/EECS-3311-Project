note
	description: "Summary description for {PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PHASE

create
	make

feature
	pid: STRING
	phase_name : STRING
	capacity : INTEGER_64
	expected_materials: ARRAY[INTEGER_64]
	containers : HASH_TABLE[MATERIAL_CONTAINER, STRING]
	currentValue : INTEGER_64


feature {NONE}
	make (phase_id : STRING; phase_nm : STRING; cap : INTEGER_64 ; expected_mat : ARRAY[INTEGER_64])
		do
			pid := phase_id
			phase_name := phase_nm
			capacity := cap
			create	expected_materials.make_from_array (expected_mat)
			currentValue := 0
			create containers.make(1)
		end

end
