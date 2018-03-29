note
	description: "Summary description for {PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PHASE
inherit
	ANY
		redefine out end

create
	make

feature
	pid: STRING
	phase_name : STRING
	capacity : INTEGER_64
	expected_materials: ARRAY[STRING]
	containers : HASH_TABLE[MATERIAL_CONTAINER, STRING]
	currentValue : VALUE
	count : INTEGER_64


feature {NONE}
	make (phase_id : STRING; phase_nm : STRING; cap : INTEGER_64 ; expected_mat : ARRAY[STRING])
		do
			pid := phase_id
			phase_name := phase_nm
			capacity := cap
			create	expected_materials.make_from_array (expected_mat)
			create currentValue.make_from_int (0)
			count := 0
			create containers.make(0)
		end


feature
	out: STRING
		do
			create Result.make_empty
			Result.append(pid + "->" + phase_name + ":" + capacity.out)
			Result.append("," + count.out + "," + currentValue.out + ",{")
			across expected_materials as material loop
				if material.is_last then
					Result.append(material.item+ "}" + "%N")
				else
					Result.append(material.item+ ",")
				end

			end
		end

end
