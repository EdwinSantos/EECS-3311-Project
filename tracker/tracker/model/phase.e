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
	container_capacity : INTEGER_64
	expected_materials: ARRAY[INTEGER_64]
	containers : ARRAY[STRING]
	currentRad : VALUE
	containers_in_phase : INTEGER

	remove_container(radioactivity:VALUE)
    	do
    		currentRad := currentRad - radioactivity
			containers_in_phase := containers_in_phase - 1
    	end
	accepts_material(material: INTEGER_64) : BOOLEAN
		do
			Result := expected_materials.has (material)
		end


feature {NONE}
	make (phase_id : STRING; phase_nm : STRING; cap : INTEGER_64 ; expected_mat : ARRAY[INTEGER_64])
		do
			pid := phase_id
			phase_name := phase_nm
			container_capacity := cap
			create	expected_materials.make_from_array (expected_mat)
			create currentRad.make_from_int (0)
			create containers.make_empty
		end


feature
	out: STRING
		do
			create Result.make_empty
			Result.append(pid + "->" + phase_name + ":" + container_capacity.out)
			Result.append("," + containers.count.out + "," + currentRad.out + ",{")
			Result.append (phase_materials_out)
		end

feature
	phase_materials_out : STRING
		local
			materialType : STRING
		do
			create Result.make_empty
			materialType := ""
			across expected_materials as material loop
				if material.item.as_integer_32 = 1 then
					materialType := "glass"
				elseif material.item.as_integer_32 = 2 then
					materialType := "metal"
				elseif material.item.as_integer_32 = 3 then
					materialType := "plastic"
				elseif material.item.as_integer_32 = 4 then
					materialType := "liquid"
				end

				if material.is_last then
					Result.append(materialType+ "}" + "%N")
				else
					Result.append(materialType+ ",")
				end

			end
		end

end
