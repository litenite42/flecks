module util

pub struct Set<T> {
	mut:
	field []T
}

pub fn (s Set<T>) field() []T {
	return s.field
}

pub fn (mut s Set<T>) add<T>(value T) bool {
	mut result := false
	
	if value !in s.field {
		s.field << value
		result = true
	}

	return result
}

pub fn (mut s Set<T>) remove<T>(value T) bool {
	mut result := false

	if value in s.field {
		s.field = s.field.filter(it != value)
		result = true
	}

	return result
}

pub fn (s Set<T>) iter() SetIterator<T> {
	return SetIterator<T> {set : s.field()}
}

pub struct SetIterator<T> {
	set []T

	mut:
	ndx int
}

pub fn (mut s SetIterator<T>) next<T>() ?T {
	if s.ndx >= s.set.len {
		return error('')
	}
	defer {
		s.ndx++
	}
	return s.set[s.ndx]
}
