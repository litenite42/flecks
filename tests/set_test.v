import util as u

fn test_main() {
	mut set := u.Set<int>{}

	mut added := set.add(4)
	println(added)
	added = set.add(3)
	println(added)
	added = set.add(3)
	println(added)


}