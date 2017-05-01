###################################
# Run the design through Innovus
# Modified for Innovus 16.1
###################################

# Setup design and create floorplan for the SoC/pin-only version
source init_pins.tcl

setMultiCpuUsage -localCpu 10

# Actually Run the Layout Main Stages
source core_run.tcl

