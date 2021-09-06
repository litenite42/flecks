module util

pub struct Set<T> {
	mut:
	field []T
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