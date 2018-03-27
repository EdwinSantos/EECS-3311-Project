note
	description: "Summary description for {TRACKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TRACKER
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

end
