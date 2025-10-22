orig = getTitle();
n=roiManager("count");
if(n==0)
	exit("ROIs required");
	
colors = create_colors_array("glasbey");
//colors = newArray(4);
//colors[0]="FF0000";
//colors[1]="008000";
//colors[2]="0000FF";


k=0;
basePlot = "";
print(n);
for(i=0; i<n; i++){
	selectImage(orig);
	roiManager("select", i);
	run("Plot Z-axis Profile");
	if(i==0){
		basePlot = getTitle();
		k++;
		print(i);
		print(k);
	}
	else {
		print(i);
		print(k);
		thisPlot = getTitle();
		selectWindow(basePlot);
		Plot.addFromPlot(thisPlot, 0);
		styleString = colors[k] + "," + colors[k] + ",1.0,Connected Circles";		
		Plot.setStyle(i+1, styleString);		
		if(k==11)
			k=0;
		else 
			k++;
		close(thisPlot);
	}
}
	



function create_colors_array(lut) {
	currentBatchMode = is("Batch Mode");
	if(!currentBatchMode) setBatchMode(true);
	newImage("ramp", "8-bit ramp", 256, 10, 1);
	run(lut);
	getLut(reds, greens, blues);
	colors = newArray(255);
	
	for(i=0; i<255; i++) {
		color1 = IJ.pad(toHex(reds[i+1]),2);
		color2 = IJ.pad(toHex(greens[i+1]),2);
		color3 = IJ.pad(toHex(blues[i+1]),2);
		colors[i] = "#"+color1+color2+color3;
	}
	print(colors.length);
	close("ramp");
	setBatchMode(currentBatchMode);
	return colors;
}