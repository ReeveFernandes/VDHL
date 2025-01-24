# This Directory

## Demonstration
Folders of projects, documentation, and results used before, during, and after the demonstration period. These files mostly pertain to the old small blue FPGA from Arduino, also known as the MKR VIDOR 4000 (kit 2). This folder contains Verilog/VHDL code for projects related to the video processing pipeline in the `/pipeline` directory.

### Purpose
The folder was created to maintain projects completed during my trial period. The only relevant folder is the `pipeline` folder because it contains open-source Verilog code worked on during the project. However, due to discrepancies in the code, the attempt was not successful. The code in the `pipeline` directory is a compilation of different projects from Sameer Puri's GitHub (https://github.com/sameer?tab=repositories). The goal was to create a video processing pipeline using the OV7670 camera, FPGA, and HDMI for screen output.

## Inner Directories

### `.idea`
Totally irrelevant system preference files to run Python simulations for image wrapping using Python.

### `Misc`
Incomplete Python scripts to run an image wrapping algorithm for a better understanding of image processing. Reason?

### `pipeline`
Contains Verilog code for the image processing pipeline for the MKR VIDOR 4000 FPGA. These files are adaptations from internet sources. However, there are bugs in the sources, and an overall merge was not possible.

### `videos`
Video demonstrations of the running code and instructions on how to set up, upload, and what to expect after programming the MKR VIDOR 4000.
