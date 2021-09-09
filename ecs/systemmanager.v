module ecs

import bitfield as bf

pub struct SystemManager {
	mut:
	signatures map[int]bf.BitField
	systems map[int]System
}

pub fn new_system_manager() &SystemManager {
	return &SystemManager<T>{}
}

pub fn (mut s SystemManager) register_system<T>() &System {
	assert T.typ !in s.systems

	system := System{}
	s.systems[t.typ] = system
	return &system
}

pub fn (mut s SystemManager) set_signature<T>(signature bf.BitField) {
	assert T.typ in s.systems

	s.signatures[T.typ] = signature
}

pub fn (mut s SystemManager) entity_destroyed(entity Entity) {
	for _, mut system in s.systems {
		system.remove(entity)
	}
}

pub fn (mut s SystemManager) entity_signature_changed(entity Entity, signature bf.BitField) {
	for typ, mut system in s.systems {
		sys_signature := s.signatures[typ]
		bit_field := sys_signature
		if bf.bf_and(signature, sys_signature) == bit_field {
			system.add(entity)
		} else {
			system.remove(entity)
		}
	}
}