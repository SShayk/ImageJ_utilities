Dialog.create("Running average");
Dialog.addNumber("window length:", "5");
Dialog.addCheckbox("Keep Source Stack", true);
Dialog.show;
n = Dialog.getNumber();
keep = Dialog.getCheckbox;

// create kernel
str_1 = "1";
str_all = "";

for (k=1;k<=(n-1)/2;k+=1){
	str_1 = "0" + str_1 + "0";
}
for (k=1;k<=n;k+=1){
	str_all = str_all + str_1 + '\n';
}


// get original image
id1 = getImageID;
// set voxels in case scaling affects convolution
setVoxelSize(1, 1, 1, "pixel");
// reslice to perform convolution in z (t) axis
run("Reslice [/]...", "input=1 output=1 start=Top");
id2 = getImageID;

// close original image if desired
if (!keep) {selectImage(id1); close;}

// convolve with moving average kernel
selectImage(id2);
run("Convolve...", "text1=["+str_all+"] normalize stack");

// reslice back to original orientation
run("Reslice [/]...", "input=1 output=1 start=Top");
selectImage(id2);
close;


// need to upgrade: 
// currently assuming odd factor, add functionality for even window size
// should original voxel size and reset later
// rename output image (RA_[original name])