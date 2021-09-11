module main

import ecs
import util as u
import bitfield as bf
//import ecs.managers as mgrs

struct Vec3d {
	mut:
	x f32
	y f32
	z f32
}

enum Operation  {
	plus times minus divide
}

fn (mut v Vec3d) apply_scalar_operation(op Operation, val f32) {
	match op {
		.times {
			v.x = v.x * val
			v.y = v.y * val
			v.z = v.z * val
		} else {}
	}
}

fn (a Vec3d) + (b Vec3d) Vec3d {
	return Vec3d{a.x+b.x, a.y + b.y, a.z + b.z}
}

struct Gravity {
	mut:
	force Vec3d
}

struct RigidBody {
	mut:
	velocity Vec3d
	acceleration Vec3d
}

struct Transform {
	mut:
	position Vec3d
	rotation Vec3d
	scale Vec3d
}

struct PhysicsSystem {
	ecs.System
}

fn (mut p PhysicsSystem) update(dt f32, mut coord ecs.Coordinator) {
	//mut x := p.entities//coord.get_system_entities()
	//for i := 0; i < p.entities.iter().length(); i++ {
		mut iterator := p.iter()
		for x in iterator {
		mut entity := x

		mut rigid_body := coord.c_mgr.get_component<RigidBody>(entity) or {
			return 
		}
		mut transform := coord.c_mgr.get_component<Transform>(entity) or {
			return
		}
		mut gravity := coord.c_mgr.get_component<Gravity>(entity) or {
			return
		}

		rigid_body.velocity.apply_scalar_operation(.times, dt)
		gravity.force.apply_scalar_operation(.times, dt)
		
		transform.position += rigid_body.velocity
		rigid_body.velocity += gravity.force
	}
}

fn main() {
	println('hello')

	mut coord := ecs.Coordinator{}
	dump(coord)

	coord.register_component<Gravity>()
	coord.register_component<RigidBody>()
	coord.register_component<Transform>()

	mut physics := coord.register_system<PhysicsSystem>()

	mut signature := bf.new(ecs.max_components)
	signature.set_bit(coord.get_component_type<Gravity>())
	signature.set_bit(coord.get_component_type<RigidBody>())
	signature.set_bit(coord.get_component_type<Transform>())
}
