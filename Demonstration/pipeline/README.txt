This Directory:

Source Code link: https://github.com/sameer?tab=repositories


pipeline - Contains verilog code for image processing pipeline for the MKR VIDOR 4000 FPGA. These files are
	   adaptation from interenet sources. However, there are bug in the sources and a overall merge was 
	   not possible.

clock-domain-crossing-master - SystemVerilog modules for clock domain crossing on an FPGA. This module was
			       downloaded as a requirement for the HDMI module below.SystemVerilog modules for 
			       clock domain crossing on an FPGA.

gray-code-master             - SystemVerilog code for generating a Gray code of arbitrary width. SystemVerilog 
			       code for generating a Gray code of arbitrary width. I needed an efficient, easy 
			       way to generate gray codes for dual clock FIFOs. It's a pain to manually write out 
			       a gray code. 


hdmi-master      	     - SystemVerilog code for HDMI 1.4b video/audio output on an FPGA.Most free and open 
			       source HDMI source (computer/gaming console) implementations actually output a DVI 
			       signal, which HDMI sinks (TVs/monitors) are backwards compatible with. To support 
			       audio and other HDMI-only functionality, a true HDMI signal must be sent. The code 
			       in this repository lets you do that without having to license an HDMI IP block 
			       from anyone.


i2c-master		     - SystemVerilog code for I2C master/slave on an FPGA.


mipi-ccs-master		     - SystemVerilog code for mipi interfacing with FPGA and Camera. This was
			       downloaded as the main module for interfacing the OV 7670 camera with 
			       FPGA


mipi-csi-2-master	     - Another version of SystemVerilog code for mipi interfacing with FPGA and 
			       camera. This an improved version of the previous module with changes that
			       suit our board and condition. 


mipi-demo-master    	     - This is a compilation of individual modules (gray-code, hdmi-master,i2c,mipi
			        , sound) in one big project.


sound-master		     - Various sound generation/mixing utilities for FPGAs. This is also a support
			       library for the HDMI module


VidorFPGA-master	     - This repository includes FPGA IP Blocks compatible with the Arduino Vidor 
			       family of products and is aimed to users already familiar with FPGA 
			       development process. FPGA development using native tools, although 
			       encouraged, is not supported by Arduino as it is quite complex difficult to 
			       support. If you feel this challenge is for you please know that we can only 
			       provide very limited support as our main efforts will be targeted at 
			       providing a smooth experience within Arduino IDE and Arduino Create through 
			       precompiled libraries and with the web tool that will provde an easy way to 
			       assemble IP blocks.