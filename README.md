# MKS22X-FinalProject  

###### By: Leon  

## Overview
This is a simple Processing-based circuit simulator. When run, directions will appear regarding how to construct a circuit, most importantly the hotkeys for each component. So far, this is the list.  

* V - Voltage source  
* A - Resistor  
* W - Wire  
* R - Rotate component in hand
* Backspace - Enter delete mode (delete any components clicked on)

Our project calculates voltages at each point in the circuit, as well as the current through any particular component. 

## Development Log

###### Sunday 5/19:  
**Jude:** This was the first day so I initialized all of the basic classes and added constructors and the structure of the simulator.  


###### Monday 5/20:  
**Jude:** I added different methods to resistor but branched off to focus on component.

**Tejas:** Wrote a function to display v-i relationships.  

###### Wednesday 5/22
**Jude:** We have a basic element class. This class has all the methods specified in the UML diagram and will be used to help us base the rest of our components as child classes.

**Tejas:** Wrote a function to display v-i relationships. Later we hope to get cross-component absolute voltage calculations functional, and I will start work on a "component" that would act like a resistor, to test the class structure.


###### Thursday 5/23:  
**Jude:** I worked heavily and almost finished resistor and voltSource, decided to eliminate the polarSource class and started working on some of the circuit class methods in order to calculate the voltage in the circuit.  

**Tejas:** Reviewed and cleaned up Jude's code somewhat  


###### Friday: 5/24:  
**Jude:** I tried to implment the display functions for every sinle component, staring off as just colored wires, trying to have each wire be connected by two nodes hich the user will place down two nodes and have the component form inbetween.  

**Tejas:** Began working out an algorithm to calculate voltages (the actual simulation bit). So far, it's not going well, but there's a framework at least.  

###### Tuesday 5/28:  
**Jude:** I worked on making a circuit out of some basic lines, but weirdly enough i encountered a ton of bugs.  

**Tejas:** Tried a new version of the algorithm - there's an issue with Wheatstone bridges that we don't know how to fix.  

###### Wednesday 5/29:  
**Jude:** I fixed most of he bugs and worked with Tejas on fixing the class structure problems that we've been encountering so far, we decided to delete the node class and slely implement the wire class as a preserver of a common voltage. We also decided that each component would have a wire going in and out and that junctions would work by wire methods.

**Tejas:** Tested the algorithm (still on paper), it works for simple circuits but we're not sure how well it holds up. Will try to streamline.  


###### Thursday 5/30:  
**Jude:** I implemted the more interactive button form of GUI.  

**Tejas:** Finally sucked up his pride and looked at Google. Found a StackExchange post on how matrices can be used to solve systems of KCL equations, will work to implement.  

###### Friday 5/31:  
**Jude:** I kep trying to make a drag and drop function for the resistors and voltsources and such but could only get a line, and on top of that the line keeps dragging all over the place. Working on fixing that last issue.

**Tejas:** Wrote a getNode() method that returns a list of all connected wires with a shared voltage. This method should replace the Node class for the purpose of calculations - worst case scenario, we make it a data structure. Not sure yet.  

###### Monday 6/3:   
**Jude:** Fixed the placing problems, moved on to iplementing rotate into thhe gui, which is tricky, but since we;re only doing snapons I figured the only valuable rotation will be 90 degrees.

**Tejas:** Starting to regret storing node data in ArrayLists, it's starting to become unwieldy but I'd like the code to work before I mess with efficiency. Worked on using getNode() to construct a matrix that can be used to isolate voltages through Gaussian elimination.  

###### Tuesday 6/4:  
**Jude:** Fixed rotate and now the GUI looks complete but I have to do some under the hood stuff in order to figure out how the compoenents will technically "connect", running into a lot of difficulty with the "in" and "out" coordinates of the componenets because current can technicaly flow either way.

**Tejas:** The construction of the matrix is complete (in theory) but very difficult to test without a working GUI, so I decided to help Jude with connecting components in the GUI so that they can be identified as working together. Having some trouble with that though. Hopefully we get an extension on this because I think finding a good calculation algorithm has been eating up most of our time.  

###### Wednesday 6/5:  
**Jude:** Stayed up all night doing the following: I created a class for junctions. This class has a few methods but I had to add it to every single type of compontent we have as well as adding it to the circuit. Junctions merge if they have the same x and y and look like little circles and I used this to connect the components which was the problem Tejas and I had in setting up the circuit. In addition, I made the resistance values and Voltage values customizable, and on top of that I added two boxes to the left, a button to run the circuit (when you click run it checks to see if the circuit is valid) and a result box where the results will be input.  

**Tejas:** Worked with Jude in the morning to figure out junction merging, which wasn't working - fixed in the case of Wires, will do the other elements soon. We still have a bug with placement of wires in certain orientations, so hopefully that gets resolved by tomorrow at the latest. To that point: last night's code broke the Wire's display, and that's mostly been dealt with now.  

###### Thursday 6/6:
**Jude:** Tried to implement reset button, but it didnt work, I also started to work on the delete function which developed some unusual behavior. I continued to try to improve the GUI and in top of that I treid to fix some issues with resistors being placed improperly.

**Tejas:** Spent basically the whole day fixing Jude's old code, working on connections between junctions and accounting for nodes with each element placement. Now that that's been resolved (as far as I can tell), I plan to finally fix the relations() method tomorrow so that we have a valid matrix to use. This is going to be the hardest part of the project, I think, so fingers crossed. Hallelujah.  



###### Saturday 6/8:
**Jude:** Added the start screen and added displays for each junction so that the user can see what the values are going to be at each point once the math gets fixed completely for each component. In addition, I fully implemented delete now, and it doesn't appear that there are any bugs with it. The reset button also seems to work.

**Tejas:** Updated the class structure; changes in how we do our math made a couple of things redundant. Messed with the GUI updates a bit, tweaked a few things, then worked on simplifying the generated matrix to reduced row-echelon form. The matrix generation was still faulty (compared components to a single junction rather than a node) but that's been resolved. Left off by updating junction voltages as per calculations - hopefully we'll be able to use those later.

###### Sunday 6/9:
**Jude:** Today I had to do a lot of bug squashing, once the calculatiosn came out it had turned out that I had made. For starters I had to fix the value displays as well as cleaned up all the buttons on the main screen that were now useless because of hotkeys the user could use. In addition delete didn't quite work with the node structure but it had to be fixed, so a new simpled delete was made (mainly by Tejas) and updateMatrix was set equal to true. I also implemented a try catch block at the end of the code.

**Tejas:** Started (and hopefully ended) current calculations for each component. Worked on some value update glitches, messed with the value displays (I think I'll just leave that sort of thing to Jude. I'm not good at it). This project was a lot harder than expected, but fingers crossed, by the end of the night we'll have something presentable.  
UPDATE - found a few major bugs, and killed those. Here they are:  
* Deleting wires didn't update circuit values
* Multiple values would display at once due to overlapping "hitboxes"
* Values displayed in the wrong part of the box 
