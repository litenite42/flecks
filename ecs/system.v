module ecs
import util as u

pub struct System {
	mut:
	entities u.Set<Entity>
}

pub fn (mut s System) add(entity Entity) {
	s.entities.add(entity)
}

pub fn (mut s System) remove(entity Entity) bool {
	return s.entities.remove(entity)
}

pub fn (mut s System) iter() u.SetIterator<Entity> {
	return s.entities.iter<Entity>()
} 