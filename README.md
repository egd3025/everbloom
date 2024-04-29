# Title: EverBloom

# Created by:

- Evan Berlin
- Jaden McIlhenny
- Elizabeth Daly
- Pine Gragg
- Jude Denton.



# Test Instructions

In the Godot editor install the GUT for Godot 4. 
  This is found in the AssetLib located at the top in the middle of the editor toolbar.
Create a test folder named Test Scripts - or whatever you want.
In the test scripts folder create test scripts that start with "test_"
Ensure that the beginning of each test script extends GutTest.
Then make a function that also starts with "test_"

Creating a test from here can vary wildly but some basics can be applied to most tests.

Ensure that you create variables that call into the test from a scene that you wish to test.
This can be anything from the scene or even the scene itself.
You can have multiple tests in a script.
assert and or simulate the parameters you wish to put into the functions.

Here is an example:

      extends GutTest
      var plant = preload("res://Plants/Plant.gd")
      
      func test_plant_instantiate():
      	var plant1 = plant.new()
      	#add_child_autofree(plant1)
      	assert_eq(0, plant1.stage, "Plant stage when created is 1")
      	
      	
      
      func test_plant_simulate():
      	var plant1 = plant.new()
      	simulate(plant1, 20, 400)
      	assert_called(plant1, 'on_timer_timeout')
      	
      	
      func test_doubler():
      	var doubled = double("res://Plants/Plant.gd").new()
      	var timeleft = doubled.getTimerLeft()
      	assert_eq(timeleft, 0, "Done")

From here all you need to do is run the scripts.
This is done by going to the GUT section of the editor.
  GUT is in the bottom middle of the editor toolbar.
On the third column of settings scroll until you see test directories.
Select the test scripts folder.
Now you should be able to select and run the test scripts inside that folder.  
You have the option to run all or one of the tests.  Selected tests will be set as current tests.
Hit run, and the test should run, the view may look oversized but you can exit and the test results should populate in the GUT middle column.




# Set Up Instructions.

- If this is your first time opening the project you will need to select the project repository in the Godot project list.
- On the project list view in the editor select import and then select the location of where the project is located.
  This often is in "Documents/GitHub/ProjectTeamName/EverBloom" or something similar.
  You can download or use git's location for a source.
- After that all you have to do is open the project and everything should populate.




