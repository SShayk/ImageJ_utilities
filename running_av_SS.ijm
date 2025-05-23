Dialog.create("Running average");
Dialog.addNumber("window length:", "5");
Dialog.addCheckbox("Keep Source Stack", true);
Dialog.show;
n = Dialog.getNumber();
keep = Dialog.getCheckbox;

// create kernel
str_1 = "1";
str_all = "";

for (k=1;k<=Math.ceil((n-1)/2);k+=1){
	str_1 = "0" + str_1 + "0";
}

for (k=1;k<=n;k+=1){
	str_all = str_all + str_1 + "\n";
}

// add row if even window desired
if (!(n%2)){
	for (k=1;k<=n+1;k+=1){
	str_all = str_all + "0";
	}
	str_all = str_all + "\n";
}
print(str_all);


// get original image
id1 = getImageID;
// set voxels in case scaling affects convolution
selectImage(id1);
getVoxelSize(orig_w, orig_h, orig_d, orig_unit);
print(orig_w +  "\n" + orig_h +  "\n" + orig_d + "\n" +  orig_unit);
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

// reset units in original and final images
setVoxelSize(orig_w, orig_h, orig_d, orig_unit);
selectImage(id1);
setVoxelSize(orig_w, orig_h, orig_d, orig_unit);

// close resliced form
selectImage(id2);
close;


// need to upgrade: 
// probably need scaling factor to account for mask zeros
// should original voxel size and reset later
// rename output image (RA_[original name])
// check if stack is large enough