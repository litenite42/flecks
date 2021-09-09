module ecs
//import managers as mgrs
import bitfield as bf

pub struct Coordinator {
	mut:
	e_mgr &EntityManager = &EntityManager{}
	c_mgr &ComponentManager = &ComponentManager{}
	s_mgr &SystemManager = &SystemManager{}
}

pub fn (mut c Coordinator) create_entity() ?Entity {
	return c.e_mgr.create_entity()
}

pub fn (mut c Coordinator) destroy_entity(entity Entity) {
	c.e_mgr.destroy_entity(entity)
	c.c_mgr.entity_destroyed(entity)
	c.s_mgr.entity_destroyed(entity)
}

pub fn (mut c Coordinator) register_component<T>() {
	c.c_mgr.register_component<T>()
}

pub fn (mut c Coordinator) add_component<T>(entity Entity, component T) {
	c.c_mgr.add_component<T>(entity, component)

	signature := c.e_mgr.get_signature(entity)

	signature.set_bit(T.typ)

	c.e_mgr.set_signature(entity, signature)
	c.s_mgr.entity_signature_changed(entity, signature)
}

pub fn (mut c Coordinator) remove_component<T>(entity Entity) {
	c.c_mgr.remove_component<T>(entity)

	signature := c.e_mgr.get_signature(entity)

	signature.clear_bit(T.typ)

	c.e_mgr.set_signature(entity, signature)
	c.s_mgr.entity_signature_changed(entity, signature)
}

pub fn (c Coordinator) get_component<T>(entity Entity) ComponentType {
	return c.c_mgr.get_component<T>(entity)
}

pub fn (c Coordinator) get_component_type<T>() {
	return c.c_mgr.get_component_type<T>()
}

pub fn (mut c Coordinator) register_system<T>() &T {
	return c.s_mgr.register_system<T>()
}

pub fn (mut c Coordinator) set_system_signature(signature bf.BitField) {
	c.s_mgr.set_signature<T>(signature)
}