module ecs
import util as u
//import ecs
import bitfield as bf

struct EntityManager {
	mut:
	available_entities u.Queue<Entity> 
	signatures []bf.BitField = []bf.BitField{len: int(max_entities), cap:int(max_entities) }
	living_entity_count i16
}

pub fn new_entity_manager() &EntityManager {
	mut e := &EntityManager{}

	e.available_entities = u.new_queue<Entity>(i16(max_entities))
	e.init()

	return e
}

pub fn (mut e EntityManager) init() {
	for i in 0..i16(max_entities) {
		e.available_entities.enqueue_m(Entity(i))
	}
}

pub fn (mut e EntityManager) create_entity() ?Entity {
	assert e.living_entity_count < max_entities

	id := e.available_entities.dequeue() or {
		return error('Available entities is empty')
	}

	e.living_entity_count++

	return id
}

pub fn (mut e EntityManager) destroy_entity(entity Entity) {
	assert entity < max_entities

	e.signatures[i16(entity)].clear_all()
	e.living_entity_count--
}

pub fn (mut e EntityManager) set_signature(entity Entity, signature bf.BitField) {
	assert entity < max_entities

	e.signatures[i16(entity)] = signature
}

pub fn (e EntityManager) get_signature(entity Entity) bf.BitField {
	assert entity < max_entities

	return e.signatures[i16(entity)]
}