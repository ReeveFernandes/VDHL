This Directory
Demonstration - Folders of projects and documentation and results used before, during, and after the
		demonstration period. These files mostly pertain to the old small blue FPGA from arduino
		aka MKR VIDOR 4000 (kit 2). This folder contains Verilog/VHDL code for projects related to video
		processing pipeline in the /pipeline directory.

Purpose:
The folder was created to maintain projects done during my trial period. The only revelant folder would be 
pipeline folder becuase it contains open source verilog code that was worked on during the project. However,
due to discripencies in the code the attempt was not a success. Also, The codes in the pipeline are a compilation
of different projects on Sameer Puri's Github (https://github.com/sameer?tab=repositories)
The Goal was to create a video processing pipeline using the OV7670 camera, FPGA, and HDMI for screen output.



Inner Directories

.idea    - Totally irreleveant system preference files to run python simulation for image wrapping using python
Misc     - Incomplete python scripts to run image wrapping algorithm for better understand of image processing. Reason?
pipeline - Contains verilog code for image processing pipeline for the MKR VIDOR 4000 FPGA. These files are
	   adaptation from interenet sources. However, there are bug in the sources and a overall merge was 
	   not possible. 
videos 	 - Video Demonstration of running code and on how to set up, upload, and what to expect after
           programming the MKR VIDOR 4000

