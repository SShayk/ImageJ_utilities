//open("U:/eng_research_economo2/SFS/TICO2/20251007/no_rescan.raw");


Dialog.create("AutoLoad .raw");

Dialog.addFile("Drag .raw file here","U:/eng_research_economo2/SFS/TICO2/20251007/no_rescan.raw");
Dialog.addNumber("Frames to load",1);

Dialog.show();


// after OKing
fs = Dialog.getString();

// get folder
sp = split(fs,"\\/");
folder = String.join(Array.trim(sp,sp.length-1),"/");
txtpath = folder + "/0_imagej_import.txt";
if (File.exists(txtpath)){
	
	// load parameters
	str = File.openAsString(txtpath);
	lines=split(str, "\n");
	
	var_width = get_numvar(lines, "Width", 9);
	var_height = get_numvar(lines, "Height", 10);
	var_offset = get_numvar(lines, "Offset", 25);
	var_gap = get_numvar(lines, "Gap", 22);	
	
	str_var = String.join(Array.filter(lines,"Image Type"));
	var_type = str_var.substring(16,str_var.length-1);
	
    print(var_type);
	var_nfiles = Dialog.getNumber();

	
	
	// assuming black = 0, little-endian byte order, open 1 file, and don't use virtual stack
	run("Raw...", "open=" + fs + " image=["+var_type+"] width="+var_width+" height="+var_height+" number="+var_nfiles+" gap="+var_gap+" little-endian");
	
	// count frames?
	
	// open
		
	
}else{
	print("text file "+txtpath+ "does not exist");
}



function get_numvar(array, ID, k){
		str_cur = String.join(Array.filter(array,ID));
		val = str_cur.substring(k,str_cur.length);
		val = 1*val;
	return val
}
	    


