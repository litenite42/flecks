module main

import ecs
import util as u
import ecs.managers as mgrs

fn main() {
	println('hello')

	emgr := mgrs.new_entity_manager()

	println(emgr)

}
