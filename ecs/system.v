module ecs
import util as u

pub struct System {
	mut:
	entities u.Set<Entity>
}

pub fn (mut s System) remove(entity Entity) bool {
	return s.entities.remove(entity)
}