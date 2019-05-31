# MKS22X-FinalProject
A Processing-based circuit simulator

By: Leon

DEVLOG

Sunday 5/19:
Jude: This was the first day so I initialized all of the basic classes and added constructors and the structure of the simulator.


Monday 5/20:
Jude: I added different methods to resistor but branched off to focus on component.
Tejas: Wrote a function to display v-i relationships.

5/22/19
So before today, we haven't been updating this, we're sorry! Here's what's
been done so far: we have a basic element class (Jude) and a working function
class that would calculate v-i relationships (Tejas). Later we hope to get
cross-component absolute voltage calculations functional, and Tejas will start
work on a "component" that would act like a resistor, to test the class
structure


Thursday 5/23:
Jude: I worked heavily and almost finished resistor and voltSource, decided to eliminate the polarSource class and started working on some of the circuit class methods in order to calculate the voltage in the circuit.
Tejas: Reviewed and cleaned up Jude's code somewhat


Friday: 5/24:
Jude: I tried to implment the display functions for every sinle component, staring off as just colored wires, trying to have each wire be connected by two nodes hich the user will place down two nodes and have the component form inbetween.
Tejas: Began working out an algorithm to calculate voltages (the actual simulation bit). So far, it's not going well, but there's a framework at least.





Tuesday 5/28:
Jude: I worked on making a circuit out of some basic lines, but weirdly enough i encountered a ton of bugs.
Tejas: Tried a new version of the algorithm - there's an issue with Wheatstone bridges that we don't know how to fix.

Wedensday 5/29:
Jude: I fixed most of he bugs and worked with Tejas on fixing the class structure problems that we've been encountering so far, we decided to delete the node class and slely implement the wire class as a preserver of a common voltage. We also decided that each component would have a wire going in and out and that junctions would work by wire methods
Tejas: Tested the algorithm (still on paper), it works for simple circuits but we're not sure how well it holds up. Will try to streamline.


Thursday 5/30:
Jude: I implemted the more interactive button form of GUI
Tejas: Finally sucked up his pride and looked at Google. Found a StackExchange post on how matrices can be used to solve systems of KCL equations, will work to implement.

Friday 5/31:
Tejas: Wrote a getNode() method that returns a list of all connected wires with a shared voltage. This method should replace the Node class for the purpose of calculations - worst case scenario, we make it a data structure. Not sure yet.
