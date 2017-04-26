###################################
# Run the design through Innovus
# Modified for Innovus 16.1
###################################

# Setup design and create floorplan
source init.tcl

# Create Floorplan
floorplan -r 1.0 0.6 50 50 50 50
unfixAllIos
legalizePin

# Add supply rings around core
addRing -spacing_bottom 9.9 -width_left 9.9 -width_bottom 9.9 -width_top 9.9 -spacing_top 9.9 -layer_bottom metal1 -width_right 9.9 -around default_power_domain -center 1 -layer_top metal1 -spacing_right 9.9 -spacing_left 9.9 -layer_right metal2 -layer_left metal2 -offset 9.9 -nets { gnd vdd }

# Place standard cells

setPlaceMode -congEffort medium 
placeDesign -inPlaceOpt
checkPlace

# If design is congested, try
#setPlaceMode congEffort high


# Route power nets
sroute


# Perform trial route and get initial timing results pre-Clock Tree Synthesis (CTS)
trialroute
timeDesign -preCTS 
# reports are in timingReports subdirectory of project

# Perform pre-CTS optimization
setOptMode -yieldEffort none
setOptMode -highEffort
setOptMode -maxDensity 0.95
setOptMode -drcMargin 0.0
setOptMode -holdTargetSlack 0.0 -setupTargetSlack 0.0
setOptMode -noSimplifyNetlist
optDesign -preCTS -drv

# Clock tree synthesis
# generate the clock tree routing and buffering where necessary
clockDesign

# Perform trial route and get preliminary timing results including effects of clock tree insertion
trialroute
timeDesign -postCTS 
# reports are in timingReports subdirectory of project

# Extract RC
setExtractRCMode -assumeMetFill
extractRC -outfile encounter.cap

# Perform post-CTS optimization
setOptMode -yieldEffort none
setOptMode -highEffort
setOptMode -maxDensity 0.95
setOptMode -drcMargin 0.0
setOptMode -holdTargetSlack 0.0 -setupTargetSlack 0.0
setOptMode -noSimplifyNetlist
optDesign -postCTS -hold 
optDesign -postCTS -drv 

# see the .ctsrpt file for report on max clock skew
reportClockTree -postRoute -localSkew -report skew.post_troute_local.ctsrpt

# Add filler cells
addFiller -cell FILL


# Metal fill
setMetalFill -layer "1 2 3" -preferredDensity 35 -gapSpacing 0.2 \
             -minWidth 0.1 -maxWidth 1.0 \
             -minLength 0.1 -maxLength 10.0
#addMetalFill -layer "1 2 3"


# Connect all new cells to VDD/GND
globalNetConnect vdd -type tiehi
globalNetConnect vdd -type pgpin -pin vdd -all -override

globalNetConnect gnd -type tielo
globalNetConnect gnd -type pgpin -pin gnd -all -override

# Route power nets
sroute 

# Route
globalDetailRoute

# Get final timing results
setExtractRCMode -engine postRoute -effortLevel low -reduce 0.0
extractRC

# Enable Active Timing Analysis by user
setAnalysisMode -analysisType onChipVariation

# Post-Route Optimization
setOptMode -yieldEffort none
setOptMode -effort high
setOptMode -maxDensity 0.95
setOptMode -drcMargin 0.0
setOptMode -holdTargetSlack 0.0 -setupTargetSlack 0.0
setOptMode -simplifyNetlist false
setOptMode -usefulSkew false
optDesign -postRoute -incr 

# Add filler
addFiller -cell FILL -prefix FIL -fillBoundary
ecoRoute

# Run DRC and Connection checks
verifyConnectivity -type all -error 1000 -warning 50
verify_drc

# Output GDSII
streamOut final.gds2 -mapFile gds2_innovus.map -outputMacros -stripes 1 -units 1000 -mode ALL
saveNetlist -excludeLeafCell final.v

# Output DSPF RC Data
rcout -spf final.dspf

puts "**************************************"
puts "* Encounter script finished          *"
puts "*                                    *"
puts "* Results:                           *"
puts "* --------                           *"
puts "* Layout:  final.gds2                *"
puts "* Netlist: final.v                   *"
puts "* Timing:  timing.rep.5.final        *"
puts "*                                    *"
puts "* Type 'win' to get the Main Window  *"
puts "* or type 'exit' to quit             *"
puts "*                                    *"
puts "**************************************"


