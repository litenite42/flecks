module managers
import util as u
import ecs

struct EntityManager {
	mut:
	available_entities u.Queue<ecs.Entity> 
	signatures []ecs.Signature = []ecs.Signature{len: int(ecs.max_entities), cap:int(ecs.max_entities) }
	living_entity_count i16
}

pub fn new_entity_manager() &EntityManager {
	mut e := &EntityManager{}

	e.available_entities = u.new_queue<ecs.Entity>(i16(ecs.max_entities))
	e.init()

	return e
}

pub fn (mut e EntityManager) init() {
	for i in 0..i16(ecs.max_entities) {
		e.available_entities.enqueue_m(ecs.Entity(i))
	}
}

pub fn (mut e EntityManager) create_entity() ?ecs.Entity {
	assert e.living_entity_count < ecs.max_entities

	id := e.available_entities.dequeue() or {
		return error('Available entities is empty')
	}

	e.living_entity_count++

	return id
}

pub fn (mut e EntityManager) destroy_entity(entity ecs.Entity) {
	assert entity < ecs.max_entities

	e.signatures[i16(entity)].clear_all()
	e.living_entity_count--
}

pub fn (mut e EntityManager) set_signature(entity ecs.Entity, signature ecs.Signature) {
	assert entity < ecs.max_entities

	e.signatures[i16(entity)] = signature
}

pub fn (e EntityManager) get_signatures(entity ecs.Entity) ecs.Signature {
	assert entity < ecs.max_entities

	return e.signatures[i16(entity)]
}