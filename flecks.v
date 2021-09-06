module main

import ecs
import util as u
import ecs.managers as mgrs

fn main() {
	println('hello')

	emgr := mgrs.new_entity_manager()

	println(emgr)

	cmgr := mgrs.new_component_manager()
	println(cmgr)

	smgr := mgrs.new_system_manager()
	println(smgr)

	// mut set := u.Set<int>{}

	// mut added := set.add(4)
	// println(added)
	// added = set.add(3)
	// println(added)
	// added = set.add(3)
	// println(added)
	// println(set)
	// mut removed := set.remove(4)
	// println(set)
}
