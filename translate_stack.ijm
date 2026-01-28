// translates each frame of a stack, according to a csv file with X and Y columns

// currently assumes the 1st frame corresponds to the 1st translation
// currently does not open a new window/rename

ID = getImageID();

Dialog.create("translate current stack");

Dialog.addFile("Drag translation CSV here","");
Dialog.show();

Table.open(Dialog.getString());

X = Table.getColumn("x");
Y = Table.getColumn("y");
for (i = 0; i < nSlices; i++) {
	setSlice(i+1);
	
	run("Translate...", "x="+ X[i] +" y="+ Y[i] +" interpolation=None slice");
}
