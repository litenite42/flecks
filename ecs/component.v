module ecs

pub struct ComponentManager{
	mut:
	component_types map[string]ComponentType
	component_arrays map[string]IComponentContainer
	next_component_type ComponentType
}

pub fn new_component_manager() &ComponentManager {
	return &ComponentManager{}
}

pub fn (mut c ComponentManager) register_component<T>() {
	assert T.name !in c.component_types

	c.component_types[T.name] = c.next_component_type
	c.component_arrays[T.name] = ComponentArray<T>{}
	c.next_component_type++
}

pub fn (c ComponentManager) get_component_type<T>() ComponentType {
	assert T.name !in c.component_types

	return c.component_types[T.name]
}

pub fn (mut c ComponentManager) add_component<T>(entity Entity, component T) {
	c.get_component_array<T>().insert(entity, component)
}

pub fn (mut c ComponentManager) remove_component<T>(entity Entity) {
	c.get_component_array<T>().remove(entity)
}

pub fn (c ComponentManager) get_component<T>(entity Entity) ?T {
	component := c.get_component_array<T>.get(entity) ?
	return component
}

pub fn (mut c ComponentManager) entity_destroyed(entity Entity) {
	for _, mut component in c.component_arrays {
		component.entity_destroyed(entity)
	} 
}

fn (c ComponentManager) get_component_array<T>() {
	assert T.name in c.component_types

	return c.component_arrays<T>[T.name]
}