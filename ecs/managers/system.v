module managers

import ecs
import bitfield as bf

pub struct SystemManager {
	signatures map[int]ecs.Signature
	systems map[int]ecs.System
}

pub fn new_system_manager() &SystemManager {
	return &SystemManager<T>{}
}

pub fn (mut s SystemManager) register_system<T>() &ecs.System {
	assert T.typ !in s.systems

	system := System{}
	s.systems[t.typ] = system
	return &system
}

pub fn (mut s SystemManager) set_signature<T>(signature ecs.Signature) {
	assert T.typ in s.systems

	s.signatures[T.typ].signatures = signature
}

pub fn (mut s SystemManager) entity_destroyed(entity ecs.Entity) {
	for _, mut system in s.systems {
		system.remove(entity)
	}
}

pub fn (mut s SystemManager) entity_signature_changed(entity ecs.Entity, signature ecs.Signature) {
	for typ, mut system in s.systems {
		sys_signature := s.signatures[typ]
		bit_field := bf.BitField(sys_signature) 
		if bf.bf_and(signature, sys_signature) == bit_field {
			system.entities.add(entity)
		} else {
			system.remove(entity)
		}
	}
}