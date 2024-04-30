extends GutTest

var main_script = null

# Test if the label updates correctly after the update interval.
func test_time_updates_correctly():
	# Set up the test conditions.
	main_script.time_index = 0  # start at the first time slot
	main_script.time_accumulator = main_script.update_interval

	# call the _process function manually.
	main_script._process(0)  # simulate frame update

	# Check if the label text updated to the next time.
	assert_eq(main_script.DayCycle_Label2.text, "11:00 AM", "Time did not update to 11:00 AM as expected.")
