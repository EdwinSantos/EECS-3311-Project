note
	description: "Summary description for {TRACKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TRACKER
inherit
	ANY
		redefine out end

create
	make

feature
	max_phase_radiation : VALUE
	max_container_radiation : VALUE

feature {NONE}
	make_new (phase_max: VALUE; container_max: VALUE)
		do
			max_phase_radiation := phase_max
			max_container_radiation := container_max
		end

	make
		do
			create max_phase_radiation.make_from_int(0)
			create max_container_radiation.make_from_int(0)
		end

feature
	out : STRING
		do
			create Result.make_from_string("  ")
			Result.append("max_phase_radiation: " + max_phase_radiation.out + ", ")
			Result.append("max_container_radiation: " + max_container_radiation.out + "%N")
		end

end
