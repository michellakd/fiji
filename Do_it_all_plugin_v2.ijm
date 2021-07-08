Dialog.create("Image analysis");
items = newArray("Save as TIFF composite", "Save as RGB", "Save as JPEG", "Save as PNG", "Make montage", "Z-project", "Save open images");
Dialog.addRadioButtonGroup("What do you want to do today ? :)", items, 7, 1, "Save as TIFF composite");
Dialog.show;
technique = Dialog.getRadioButton;
inputFolder=getDirectory("Choose input folder");
outputFolder=getDirectory("Choose output folder");
list=getFileList(inputFolder);



// Save as composite TIFF
if (technique=="Save as TIFF composite") {
	run("Close All");
	for(i=0; i<list.length; i++) {
	path=inputFolder+list[i];
	open(path);
	getDimensions(width, height, channels, slices, frames);
	chan=channels;
	source = getTitle();
	selectWindow(source);
	if(chan==2){
		Stack.setDisplayMode("composite");
		Stack.setChannel(1);
		run("Grays");
		Stack.setChannel(2);
		run("Cyan");
		saveAs("tiff", path);
		run("Close All");
		}
	if(chan==3){
		Stack.setDisplayMode("composite");
		Stack.setChannel(1);
		run("Green");
		Stack.setChannel(2);
		run("Red");
		Stack.setChannel(3);
		run("Cyan");
		saveAs("tiff", path);
		run("Close All");
		}
	if(chan==4){
		Stack.setDisplayMode("composite");
		Stack.setChannel(1);
		run("Green");
		Stack.setChannel(2);
		run("Red");
		Stack.setChannel(3);
		run("Grays");
		Stack.setChannel(4);
		run("Cyan");
		saveAs("tiff", path);
		run("Close All");
		}
	}
}

// Save as RGB
if (technique=="Save as RGB") {
	run("Close All");
	for(i=0; i<list.length; i++) {
	path=inputFolder+list[i];
	open(path);
	getDimensions(width, height, channels, slices, frames);
	chan=channels;
	source = getTitle();
	selectWindow(source);
	run("RGB Color");
	save(path);
	run("Close All");
	}
}


// Save as JPEG
if (technique=="Save as JPEG") {
	run("Close All");
	for(i=0; i<list.length; i++) {
	path=inputFolder+list[i];
	open(path);
	getDimensions(width, height, channels, slices, frames);
	chan=channels;
	source = getTitle();
	dotIndex = indexOf(source, ".");
	title = substring(source, 0, dotIndex);
	path2 = outputFolder+title;
	selectWindow(source);
	for(j=1; j<=chan; j++){
		Stack.setDisplayMode("color");
		Stack.setChannel(j);
		saveAs("jpeg", path2+"-"+j);
		}
	Stack.setDisplayMode("composite");
	saveAs("jpeg", path);
	run("Close All");
	}
}



// Save as PNG
if (technique=="Save as PNG") {
	run("Close All");
	for(i=0; i<list.length; i++) {
	path=inputFolder+list[i];
	open(path);
	getDimensions(width, height, channels, slices, frames);
	chan=channels;
	source = getTitle();
	dotIndex = indexOf(source, ".");
	title = substring(source, 0, dotIndex);
	path2 = outputFolder+title;
	selectWindow(source);
	for(j=1; j<=chan; j++){
		Stack.setDisplayMode("color");
		Stack.setChannel(j);
		saveAs("png", path2+"-"+j);
		}
	Stack.setDisplayMode("composite");
	saveAs("png", path);
	run("Close All");
	}
}



// Make montage
if (technique=="Make montage") {
	run("Close All");
	for(i=0; i<list.length; i++) {
	path=inputFolder+list[i];
	open(path);
	getDimensions(width, height, channels, slices, frames);
	chan=channels;
	source = getTitle();
	dotIndex = indexOf(source, ".");
	title = substring(source, 0, dotIndex);
	path2 = outputFolder+title;
	selectWindow(source);
	if(chan==3){
		run("Make Montage...", "columns=3 rows=1 scale=1");
		saveAs("jpeg", path);
	}
	if(chan==4){
		run("Make Montage...", "columns=2 rows=2 scale=1");
		saveAs("jpeg", path);
	}
	run("Close All");
	}
}



// Z-project
if (technique=="Z-project") {
	run("Close All");
	for(i=0; i<list.length; i++) {
	path=inputFolder+list[i];
	open(path);
	source = getTitle();
	selectWindow(source);
	run("Z Project...", "projection=[Max Intensity]");
	source2 = "MAX_" + source;
	selectWindow(source2);
	source3 = replace(source2, " ", "_");
	path2=outputFolder+source3;
	saveAs("tiff", path2);
	run("Close All");
	}
}


//Save open images
if (technique=="Save open images") {
	for(i=1; i <= nImages; i++) {
	selectImage(i);
	source = getTitle();
	save(outputFolder+source);
	}
}

