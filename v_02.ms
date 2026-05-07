function runExtrusion extrusionDepth isIllumachrome =
(
	if units.MetricType != #millimeters then --check if environment is set to input mm
		(
			print "not in mm"
			retryCancelBox "Scene is not set in mm, please hit cancel and set to mm (Customize > Unit Scale > Display Unit Scale > Millimeters), delete/re-import your vector path, then send the written command again."
		)
	
	else
	(
		outerShell = $Shape1 -- declare variable for original vector path object
		outerShell.pos = [0, 0, 0] -- set path at origin
		outerShell.wirecolor = white -- change to white
		rotateToFace = EulerAngles 90 0 0 -- creates rotation object so that shape faces User
		rotate outerShell rotateToFace -- rotates Shape per rotation object
		outerShell.steps = 20 -- set interpolation to smooth out curves
		updateShape(outerShell) -- updates path object
		print "path updated"
		-- path is set up for extrusion
		
		addDepth = Extrude() -- creates Extrude Modifier function called 'addDepth' 
			addDepth.amount = extrusionDepth -- sets initial extrusion value to the value set by the User
		-- create main Extrude modifier that will sit on every object
		
		addModifier outerShell (addDepth) -- applies Modifier
		outerShell.pivot = outerShell.center -- sets pivot to center of object
		outerShell.pos = [0, 0, 0] -- sets object to origin
		
		if isIllumachrome == false then
		(
			maxOps.cloneNodes outerShell cloneType:#copy newNodes:&nnl -- duplicates object to create 2nd copy
			layer2 = $Shape002 -- renames object
			layer2.Extrude.amount = (layer2.Extrude.amount - 0.6) -- subtracts depth
			layer2.pivot = layer2.center -- sets pivot to center of object
			layer2.pos = [0, 0, 0] -- sets object to origin
			print "no Illumachrome layers 2 and 5 created"
			
			maxOps.cloneNodes layer2 cloneType:#copy newNodes:&nnl -- duplicates layer2 to create 3rd copy
			layer3 = $Shape003 -- renames object
			layer3.Extrude.amount = (layer3.Extrude.amount - 0.6) --subtracts depth
			layer3.pivot = layer3.center -- sets pivot to center of object
			layer3.pos = [0, 0, 0] -- sets object to origin
			print "no Illumachrome layers 3 and 4 created"
		)
		else
		(
						maxOps.cloneNodes outerShell cloneType:#copy newNodes:&nnl -- duplicates object to create 2nd copy
			layer2 = $Shape002 -- renames object
			layer2.Extrude.amount = (layer2.Extrude.amount - 0.6) -- subtracts depth
			layer2.pivot = layer2.center -- sets pivot to center of object
			layer2.pos = [0, 0, 0] -- sets object to origin
			print "Illumachrome layers 2 and 9 created"
			
			maxOps.cloneNodes layer2 cloneType:#copy newNodes:&nnl -- duplicates layer2 to create 3rd copy
			layer3 = $Shape003 -- renames object
			layer3.Extrude.amount = (layer3.Extrude.amount - 0.6) --subtracts depth
			layer3.pivot = layer3.center -- sets pivot to center of object
			layer3.pos = [0, 0, 0] -- sets object to origin
			print "Illumachrome layers 3 and 8 created"
			
			maxOps.cloneNodes layer3 cloneType:#copy newNodes:&nnl -- duplicates layer3 to create 4th copy
			layer4 = $Shape004 -- renames object
			layer4.Extrude.amount = (layer4.Extrude.amount - 0.6) --subtracts depth
			layer4.pivot = layer4.center -- sets pivot to center of object
			layer4.pos = [0, 0, 0] -- sets object to origin
			print "Illumachrome layers 4 and 7 created"
			
			maxOps.cloneNodes layer4 cloneType:#copy newNodes:&nnl -- duplicates layer4 to create 5th copy
			layer5 = $Shape005 -- renames object
			layer5.Extrude.amount = (layer5.Extrude.amount - 0.6) --subtracts depth
			layer5.pivot = layer5.center -- sets pivot to center of object
			layer5.pos = [0, 0, 0] -- sets object to origin
			print "Illumachrome layers 5 and 6 created"
		)
	)

)

--runExtrusion extrusionDepth isIllumachrome