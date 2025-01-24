# This Directory

## Source Code Link
[GitHub Repository](https://github.com/sameer?tab=repositories)

## Pipeline
Contains Verilog code for the image processing pipeline for the MKR VIDOR 4000 FPGA. These files are adaptations from internet sources. However, there are bugs in the sources, and an overall merge was not possible.

## clock-domain-crossing-master
SystemVerilog modules for clock domain crossing on an FPGA. This module was downloaded as a requirement for the HDMI module below.

## gray-code-master
SystemVerilog code for generating a Gray code of arbitrary width. This was needed for dual clock FIFOs, providing an efficient way to generate Gray codes without manually writing them out.

## hdmi-master
SystemVerilog code for HDMI 1.4b video/audio output on an FPGA. Unlike most free and open-source HDMI implementations that output a DVI signal, this module supports true HDMI functionality, including audio, without requiring a licensed HDMI IP block.

## i2c-master
SystemVerilog code for I2C master/slave on an FPGA.

## mipi-ccs-master
SystemVerilog code for MIPI interfacing with FPGA and camera. This module was downloaded as the main component for interfacing the OV7670 camera with the FPGA.

## mipi-csi-2-master
An improved version of the MIPI interfacing module with modifications to suit specific board conditions.

## mipi-demo-master
A compilation of individual modules (gray-code, hdmi-master, i2c, mipi, sound) combined into one project.

## sound-master
Various sound generation/mixing utilities for FPGAs. This also serves as a support library for the HDMI module.

## VidorFPGA-master
This repository includes FPGA IP Blocks compatible with the Arduino Vidor family of products. It is aimed at users already familiar with FPGA development. Note that Arduino provides limited support for FPGA development using native tools, focusing instead on precompiled libraries and web tools for easier IP block assembly.
