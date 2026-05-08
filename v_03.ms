function runExtrusion extrusionDepth isIllumachrome =
(
	if units.MetricType != #millimeters then --check if environment is set to input mm
		(
			print "not in mm"
			retryCancelBox "Scene is not set in mm, please hit cancel and set to mm (Customize > Unit Scale > Display Unit Scale > Millimeters), delete/re-import your vector path, then send the written command again."
		)
		
	--write verification that a Shape1 exists in the scene
		--for obj in rootScene where obj.name == "Shape1" do print "test"
	
	(
		outerShell = $Shape1 -- declare variable for original vector path object
		outerShell.pos = [0, 0, 0] -- set path at origin
		outerShell.wirecolor = white -- change to white
		rotateToFace = EulerAngles 90 0 0 -- creates rotation object so that shape faces User
		rotate outerShell rotateToFace -- rotates Shape per rotation object
		outerShell.steps = 20 -- set interpolation to smooth out curves
		updateShape(outerShell) -- updates path object
		-- path is set up for extrusion
		
		addDepth = Extrude() -- creates Extrude Modifier function called 'addDepth' 
			addDepth.amount = extrusionDepth -- sets initial extrusion value to the value set by the User
		-- create main Extrude modifier that will sit on every object
		
		addModifier outerShell (addDepth) -- applies Modifier to outerShell
		outerShell.pivot = outerShell.center -- sets pivot to center of object
		outerShell.pos = [0, 0, 0] -- sets object to origin
		
		local layers = 3 -- default total number of layers for regular is 6 total, which is 3 overall objects
		if isIllumachrome then (
			layers = 5 -- sets to 5 overall objects to create 10 layers for Illumachrome backed pieces
		)
		
		for i = 2 to layers do ( --loop starts at 2 because first extrusion already exists
			maxOps.cloneNodes outerShell cloneType:#copy newNodes:&nnl -- duplicates original outerShell
			layer = execute ("$'Shape00" + i as string +"") -- grabs shape duplicates iteratively by name
			layer.Extrude.amount = (layer.Extrude.amount - (0.6 * (i-1))) -- subtracts depth, multiplying amount subtracted iteratively
			layer.pivot = layer.center -- sets pivot to center of object
			layer.pos = [0, 0, 0] -- sets object to origin
		)
	)
)